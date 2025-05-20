extends MarginContainer

const OPTIONS: String = "res://scenes/menus/options.tscn"
const TITLESCREEN: String = "res://scenes/menus/titlescreen.tscn"

func _on_save_pressed() -> void:
	pass # Replace with function body.


func _on_load_map_pressed() -> void:
	pass # Replace with function body.


func _on_high_scores_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file(OPTIONS)

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file(TITLESCREEN)
