extends RigidBody2D

class_name rigidBodyBox
var boxPosi
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if position.y>1060:
        Hideself()

func SetboxPoi(boxPoi:int):
    boxPosi=boxPoi
    
func GetboxPoi()->int:
    return boxPosi

func Hideself():
    hide()
