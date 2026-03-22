extends TextureButton
@onready var popup_menu = $PopupMenu

func _ready():
    # 添加两个选项
    popup_menu.add_item("附身", 0)
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
        Dialogic.start("main", "衣服")
        
            # 最简单弹窗提示（使用OS.alert）
            
