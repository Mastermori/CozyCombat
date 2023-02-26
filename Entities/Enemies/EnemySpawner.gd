extends Marker3D


@export var enemy_scene: PackedScene
@export var delay_min: float = 2
@export var delay_max: float = 10

@onready var timer := $Timer

func _ready():
	start_timer()

func start_timer():
	timer.start(randf_range(delay_min, delay_max))

func spawn_enemy():
	var enemy: Enemy = preload("res://Entities/Enemies/Enemy.tscn").instantiate()
	Global.level.find_child("Entities").add_child(enemy)
	enemy.global_position = global_position
	enemy.global_position.y += .1


func _on_timer_timeout() -> void:
	start_timer()
	spawn_enemy()
