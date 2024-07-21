extends Control

signal drag 
signal zoom 

var DOUBLE_TAP_TIME = 0.2
var listen_for_double = false
var last_click_time = 0

func _input(event):
		
	if event is InputEventScreenDrag:
		var evt = event as InputEventScreenDrag
		emit_signal("drag", evt.relative)
		
	if event is InputEventMouseButton:
		var evt = event as InputEventMouseButton
		if evt.pressed:
			
			# Because HTML5 touch screen is a bit wonky, we make our own 
			# double tap/press logic.
			
			var t = get_tree().create_timer(DOUBLE_TAP_TIME)
			t.connect("timeout", self, "set", ["listen_for_double", false])
			
			if listen_for_double:
				# Is a double tap
				emit_signal("zoom")
				listen_for_double = false
			else:
				listen_for_double = true
			
