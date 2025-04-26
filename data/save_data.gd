extends Node

# NOTE: Use signal to allow UI elements to "react" to changes
signal coin_changed
var coin: int :
	set(value):
		coin = value
		coin_changed.emit()

var game_over_message: String = "";

# Universal stats i.e. the stats on the main menu
var stat_base_productivity: int
var stat_base_wellbeing: int
var stat_base_momentum: int

# Stats for your current run (reset each time you die)
signal stat_current_productivity_changed
signal stat_current_wellbeing_changed
signal stat_current_momentum_changed

# Productivity
var stat_current_productivity: int = 0 :
	set(value):
		stat_current_productivity = value
		stat_current_productivity_changed.emit()
var stat_current_productivity_percentage: float:
	get:
		return inverse_lerp(Content.stats_initial_value, Content.stats_max_value, float(stat_current_productivity))

# Wellbeing
var stat_current_wellbeing: int = 0 :
	set(value):
		stat_current_wellbeing = value
		stat_current_wellbeing_changed.emit()
var stat_current_wellbeing_percentage: float:
	get:
		return inverse_lerp(Content.stats_initial_value, Content.stats_max_value, float(stat_current_wellbeing))

# Momentum
var stat_current_momentum: int = 0 :
	set(value):
		stat_current_momentum = value
		stat_current_momentum_changed.emit()
var stat_current_momentum_percentage: float:
	get:
		return inverse_lerp(Content.stats_initial_value, Content.stats_max_value, float(stat_current_momentum))



func _ready():
	start_new_run()
	stat_base_productivity = Content.stats_initial_value
	stat_base_wellbeing = Content.stats_initial_value
	stat_base_momentum = Content.stats_initial_value
	coin = Content.initial_coin

func start_new_run():
	game_over_message = ""
	stat_current_productivity = stat_base_productivity
	stat_current_wellbeing = stat_base_wellbeing
	stat_current_momentum = stat_base_momentum
