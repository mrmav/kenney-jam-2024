extends Node
class_name ColorPulse

export(Color) var target = Color.cornflower

var pulsate_tween : SceneTreeTween = null
var original_modulate : Color = Color.white


func _ready():
	
	original_modulate = get_parent().modulate
	
	pulsate_tween = create_tween()
	pulsate_tween.tween_property(get_parent(), "modulate", target, 2)
	pulsate_tween.tween_property(get_parent(), "modulate", original_modulate, 2)
	pulsate_tween.set_loops()
	pulsate_tween.set_ease(Tween.EASE_IN_OUT)
	pulsate_tween.play()
	
