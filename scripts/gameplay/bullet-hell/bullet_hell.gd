extends Node2D

# NOTE: Debug
func _on_kys_pressed():
	SaveData.game_over_message = "You died!!!!"
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
