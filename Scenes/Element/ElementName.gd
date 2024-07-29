extends Label

signal text_changed

func _set(property, value):
	match property:
		"text":
			text = value
			emit_signal("text_changed")
			return true
