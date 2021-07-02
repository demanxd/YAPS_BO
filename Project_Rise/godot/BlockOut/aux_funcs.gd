extends Node

onready var time
var hour
var minute
var seconds


func get_time():
	var time = OS.get_time();
	var hour = time.hour;
	var minute = time.minute;
	var seconds = time.second;
	#print(String(hour) + " " + String(minute) + " " + String(seconds))
