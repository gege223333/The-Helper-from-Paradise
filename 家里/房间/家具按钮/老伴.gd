extends TextureButton
@onready var popup_menu = $PopupMenu
var 目标场景 = preload("res://家里/主场景.tscn")
func _ready():
    # 添加两个选项
    popup_menu.add_item("进入任务（耗时1天，精力-15，能力值+10）", 0)
    popup_menu.add_item("取消", 1)
    # 连接信号
    pressed.connect(_show_popup)
    popup_menu.id_pressed.connect(_on_option_selected)
func _show_popup():
    # 在鼠标位置显示弹出菜单
    if Global.task1:
        popup_menu.position = get_global_mouse_position()
        popup_menu.popup()
func _on_option_selected(id):
    if id == 0:  
        if Global.energy>=15 and Global.capacity>=20 and Global.task1:
            if not Global.click1:
                Dialogic.start("第二关第三关剧情","第一次")
                Global.capacity+=10
                var next_scene = load("res://screan/before.tscn") 
                get_tree().change_scene_to_packed(next_scene)                
            elif Global.click1 :
                Dialogic.start("第二关第三关剧情","再试一次")
                if Global.state_of_disc==true:
                    var next_scene = load("res://screan/choose.tscn") 
                    get_tree().change_scene_to_packed(next_scene)
                else:
                    var next_scene = load("res://screan/before.tscn") 
                    get_tree().change_scene_to_packed(next_scene)                    
            Global.energy-=15
            Global.time+=3
            Global.advance_time()
        
                
        elif Global.energy<15:
            # 最简单弹窗提示（使用OS.alert）
            OS.alert("精力不足！需要10点精力\n当前只有%d点" % Global.energy, "警告")
        elif Global.capacity<20:
            OS.alert("能力不够！需要20点能量\n当前只有%d点" % Global.capacity, "警告")
