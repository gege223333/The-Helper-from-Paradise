extends TextureButton
@onready var popup_menu = $PopupMenu

func _ready():
    # 添加两个选项
    popup_menu.add_item("锻炼一次（精力上限+1 能力值+5 精力-10）", 0)
    popup_menu.add_item("取消", 1)
    
    # 连接信号
    pressed.connect(_show_popup)
    popup_menu.id_pressed.connect(_on_option_selected)

func _show_popup():
    # 在鼠标位置显示弹出菜单
    popup_menu.position = get_global_mouse_position()
    popup_menu.popup()


func _on_option_selected(id):
    if id == 0:  # 修改全局变量
        if Global.energy>=10:
            Global.energy_max+=1
            Global.energy-=10
            Global.capacity+=5
        elif Global.energy<10:
            # 最简单弹窗提示（使用OS.alert）
            OS.alert("精力不足！需要10点精力\n当前只有%d点" % Global.energy, "警告")
