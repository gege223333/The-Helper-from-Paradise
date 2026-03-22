extends TextureButton
@onready var popup_menu = $PopupMenu
func _ready():
    # 添加两个选项
    popup_menu.add_item("进入任务（耗时1天，精力-15，能力值+10）", 0)
    popup_menu.add_item("取消", 1)
    
    # 连接信号
    pressed.connect(_show_popup)
    popup_menu.id_pressed.connect(_on_option_selected)

func _show_popup():
    # 在鼠标位置显示弹出菜单
    if not Global.task1:
        popup_menu.position = get_global_mouse_position()
        popup_menu.popup()


func _on_option_selected(id):
    if id == 0:  # 修改全局变量
        if Global.energy>=15 and Global.capacity>=5:
            Global.energy-=15
            Global.capacity+=10
            Global.time+=3
            Global.advance_time()
            get_tree().change_scene_to_file("res://第一关/小艾关卡.tscn")
        elif Global.energy<15:
            # 最简单弹窗提示（使用OS.alert）
            OS.alert("精力不足！需要15点精力\n当前只有%d点" % Global.energy, "警告")
            # 最简单弹窗提示（使用OS.alert）
        elif Global.capacity<5:
            OS.alert("能力不够！需要5点能量\n当前只有%d点" % Global.capacity, "警告")
            
