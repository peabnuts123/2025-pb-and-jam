extends Node2D

var buff_type = $Item.buff_type
var buff_value = $Item.buff_value
var item_value = $Item.item_value

func _on_keep_pressed():
	match buff_type:
		"wellbeing":
			var _wellbeing = %SaveData.stat_current_wellbeing.get
			_wellbeing += buff_value
			%SaveData.stat_current_wellbeing.set(_wellbeing)
		"productivity":
			var _productivity = %SaveData.stat_current_productivity.get
			_productivity += buff_value
			%SaveData.stat_current_productivity.set(_productivity)
		"momentum":
			var _momentum = %SaveData.stat_current_momentum.get
			_momentum += buff_value
			%SaveData.stat_current_momentum.set(_momentum)
	print("@TODO trigger keep animation")
	get_tree().change_scene_to_file("res://scenes/gameplay/bullet_hell.tscn")


func _on_discard_pressed():
	var _coin = %SaveData.coin.get
	_coin += item_value
	%SaveData.coin.set(_coin)
	print("@TODO trigger discard animation")
	get_tree().change_scene_to_file("res://scenes/gameplay/bullet_hell.tscn")
