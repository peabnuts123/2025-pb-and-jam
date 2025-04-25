extends Node

@export var coin: float = 0;

# Universal stats i.e. the stats on the main menu
@export var stat_base_productivity: int = 10;
@export var stat_base_wellbeing: int = 10;
@export var stat_base_momentum: int = 10;

# Stats for your current run (reset each time you die)
@export var stat_current_productivity: int = 0;
@export var stat_current_wellbeing: int = 0;
@export var stat_current_momentum: int = 0;
