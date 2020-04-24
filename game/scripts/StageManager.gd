extends CanvasLayer

const GAME_STAGE: String = "res://stages/GameStage.tscn"

var is_changing: bool = false

signal stage_changed

func _ready() -> void:
	pass # Replace with function body.

func change_scene(stage: String) -> void:
	if is_changing: return

	is_changing = true
	get_tree().get_root().set_disable_input(true)
	layer = 5

	$Anim.play("fade_in")
	yield($Anim, "animation_finished")

	get_tree().change_scene(stage)
	emit_signal("stage_changed")

	$Anim.play("fade_out")
	yield($Anim, "animation_finished")

	layer = 1
	get_tree().get_root().set_disable_input(false)
	is_changing = false
