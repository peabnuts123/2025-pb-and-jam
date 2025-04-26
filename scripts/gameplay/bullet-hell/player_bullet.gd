extends Area2D

var direction = Vector2.RIGHT
var bullet_type: int = 0

func _physics_process(delta):
	position += direction * Content.player_bullet_base_move_speed_per_second * delta

func _on_screen_exited():
	queue_free()


# Bullet hell physics
#  Enemy: Area on layer 2, group 'enemy'
#  Enemy Bullet: Area on layer 2, group 'enemy_bullet'
#  Player: Body on layer 1, group 'player'
#  Player bullet: Area on layer 1, group 'player_bullet'

func _on_area_entered(area):
	if area.is_in_group('enemy'):
		area.take_damage(1); # Damage enemies
		queue_free()
	elif area.is_in_group('enemy_bullet'):
		# queue_free(); # Destroy on impact
		pass; # Do not interact with enemy bullets
	elif area.is_in_group('player_bullet'):
		pass; # Do not interact with other bullets
