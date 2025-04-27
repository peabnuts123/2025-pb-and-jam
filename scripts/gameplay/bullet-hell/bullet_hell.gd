extends Node2D

# NOTE: Debug
func _on_kys_pressed():
	SaveData.game_over_message = "You died!!!!"
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
	
func on_boss_die():
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://scenes/gameplay/decision_screen.tscn")
