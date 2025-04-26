extends Node

# Data
@export var items: Array[Item];
enum BulletType {
	default,
	poison,
	slow,
	stun,
}

# Balance
# - Economy
@export var upgrade_cost: int = 5;
@export var initial_coin: int = 0
@export var stats_initial_value: int = 10;
@export var stats_max_value: int = 20;
# - Item generation
@export var item_buff_value_range_min: int = 1;
@export var item_buff_value_range_max: int = 3;
@export var item_value_range_min: int = 3;
@export var item_value_range_max: int = 5;
# - Bullet hell
@export var enemy_base_move_speed_per_second = 80
@export var enemy_bullet_base_move_speed_per_second = 200
@export var player_base_move_speed_per_second = 200
@export var player_bullet_base_move_speed_per_second = 450
@export var boss_move_speed_per_second = 100
@export var boss_zoom_phase_hold_time_min_seconds = 3
@export var boss_zoom_phase_hold_time_max_seconds = 8


func _ready():
	items = load_all_item_resources('res://resources/items')

	for item in items:
		print("Loaded item '%s'" % item.name)

func load_all_item_resources(folder_path: String) -> Array[Item]:
	var resources: Array[Item] = []
	var dir = DirAccess.open(folder_path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		# Hack to fix file names on export. See: https://github.com/godotengine/godot/issues/66014#issuecomment-1501894950
		if file_name.ends_with(".remap"):
				file_name = file_name.trim_suffix(".remap")

		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			var resource_path = folder_path + "/" + file_name
			var resource = load(resource_path) as Item
			if resource:
				resources.append(resource)
		file_name = dir.get_next()
	dir.list_dir_end()
	return resources
