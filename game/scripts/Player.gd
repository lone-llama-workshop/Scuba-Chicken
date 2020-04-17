extends KinematicBody2D
class_name QPlayer


var speed: int = 100
var gravity: int = 1500
var swim_velocity: int = -500
var velocity: Vector2 = Vector2()


func _ready() -> void:
	swim()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swim"):
		swim()


func _physics_process(delta: float) -> void:
	velocity.x = speed
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)


func swim() -> void:
	print("swim: %s" % position)
	velocity.y = swim_velocity
