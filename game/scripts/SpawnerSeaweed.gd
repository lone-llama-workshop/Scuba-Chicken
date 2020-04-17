extends Node2D
class_name QSpawnerSeaweed

onready var scnSeaweed: PackedScene = preload("res://scenes/Seaweed.tscn")

const SEAWEED_WIDTH: int = 64
const OFFSET_X: int = 250
const OFFSET_Y: int = 400
const INITIAL_SPAWNS: int = 3


func _ready() -> void:
	var viewportSize: Vector2 = get_viewport_rect().size
	position = viewportSize

	for i in range(INITIAL_SPAWNS):
		spawn_and_move()


func spawn_and_move() -> void:
	spawn()
	move()


func move() -> void:
	randomize()

	var nextPosition: Vector2 = position
	var viewportSize: Vector2 = get_viewport_rect().size

	nextPosition.x += (SEAWEED_WIDTH / 2) + (OFFSET_X) + (SEAWEED_WIDTH / 2)
	nextPosition.y += rand_range((0 + OFFSET_Y), viewportSize.y - OFFSET_Y)

	position = nextPosition


func spawn() -> void:
	var newSeaweed: QSeaweed = scnSeaweed.instance()
	newSeaweed.connect("tree_exited", self, "spawn_and_move")
	newSeaweed.position = position
	$Container.call_deferred("add_child", newSeaweed)
