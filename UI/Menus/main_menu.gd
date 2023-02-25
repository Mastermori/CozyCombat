extends MarginContainer




func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://World.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Menus/credits_menu.tscn")


func _on_leave_button_pressed() -> void:
	get_tree().quit()
