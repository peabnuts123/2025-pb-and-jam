extends Node2D

# References
@onready var wellbeing_base_stat_label = $CanvasLayer/Container/Stats/Wellbeing/Value
@onready var productivity_base_stat_label = $CanvasLayer/Container/Stats/Productivity/Value
@onready var momentum_base_state_label = $CanvasLayer/Container/Stats/Momentum/Value

@onready var wellbeing_upgrade_button = $CanvasLayer/Container/Stats/Wellbeing/Button
@onready var productivity_upgrade_button = $CanvasLayer/Container/Stats/Productivity/Button
@onready var momentum_upgrade_button = $CanvasLayer/Container/Stats/Momentum/Button

@onready var game_over_music = $GameOverMusic
@onready var normal_music = $NormalMusic
@onready var spend_coin_sound = $SpendCoin

func _ready():
	_update_ui()
	if not SaveData.game_over_message.is_empty():
		game_over_music.play()
	else:
		normal_music.play()

func _on_play_pressed():
	SaveData.start_new_run()
	get_tree().change_scene_to_file("res://scenes/gameplay/decision_screen.tscn")

func _on_upgrade_wellbeing():
	if SaveData.coin >= Content.upgrade_cost and SaveData.stat_base_wellbeing < Content.stats_max_value:
		SaveData.coin -= Content.upgrade_cost;
		SaveData.stat_base_wellbeing += 1
		spend_coin_sound.play()
		_update_ui()

func _on_upgrade_productivity():
	if SaveData.coin >= Content.upgrade_cost and SaveData.stat_base_productivity < Content.stats_max_value:
		SaveData.coin -= Content.upgrade_cost;
		SaveData.stat_base_productivity += 1
		spend_coin_sound.play()
		_update_ui()

func _on_upgrade_momentum():
	if SaveData.coin >= Content.upgrade_cost and SaveData.stat_base_momentum < Content.stats_max_value:
		SaveData.coin -= Content.upgrade_cost;
		SaveData.stat_base_momentum += 1
		spend_coin_sound.play()
		_update_ui()

func _update_ui():
	# Bind stats
	wellbeing_base_stat_label.text = str(SaveData.stat_base_wellbeing)
	productivity_base_stat_label.text = str(SaveData.stat_base_productivity)
	momentum_base_state_label.text = str(SaveData.stat_base_momentum)

	# Disable buttons if you can't click them
	wellbeing_upgrade_button.disabled = SaveData.stat_base_wellbeing >= Content.stats_max_value or SaveData.coin < Content.upgrade_cost
	productivity_upgrade_button.disabled = SaveData.stat_base_productivity >= Content.stats_max_value or SaveData.coin < Content.upgrade_cost
	momentum_upgrade_button.disabled = SaveData.stat_base_momentum >= Content.stats_max_value or SaveData.coin < Content.upgrade_cost

	# Bind all the buttons to say the correct cost based on config
	wellbeing_upgrade_button.text = " +1 (%d coin) " % Content.upgrade_cost
	productivity_upgrade_button.text = " +1 (%d coin) " % Content.upgrade_cost
	momentum_upgrade_button.text = " +1 (%d coin) " % Content.upgrade_cost
