extends Control


func _ready():
	$MarginContainer/DeathLabel.hide()

func display_death():
	$MarginContainer/DeathLabel.show()

func update_health_display(new_health, previous_health, max_health) -> void:
	var tween = create_tween()
	tween.tween_property($MarginContainer2/HealthBar, "value", new_health / max_health, .4
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
