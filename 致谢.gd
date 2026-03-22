extends Node2D


func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://标题界面/标题界面.tscn")
