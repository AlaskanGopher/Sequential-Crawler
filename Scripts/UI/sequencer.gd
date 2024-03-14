extends Control

@export_range(0, 240, 1.0, "or_greater") var BEATS_PER_MINUTE : float = 120.0
@export_range(1, 4, 1, "or_greater") var NUM_MEASURES : int = 4
@export_range(1, 4, 1, "or_greater") var BEATS_PER_MEASURE : int = 4

var measures := []
var currentMeasure : int = -1

signal on_beat(measure : int, beat : int)

func add_barline():
	var barline = ColorRect.new()
	barline.custom_minimum_size = Vector2(2, 30)
	$MeasureContainer.add_child(barline)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(NUM_MEASURES):
		add_barline()
		var measure := Measure.new(BEATS_PER_MEASURE)
		measure.connect("measureFinished", _on_measure_finished)
		measures.append(measure)
		$MeasureContainer.add_child(measure)
	add_barline()
	$TempoTimer.wait_time = 60.0 / BEATS_PER_MINUTE
	$TempoTimer.start()
	_on_measure_finished()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tempo_timer_timeout():
	if measures[currentMeasure].currentBeat != measures[currentMeasure].NUM_BEATS-1:
		$AudioStreamPlayer.pitch_scale = 1
		$AudioStreamPlayer.play()
	emit_signal("on_beat", currentMeasure, measures[currentMeasure].currentBeat + 1)
	measures[currentMeasure].progressSequence()

func _on_measure_finished():
	$AudioStreamPlayer.pitch_scale = 2
	$AudioStreamPlayer.play()
	
	currentMeasure += 1
	currentMeasure %= len(measures)
	measures[currentMeasure].progressSequence()

func _input(event):
	pass
