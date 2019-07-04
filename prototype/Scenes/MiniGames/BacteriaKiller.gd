extends Node2D

const Bacteria = preload("res://Scenes/Entities/Bacteria.tscn")

const _NUMBER_BACTERIA_PER_WAVE = 20
var _SCREEN_WIDTH
var _SCREEN_HEIGHT

var _bacteria = []
var _pills_left = 3

func _ready():
	_SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
	_SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
	
	for i in range(_NUMBER_BACTERIA_PER_WAVE):
		var b = Bacteria.instance()
		var x = randi() % int(_SCREEN_WIDTH - b.width())
		var y = randi() % int(_SCREEN_HEIGHT - b.height())
		b.position = Vector2(x, y)
		_bacteria.append(b)
		add_child(b)
		
func _input(event):
	if event is InputEventMouseMotion:
		$PlacementCursor.position = event.position

func _on_PlacementCursor_dispensed_pill():
	_pills_left -= 1
	$CanvasLayer/PillsLeftLabel.text = "Pills left: " + str(_pills_left)
	if _pills_left <= 0:
		_game_over()

func _game_over():
	$PlacementCursor.die()
	$CanvasLayer/PillsLeftLabel.visible = false