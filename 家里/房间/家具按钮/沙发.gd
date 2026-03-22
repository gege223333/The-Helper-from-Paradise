extends TextureButton
@onready var popup_menu = $PopupMenu
var gonna_get
var current_time = Global.time % 3
func _ready():
    # 初始化时设置一次菜单
    _update_popup_menu()
    # 确保信号连接正确
    pressed.connect(_show_popup)
    popup_menu.id_pressed.connect(_on_option_selected)

func _update_popup_menu():
    # 清除现有菜单项
    popup_menu.clear()

    # 根据当前时间添加新选项
    if current_time == 0:
        popup_menu.add_item("休息一下（耗时一上午 精力+8）", 0)
        gonna_get = 8
    elif current_time == 1:
        popup_menu.add_item("休息一下（耗时一下午 精力+8）", 1)
        gonna_get = 8
    elif current_time == 2:
        popup_menu.add_item("休息一下（耗时一晚上 精力+10）", 2)
        gonna_get = 10
    popup_menu.add_item("取消", 3)

func _show_popup():
    # 更新菜单内容
    _update_popup_menu()
    # 在鼠标位置显示弹出菜单
    popup_menu.position = get_global_mouse_position()
    popup_menu.popup()

func _on_option_selected(id):
    if id == 3:  # 取消选项
        return
        
    var can_recover = Global.energy_max - Global.energy
    if can_recover == 0:
        OS.alert("精力值已达上限，不能休息啦~", "警告")
        return
    if can_recover <= gonna_get: 
        Global.energy = Global.energy_max
        Global.time+=1
        return
    else:
        Global.energy += gonna_get
        Global.time+=1
    # 时间前进
    Global.advance_time()
    print("当前 Global.time 的值是: ", Global.time)
