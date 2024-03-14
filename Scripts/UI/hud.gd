extends CanvasLayer

signal on_beat(measure : int, beat : int)

var grabbedNode : Control = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var selectedZIndex = -INF
			for node in get_tree().get_nodes_in_group("Sequencables"):
				if node.z_index > selectedZIndex and Rect2(Vector2.ZERO, node.size).has_point(node.get_local_mouse_position()):
					grabbedNode = node
		elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			grabbedNode = null
	
	if event is InputEventMouseMotion:
		if grabbedNode:
			grabbedNode.position += event.relative


func _on_sequencer_on_beat(measure : int, beat : int):
	emit_signal("on_beat", measure, beat)
