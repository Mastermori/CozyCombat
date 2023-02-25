class_name Enemy
extends Entity


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var knockback_drag: float = .1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var stagger_timer: float = 0

func _process(delta: float) -> void:
	if stagger_timer > 0:
		stagger_timer -= delta

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if velocity.length() < 1:
		unstagger()
	
	if not is_staggered():
		calculate_movement_velocity()
	else:
		calculate_stagger_velocity()
	
	move_and_slide()

func calculate_stagger_velocity() -> void:
	velocity = velocity.lerp(Vector3.ZERO, knockback_drag)

func calculate_movement_velocity() -> void:
	var desired_dir := Vector3(0, 0, 0)
	var direction := (transform.basis * Vector3(desired_dir.x, 0, desired_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func knockback(direction: Vector3, strength: float):
	super.knockback(direction, strength)
	stagger_timer = 9999

func is_staggered() -> bool:
	return stagger_timer > 0

func unstagger() -> void:
	stagger_timer = 0
