extends Node2D

@export var bullet_node: PackedScene

func shoot():
	var bullet = bullet_node.instantiate()
	
	bullet.position = global_position
	bullet.direction = Vector2.DOWN
	#bullet.set_property(bullet_type)
	
	get_tree().current_scene.call_deferred("add_child", bullet)
