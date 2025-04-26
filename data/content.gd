extends Node

@export var items: Array[Item];
@export var upgrade_cost: int = 5;
@export var stats_initial_value: int = 10;
@export var stats_max_value: int = 20;
@export var initial_coin: int = 0

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
