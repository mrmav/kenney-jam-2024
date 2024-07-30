extends Node

signal bus_muted

func _ready():
	connect("bus_muted", self, "_bus_muted")
	

func _bus_muted(muted):
	$MainMenu.stream_paused = muted
