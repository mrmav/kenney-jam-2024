extends Button
class_name SubmitRunColorButton

export(int) var color_index = 0

onready var nigredo_option  = $"../../../../../TintRun/VBoxContainer/NinePatchRect/ButtonsContainer/Button-nigredo"
onready var albedo_option   = $"../../../../../TintRun/VBoxContainer/NinePatchRect/ButtonsContainer/Button-albedo"
onready var citrinas_option = $"../../../../../TintRun/VBoxContainer/NinePatchRect/ButtonsContainer/Button-citrinas"
onready var rubedo_option   = $"../../../../../TintRun/VBoxContainer/NinePatchRect/ButtonsContainer/Button-rubedo"

func _ready():
	pass


func get_checked_color():
	if nigredo_option.pressed:
		return nigredo_option.modulate
	if albedo_option.pressed:
		return albedo_option.modulate
	if citrinas_option.pressed:
		return citrinas_option.modulate
	if rubedo_option.pressed:
		return rubedo_option.modulate
	
	return null


func _pressed():
	
	var color = get_checked_color()
	if color == null:
		return
	
	disabled = true
	# prepare the data:
	var data = GlobalAccess.run_nodes
	
	#endpoint : String, caller : Object, callback : String, parameters : Dictionary = {}
	RequestManager.make_request("submit_colors", self, "_on_server_reply", \
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


func _on_server_reply(body : PoolByteArray):
	disabled = false
	GlobalAccess.reset_state()
	get_tree().change_scene("res://Main.tscn")
