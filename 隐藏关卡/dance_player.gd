extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if $"../AudioStreamPlayer2D".playing:
        if Input.is_action_pressed("down-arr"):
            animated_sprite.play("down")
        if Input.is_action_pressed("up-arr"):
            animated_sprite.play("up")
        if Input.is_action_pressed("left-arr"):
            animated_sprite.play("left")
        if Input.is_action_pressed("right-arr"):
            animated_sprite.play("right")
