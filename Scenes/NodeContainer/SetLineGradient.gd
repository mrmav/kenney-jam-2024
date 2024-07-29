extends Line2D


func set_color(color_a : Color, color_b : Color):
	
	if not gradient:
		return
		
	gradient.colors[0] = color_a
	gradient.colors[1] = color_b
