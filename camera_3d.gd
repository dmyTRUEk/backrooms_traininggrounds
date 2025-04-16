extends Camera3D

@export var movement_step: float = 1
@export var rotation_step: float = 10

enum Movement {None, Forward, Backward, Left, Right}

func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	var movement: Movement = Movement.None
	if Input.is_key_pressed(KEY_UP):
		movement = Movement.Forward
	if Input.is_key_pressed(KEY_DOWN):
		movement = Movement.Backward
	if Input.is_key_pressed(KEY_LEFT):
		movement = Movement.Left
	if Input.is_key_pressed(KEY_RIGHT):
		movement = Movement.Right
	
	if movement == Movement.None:
		return
	
	match movement:
		Movement.Forward:
			var step: Vector3 = -self.transform.basis.z
			self.transform.origin += step
		Movement.Backward:
			var step: Vector3 = -self.transform.basis.z
			self.transform.origin -= step
		Movement.Left:
			self.rotate_y(deg_to_rad(rotation_step))
		Movement.Right:
			self.rotate_y(deg_to_rad(-rotation_step))
	
	self.transform.origin.y = 2
