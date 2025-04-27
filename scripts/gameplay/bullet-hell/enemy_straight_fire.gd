extends Node2D

@export var bullet_node: PackedScene

var health = 5

func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size
	position.y += Content.enemy_base_move_speed_per_second * delta
	if position.y > screen_size.y + 500:
		queue_free()


func shoot():
	var bullet = bullet_node.instantiate()

	bullet.direction = Vector2.DOWN
	bullet.position = global_position + (bullet.direction * 50)

	if is_inside_tree():
		get_tree().current_scene.call_deferred("add_child", bullet)

func die():
	queue_free()
