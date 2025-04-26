extends Node2D

@export var bullet_node: PackedScene
@export var speed: float = 80

var screen_size: Vector2
var health = 5

func _ready():
	screen_size = get_viewport().get_visible_rect().size

func _process(delta):
	position.y += speed * delta
	if position.y > screen_size.y + 100:
		queue_free()


func shoot():
	var bullet = bullet_node.instantiate()
	
	bullet.position = global_position
	bullet.direction = Vector2.DOWN
 	#bullet.set_property()
	
	get_tree().current_scene.call_deferred("add_child", bullet)
	
	

		
		
func die():
	queue_free()
	
