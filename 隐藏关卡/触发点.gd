extends Area2D

func _on_body_entered(body: Node2D):
    if $"../AudioStreamPlayer2D".playing:
        if body is AnimatedSprite2D:
            print("箭头进入区域:", body.name)

func _input(event):
    if $"../AudioStreamPlayer2D".playing:
        if event is InputEventKey:
            if event.pressed:
                match event.keycode:
                    KEY_UP:
                        print("上箭头按下")
                    KEY_DOWN:
                        print("下箭头按下") 
                    KEY_LEFT:
                        print("左箭头按下")
                    KEY_RIGHT:
                        print("右箭头按下")
