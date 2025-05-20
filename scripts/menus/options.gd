extends MarginContainer
const TITLESCREEN: String = "res://scenes/menus/titlescreen.tscn"

func _on_back_pressed() -> void:
		get_tree().change_scene_to_file(TITLESCREEN)


func _on_graphics_pressed() -> void:
	pass # Replace with function body.


func _on_sound_pressed() -> void:
	pass # Replace with function body.
