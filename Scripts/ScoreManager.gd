extends Node

signal received_player_score

var last_player_score : float = -1.0 setget set_player_score

func set_player_score(value : float):
	# Do not set score twice.
	if last_player_score > -1.0:
		return
	
	last_player_score = value
	emit_signal("received_player_score")


func reset_state():
	# Wont use the setter.
	# If we wanted to use the setter while calling
	# from own class, we would have to: self.last_player_score = -1
	last_player_score = -1.0

