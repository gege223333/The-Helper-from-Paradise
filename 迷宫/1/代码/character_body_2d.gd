extends CharacterBody2D

@export var M_move_speed:float= 100
# Called when the node enters the scene tree for the first time.
func _physics_process(_delta: float) -> void:
	if get_tree().current_scene.is_game_over==0:
		
		move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
