extends Node2D
@export var win_label: Label
@export var lose_label: Label
@export var time_label: Label
var is_game_over := false
var elapsed_time := 0.0
var timer_active := false

func _ready():
    assert(win_label != null, "Win Label未设置")
    assert(lose_label != null, "Lose Label未设置")
    assert(time_label != null, "Time Label未设置")
    
    win_label.visible = false
    lose_label.visible = false
    time_label.text = "Time: 0.0"
    
    if has_node("GameTimer"):
        $GameTimer.timeout.connect(_on_timer_timeout)
        $GameTimer.start()
        timer_active = true
    else:
        printerr("警告：未找到GameTimer节点，将使用_process计时")

func _process(delta):
    if timer_active and not is_game_over:
        elapsed_time += delta
        update_time_display()

func _on_timer_timeout():
    if not is_game_over:
        elapsed_time += 1.0
        update_time_display()

func update_time_display():
    time_label.text = "Time: %.1f" % elapsed_time

func win_game_over():
    end_game(true)
    $CanvasLayer.layer = -1
    Global.task3=true
    get_tree().change_scene_to_file("res://过渡.tscn")
    Dialogic.start("彩票之后","赢")



func lose_game_over():
    end_game(false)
    Global.credibility-=5
    Dialogic.start("彩票之后","输")
    get_tree().change_scene_to_file("res://家里/主场景.tscn")
func end_game(is_win: bool):
    is_game_over = true
    timer_active = false
    
    if has_node("GameTimer"):
        $GameTimer.stop()
    
    var result_label = win_label if is_win else lose_label
    result_label.text = "%s\nClear Time: %.1fs" % ["WIN" if is_win else "LOSE", elapsed_time]
    result_label.visible = true
