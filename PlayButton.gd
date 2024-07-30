extends Button


func _pressed():
	Audio.emit_signal("ui_click")
	get_tree().change_scene("res://Main.tscn")
