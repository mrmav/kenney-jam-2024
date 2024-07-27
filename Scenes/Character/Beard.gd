extends Control

var pulsate_tween: SceneTreeTween = null

var _original_scale = rect_scale


func _ready():
	rect_pivot_offset = rect_size / 2.0


func animate():
	if pulsate_tween:
		pulsate_tween.kill()

	pulsate_tween = create_tween()
	pulsate_tween.tween_property(self, "rect_rotation", 6, 0.1)
	pulsate_tween.tween_property(self, "rect_rotation", -6, 0.1)
	pulsate_tween.set_loops(4)
	pulsate_tween.tween_property(self, "rect_rotation", 0, 0.05)
	pulsate_tween.set_ease(Tween.EASE_IN_OUT)
	pulsate_tween.set_trans(Tween.TRANS_ELASTIC)
	pulsate_tween.play()
