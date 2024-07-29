extends CPUParticles2D

export(NodePath) var line_path = null

onready var line : Line2D = get_node_or_null(line_path)

func activate():
	
	line.points
