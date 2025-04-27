extends Node2D

@export var bullet_node: PackedScene

@onready var sprite = $Sprite2D
@onready var death_sound = $DeathSound

var health = 0
var is_dead = false;

func _ready():
	var current_level = max(0, SaveData.current_run_level - 1)
	health = Content.enemy_base_health + (current_level * Content.enemy_health_increase_per_level)

func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size
	position.y += Content.enemy_base_move_speed_per_second * delta
	if position.y > screen_size.y + 200:
		queue_free()


func shoot():
	var bullet = bullet_node.instantiate()

	bullet.direction = Vector2.DOWN
	bullet.position = global_position + (bullet.direction * 50)

	if is_inside_tree():
		get_tree().current_scene.call_deferred("add_child", bullet)

func die():
	if is_dead:
		return
	is_dead = true
	sprite.visible = false
	SaveData.coin += Content.enemy_coins_per_death
	death_sound.play()
	await death_sound.finished
	print("Death sound over")
	queue_free()
