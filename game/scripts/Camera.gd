extends Camera2D
class_name QCamera

onready var player: QPlayer = Utils.get_main_node().get_node("Player")


func _physics_process(delta: float) -> void:
	position.x = player.position.x
	position.y += 1


func get_total_position() -> Vector2:
	return position + offset
