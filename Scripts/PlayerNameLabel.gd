extends Label


func _ready():
	PlayerManager.connect("received_player_data", self, "_set_text")


func _set_text():
	text = PlayerManager.get_name()
