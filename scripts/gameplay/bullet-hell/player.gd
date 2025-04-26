extends CharacterBody2D

@export var bullet_node: PackedScene

var speed = 250
@onready var debug = $debug
@onready var progress_bar = $ProgressBar

var health = 100:
	set(value):
		health = value
		progress_bar.value = value

func _physics_process(_delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down") * speed
	move_and_slide()
	if Input.is_action_just_pressed("shoot"):
		shoot()

func set_status(bullet_type):
	match bullet_type:
		0:
			fire()
		1:
			poison()
		2:
			slow()
		3:
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
	speed = 50
	
func stun():
	debug.text = "stun"
	speed = 0
	await get_tree().create_timer(2.5).timeout
	speed = 250
	
	
func shoot():
	var bullet = bullet_node.instantiate()
	
	bullet.position = global_position
	bullet.direction = Vector2.UP
	#bullet.set_property(bullet_type)
	
	get_tree().current_scene.call_deferred("add_child", bullet)
	
	
