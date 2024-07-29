tool
extends ColorRect
export(float) var speed = 0.2

var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalAccess.connect("received_results", self, "on_results")
	

func on_results(results):
	if results.result == 100:
		speed = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value += delta * speed
	var v = float(int(value * 1000) % 1000) / 1000.0
	color = color.from_hsv(v, color.s, color.v)
	
	$TextureRect.modulate = color.darkened(0.05)
