extends Control
@onready var continue_button = $VBoxContainer/继续
@onready var credits_button = $VBoxContainer/致谢 
func _ready() :
    update_credits_button_visibility()  
func _on_新游戏_pressed() -> void:
    get_tree().change_scene_to_file("res://scene/天堂街道.tscn")
    if not FileAccess.file_exists("user://settings.cfg"):
        continue_button.disabled = true
        continue_button.text = "继续 (无存档)"
func update_credits_button_visibility():
    if Global.task1 and Global.task2 and Global.task3:
        credits_button.visible = true
    else:
        credits_button.visible = false
func _on_继续_pressed() -> void:
    
    if FileAccess.file_exists("user://save.dat"):
        var file = FileAccess.open("user://save.dat", FileAccess.READ)
        var data = file.get_var()
        file.close()
        
        # 加载游戏数据
        var game_data = data["game_data"]
        Global.capacity = game_data["capacity"]
        Global.energy = game_data["energy"]
        Global.energy_max = game_data["energy_max"]
        Global.credibility = game_data["credibility"]
        Global.day = game_data["day"]
        Global.time = game_data["time"]
        Global.state_of_disc=game_data["state_of_disc"]
        Global.task1=game_data["task1"]
        Global.task2=game_data["task2"]
        Global.task3=game_data["task3"]
        #Global.click=game_data["click"]
        #Global.click1=game_data["click1"]
        Global.click = game_data.get("click", false)
        Global.click1 = game_data.get("click1", false)
        Global.day15_triggered = game_data.get("day15_triggered", false)
        Global.day20_triggered = game_data.get("day20_triggered", false)
        Global.day30_triggered = game_data.get("day30_triggered", false)
        
        # 加载对话进度
        Dialogic.Save.load("slot1")
        get_tree().change_scene_to_file("res://家里/主场景.tscn")
    
    update_credits_button_visibility()  

func _on_退出游戏_pressed() -> void:
    get_tree().quit() # Replace with function body.


func _on_致谢_pressed() -> void:
    get_tree().change_scene_to_file("res://致谢.tscn")
