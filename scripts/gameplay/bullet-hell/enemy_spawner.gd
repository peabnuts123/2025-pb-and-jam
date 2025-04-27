extends Area2D

@export var enemy_prefab: PackedScene
@export var boss_prefab: PackedScene
@export var min_spawn_time: float = 0.5  # minimum seconds between spawns
@export var max_spawn_time: float = 2.0  # maximum seconds between spawns

var screen_size: Vector2
var spawn_count: int = 0
var max_enemies: int = 5

func _ready():
	#set level difficulty
	max_enemies = max_enemies * (SaveData.current_run_level +1)
	
	screen_size = get_viewport().get_visible_rect().size
	spawn_enemy()

func spawn_enemy():
	if spawn_count < max_enemies:
		var enemy = enemy_prefab.instantiate()
		var random_x = randf_range(0, screen_size.x)
		enemy.position = Vector2(random_x, -50)

		
		add_child(enemy)
		
		#set time until next spawn
		var next_spawn_time = randf_range(min_spawn_time, max_spawn_time)
		await get_tree().create_timer(next_spawn_time).timeout
		spawn_count += 1
		spawn_enemy()
		
	else:
		
		
		var boss = boss_prefab.instantiate()
		boss.position = Vector2(screen_size.x/2, -50)
		add_child(boss)
			
