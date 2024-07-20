extends TextureRect

# Export variables for easy tweaking in the editor
export var move_speed : float = 3.0 # Pixels per second
export var move_distance : float = 4.0 # Total distance to move up and down

var start_position : Vector2
var direction : int = 1 # 1 for moving up, -1 for moving down

func _ready():
	start_position = rect_position

func _process(delta):
	# Calculate the new position
	rect_position.y += move_speed * direction * delta

	# Check if we need to change direction
	if abs(rect_position.y - start_position.y) > move_distance:
		direction *= -1
