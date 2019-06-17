extends Node2D

const _VELOCITY:int = 100
var _SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var _SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")

var _destination:Vector2

func _ready():
	_pick_destination()
	
func _pick_destination():
	var x = randi() % int(_SCREEN_WIDTH - self.width())
	var y = randi() % int(_SCREEN_HEIGHT - self.height())
	_destination = Vector2(x, y)

func _process(delta):
	var direction = position - _destination
	direction = direction.normalized()
	position += (direction * _VELOCITY * delta)

func width():
	return $ColorRect.margin_right

func height():
	return $ColorRect.margin_bottom