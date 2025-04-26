extends Node

# NOTE: Use signal to allow UI elements to "react" to changes
signal coin_changed
var _coin: int
@export var coin: int :
	get:
		return _coin
	set(value):
		_coin = value
		coin_changed.emit()

@export var game_over_message: String = "";

# Universal stats i.e. the stats on the main menu
@export var stat_base_productivity: int
@export var stat_base_wellbeing: int
@export var stat_base_momentum: int

# Stats for your current run (reset each time you die)
signal stat_current_productivity_changed
signal stat_current_wellbeing_changed
signal stat_current_momentum_changed
var _current_productivity: int = 0
var _current_wellbeing: int = 0
var _current_momentum: int = 0

@export var stat_current_productivity: int = 0 :
	get:
		return _current_productivity
	set(value):
		_current_productivity = value
		stat_current_productivity_changed.emit()

@export var stat_current_wellbeing: int = 0 :
	get:
		return _current_wellbeing
	set(value):
		_current_wellbeing = value
		stat_current_wellbeing_changed.emit()

@export var stat_current_momentum: int = 0 :
	get:
		return _current_momentum
	set(value):
		_current_momentum = value
		stat_current_momentum_changed.emit()


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
