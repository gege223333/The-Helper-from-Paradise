extends Sprite2D
const SAVE_PATH="user://data.sav"


    
func _ready() -> void: 
    Dialogic.start("main")
    Dialogic.signal_event.connect(_on_dialogic_signal)


func _on_dialogic_signal(argument:String):
    if argument == "change_to_主界面":
        get_tree().change_scene_to_file("res://家里/主场景.tscn")

func load_game() -> void:
    pass

func save_game()->void:
    var data:={
        
    }
