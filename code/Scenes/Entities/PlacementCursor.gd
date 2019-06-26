extends Node2D

var _targets = []

func _on_Area2D_input_event(viewport, event, shape_idx):
	# TODO: android support
	print("KABOOM!!!!")
	get_parent().remove_child(self)
	
	for target in _targets:
		get_parent().remove_child(target)
		
	queue_free()

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	_targets.append(area)

func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	_targets.remove(_targets.find(area))