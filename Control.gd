extends ColorRect


var value = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value += delta * 0.2
	var v = float(int(value * 1000) % 1000) / 1000.0
	color = color.from_hsv(v, 0.8, 0.7)
