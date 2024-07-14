extends Node2D

var activeBuckets : int
var timeSinceLast : float
var numberLettuce : int
var numberTomato : int
var rng = RandomNumberGenerator.new()
var leftBucketNeeds
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
		if timeSinceLast > 10:
			timeSinceLast = 0.0
			spawnNewBucket()
			activeBuckets += 1
	
func spawnNewBucket():
	var k = rng.randi_range(0,2)
	
	pass
	
