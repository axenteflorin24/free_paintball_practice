extends Marker3D
@onready var ROOT = get_tree().root.get_children()[0]
@onready var _raycast = $RayCast3D_A
@onready var _raycasta = $RayCast3D_B
@onready var _raycastb = $RayCast3D_C
@onready var _raycastc = $RayCast3D_D



@onready var Crosshair = $"../../../../HUD/Crosshair"
@onready var _Crosshair = $"../../../../HUD/_Crosshair"


var _collinder = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ROOT.paused == true:
		return
	if _raycastc != null:
					
		if _raycastc.is_colliding():
			if _raycastc.get_collider()!=null:
				var collinder = _raycastc.get_collider().name

				if _raycastc.get_collider().get_parent().get_parent().visible == true:
					collinder = collinder.split("_")[0]
					if collinder == "target":
						_Crosshair.visible = true	
						Crosshair.visible = false
						_collinder = true
						
						if Input.is_action_pressed("shoot"):
							
							var temp_id = _raycastc.get_collider().get_parent().get_parent().get_children()[0].this_id
							_raycastc.get_collider().get_parent().get_parent().get_children()[0].activated = false
							_raycastc.get_collider().get_parent().get_parent().get_children()[0].get_children()[0].stop()
							if _raycastc.get_collider().get_parent().get_parent().visible == true:
							
								_raycastc.get_collider().get_parent().get_parent().visible = false
								
								var _targets_ = get_el(ROOT, "targets")
								_targets_.score = _targets_.score+1
								
					
					
					
					else:
						_Crosshair.visible = false

						Crosshair.visible = true

						_collinder = false	
		
	if _raycastb != null:
					
		if _raycastb.is_colliding():
			if _raycastb.get_collider()!=null:
				var collinder = _raycastb.get_collider().name

				if _raycastb.get_collider().get_parent().get_parent().visible == true:
					collinder = collinder.split("_")[0]
					if collinder == "target":
						_Crosshair.visible = true	
						Crosshair.visible = false
						_collinder = true
						
						if Input.is_action_pressed("shoot"):
							
							var temp_id = _raycastb.get_collider().get_parent().get_parent().get_children()[0].this_id
							_raycastb.get_collider().get_parent().get_parent().get_children()[0].activated = false
							_raycastb.get_collider().get_parent().get_parent().get_children()[0].get_children()[0].stop()
							if _raycastb.get_collider().get_parent().get_parent().visible == true:
							
								_raycastb.get_collider().get_parent().get_parent().visible = false
								
								var _targets_ = get_el(ROOT, "targets")
								_targets_.score = _targets_.score+1
								
					
					
					
					else:
						_Crosshair.visible = false
						Crosshair.visible = true
						_collinder = false	
		
		
	if _raycasta != null:
					
		if _raycasta.is_colliding():
			if _raycasta.get_collider()!=null:
				var collinder = _raycasta.get_collider().name

				if _raycasta.get_collider().get_parent().get_parent().visible == true:
					collinder = collinder.split("_")[0]
					if collinder == "target":
						_Crosshair.visible = true	
						Crosshair.visible = false
						_collinder = true
						
						if Input.is_action_pressed("shoot"):
							
							var temp_id = _raycasta.get_collider().get_parent().get_parent().get_children()[0].this_id
							_raycasta.get_collider().get_parent().get_parent().get_children()[0].activated = false
							_raycasta.get_collider().get_parent().get_parent().get_children()[0].get_children()[0].stop()
							if _raycasta.get_collider().get_parent().get_parent().visible == true:
							
								_raycasta.get_collider().get_parent().get_parent().visible = false
								
								var _targets_ = get_el(ROOT, "targets")
								_targets_.score = _targets_.score+1
								
					
					
					
					else:
						_Crosshair.visible = false
						Crosshair.visible = true
						_collinder = false
	
	
	
	if _raycast != null:
					
		if _raycast.is_colliding():
			if _raycast.get_collider()!=null:
				var collinder = _raycast.get_collider().name

				if _raycast.get_collider().get_parent().get_parent().visible == true:
					collinder = collinder.split("_")[0]
					if collinder == "target":
						_Crosshair.visible = true	
						Crosshair.visible = false
						_collinder = true
						
						if Input.is_action_pressed("shoot"):
							
							var temp_id = _raycast.get_collider().get_parent().get_parent().get_children()[0].this_id
							_raycast.get_collider().get_parent().get_parent().get_children()[0].activated = false
							_raycast.get_collider().get_parent().get_parent().get_children()[0].get_children()[0].stop()
							if _raycast.get_collider().get_parent().get_parent().visible == true:
							
								_raycast.get_collider().get_parent().get_parent().visible = false
								
								var _targets_ = get_el(ROOT, "targets")
								_targets_.score = _targets_.score+1
								
					
					

					
					else:
						_Crosshair.visible = false
						Crosshair.visible = true
						_collinder = false

	if Input.is_action_just_pressed("shoot"):
		pass
		add_bullet()
		

func get_el(_node, _name):
	
	
	var array = _node.get_children()
	
	var i = 0
	var c = array.size()-1
	while i<=c:
		
		if array[i].name == _name:
			return array[i]
		
		
		i=i+1

	return null		
func add_bullet():
	
	var bullet = load("res://assets/models/bullet/bullet.tscn").instantiate()
	$".".add_child(bullet)
