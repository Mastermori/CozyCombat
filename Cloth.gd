extends SoftBody3D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	mesh.get_incoming_connections()
