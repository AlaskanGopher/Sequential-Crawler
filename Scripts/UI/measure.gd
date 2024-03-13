extends HBoxContainer
class_name Measure

@export_range(1, 6, 1, "or_greater") var NUM_BEATS : int = 4

var beats := []
var currentBeat : int = -1

signal measureFinished

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(self.NUM_BEATS):
		var beat := ColorRect.new()
		beat.custom_minimum_size = Vector2(50, 50)
		beat.size_flags_horizontal = Control.SIZE_FILL
		beat.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		beats.append(beat)
		add_child(beat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func progressSequence():
	if self.currentBeat != -1:
		beats[currentBeat].color = Color.WHITE
	self.currentBeat += 1
	if self.currentBeat < len(beats):
		beats[currentBeat].color = Color.LIGHT_GRAY
	else:
		self.currentBeat = -1
		emit_signal("measureFinished")
