extends Node3D

@export var score = 0 
var updated_score = 0
var _score = 0
var LiveEstimator = 38
@export var gameoverstatus = false


@export var game_over = false
@onready var ROOT = get_tree().root.get_children()[0]





var types = ['front', 'front', 'front', 'front', 'side', 'front', 'front', 'front', 'front', 'front', 'front', 'front', 'front', 'front', 'front', 'front', 'side', 'front']
var _locations = ['001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011', '012', '013', '014', '015', '016', '017', '018']
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func text_adder(text, count):
	
	if len(text) == count:
		return text
	var i = 1
	var c = count-len(text)
	
	while i <= c:
		text = '0'+text
		
		i=i+1
	return text
func _update_score():
	var score_label = get_el(get_el(ROOT, 'HUD'), 'score')
	score_label.text = text_adder(str(score), 8)
	_score = _score+1
	if _score == LiveEstimator:
		_update_lives()
		_score = 1
func _update_lives():
	var lives = get_el(get_el(ROOT, 'HUD'), 'lives')
	var lives_new = int(lives.text) + 1
	lives_new = text_adder(str(lives_new), 2)
	
	lives.text = lives_new

func _process(delta: float) -> void:	
	
	
	if Input.is_action_just_pressed("pause"):
		var logical = true
		
		
		var pause = get_el(get_el(ROOT, 'HUD'), 'pause')
		if ROOT.paused == false and logical == true:
			logical = false
			ROOT.paused = true
			
			if pause.visible == false:
				pause.visible = true
		
		if ROOT.paused == true and logical == true:
			logical = false
			if pause.visible == true:
				pause.visible = false
			ROOT.paused = false
	
	if ROOT.paused == true:
		return
	
	if Input.is_action_just_pressed("reset"):
		var lives = get_el(get_el(ROOT, 'HUD'), 'lives').text
		if int(lives) == 0:
			_update_lives()
			_update_lives()
			_update_lives()
			
			var controls = get_el(get_el(ROOT, 'HUD'), 'CONTROLS')
			controls.visible = false
			
			var ready_label =  get_el(get_el(ROOT, 'HUD'), 'ready')
			ready_label.visible = true
			ready_label.get_children()[0].start()
			var ready_sfx = get_el(get_el(ROOT, 'sfx'), 'ready')
			ready_sfx.play()
			var label =  get_el(get_el(ROOT, 'HUD'), 'GameOver')
			label.visible = false
			score = 0 
			updated_score = 0

			var score_label = get_el(get_el(ROOT, 'HUD'), 'score')
			score_label.text = '00000000'
			game_over = false
			$loading.start()
		
	if game_over == true and gameoverstatus == true:
		gameoverstatus = false
		game_over = false

		
		
		var lives_text = get_el(get_el(ROOT, 'HUD'), 'lives').text
		var lives = int(lives_text)
		if lives > 0:
			var splat = get_el(get_el(ROOT, 'HUD'), 'SPLAT')
			splat.visible = true
			splat.get_children()[0].start()
			var splat_sfx =  get_el(get_el(ROOT, 'sfx'), 'splat')
			splat_sfx.play()
			lives = lives - 1
			get_el(get_el(ROOT, 'HUD'), 'lives').text = text_adder(str(lives), 2)
		
		if lives == 0:	
			var controls = get_el(get_el(ROOT, 'HUD'), 'CONTROLS')
			controls.visible = true
			game_over = true
			var game_over_sfx = get_el(get_el(ROOT, 'sfx'), 'game_over')
			game_over_sfx.play()
			var label =  get_el(get_el(ROOT, 'HUD'), 'GameOver')
			label.visible = true
			$loading.stop()
		
	if game_over == false:	
		if score > 0:
			if score != updated_score:
				updated_score = score
				_update_score()
	
	
	if game_over == true:
		$loading.stop()
	
func add_targets():
	

	var id = get_random_location()
	
	var loc = _locations[id]
	var locations_node = get_el(get_el(ROOT, 'target_locations'), loc)
		
	if locations_node.get_children()[0].visible == false:

		
		var temp = null
			
		if locations_node.get_children() != []:
				
			var enemy = locations_node.get_children()[0]
				
			temp = locations_node.get_children()[0].get_children()[0]
				
			temp.this_id = id
			enemy.visible = true
			temp.activated = true
		else:
			print('empty : ', id)
	
func get_random_location():
	
	var id = randi_range(0, _locations.size()-1)
	return id


func get_el(_node, _name):
	
	
	var array = _node.get_children()
	
	var i = 0
	var c = array.size()-1
	while i<=c:
		
		if array[i].name == _name:
			return array[i]
		
		
		i=i+1

	return null

func _on_loading_timeout() -> void:
	if ROOT.paused == false:
		if game_over == false:
			if score <= 10:
				$loading.set("wait_time", 1.68)
				add_targets()	
		if game_over == false:
			if score > 10 and score <= 20:
				$loading.set("wait_time", 1.68)
				add_targets()		
				add_targets()
		if game_over == false:
			if score > 20 and score <= 30:
				$loading.set("wait_time", 1.68)
				add_targets()		
				add_targets()		
		if game_over == false:
			if score > 30 and  score <= 40:
				$loading.set("wait_time", 1.63)
				add_targets()		
				add_targets()		
				add_targets()		
		if game_over == false:
			if score > 40 and  score <= 50:
				$loading.set("wait_time", 1.63)
				add_targets()		
				add_targets()			
				add_targets()		
		if game_over == false:
			if score > 50 and  score <= 60:
				$loading.set("wait_time", 1.63)
			
				add_targets()			
				add_targets()		
				add_targets()
		if game_over == false:
			if score > 60 and  score <= 80:
				$loading.set("wait_time", 1.48)
			
				add_targets()			
				add_targets()		
				add_targets()			
		if game_over == false:
			if score > 80 and  score <= 90:
				$loading.set("wait_time", 1.48)
				add_targets()		
				add_targets()			
				add_targets()		
				add_targets()					
					
		if game_over == false:
			if score > 90 and  score <= 120:
				$loading.set("wait_time", 1.48)
				add_targets()
				add_targets()		
		
		if game_over == false:
			if score > 120 and  score <= 160:
				$loading.set("wait_time", 1.48)
				add_targets()		
				add_targets()			
		if game_over == false:
			if score > 160 and  score <= 200:
				$loading.set("wait_time", 1.36)
				add_targets()		
				add_targets()		
				add_targets()		
		if game_over == false:
			if score > 200 and  score <= 230:
				$loading.set("wait_time", 1.36)
				add_targets()		
				add_targets()		
				add_targets()		
		if game_over == false:
			if score > 230 and  score <= 280:
				$loading.set("wait_time", 1.36)
				add_targets()		
				add_targets()		
		if game_over == false:
			if score > 280 and  score <= 380:
				$loading.set("wait_time", 1.18)
				add_targets()		
				add_targets()	
		if game_over == false:
			if score > 380 and  score <= 480:
				$loading.set("wait_time", 1.18)
				add_targets()		
				add_targets()
				add_targets()		
		if game_over == false:
			if score > 480 and  score <= 680:
				$loading.set("wait_time", 1.18)
				add_targets()
				add_targets()		
				add_targets()
						
		if game_over == false:
			if  score > 680 and score <= 800:
				$loading.set("wait_time", 1.18)
				add_targets()
				add_targets()		
		
