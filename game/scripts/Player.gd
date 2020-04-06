extends RigidBody2D


func _ready():
	pass


func _process(delta):
	if rad2deg(rotation) < -30:
		angular_velocity = 0
		rotation = deg2rad(-30)

	if linear_velocity.y > 0:
		angular_velocity = 1.5


func _input(event):
	if event.is_action_pressed("swim"):
		swim()


func swim():
	set_axis_velocity(Vector2(linear_velocity.x, -150))
	angular_velocity = -3
