extends Node2D

# Constants
enum BuffType {
	wellbeing,
	productivity,
	momentum
}

# References
@onready var item_effect_label = $"CanvasLayer/VBoxContainer/ScreenContent/Left/Keep Button/ButtonContentsContainer/Effect"
@onready var item_reward_label = $"CanvasLayer/VBoxContainer/ScreenContent/Right/Discard Button/ButtonContentsContainer/Reward"
@onready var item_title_label = $"CanvasLayer/VBoxContainer/ScreenContent/Middle/Item title"
@onready var item_image_texture = $CanvasLayer/VBoxContainer/ScreenContent/Middle/Control/ItemPicture
@onready var item_description_label = $"CanvasLayer/VBoxContainer/ScreenContent/Middle/Item description"

# Screen data
var buff_type: BuffType
var buff_value: int
var item_value: int

func _ready():
	SaveData.current_run_level += 1
	_generate_item()

func _generate_item():
	# pick random item from data
	var item = Content.items.pick_random()

	# random stats for item
	buff_type = BuffType.values().pick_random()
	buff_value = randi_range(Content.item_buff_value_range_min, Content.item_buff_value_range_max)
	item_value = randi_range(Content.item_value_range_min, Content.item_value_range_max)

	# bind all the different UI elements to the data
	item_effect_label.text = "+%d %s" % [buff_value, BuffType.find_key(buff_type)]
	item_reward_label.text = "+%d coin" % item_value
	item_title_label.text = item.name
	item_image_texture.texture = item.texture
	item_description_label.text = item.description

func _on_keep_pressed():
	match buff_type:
		BuffType.wellbeing:
			SaveData.stat_current_wellbeing += buff_value
		BuffType.productivity:
			SaveData.stat_current_productivity += buff_value
		BuffType.momentum:
			SaveData.stat_current_momentum += buff_value
	print("Current stats: %sW %sP %sM" % [SaveData.stat_current_wellbeing, SaveData.stat_current_productivity, SaveData.stat_current_momentum])
	print("@TODO trigger keep animation")
	get_tree().change_scene_to_file("res://scenes/gameplay/bullet_hell.tscn")

func _on_discard_pressed():
	SaveData.coin += item_value
	print("Current coin: %s" % SaveData.coin)
	print("@TODO trigger discard animation")
	get_tree().change_scene_to_file("res://scenes/gameplay/bullet_hell.tscn")
