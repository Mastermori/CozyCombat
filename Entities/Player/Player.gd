class_name Player
extends Entity


@export var speed: float = 10
@export var jump_velocity: float = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var look_sensitivity: float = ProjectSettings.get_setting("player/look_sensitivity")

var dead := false

@onready var hands := $Hands
@onready var right_hand: Hand = $Hands/RightHand
@onready var camera: Camera3D = $Camera3D


func _ready():
	Global.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if not is_staggered():
		calculate_movement_velocity()
	else:
		calculate_stagger_velocity()
	
	move_and_slide()
	
	if not dead:
		if Input.is_action_just_pressed("ui_cancel"): 
			if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
				$HUD.display_paused(false)
				Engine.time_scale = 1
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				$HUD.display_paused(true)
				Engine.time_scale = 0
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func calculate_movement_velocity() -> void:
	if dead:
		return
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

func _input(event):
	if dead:
		return
	if not is_controlling():
		return
	
	if event.is_action_pressed("punch"):
		right_hand.punch()
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * look_sensitivity * .001 * Engine.time_scale)
		camera.rotate_x(-event.relative.y * look_sensitivity * .002 * Engine.time_scale)
		camera.rotation.x = clamp(camera.rotation.x, -PI/4, PI/3)
		hands.rotation = camera.rotation

func die():
	print("You died!")
	Engine.time_scale = .1
	
	$HUD.display_death()
	dead = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func is_controlling() -> bool:
	return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
