extends Control
@onready var Currentscene = $CanvasLayer/云朵/currentscene
@onready var 草丛=$CanvasLayer/草丛
var click_count=0
func _ready() -> void:
    Currentscene.texture = load("res://背景素材/街道/街道-白天.png") 
    Dialogic.start("main", "小艾场景")

func _on_云朵_pressed() -> void:
    pass # Replace with function body.


func _on_草丛_pressed() -> void:
    click_count += 1
    if click_count==1:
        Dialogic.start("main","草丛1")
    if click_count==3:
        Dialogic.start("main","草丛3")
    if click_count==5:
 
        Dialogic.start("main","草丛5")
        @warning_ignore("standalone_expression")
        Global.state_of_disc = true

    
func _on_衣服_pressed() -> void:
    pass # Replace with function body.


func _on_纸片_pressed() -> void:
    pass # Replace with function body.


func _on_树_pressed() -> void:
    pass # Replace with function body.
