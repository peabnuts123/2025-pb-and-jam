extends Area2D

var direction = Vector2.RIGHT

@onready var sprite = $Sprite2D
@onready var shoot_sound = $ShootSound
@onready var pop_sound = $PopSound


func _physics_process(delta):
	position += direction * Content.player_bullet_base_move_speed_per_second * delta

func _on_screen_exited():
	queue_free()

func _ready():
	shoot_sound.play()

# Bullet hell physics
#  Enemy: Area on layer 2, group 'enemy'
#  Enemy Bullet: Area on layer 2, group 'enemy_bullet'
#  Player: Body on layer 1, group 'player'
#  Player bullet: Area on layer 1, group 'player_bullet'

func _on_area_entered(area):
	if area.is_in_group('enemy'):
		area.take_damage(1); # Damage enemies
		_pop()
	elif area.is_in_group('enemy_bullet'):
		# queue_free(); # Destroy on impact
		pass; # Do not interact with enemy bullets
	elif area.is_in_group('player_bullet'):
		pass; # Do not interact with other bullets

func _pop():
	sprite.visible = false
	pop_sound.play()
	await pop_sound.finished
	queue_free()
