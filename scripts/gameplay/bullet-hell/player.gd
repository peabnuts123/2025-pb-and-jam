extends CharacterBody2D

@export var bullet_node: PackedScene

var speed_multiplier = 1
@onready var debug = $debug
@onready var progress_bar = $ProgressBar
@onready var shoot_timer = $ShootTimer
@onready var animation = $Sprite2D

var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if health <= 0:
			die()

var movement_speed_per_second: float;

var is_dead = false
var can_shoot = true

func _ready():
	# Bind stats
	# - Movement speed
	movement_speed_per_second = lerp(Content.player_movement_speed_min, Content.player_movement_speed_max, SaveData.stat_current_momentum_percentage)

	# - Health
	var player_max_health = lerp(Content.player_health_min, Content.player_health_max, SaveData.stat_current_wellbeing_percentage)
	progress_bar.max_value = player_max_health
	health = player_max_health
	# - Fire rate
	var player_fire_rate_per_second = lerp(Content.player_fire_rate_per_second_min, Content.player_fire_rate_per_second_max, SaveData.stat_current_productivity_percentage)
	shoot_timer.wait_time = 1.0 / player_fire_rate_per_second

	print("(movement_speed_per_second='%d') (player_max_health='%d') (player_fire_rate_per_second='%d')" % [
		movement_speed_per_second,
		player_max_health,
		player_fire_rate_per_second
	])

func _process(_delta):
	if can_shoot and Input.is_action_pressed("shoot"):
		shoot()


func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	velocity = direction * speed_multiplier * movement_speed_per_second
	animation.speed_scale = clampf(direction.length(), 0.0, 1.0)
	move_and_slide()


func set_status(bullet_type: Content.BulletType):
	match bullet_type:
		Content.BulletType.default:
			fire()
		Content.BulletType.poison:
			poison()
		Content.BulletType.slow:
			slow()
		Content.BulletType.stun:
			stun()

func fire():
	debug.text = "fire"
	health -= Content.bullet_type_default_damage


func poison():
	debug.text = "poison"
	for i in range(Content.bullet_type_poison_damage_num_ticks):
		health -= Content.bullet_type_poison_damage_per_tick
		if is_dead:
			break
		await get_tree().create_timer(1).timeout


func slow():
	debug.text = "slow"
	health -= Content.bullet_type_slow_damage
	if not is_dead:
		speed_multiplier = Content.bullet_type_slow_speed_multiplier
		await get_tree().create_timer(Content.bullet_type_slow_duration_seconds).timeout
		speed_multiplier = 1

func stun():
	debug.text = "stun"
	health -= Content.bullet_type_stun_damage
	if not is_dead:
		speed_multiplier = 0
		await get_tree().create_timer(Content.bullet_type_stun_duration).timeout
		speed_multiplier = 1


func shoot():
	shoot_timer.start(0) # Reset shoot timer to 0
	can_shoot = false # Disable shooting until next timer

	var bullet = bullet_node.instantiate()

	bullet.direction = Vector2.UP
	bullet.position = global_position + (bullet.direction * 50)


	get_tree().current_scene.call_deferred("add_child", bullet)


func _on_shoot_timer_fire():
	can_shoot = true


func die():
	is_dead = true
	SaveData.game_over_message = "You died!!!!"
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
