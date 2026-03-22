extends Node2D


func _on_喜爱之曲_pressed() -> void:
    get_tree().change_scene_to_file("res://screan/main.tscn")


func _on_定情之曲_pressed() -> void:
    get_tree().change_scene_to_file("res://screan/main(2).tscn")
