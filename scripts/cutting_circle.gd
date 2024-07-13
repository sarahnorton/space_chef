extends RigidBody2D

# dictionary to store different assets
var cut_bar_versions = {
	"uncut_version": preload("res://assets/Cut Bar/cut_bar_0.png"),
	"first_cut" : preload("res://assets/Cut Bar/cut_bar_1.png"),
	"second_cut" : preload("res://assets/Cut Bar/cut_bar_2.png"),
	"third_cut" : preload("res://assets/Cut Bar/cut_bar_3.png"),
	"fourth_cut" : preload("res://assets/Cut Bar/cut_bar_4.png"),
	"successful_cut" : preload("res://assets/Cut Bar/cut_cloud.png"),
}

# enum State = { "cutting" }

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_control_mouse_entered():
	pass # Replace with function body.


func _on_control_mouse_exited():
	pass # Replace with function body.
