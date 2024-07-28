extends Control

func _ready():
	owner.connect("game_ready", $AnimationPlayer, "play", ["fade_in"])
