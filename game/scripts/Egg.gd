extends Area2D


func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(other_body: Node) -> void:
	if other_body.is_in_group(Game.GROUP_PLAYER):
		Game.score_current += 1
		queue_free()
