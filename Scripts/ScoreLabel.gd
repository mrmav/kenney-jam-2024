extends Label

func _ready():
	# When this label enters the tree, the player score should already be available.
	text = text % [ScoreManager.last_player_score]
