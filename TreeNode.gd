tool
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		var line = Line2D.new()
		line.add_point(self.global_position)
		line.add_point(child.global_position)
		add_child(line)
