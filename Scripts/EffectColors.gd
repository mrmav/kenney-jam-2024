tool
extends Node
class_name EffectColors

export(float) var speed = 0.2

onready var _target : CanvasItem = get_parent()

var value = 0

func _process(delta):
	if not _target:
		return
	
	value += delta * speed
	var v = float(int(value * 1000) % 1000) / 1000.0
	_target.modulate = _target.modulate.from_hsv(v, _target.modulate.s, _target.modulate.v)
