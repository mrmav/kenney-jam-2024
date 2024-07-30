extends Control



func _ready():
	
	randomize()

	# pick random pattern
	var files = []
	var dir = Directory.new()
	if dir.open("res://Graphics/Textures/Others/Patterns") == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "png":
				files.append("res://Graphics/Textures/Others/Patterns/" + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
		
	$Viewport/CanvasLayer2/TextureRect.texture = load(files.pick_random())
