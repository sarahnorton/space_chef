extends Sprite2D

var tomato = "<CompressedTexture2D#-9223372006706117412>"
var lettuce = "<CompressedTexture2D#-9223372008400616234>"
var blueberry = "<CompressedTexture2D#-9223372006035028768>"
var carrot = "<CompressedTexture2D#-9223372006370573089>"

@export var ingredients = {
	0 : preload("res://assets/Fruits and Vegetables/Lettuce.png"),
	1 : preload("res://assets/Fruits and Vegetables/Tomato.png")
	#2 : preload("res://assets/Fruits and Vegetables/Carrot.png"),
	#3 : preload("res://assets/Fruits and Vegetables/Blueberries.png")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var item = ingredients[randi() % ingredients.size()]
	texture = item
	if (item.to_string() == "tomato"):
		print("tomato")
	if (item.to_string() == "carrot"):
		print("carrot")
	if (item.to_string() == "lettuce"):
		print("lettuce")
	if (item.to_string() == "blueberry"):
		print("blueberry")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
