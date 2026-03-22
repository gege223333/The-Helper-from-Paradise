extends TextureButton
@onready var popup_menu = $PopupMenu
var 目标场景 = preload("res://家里/主场景.tscn")
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
        get_tree().change_scene_to_file("res://过渡.tscn")
        Global.credibility+=8
        Global.task1=true
        var dialog = Dialogic.start("main", "树木")
        # 等待对话结束
        await dialog.tree_exited
        get_tree().change_scene_to_packed(目标场景)  

        
            # 最简单弹窗提示（使用OS.alert）
            
