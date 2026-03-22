extends Node
var energy:int=20
var energy_max:int=20
var capacity:int=0#能力值
var credibility:int=0#信力值
var day:int=0
var time:int=2
var state_of_disc=false
var task1:bool=false
var task2:bool=false
var task3:bool=false
var click1:bool=false
var click:bool=false
var percentage
var day15_triggered: bool = false
var day20_triggered: bool = false
var day30_triggered: bool = false
var all_tasks_completed: bool:
    get:
        return task1 and task2 and task3
func _ready():
    Dialogic.signal_event.connect(_on_dialogic_signal)  

func _on_dialogic_signal(argument: String):
    if argument == "start_dancing": 
        change_to_dance_scene()
    elif argument == "回到标题界面":
        get_tree().change_scene_to_file("res://标题界面/标题界面.tscn")
    elif argument =="回到主界面":
        get_tree().change_scene_to_file("res://家里/主场景.tscn")
     
func change_to_dance_scene():
    # 使用 Godot 内置函数切换场景
    get_tree().change_scene_to_file("res://隐藏关卡/开始游戏界面.tscn") 
func advance_time():
    if time > 2:
        time = 0
        day += 1
#0：早上 1：下午 2：晚上
func _process(delta):
    check_day_dialogs()

func check_day_dialogs():
    # 检查第15天对话
    if day == 10 and not day15_triggered:
        # 确保没有其他对话正在进行
        if not is_dialog_active():
            get_tree().change_scene_to_file("res://过渡.tscn") 
            Dialogic.start("15天的对话-小艾")
            day15_triggered = true
    
    # 检查第20天对话
    if day == 15 and not day20_triggered:
        if not is_dialog_active():
            get_tree().change_scene_to_file("res://过渡.tscn") 
            Dialogic.start("20天的对话-彩票")
            day20_triggered = true
    
    # 检查第30天结局
    if day == 31 and not day30_triggered and not all_tasks_completed:
        day30_triggered = true

        # 等待一帧再开始新对话
        await get_tree().process_frame
        Dialogic.start("儿孙自有儿孙福")
        
func is_dialog_active() -> bool:
    return get_tree().get_nodes_in_group("dialogic").size() > 0
