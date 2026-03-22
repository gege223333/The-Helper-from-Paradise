extends AudioStreamPlayer
func _ready():
    $".".finished.connect(_on_finished)
    $".".play()

func _on_finished():
    $".".play()  # 播放结束后重新触发
