extends Node

# Data
var items: Array[Item];
enum BulletType {
	default,
	poison,
	slow,
	stun,
}

# Balance
# - Economy
var upgrade_cost: int = 5;
var initial_coin: int = 0
var stats_initial_value: int = 0;
var stats_max_value: int = 10;
# - Item generation
var item_buff_value_range_min: int = 1;
var item_buff_value_range_max: int = 3;
var item_value_range_min: int = 3;
var item_value_range_max: int = 5;
# - Bullet hell
var enemy_base_move_speed_per_second: float = 80
var enemy_bullet_base_move_speed_per_second: float = 200
var player_bullet_base_move_speed_per_second: float = 450
var boss_move_speed_per_second: float = 100
var boss_zoom_phase_hold_time_min_seconds: float = 3
var boss_zoom_phase_hold_time_max_seconds: float = 8
var rare_bullet_type_chance_per_type: float = 0.05
# - Damage
var bullet_type_default_damage: float = 5
var bullet_type_poison_damage_per_tick: float = 2
var bullet_type_poison_damage_num_ticks: float = 5
var bullet_type_slow_damage: float = 5
var bullet_type_slow_speed_multiplier: float = 0.4
var bullet_type_slow_duration_seconds: float = 2
var bullet_type_stun_damage: float = 5
var bullet_type_stun_duration: float = 1.5

# - Player stats
var player_health_min: float = 50
var player_health_max: float = 250
var player_movement_speed_min: float = 150
var player_movement_speed_max: float = 600
var player_fire_rate_per_second_min: float = 2.5
var player_fire_rate_per_second_max: float = 10


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
