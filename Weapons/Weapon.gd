class_name Weapon
extends Node3D

var active := false : set = set_active

func _ready() -> void:
	$Hitbox.knockback_source_node = owner

func set_active(value: bool) -> void:
	$Hitbox.monitoring = value
	active = value

func hit_effect(entity: Entity) -> void:
	var feather_particles = preload("res://Weapons/feather_particles.tscn").instantiate()
	$ParticleContainer.add_child(feather_particles)
	feather_particles.global_position = entity.global_position
	feather_particles.global_position += entity.velocity * .05
	var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
	feather_particles.global_position.y += gravity * .05
#	feather_particles.global_position.y += 1
	feather_particles.restart()
	feather_particles.emitting = true
	await get_tree().create_timer(1.5).timeout
	feather_particles.queue_free()
