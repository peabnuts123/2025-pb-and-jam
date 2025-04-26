extends HBoxContainer

@onready var stat_wellbeing_progressbar = $Wellbeing/VBoxContainer/ProgressBar
@onready var stat_productivity_progressbar = $Productivity/VBoxContainer/ProgressBar
@onready var stat_momentum_progressbar = $Momentum/VBoxContainer/ProgressBar
@onready var coin_label = $Coin/Label

func _ready():
	_update_ui()
	SaveData.stat_current_wellbeing_changed.connect(_update_ui)
	SaveData.stat_current_productivity_changed.connect(_update_ui)
	SaveData.stat_current_momentum_changed.connect(_update_ui)

func _update_ui():
	stat_wellbeing_progressbar.value = inverse_lerp(Content.stats_initial_value, Content.stats_max_value, float(SaveData.stat_current_wellbeing))
	stat_productivity_progressbar.value = inverse_lerp(Content.stats_initial_value, Content.stats_max_value, SaveData.stat_current_productivity)
	stat_momentum_progressbar.value = inverse_lerp(Content.stats_initial_value, Content.stats_max_value, SaveData.stat_current_momentum)
	coin_label.text = str(SaveData.coin)
