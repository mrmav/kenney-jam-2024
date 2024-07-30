extends Button

func _pressed():
	var bus_index = AudioServer.get_bus_index("Master")
	var bus_muted = AudioServer.is_bus_mute(bus_index)
	AudioServer.set_bus_mute(bus_index, not bus_muted)
	Audio.emit_signal("bus_muted", not bus_muted)
	
	text = "Audio: %s" % ["on" if bus_muted else "off"]
