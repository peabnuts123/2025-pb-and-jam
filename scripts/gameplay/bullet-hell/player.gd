extends CharacterBody2D

@export var bullet_node: PackedScene

var speed_multiplier = 1
@onready var debug = $debug
@onready var progress_bar = $ProgressBar
@onready var shoot_timer = $ShootTimer

var health = 100:
	set(value):
		health = value
		progress_bar.value = value

var movement_speed_per_second: float;

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

func _process(_delta):
	if can_shoot and Input.is_action_pressed("shoot"):
		shoot()


func _physics_process(_delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down") * speed_multiplier * movement_speed_per_second
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
	health -= 10

func poison():
	debug.text = "poison"
	for i in range(5):
		health -= 2
		await get_tree().create_timer(1).timeout

func slow():
	debug.text = "slow"
	speed_multiplier = 0.4

func stun():
	debug.text = "stun"
	speed_multiplier = 0
	await get_tree().create_timer(2.5).timeout
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
