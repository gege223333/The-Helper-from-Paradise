extends TextureButton

@onready var popup_panel = $PopupPanel
@onready var save_button = $PopupPanel/VBoxContainer/保存
@onready var cancel_button = $PopupPanel/VBoxContainer/取消
@onready var back_button = $PopupPanel/VBoxContainer/回到标题界面
@onready var success_dialog = $PopupPanel/VBoxContainer/保存/AcceptDialog
@export var capacity=Global.capacity
@export var energy=Global.energy
@export var energy_max=Global.energy_max
@export var credibility=Global.credibility
@export var day=Global.day
@export var time=Global.time
@export var state_of_disc=Global.state_of_disc
@export var click=Global.click
@export var click1=Global.click1
@export var day15_triggered=Global.day15_triggered
@export var day20_triggered=Global.day20_triggered
@export var day30_triggered=Global.day30_triggered

func _ready() -> void:
    pressed.connect(_on_button_pressed)
    save_button.pressed.connect(_save)
    cancel_button.pressed.connect(_cancel)
    back_button.pressed.connect(_back)
    success_dialog.title = "提 示"
    success_dialog.ok_button_text = "确 定"

func _on_button_pressed():
    # Godot 4.4 使用 position 而不是 rect_position
    popup_panel.position = get_global_mouse_position()
    popup_panel.popup()
func _save() -> void:
    Dialogic.Save.save("slot1")
    # 同时保存你的游戏数据到同一个槽位
    var save_data = {
        "game_data": {
            "capacity": Global.capacity,
            "energy": Global.energy,
            "energy_max": Global.energy_max,
            "credibility": Global.credibility,
            "day": Global.day,
            "time": Global.time,
            "state_of_disc":Global.state_of_disc,
            "task1":Global.task1,
            "task2":Global.task2,
            "task3":Global.task3,
            "click":Global.click,
            "click1":Global.click1,
            "day15_triggered":Global.day15_triggered,
            "day20_triggered":Global.day20_triggered,
            "day30_triggered":Global.day30_triggered,
            }
    }
    var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
    file.store_var(save_data)
    file.close()
    popup_panel.hide()
    success_dialog.dialog_text = "保 存 成 功！"
    success_dialog.popup_centered()
func _cancel() -> void:
    popup_panel.hide()


func _back() -> void:
   get_tree().change_scene_to_file("res://标题界面/标题界面.tscn")
