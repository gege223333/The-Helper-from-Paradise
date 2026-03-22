extends TextureButton
@onready var popup_menu = $PopupMenu
@onready var Currentscene = $currentscene
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
        Currentscene.texture = load("res://背景素材/街道/街道-下雨.png")
        Global.credibility-=5
        Global.task1=true
        get_tree().current_scene.hide()
        var dialog = Dialogic.start("main", "云朵")
        # 等待对话结束
        await dialog.tree_exited
        get_tree().change_scene_to_packed(目标场景)  
