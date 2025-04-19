extends Node3D

@export_category('Player Controls')

enum RUN_MODE_VALUE {
	CLICK, 
	PRESS
}

@export var RUN_MODE = RUN_MODE_VALUE.CLICK
@export var JUMP_VELOCITY: float = 4.5
@export var NORMAL_SPPED: float = 5.0
@export var RUN_SPEED: float = 10.0 
@export var CROUCH_SPEED: float = 2.0
@export var SENSITIVITY: float = 0.2
