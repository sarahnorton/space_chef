extends Node2D

var activeBuckets : int
var timeSinceLast : float
var numberLettuce : int
var numberTomato : int
var leftTomatoNeed : int
var rightTomatoNeed : int
var leftLettuceNeed : int
var rightLettuceNeed : int
var rng = RandomNumberGenerator.new()
var leftFusionNeed : int
var rightFusionNeed : int
var tomatoMax : int
var LettuceMax : int
var leftActive : bool
var rightActive : bool
var spawnTimer : float

# Called when the node enters the scene tree for the first time.
func _ready():
	activeBuckets = 0
	timeSinceLast = 0.0
	numberLettuce = 0
	numberTomato = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activeBuckets != 2:
		timeSinceLast += 1*delta
		if timeSinceLast > 1:
			timeSinceLast = 0.0
			if leftActive == false:
				spawnNewBucket('left')
				activeBuckets += 1
			if rightActive == false:
				spawnNewBucket('right')
				activeBuckets += 1
	if spawnTimer > 2.5:
		if tomatoMax != numberTomato:
			spawn('tomato')
			numberTomato += 1
			spawnTimer = 0.0
		elif tomatoMax != numberTomato:
			spawn('lettuce')
			numberTomato += 1
			spawnTimer = 0.0
	spawnTimer += 1*delta
			
func spawn(vege):
	var newVege
	if vege == 'lettuce':
		newVege = preload("res://scenes/lettuce.tscn")
	else:
		newVege = preload("res://scenes/Tomato.tscn")
	newVege = newVege.instantiate()
	var k = rng.randi_range(0,2)
	
	if (k == 0):
		newVege.position = (Vector2(-650,575))
		
	if (k == 1):
		newVege.position = (Vector2(0,575))
	if (k == 2):
		newVege.position = (Vector2(650,575))
	newVege.linear_velocity = Vector2(0,-500)
	add_child(newVege)
	
	
func spawnNewBucket(bin):
	var k = rng.randi_range(0,2)
	if k == 0:
		if bin == 'left':
			leftFusionNeed = 1
			leftTomatoNeed = 1
			LettuceMax += 1
			tomatoMax += 2
	if k == 0:
		if bin == 'right':
			rightFusionNeed = 1
			rightTomatoNeed = 1
			LettuceMax += 1
			tomatoMax += 2
	if k == 1:
		if bin == 'left':
			leftFusionNeed = 1
			leftLettuceNeed = 1
			LettuceMax += 2
			tomatoMax += 1
	if k == 1:
		if bin == 'right':
			rightFusionNeed = 1
			rightLettuceNeed = 1
			LettuceMax += 2
			tomatoMax += 1
	if k == 2:
		if bin == 'left':
			leftTomatoNeed = 1
			tomatoMax += 1
	if k == 2:
		if bin == 'right':
			rightTomatoNeed = 1
			tomatoMax += 1
	
	
