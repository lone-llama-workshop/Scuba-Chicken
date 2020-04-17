extends StaticBody2D
class_name QSeaweed

onready var bottomRight: Position2D = $BottomRight
onready var camera: QCamera = Utils.get_main_node().get_node("Camera")


func _ready() -> void:
	add_to_group(Game.GROUP_SEAWEED)


func _process(delta: float) -> void:
	if camera == null: return

	if bottomRight.global_position <= camera.get_global_position():
		queue_free()
