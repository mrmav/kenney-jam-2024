extends ColorRect

export(PackedScene) var change_to_this_scene = null

func _ready():
	
	if not OS.has_feature("HTML5"):
		# if not running on the web, skip direclty
		get_tree().change_scene_to(change_to_this_scene)
		return
	
	var t = get_tree().create_timer(5)
	yield(t, "timeout")
	
	$Control/AnimationPlayer.play("exit")
	
	yield($Control/AnimationPlayer, "animation_finished")
	get_tree().change_scene_to(change_to_this_scene)
