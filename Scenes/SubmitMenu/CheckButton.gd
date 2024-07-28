extends CheckBox

var pulsate_tween : SceneTreeTween = null

var _original_scale = rect_scale

func _ready():
	pulsate_tween = create_tween()
	pulsate_tween.tween_property(self, "rect_scale", Vector2(1.1, 1.1), 1.2)
	pulsate_tween.tween_property(self, "rect_scale", Vector2(0.9, 0.9), 1.2)
	pulsate_tween.set_loops()
	pulsate_tween.set_ease(Tween.EASE_IN_OUT)
	pulsate_tween.stop()
	
	rect_pivot_offset = rect_size / 2.0
	
	group.connect("pressed", self, "_group_pressed")
	
	
func _group_pressed(button : BaseButton):
	if not button == self:
		pulsate_tween.stop()
		rect_scale = _original_scale
		return
		
	pulsate_tween.play()
