extends CanvasLayer

signal on_beat(measure : int, beat : int)

var grabbedNode : Control = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if grabbedNode:
		#grabbedNode.position = grabbedNode.get_global_mouse_position()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var sequencables = get_tree().get_nodes_in_group("Sequencables")
			var sortedSequencableIndices := range(len(sequencables))
			sortedSequencableIndices.sort_custom(func(a : int, b : int): return sequencables[a].z_index > sequencables[b].z_index)
			
			for i in sortedSequencableIndices:
				print(sequencables[i].name, ": ", sequencables[i].z_index)
			
			var highestSelectedIndex = -1
			for ii in range(len(sortedSequencableIndices)):
				var i = sortedSequencableIndices[ii]
				if Rect2(Vector2.ZERO, sequencables[i].size).has_point(sequencables[i].get_local_mouse_position()):
					grabbedNode = sequencables[i]
					highestSelectedIndex = ii
					break
			print(highestSelectedIndex)
			if highestSelectedIndex != -1:
				for i in range(highestSelectedIndex, 0, -1):
					var temp = sortedSequencableIndices[i]
					sortedSequencableIndices[i] = sortedSequencableIndices[i - 1]
					sortedSequencableIndices[i - 1] = temp
				
				for i in range(len(sortedSequencableIndices)):
					sequencables[sortedSequencableIndices[i]].z_index = len(sortedSequencableIndices) - i
					
		elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			grabbedNode = null
	
	if event is InputEventMouseMotion:
		if grabbedNode:
			grabbedNode.position += event.relative


func _on_sequencer_on_beat(measure : int, beat : int):
	emit_signal("on_beat", measure, beat)
