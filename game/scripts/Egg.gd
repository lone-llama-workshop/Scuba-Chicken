extends Area2D


onready var target: Node


func _ready() -> void:
	connect("body_shape_entered", self, "_on_body_shape_entered")


func _on_body_shape_entered(body_id: int, other_body: Node, body_shape: int, area_shape: int) -> void:
	print("body_id: %s, other_body: %s, body_shape: %s, area_shape: %s" % [body_id, other_body, body_shape, area_shape])

	if other_body.is_in_group(Game.GROUP_PLAYER):
		if area_shape == 0:
			print("pickup")
			Game.score_current += 1
			queue_free()

		elif area_shape ==1:
			print("aggro")
			target = other_body


func _physics_process(delta: float) -> void:
	if target:
		print("pos: %s, tar: %s" % [global_position, target.global_position])
		# global_position -= lerp(global_position, target.global_position, 0.01) * delta
