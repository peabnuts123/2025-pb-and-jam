extends Area2D

@export var enemy_prefab: PackedScene
@export var boss_prefab: PackedScene
@export var min_spawn_time: float = 0.5  # minimum seconds between spawns
@export var max_spawn_time: float = 2.0  # maximum seconds between spawns

var spawn_count: int = 0
var base_max_enemies = 6
var max_enemies: int = 0

signal boss_died

func _ready():
	#set level difficulty
	update_max_enemies()


	spawn_enemy()

func update_max_enemies():
	max_enemies = max(base_max_enemies, base_max_enemies + (SaveData.current_run_level - 1) * 2)

func spawn_enemy():
	var screen_size = get_viewport().get_visible_rect().size

	if spawn_count < max_enemies:
		var enemy = enemy_prefab.instantiate()
		var random_x = randf_range(0, screen_size.x)
		enemy.position = Vector2(random_x, -50)


		add_child(enemy)

		#set time until next spawn
		var next_spawn_time = randf_range(min_spawn_time, max_spawn_time)

		if not is_inside_tree():
			return

		await get_tree().create_timer(next_spawn_time).timeout
		spawn_count += 1
		spawn_enemy()

	else:


		var boss = boss_prefab.instantiate()
		boss.position = Vector2(screen_size.x/2, -50)
		add_child(boss)

		boss.connect("died", _on_boss_died)

func _on_boss_died():
	boss_died.emit()
