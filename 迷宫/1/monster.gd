extends Area2D

@export var move_speed: float = 200  # 移动速度(像素/秒)
var is_moving: bool = true

func _physics_process(delta: float) -> void:
    if not get_tree().current_scene.is_game_over: 
        # 向右移动
        position.x += move_speed * delta
    if get_tree().current_scene.has_method("is_game_over") and get_tree().current_scene.is_game_over():
        is_moving = false
func _on_body_entered(body: Node2D) -> void:
    if body is CharacterBody2D:
        get_tree().current_scene.lose_game_over()
        is_moving = false
