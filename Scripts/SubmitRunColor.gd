extends Button
class_name SubmitRunColorButton

export(int) var color_index = 0

onready var button_ref = $"../../ButtonsContainer/Button-nigredo"

func _ready():
	pass


func get_checked_color():
	
	var button_group : ButtonGroup = button_ref.group
	var choice = button_group.get_pressed_button()
	
	if choice:
		return choice.modulate
	
	return null


func _pressed():
	
	var color = get_checked_color()
	if color == null:
		GlobalAccess.prepare_new_run()
		return
	
	disabled = true
	# prepare the data:
	var data = GlobalAccess.run_nodes
	
	#endpoint : String, caller : Object, callback : String, parameters : Dictionary = {}
	RequestManager.make_request("submit_colors", GlobalAccess, "_on_run_submit_reply", \
		{
			"recipe" : data,
			"color": JSON.print(
				{
					"r": color.r8,
					"g": color.g8,
					"b": color.b8,
					"a": color.a8
				}
			)
		}, true)
