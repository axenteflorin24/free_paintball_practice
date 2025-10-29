extends Node3D
@onready var ROOT = get_tree().root.get_children()[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_pos = get_el(ROOT, 'Player').global_position
	
	
	look_at(Vector3(player_pos.x, global_position.y, player_pos.z),Vector3.UP)

func get_el(_node, _name):
	
	
	var array = _node.get_children()
	
	var i = 0
	var c = array.size()-1
	while i<=c:
		
		if array[i].name == _name:
			return array[i]
		
		
		i=i+1

	return null
