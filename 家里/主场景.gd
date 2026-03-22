extends Control
@onready var currentroom = $CurrentRoom
@onready var 信件面板=$客厅家具按钮/信件任务面板
@onready var 家书 = $客厅家具按钮/家书
@onready var 收起信件 = $客厅家具按钮/信件任务面板/收起信件
var last_time = -1  # 用于记录上一次的 Global.time 值



func _process(delta):  
    if Global.time != last_time:
        last_time = Global.time
        change_scene()
    $UI/能力值.text = str(Global.capacity)
    $UI/当前精力值.text = str(Global.energy)
    $UI/最大精力值.text = str(Global.energy_max)
    $UI/当前天数.text = str(Global.day)
    $UI/信力值.text = str(Global.credibility)
    
func _ready()->void:
    change_scene()
    Dialogic.signal_event.connect(_on_dialogic_signal)
    家书.pressed.connect(_打开信件面板)
    收起信件.pressed.connect(_关闭信件面板)
    
func change_scene():
    if Global.time == 0:
        currentroom.texture = load("res://背景素材/主界面（客厅）/客厅-白天.png")
    elif Global.time == 1:
        currentroom.texture = load("res://背景素材/主界面（客厅）/客厅-下午.png")
    elif Global.time == 2:
        currentroom.texture = load("res://背景素材/主界面（客厅）/客厅-晚上.png")
        
func _打开信件面板():
    信件面板.show()  # 显示面板

func _关闭信件面板():
    信件面板.hide()  # 隐藏面板   



func _on_dialogic_signal(argument:String):
    if argument == "change_to_主界面":
        get_tree().change_scene_to_file("res://家里/主场景.tscn")
    


func _on_沙发_pressed() -> void:
   pass# Replace with function body.


func _on_电脑_pressed() -> void:
    pass

func _on_夫妻卧室_pressed() -> void:
    pass

func _on_老伴卧室_pressed() -> void:
    pass

func _on_小艾卧室_pressed() -> void:
    pass
