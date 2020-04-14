extends KinematicBody2D

var speed: int = 100
var gravity: int = 400
var swim_speed: int = -500
var velocity: Vector2 = Vector2.ZERO #Vector2(1, 2)


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swim"):
		#swim()
		pass


func get_input() -> void:
	if Input.is_action_pressed("swim"):
		swim()
		pass


func _physics_process(delta: float) -> void:
	# velocity = velocity.normalized() * speed
	# velocity.x = speed
	velocity.y = gravity
	get_input()
	move_and_collide(velocity * delta)


func swim() -> void:
	print("swim")
	velocity.y = swim_speed
