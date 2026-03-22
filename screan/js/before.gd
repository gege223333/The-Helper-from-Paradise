extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass


func _on_button_pressed() -> void:
    if Global.state_of_disc ==false:
        get_tree().change_scene_to_file("res://screan/main.tscn")
    elif Global.state_of_disc ==true:
        get_tree().change_scene_to_file("res://screan/main(2).tscn")
