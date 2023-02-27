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
		var player_pos = Global.player.global_position
		player_pos.y = global_position.y
		look_at(player_pos)
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

func die():
	Global.score += 100
	super.die()

func _on_hitbox_on_hit(entity_hit) -> void:
	stagger_timer = .4
