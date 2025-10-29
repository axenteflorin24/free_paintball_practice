extends MeshInstance3D

var colors = [Color(0.549, 0.549, 0.0, 1.0), Color(1.0, 0.42, 0.191, 1.0), Color(1.0, 0.126, 0.088, 1.0), Color(0.46, 0.26, 0.368, 1.0), Color(0.242, 0.398, 1.0, 1.0), Color(0.158, 0.369, 0.028, 1.0), Color(0.178, 0.28, 0.28, 1.0), Color(0.4, 0.23, 0.022, 1.0)]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_rotation()
	$"..".name = random_name()
	$".".get("mesh").get("surface_0/material").set("shader_parameter/albedo", random_color())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_color():
	
	var color_id = randi_range(0, colors.size()-1)
	var color = colors[color_id]
	return color
	
func random_name():
	var random = str(randi_range(1,100))+"_"+str(randi_range(1,1000))+"_"+str(randi_range(1,10000))
	var _name = "barrel_"+random
	return _name
	
func random_rotation():
	$"..".rotation.y = deg_to_rad(randi_range(0, 180))
