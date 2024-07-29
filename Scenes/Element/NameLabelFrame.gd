extends NinePatchRect

func _ready():
	get_child(0).connect("text_changed", self, "_resize")
	_resize()
	
	
func _resize():
	rect_size = get_child(0).get_font("font").get_string_size(get_child(0).text + "       ")
