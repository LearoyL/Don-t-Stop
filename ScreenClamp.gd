# extends Node

# export var margin: Vector2 = Vector2.ZERO

# var screen_size: Vector2

# func _ready():
#     screen_size = get_viewport().get_visible_rect().size
#     get_viewport().connect("size_changed", self, "_on_viewport_size_changed")

# func _process(_delta):
#     var parent = get_parent()
#     if parent is Node2D:
#         parent.position.x = clamp(parent.position.x, margin.x, screen_size.x - margin.x)
#         parent.position.y = clamp(parent.position.y, margin.y, screen_size.y - margin.y)

# func _on_viewport_size_changed():
#     screen_size = get_viewport().get_visible_rect().size

extends Node

export var margin: Vector2 = Vector2.ZERO
export var ignore_groups: Array = ["bullets"]

var screen_size: Vector2

func _ready():
    screen_size = get_viewport().get_visible_rect().size
    get_viewport().connect("size_changed", self, "_on_viewport_size_changed")

func _process(_delta):
    var parent = get_parent()
    if parent is Node2D and not is_in_ignore_group(parent):
        parent.position.x = clamp(parent.position.x, margin.x, screen_size.x - margin.x)
        parent.position.y = clamp(parent.position.y, margin.y, screen_size.y - margin.y)

func _on_viewport_size_changed():
    screen_size = get_viewport().get_visible_rect().size

func is_in_ignore_group(node: Node) -> bool:
    for group in ignore_groups:
        if node.is_in_group(group):
            return true
    return false