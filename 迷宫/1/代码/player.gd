extends CharacterBody2D

@export var C_move_speed: float = 1000

func _physics_process(_delta: float) -> void:
    if not get_tree().current_scene.is_game_over:  # 修复后的条件判断
        velocity = Input.get_vector("left", "right", "up", "down") * C_move_speed
        move_and_slide()
