extends Node

const GROUP_SEAWEED = "seaweed"
const GROUP_PLAYER  = "player"

var score_current: int = 0 setget _set_score_current
var score_best: int = 0 setget _set_score_best
var is_paused: bool = false

signal score_changed


func _ready() -> void:
	pause_mode = Node.PAUSE_MODE_PROCESS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		is_paused = !is_paused
		get_tree().paused = is_paused


func _set_score_current(new_value: int) -> void:
	score_current = new_value
	_set_score_best(new_value)
	emit_signal("score_changed")
	print("Current Score: %s" % score_current)


func _set_score_best(new_value: int) -> void:
	if new_value > score_best:
		score_best = new_value
