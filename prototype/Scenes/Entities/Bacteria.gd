extends Node2D

var Bacteria = get_script()

const _VELOCITY:int = 100
var _SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var _SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")

var _destination:Vector2
var _tween:Tween # movement tween
var _death_tween:Tween
var _is_glowing:bool = false
var _glow_from:int = 0

func _ready():
	_pick_destination()
	
func _process(delta):
	if _is_glowing:
		# Map -1 .. 1 to 0.5 .. 1?
		self.modulate.a = 0.5 * (sin(GlobalTimer.elapsed_seconds * 4)) + 0.5
	
	var now = OS.get_ticks_msec()
	if _is_glowing and (now - _glow_from) >= 5000:
		die()
	
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
	if not self._is_glowing:
		self._is_glowing = true
		self._glow_from = OS.get_ticks_msec()

func die():
	get_parent().remove_child(self)
	queue_free()

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if _is_glowing and area != null:
		var parent = area.get_parent()
		if parent is Bacteria:
			parent.glow()
