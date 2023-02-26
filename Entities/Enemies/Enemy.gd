class_name Enemy
extends Entity


@export var speed = 4.0
@export var jump_velocity = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if not is_staggered():
		calculate_movement_velocity()
		look_at(Global.player.global_position)
	else:
		calculate_stagger_velocity()
	
	move_and_slide()


func calculate_movement_velocity() -> void:
	var desired_dir := global_position.direction_to(Global.player.global_position)
	if desired_dir:
		velocity.x = desired_dir.x * speed
		velocity.z = desired_dir.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

func hit_effect(entity: Entity):
	pass


func _on_hitbox_on_hit(entity_hit) -> void:
	stagger_timer = .4
