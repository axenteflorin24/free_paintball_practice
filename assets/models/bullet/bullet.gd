extends CharacterBody3D

var raycast = false
var SPEED = 68


@onready var ROOT = get_tree().root.get_children()[0]
@onready var bullet_friction = $bullet_friction













var _collinder = false
var targets = []

var stored = 0.0
var decrement = 0.068
var movement_ = true
var IsCollinded = false
func _ready():
	
	var sfx_id = randi_range(0,3)
	var sfx = get_el(ROOT, "sfx").get_children()[sfx_id]
	sfx.play()
	name = "bullet"+"_"+str(randi_range(1, 1000))+"_"+str(randi_range(1, 1000))+"_"+str(randi_range(1, 1000))+"_"+str(randi_range(1, 1000))
	load_targets()
func check_shoot():
	
	var i=0
	var c=targets.size()-1
	while(i<=c):
		if targets[i] != null:
			if targets[i].get_children()[0] != null:

						
						
				if check_mesh_intersection(bullet_friction, targets[i].get_children()[0]) or _collinder == true:
					if is_on_wall():
						movement_ = false
						raycast = true
						var temp_id = targets[i].get_children()[0].this_id
						targets[i].get_children()[0].activated = false
						targets[i].get_children()[0].get_children()[0].stop()
						if targets[i].visible == true:
						
							targets[i].visible = false
							
							var _targets_ = get_el(ROOT, "targets")
							_targets_.score = _targets_.score+1

						
						$".".queue_free()
		i=i+1	
		
func _physics_process(delta):

	var _delta = delta
	check_shoot()
	if $lifetime.is_stopped() == false:
		if movement_:
			if $lifetime.time_left <= 0.999:
				$bullet_mesh.visible = true
			if $lifetime.time_left <= 0.45:
				if stored == 0.0:
					stored = global_position.y
				global_position.y = stored-decrement  
				
				decrement += 0.068
			
			movement(Vector3(0.0, 0.0, -1.0))
	
	if movement_:
		move_and_slide()


func movement(_direction):
	if 	_direction != Vector3(0.0, 0.0, 0.0):
		var direction = (transform.basis * _direction).normalized()
		
		if direction:
			
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			velocity.y = direction.y * SPEED
			
		else:
			
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)


func check_mesh_intersection(mesh_a: MeshInstance3D, mesh_b: MeshInstance3D) -> bool:
	
	var aabb_a = mesh_a.get_aabb()
	var aabb_b = mesh_b.get_aabb()
	var global_aabb_a = mesh_a.global_transform * aabb_a
	var global_aabb_b = mesh_b.global_transform * aabb_b
	if not global_aabb_a.intersects(global_aabb_b):
		 
		return false
	return true

func get_el(_node, _name):
	
	
	var array = _node.get_children()
	
	var i = 0
	var c = array.size()-1
	while i<=c:
		
		if array[i].name == _name:
			return array[i]
		
		
		i=i+1

	return null

func load_targets():
	
	var _locations = ['001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011', '012', '013', '014', '015', '016', '017', '018']
	
	var temp = get_el(ROOT, 'target_locations')
	var _temp = null
	if temp != null:
		temp = temp.get_children()
		var i = 0
		var c = temp.size()-1
		while i<=c:
			
			if not temp[i] == null:
				if not temp[i].get_children() == []:
					targets.append(temp[i].get_children()[0])
					
			i=i+1	

func _on_loading_timeout():
	
	reparent(ROOT)
	$lifetime.start()

func _on_lifetime_timeout():
	pass
	$".".queue_free()
