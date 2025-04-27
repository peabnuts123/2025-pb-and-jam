extends Node2D

@onready var music = $Music

# NOTE: Debug
func _on_kys_pressed():
	SaveData.game_over_message = "You died!!!!"
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
	
func on_boss_die():
	music.stop()
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/gameplay/decision_screen.tscn")
