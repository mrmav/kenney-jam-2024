extends NinePatchRect


var pulsate_tween = create_tween()

func _ready():
	rect_pivot_offset = rect_size / 2.0
	
	pulsate_tween = create_tween()
	pulsate_tween.tween_property(self, "rect_scale", Vector2(1.05, 1.05), 0.5)
	pulsate_tween.tween_property(self, "rect_scale", Vector2(0.95, 0.95), 0.5)
	pulsate_tween.set_loops()
	pulsate_tween.set_ease(Tween.EASE_IN_OUT)
	pulsate_tween.set_trans(Tween.TRANS_ELASTIC)
	pulsate_tween.play()
	
