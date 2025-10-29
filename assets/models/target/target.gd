extends MeshInstance3D
@export var this_id = 0
@onready var ROOT = get_tree().root.get_children()[0]


@onready var timer = $lifetime
# Called when the node enters the scene tree for the first time.
@export var activated = false
var first = true

func _ready() -> void:
	var _name = 'target_'+str(randi_range(1, 100))+'_'+str(randi_range(1, 1000))+'_'+str(randi_range(1, 10000))
	$"..".name = _name
	$".".name = _name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ROOT.paused == true:
		first = true
		if $lifetime.is_stopped():
			$lifetime.stop()
	
	
	if ROOT.paused == true:
		return
	
	if get_el(ROOT, 'targets').game_over == true:
		
		if $"..".visible == false:
			if timer.is_stopped() == false:
				timer.stop
		activated = false
		if $"..".visible == true:	
			$"..".visible = false
			timer.stop()
			
	if first == true and timer != null:
		first = false
		timer.set("wait_time", randf_range(6.38, 8.0))
	if activated == true:
		activated = false
		timer.start()	

func get_el(_node, _name):
	
	
	var array = _node.get_children()
	
	var i = 0
	var c = array.size()-1
	while i<=c:
		
		if array[i].name == _name:
			return array[i]
		
		
		i=i+1

	return null





func _on_lifetime_timeout() -> void:
	if $"..".visible == true and ROOT.paused == false:
		var _game_over = get_el(ROOT, 'targets')

		if not _game_over.gameoverstatus == true and not _game_over.game_over == true:
			_game_over.gameoverstatus = true
			_game_over.game_over = true	
		
		$"..".visible = false
	


func _on_init_timeout() -> void:
	$"..".visible = false
