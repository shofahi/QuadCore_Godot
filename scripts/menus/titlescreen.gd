extends MarginContainer

const MAIN_MENU: String = "res://scenes/menus/main_menu.tscn"
const OPTIONS: String = "res://scenes/menus/options.tscn"

const textSize: int = 50

func _on_continue_button_pressed() -> void:
	pass # Replace with function body.


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU)

func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file(OPTIONS)

func _on_exit_button_pressed() -> void:
	pass # Replace with function body.
