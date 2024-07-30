extends Node

signal bus_muted
signal ui_click

func _ready():
	connect("bus_muted", self, "_bus_muted")
	connect("ui_click", self, "_on_ui_click")

func _bus_muted(muted):
	$MainMenu.stream_paused = muted


func _on_ui_click():
	$UiClick.play()
