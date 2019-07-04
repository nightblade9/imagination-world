extends Node2D

const Bacteria = preload("res://Scenes/Entities/Bacteria.gd")

var _targets = []

func _on_Area2D_input_event(viewport, event, shape_idx):
	# TODO: android support
	print("KABOOM!!!!")
	
	for target in _targets:
		target.glow()
		
	#queue_free()

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	var bacteria = area.get_parent()
	_targets.append(bacteria)

func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	if area != null:
		var bacteria = area.get_parent()
		_targets.remove(_targets.find(bacteria))