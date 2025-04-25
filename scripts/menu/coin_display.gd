extends Label

func _ready():
	SaveData.connect('coin_changed', _rebind_coin_text)
	_rebind_coin_text()
	
func _rebind_coin_text():
	self.text = str(SaveData.coin)
