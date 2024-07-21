extends Control

signal drag 
signal zoom 

func _input(event):
	
	
	if event is InputEventScreenDrag:
		var evt = event as InputEventScreenDrag
		emit_signal("drag", evt.relative)
	
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		if evt.doubleclick:
			emit_signal("zoom")
