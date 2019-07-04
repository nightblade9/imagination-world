extends Node2D

const _VELOCITY:int = 100
var _SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var _SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")

var _destination:Vector2
var _tween:Tween # movement tween
var _is_glowing:bool = false

func _ready():
	_pick_destination()
	
func _process(delta):
	if _is_glowing:
		# Map -1 .. 1 to 0.5 .. 1?
		self.modulate.a = 0.5 * (sin(GlobalTimer.elapsed_seconds * 4)) + 0.5
	
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

func glow():
	self._is_glowing = true
	