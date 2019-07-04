extends Node2D

const _VELOCITY:int = 100
var _SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var _SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")

var _destination:Vector2
var _tween:Tween

func _ready():
	_pick_destination()
	
func _pick_destination():
	var x = randi() % int(_SCREEN_WIDTH - self.width())
	var y = randi() % int(_SCREEN_HEIGHT - self.height())
	_destination = Vector2(x, y)
	
	# Start tween
	if _tween != null:
		remove_child(_tween)
		
	var duration:float = (_destination - position).length() / _VELOCITY;
	
	_tween = Tween.new()
	_tween.interpolate_property(self, "position", position, _destination,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	_tween.connect("tween_completed", self, "_tween_completed")
	_tween.start()
	
	add_child(_tween)

func width():
	return $ColorRect.margin_right

func height():
	return $ColorRect.margin_bottom
	
func _tween_completed(object, key):
	_pick_destination()

func die():
	print("DIED")
	queue_free()