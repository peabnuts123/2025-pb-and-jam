extends Area2D

var direction = Vector2.RIGHT
var bullet_type = Content.BulletType.default


func _ready():
	$Sprite.animation = str(Content.BulletType.find_key(bullet_type))

func _physics_process(delta):
	position += direction * Content.enemy_bullet_base_move_speed_per_second * delta


func _on_screen_exited():
	queue_free()


func set_property(type: Content.BulletType):
	bullet_type = type
	$Sprite.animation = str(Content.BulletType.find_key(bullet_type))


# Bullet hell physics
#  Enemy: Area on layer 2, group 'enemy'
#  Enemy Bullet: Area on layer 2, group 'enemy_bullet'
#  Player: Body on layer 1, group 'player'
#  Player bullet: Area on layer 1, group 'player_bullet'

func _on_body_entered(body):
	if body.is_in_group('player'):
		body.set_status(bullet_type)
		queue_free()


func _on_area_entered(area):
	if area.is_in_group('enemy'):
		pass; # Enemy bullets do not hit other enemies
	elif area.is_in_group('enemy_bullet'):
		pass; # Enemy bullets do not interact
	elif area.is_in_group('player_bullet'):
		# queue_free(); # Destroy on impact
		pass; # Do not interact with player bullets
