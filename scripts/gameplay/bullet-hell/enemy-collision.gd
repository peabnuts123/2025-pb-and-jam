extends Area2D

@onready var enemy = $".."

func take_damage(amount):
	enemy.health -= amount
	if enemy.health <= 0:
		enemy.die()
