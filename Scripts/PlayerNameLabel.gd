extends Label


func _ready():
	if not PlayerManager.restored:
		PlayerManager.connect("received_player_data", self, "_set_text")
		return

	# already have the necessary data
	_set_text()


func _set_text():
	text = PlayerManager.get_name()
