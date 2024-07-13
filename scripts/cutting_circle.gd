extends RigidBody2D

@export var AllowedCuttingAngles = [ 1, 10 ]
@export var AllowedVariationOnCuttingAngle = 10
@export var NumberOfCutsToNextState = 4
@export var NextCutScene : Resource

signal ObjectCut()

enum State
{
	Default,
	Hovering,
	Cutting,
	Dragging,
}

var LocalInitialCutVector : Vector2
var CurrentState : State = State.Default;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass


func _on_control_mouse_entered():
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		LocalInitialCutVector = GetLocalPositionOfMouse()
		CurrentState = State.Cutting
	else:
		CurrentState = State.Hovering


func _on_control_mouse_exited():
	if (CurrentState == State.Hovering):
		CurrentState = State.Default
	elif (CurrentState == State.Cutting):
		FoodCut()
	
	return


func FoodCut():
	var LocalFinalCutVector = GetLocalPositionOfMouse()
	var DirectionVectorOfCut : Vector2 = (LocalInitialCutVector - LocalFinalCutVector).normalized()
	var CutAngle = GetAllowedAngleDirectionVector().dot(DirectionVectorOfCut)
	print(CutAngle)
	
	ObjectCut.emit()


func GetLocalPositionOfMouse() -> Vector2:
	var MousePosition = get_viewport().get_mouse_position()
	
	return to_local(MousePosition)


func GetAllowedAngleDirectionVector() -> Vector2:
	var Output : Vector2 = Vector2(0, 1)
	
	Output.rotated(AllowedCuttingAngles[0])
	
	return Output
	




