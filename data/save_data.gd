extends Node

# NOTE: Use signal to allow UI elements to "react" to changes
signal coin_changed
var _coin: int = 3
@export var coin: int :
	get:
		return _coin
	set(value):
		_coin = value
		emit_signal('coin_changed')

@export var game_over_message: String = "";

# Universal stats i.e. the stats on the main menu
@export var stat_base_productivity: int = 10;
@export var stat_base_wellbeing: int = 10;
@export var stat_base_momentum: int = 10;

# Stats for your current run (reset each time you die)
@export var stat_current_productivity: int = 0;
@export var stat_current_wellbeing: int = 0;
@export var stat_current_momentum: int = 0;
