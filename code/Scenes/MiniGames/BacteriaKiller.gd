extends Node2D

const Bacteria = preload("res://Scenes/Entities/Bacteria.tscn")

const _NUMBER_BACTERIA_PER_WAVE = 5
var _SCREEN_WIDTH
var _SCREEN_HEIGHT

var _bacteria = []

func _ready():
	_SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
	_SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/width")
	
	for i in range(_NUMBER_BACTERIA_PER_WAVE):
		var b = Bacteria.instance()
		var x = randi() % int(_SCREEN_WIDTH - b.width())
		var y = randi() % int(_SCREEN_HEIGHT - b.height())
		b.position = Vector2(x, y)
		add_child(b)
		