extends Node2D


func _on_keep_pressed():
	print("@TODO keep item")
	get_tree().change_scene_to_file("res://scenes/gameplay/bullet_hell.tscn")


func _on_discard_pressed():
	print("@TODO keep item")
	SaveData.coin += 2;
	get_tree().change_scene_to_file("res://scenes/gameplay/bullet_hell.tscn")
