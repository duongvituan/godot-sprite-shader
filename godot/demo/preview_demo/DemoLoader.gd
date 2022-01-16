class_name DemoLoader extends Node

const PATH_DEMO_SHADER = "res://demo/list_demo/shaders/"
const PATH_DEMO_GAME = "res://demo/list_demo/games/"

# If you assign a value, the preview_demo will load only this demo
var testing_demo_name = "" 

var list_demo = []
var index = 0


func _ready():
	_load_all_collection_demo()


func get_first_screen():
	if len(list_demo) == 0:
		return
	index = 0
	return list_demo[0]


func get_current_screen():
	if len(list_demo) == 0:
		return
	return list_demo[index]


func next():
	if len(list_demo) == 0:
		return
	index = (index + 1) % list_demo.size()
	return list_demo[index]


func back():
	if len(list_demo) == 0:
		return
	index = (index + list_demo.size() - 1) % list_demo.size()
	return list_demo[index]


func _get_list_folder_demo(path) -> Array:
	var dir = Directory.new()
	var list_dir = []
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if dir.current_is_dir() and file_name != ".." and file_name != ".":
				list_dir.append(file_name)
			file_name = dir.get_next()
		return list_dir
	
	else:
		print("An error occurred when trying to access the path.")
		return []


func _load_all_collection_demo():
	_load_demo_with_path(PATH_DEMO_SHADER)
	_load_demo_with_path(PATH_DEMO_GAME)


func _load_demo_with_path(path: String):
	var list_demo_folder = []
	if testing_demo_name.empty():
		list_demo_folder = _get_list_folder_demo(path)
	else:
		list_demo_folder = [testing_demo_name]
	
	list_demo_folder.sort()
	for folder in list_demo_folder:
		var demo_path = "%s%s/demo.tscn" % [path, folder]
		print("loading demo: %s" % demo_path)
		list_demo.append(load(demo_path))

