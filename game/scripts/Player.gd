extends KinematicBody2D
class_name QPlayer


var speed: int = 100
var gravity: int = 1500
var swim_direction: Vector2 = Vector2(3, 4)
var swim_velocity: int = -500
var velocity: Vector2 = Vector2()


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swim"):
		print("swim")
		velocity.y = swim_velocity


func _get_input() -> void:
	if Input.is_action_pressed("swim"):
		swim()
		pass


func _physics_process(delta: float) -> void:
	_get_input()
	# velocity = velocity.normalized() * speed
	velocity.x = speed
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity)


func swim() -> void:
	pass
