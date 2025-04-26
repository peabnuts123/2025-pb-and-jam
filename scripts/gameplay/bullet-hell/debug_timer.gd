extends Label

func _ready():
	for i in range(100,0,-1):
		self.text = str(i)
		await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/gameplay/decision_screen.tscn")
