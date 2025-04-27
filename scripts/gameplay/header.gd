extends HBoxContainer

@onready var stat_wellbeing_progressbar = $Wellbeing/VBoxContainer/ProgressBar
@onready var stat_productivity_progressbar = $Productivity/VBoxContainer/ProgressBar
@onready var stat_momentum_progressbar = $Momentum/VBoxContainer/ProgressBar
@onready var level_label = $Level/Label
@onready var coin_label = $Coin/Label
@onready var stat_wellbeing_progressbar_value = $Wellbeing/VBoxContainer/ProgressBar/Value
@onready var stat_productivity_progressbar_value = $Productivity/VBoxContainer/ProgressBar/Value
@onready var stat_momentum_progressbar_value = $Momentum/VBoxContainer/ProgressBar/Value

func _ready():
	_update_ui()
	SaveData.coin_changed.connect(_update_ui)
	SaveData.stat_current_wellbeing_changed.connect(_update_ui)
	SaveData.stat_current_productivity_changed.connect(_update_ui)
	SaveData.stat_current_momentum_changed.connect(_update_ui)

func _update_ui():
	stat_wellbeing_progressbar.value = SaveData.stat_current_wellbeing_percentage
	stat_productivity_progressbar.value = SaveData.stat_current_productivity_percentage
	stat_momentum_progressbar.value = SaveData.stat_current_momentum_percentage
	coin_label.text = str(SaveData.coin)
	

	if SaveData.stat_current_wellbeing_percentage > 1:
		stat_wellbeing_progressbar_value.text = "JUICED! %d/%d" % [SaveData.stat_current_wellbeing, Content.stats_max_value]
	else:
		stat_wellbeing_progressbar_value.text = "%d/%d" % [SaveData.stat_current_wellbeing, Content.stats_max_value]

	if SaveData.stat_current_productivity_percentage > 1:
		stat_productivity_progressbar_value.text = "JUICED! %d/%d" % [SaveData.stat_current_productivity, Content.stats_max_value]
	else:
		stat_productivity_progressbar_value.text = "%d/%d" % [SaveData.stat_current_productivity, Content.stats_max_value]

	if SaveData.stat_current_momentum_percentage > 1:
		stat_momentum_progressbar_value.text = "JUICED! %d/%d" % [SaveData.stat_current_momentum, Content.stats_max_value]
	else:
		stat_momentum_progressbar_value.text = "%d/%d" % [SaveData.stat_current_momentum, Content.stats_max_value]
		
	# Delay to make sure level number has actually updated first
	if is_inside_tree():
		await get_tree().process_frame
		level_label.text = "Level %d" % (SaveData.current_run_level)
