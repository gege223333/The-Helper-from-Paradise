extends CharacterBody2D

@export var move_speed := 1000
@export var hit_zone_width := 500
@onready var label=$"../score"
var initial_position := Vector2.ZERO
var animation_names := ["down-arr", "up-arr", "left-arr", "right-arr"]
var active := false
var respawn_timer := 0.75
var in_hit_zone := false
var count=0
var allcount=-1
var start_dialog=false

func _ready():
    if $"../AudioStreamPlayer2D".playing:
        initial_position = position
        reset_arrow()

func _process(delta):
    if $"../AudioStreamPlayer2D".playing:
        if active:
            position.x -= move_speed * delta
            in_hit_zone = position.x > 125 && position.x < 125 + hit_zone_width
            if position.x < -100:
                reset_arrow()
    
    if not $"../AudioStreamPlayer2D".playing and not start_dialog:
        start_dialog = true
        $".".visible=false
        var percentage = "%.2f%%" % (float(count)/max(allcount, 1) * 100)
        $"../end".set_text("准确率："+str(percentage))
        $"../end".visible=true
        Dialogic.start("彩票之后","跳舞后")

# 移除reset_arrow函数中的await，改用Timer节点
func reset_arrow():
    if $"../AudioStreamPlayer2D".playing:
        position = initial_position
        active = false
        $AnimatedSprite2D.play(animation_names[randi() % animation_names.size()])
        # 创建一次性计时器，不阻塞游戏
        var timer = Timer.new()
        add_child(timer)
        timer.wait_time = respawn_timer
        timer.one_shot = true
        timer.start()
        timer.timeout.connect(_on_respawn_timer_timeout.bind(timer))

func _on_respawn_timer_timeout(timer):
    timer.queue_free()  # 删除计时器
    active = true
    allcount += 1
    print("count:",count)
    print("allcount：",allcount)

func _input(event):
    if $"../AudioStreamPlayer2D".playing:
        if event is InputEventKey and event.pressed and active and in_hit_zone:
            match [$AnimatedSprite2D.animation, event.keycode]:
                ["down-arr", KEY_DOWN]:
                    reset_arrow()
                    count+=1
                    label.set_text("score:"+str(count))
                ["up-arr", KEY_UP]:
                    reset_arrow()
                    count+=1
                    label.set_text("score:"+str(count))
                ["left-arr", KEY_LEFT]:
                    reset_arrow()
                    count+=1
                    label.set_text("score:"+str(count))
                ["right-arr", KEY_RIGHT]:
                    reset_arrow()
                    count+=1
                    label.set_text("score:"+str(count))
