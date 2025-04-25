extends Label

func _ready():
	self.text = SaveData.game_over_message;
	SaveData.game_over_message = "";
