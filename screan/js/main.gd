extends Node2D
var audio_server
var scene
var max_hz=11050.0
var pic_num=4
var pre_eng=[]
var add_door=0.1
var add_flag=false
var add_num=0
var add_clock=0.1
var radom=RandomNumberGenerator.new()
var areaNum=[]
var scene_Anim
var count=0
var totalcount1=0
var totalcount2=0
var was_playing = false
@onready var label=$Label
@onready var audio=$AudioStreamPlayer
@onready var audio2=$AudioStreamPlayer2
@export var label1:Label

func _ready() -> void:
    label1.visible = false
    scene=load("res://screan/pic.tscn")
    scene_Anim=load("res://screan/Anim.tscn")
    audio_server=AudioServer.get_bus_effect_instance(1,0)
    pre_eng.resize(pic_num)
    pre_eng.fill(0)
    Vector2.DOWN.length()
func _process(delta: float) -> void:
    if not $AudioStreamPlayer.playing and was_playing:
        print("音乐已结束播放")
        totalcount1=count
        print(totalcount1)
        print(totalcount2)
        var success_ratio = totalcount1 / totalcount2
        if totalcount2 > 0:	# 防止除零错误
            Global.percentage = "%.2f%%" % (float(totalcount1)/totalcount2 * 100)
            print(Global.percentage)
            label1.set_text("准确率:"+str(Global.percentage))
        else:
            print("暂无数据")
            label1.set_text("准确率:0%")
        label1.visible = true 
        start_dialog_based_on_percentage()
    was_playing = $AudioStreamPlayer.playing
    
    for m:rigidBodyBox in areaNum:
        if m.GetboxPoi()==1&&Input.is_action_just_pressed("S"):
            CutBox(m)
            break
    for m:rigidBodyBox in areaNum:
        if m.GetboxPoi()==2&&Input.is_action_just_pressed("D"):
            CutBox(m)
            break
    for m:rigidBodyBox in areaNum:
        if m.GetboxPoi()==3&&Input.is_action_just_pressed("J"):
            CutBox(m)
            break
    for m:rigidBodyBox in areaNum:
        if m.GetboxPoi()==4&&Input.is_action_just_pressed("K"):
            CutBox(m)
            break
    
    var hz
    var pre_hz=0
    var max_eng=0
    add_num+=delta
    if add_num>add_clock:
        add_flag=true	
    if add_flag:
        for i in range(pic_num):
            hz=max_hz/pic_num*(i+1)
            var eng=100*clampf(audio_server.get_magnitude_for_frequency_range(pre_hz,hz).length_squared(),0,1)
            if eng-pre_eng[i]>max_eng+0.25:
                max_eng=eng
            pre_eng[i]=eng	
        print(max_eng,"-----",add_door)
        if max_eng>add_door:
            addBox()		
        pre_hz=hz
        add_flag=false
        add_num=0

func addBox():
    if $AudioStreamPlayer.playing:  # 音乐播放时生成方块
        var instance=scene.instantiate()
        var nnn=radom.randi()%pic_num+1
        totalcount2+=1
        instance.position=Vector2(nnn*400,0)
        instance.SetboxPoi(nnn)
        add_child(instance)

func _on_area_2d_body_entered(body: Node2D) -> void:
    areaNum.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
    areaNum.erase(body)

func CutBox(body:rigidBodyBox):#删除方块
    areaNum.erase(body)
    body.Hideself()
    var scene_A=scene_Anim.instantiate()
    scene_A.position=body.position
    add_child(scene_A)
    audio2.play()
    count+=1
    
    label.set_text("scores:"+str(count))
func start_dialog_based_on_percentage():
    var percentage_value = 0.0
    if Global.percentage is String:
        # 移除百分号并转换为浮点数
        var clean_string = Global.percentage.replace("%", "")
        percentage_value = clean_string.to_float()
    
    # 根据百分比值触发不同对话
    var dialog
    if  Global.click1==false:
        if percentage_value >= 85:
            print("触发85%对话")
            Global.credibility+=20
            dialog = Dialogic.start("赛后", "85")
            Global.task2=true
        elif percentage_value >= 60:  # 这里不需要检查 <85，因为>=85的情况已经被上面处理了
            print("触发60%对话")
            Global.credibility+=8
            dialog = Dialogic.start("赛后", "60")
            Global.task2=true
        else:  # 所有其他情况（<60）
            print("触发0%对话")
            Global.credibility-=5
            dialog = Dialogic.start("赛后", "0")
            Global.task2=false
            print(3)
        await dialog.tree_exited
        Global.click1=true
    elif Global.click1==true:
        Dialogic.start("比赛结果")
        
    get_tree().change_scene_to_file("res://家里/主场景.tscn")
