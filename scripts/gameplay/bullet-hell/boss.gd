extends Node2D

signal died

var theta: float = 0.0
@export_range(0,2*PI) var alpha: float = 0.0
@export var marie_textures: Array[Texture]
@export var bullet_node: PackedScene

@onready var sprite = $Sprite2D

var health = 5:
	set(value):
		health = value

enum BehaviourMode {
	EnteringScreen,
	Zooming,
}

var current_behaviour: BehaviourMode = BehaviourMode.EnteringScreen

enum ZoomBehaviourSubPhase {
	Ready, 		# Ready to zoom somewhere
	Moving,		# Zooming in progress
	Waiting,	# Holding in place at target location
}

var zooming_behaviour_move_target: Vector2
var zooming_behaviour_current_phase = ZoomBehaviourSubPhase.Ready

func _ready():
	# @NOTE `current_run_level` is 1-based
	sprite.texture = marie_textures[clamp(SaveData.current_run_level - 1, 0, marie_textures.size() - 1)]

func _process(delta):
	match current_behaviour:
		BehaviourMode.EnteringScreen:
			# Move on screen
			position.y += Content.enemy_base_move_speed_per_second * delta

			# Once sufficiently on-screen, begin zooming
			if position.y > 200:
				current_behaviour = BehaviourMode.Zooming

		BehaviourMode.Zooming:
			# Zooming behaviour is processed in a coroutine
			# If the zoom behaviour is idle, begin another zoom
			if zooming_behaviour_current_phase == ZoomBehaviourSubPhase.Ready:
				_process_zooming_behaviour()

func _process_zooming_behaviour():
	# Config
	var screen_size = get_viewport().get_visible_rect().size
	var screen_margin = 100
	var reached_target_radius_squared = 100

	# 1. Pick a target location to move to
	zooming_behaviour_current_phase = ZoomBehaviourSubPhase.Moving
	zooming_behaviour_move_target = Vector2(randf_range(screen_margin, screen_size.x - screen_margin), randf_range(screen_margin, screen_size.y - screen_margin))
	print("[Boss] (_process_zooming_behaviour) New target (zooming_behaviour_move_target='%s')" % str(zooming_behaviour_move_target))

	# 2. Move there
	var move_delta = zooming_behaviour_move_target - position
	while move_delta.length_squared() > reached_target_radius_squared:
		# @NOTE: Fix for crash
		if not is_inside_tree():
			zooming_behaviour_current_phase = ZoomBehaviourSubPhase.Ready
			return

		# Wait 1 frame
		await get_tree().process_frame
		# Move towards target
		position += move_delta.normalized() * Content.boss_move_speed_per_second * get_process_delta_time()
		# Update delta
		move_delta = zooming_behaviour_move_target - position

	# 3. Wait there for a while
	zooming_behaviour_current_phase = ZoomBehaviourSubPhase.Waiting
	var wait_time_seconds = randf_range(Content.boss_zoom_phase_hold_time_min_seconds, Content.boss_zoom_phase_hold_time_max_seconds)

	# @NOTE: Fix for crash
	if not is_inside_tree():
		zooming_behaviour_current_phase = ZoomBehaviourSubPhase.Ready
		return

	await get_tree().create_timer(wait_time_seconds).timeout

	# Mark zoom behaviour as ready again
	zooming_behaviour_current_phase = ZoomBehaviourSubPhase.Ready

func get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta),sin(theta))


func shoot(angle):
	var bullet = bullet_node.instantiate()

	bullet.position = global_position
	bullet.direction = get_vector(angle)
	var bullet_type: Content.BulletType
	var dice_roll = randf()
	if dice_roll < Content.rare_bullet_type_chance_per_type:
		bullet_type = Content.BulletType.poison
	elif dice_roll < Content.rare_bullet_type_chance_per_type * 2:
		bullet_type = Content.BulletType.slow
	elif dice_roll < Content.rare_bullet_type_chance_per_type * 3:
		bullet_type = Content.BulletType.stun
	else:
		bullet_type = Content.BulletType.default

	bullet.set_property(bullet_type)

	if is_inside_tree():
		get_tree().current_scene.call_deferred("add_child", bullet)


func _on_speed_timeout():
	shoot(theta)


func die():
	died.emit()
	queue_free()
