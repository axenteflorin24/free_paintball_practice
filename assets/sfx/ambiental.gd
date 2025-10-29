extends AudioStreamPlayer
var first_play = true
var track = "A"
@onready var ROOT = get_tree().root.get_children()[0]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ROOT.paused == true:
		$".".stop()
		$"../ambiental_loop".stop()
		$"../ambientalLoop".stop()
		return
		
	if not $"../../Player" == null:
		if first_play == true:
			first_play = false
			$".".play()
	
	if $"../ambientalLoop".is_stopped():
		
		if track == "A":
			track == "B"
			$"../ambiental_loop".set("volume_db", "-8.0")
			$"../ambiental_loop".play()
			$".".set("volume_db", "-80.0")
			$".".stop()
		if track == "B":
			track == "A"
			$".".set("volume_db", "-8.0")
			$".".play()
			$"../ambiental_loop".set("volume_db", "-80.0")
			$"../ambiental_loop".stop()
		$"../ambientalLoop".start()		
