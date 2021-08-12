extends Sprite

func _onPlayerEnter(area) -> void:
	get_tree().change_scene("res://Scenes/Levels/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")

