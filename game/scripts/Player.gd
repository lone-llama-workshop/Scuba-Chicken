extends KinematicBody2D
class_name QPlayer

onready var state: PlayerState
var prev_state
enum states {
	FLOATING
	SWIMMING
	HIT
	INVALID = -1
}
signal state_changed

var speed: int = 100
var gravity: int = 1500
var swim_velocity: int = -500
var velocity: Vector2 = Vector2()


func _ready() -> void:
	add_to_group(Game.GROUP_PLAYER)
	set_state(states.FLOATING)


func _input(event: InputEvent) -> void:
	state.input(event)


func _physics_process(delta: float) -> void:
	state.update(delta)


func set_state(new_state: int) -> void:
	if state:
		state.exit()

	prev_state = get_state()

	if   new_state == states.FLOATING: state = FloatingState.new(self)
	elif new_state == states.SWIMMING: state = SwimmingState.new(self)
	elif new_state == states.HIT:      state = HitState.new(self)
	else:
		print("Error: Unexpected state (%d)" % new_state)

	emit_signal("state_changed", self)


func get_state() -> int:
	if   state is FloatingState: return states.FLOATING
	elif state is SwimmingState: return states.SWIMMING
	elif state is HitState:      return states.HIT
	else: return states.INVALID


# #############
# STATE MACHINE
# #############
class PlayerState:
	var player: QPlayer

	func _init(player: QPlayer) -> void:
		self.player = player

	func update(delta: float) -> void:
		pass

	func input(event: InputEvent) -> void:
		pass

	func on_body_enter(collision: KinematicCollision2D) -> void:
		pass

	func exit() -> void:
		pass

# -------------------------------------------------------------------------
class FloatingState extends PlayerState:
	func _init(p: QPlayer).(p) -> void:
		player.get_node("Body/Anim").play("float")

	func input(event: InputEvent) -> void:
		if event.is_action_pressed("swim"):
			player.set_state(player.states.SWIMMING)

	func exit() -> void:
		player.get_node("Body/Anim").stop()


# -------------------------------------------------------------------------
class SwimmingState extends PlayerState:
	func _init(p: QPlayer).(p) -> void:
		swim()


	func update(delta: float) -> void:
		player.velocity.x = player.speed
		player.velocity.y += player.gravity * delta
		var collision = player.move_and_collide(player.velocity * delta)
		if collision:
			on_body_enter(collision)


	func input(event: InputEvent) -> void:
		if event.is_action_pressed("swim"):
			swim()


	func swim() -> void:
		player.get_node("Body/Anim").play("swim")
		player.velocity.y = player.swim_velocity


	func on_body_enter(collision: KinematicCollision2D) -> void:
		if collision.collider.is_in_group(Game.GROUP_SEAWEED):
			player.set_state(player.states.HIT)


# -------------------------------------------------------------------------
class HitState extends PlayerState:
	func _init(p: QPlayer).(p) -> void:
		print("HIT! (%s)" % player.position)

	func input(event: InputEvent) -> void:
		if event.is_action_pressed("swim"):
			StageManager.change_scene(StageManager.GAME_STAGE)
