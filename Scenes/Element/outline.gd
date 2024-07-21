extends Sprite

func _ready():
	
	if NodesColors.initialized:
		modulate = NodesColors.get_node_color(get_)
