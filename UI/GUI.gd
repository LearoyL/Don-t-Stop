extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	set_mouse_filter_recursively(self)

func set_mouse_filter_recursively(node):
	for child in node.get_children():
		if child is Control:
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE
		set_mouse_filter_recursively(child)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
