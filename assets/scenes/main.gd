extends Control
@export var paused = false
var screen_res = Vector2i(1280, 720)
# Called when the node enters the scene tree for the first time.
var windowed = true

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("fullscreen"):
	
		var logical = true
		if logical == true and windowed == true:
			windowed = false
			logical = false
			set_windowed()
		if logical == true and windowed == false:
			windowed = true
			logical = false
			set_full_screen()
	
	
	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if paused == true:
		if not $sfx/background.get("playing"):
			$sfx/background.play()
	else:
		$sfx/background.play()
	pass


func set_windowed():
	get_window().content_scale_size = screen_res
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(screen_res))

func set_full_screen():
	get_window().content_scale_size = screen_res
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
