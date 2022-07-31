extends CanvasLayer




func _ready() -> void:
	var images = _find_png_paths()
	for files in images:
		var nImage = TextureRect.new()
		nImage.texture = load(files)
		$IMAGES.add_child(nImage)

	print(images)




"""
Returns a list of all png files in the /assets directory.

Recursively traverses the assets directory searching for pngs. Any additional directories it discovers are appended to
a queue for later traversal.

Note: We search for '.png.import' files instead of searching for png files directly. This is because png files
  disappear when the project is exported.
"""
func _find_png_paths() -> Array:
	var png_paths := [] # accumulated png paths to return
	var dir_queue := ["res://images/"] # directories remaining to be traversed
	var dir: Directory # current directory being traversed
	var file: String # current file being examined
	print(file)
	while file or not dir_queue.empty():
	# continue looping until there are no files or directories left
		if file:
			
			# there is another file in this directory
			if dir.current_is_dir():
			# found a directory, append it to the queue.
				dir_queue.append("%s/%s" % [dir.get_current_dir(), file])
			elif file.ends_with(".png.import"):
		# found a .png.import file, append its corresponding png to our results
				png_paths.append("%s/%s" % [dir.get_current_dir(), file.get_basename()])
		else:
	  # there are no more files in this directory
			if dir:
		# close the current directory
				dir.list_dir_end()
			if dir_queue.empty():
		# there are no more directories. terminate the loop
				break
	  # there are more directories. open the next directory
			dir = Directory.new()
			dir.open(dir_queue.pop_front())
			dir.list_dir_begin(true, true)
		file = dir.get_next()
	return png_paths
#
#func get_files_recursively(path : String, type = []) -> PoolStringArray:
#	var files : PoolStringArray = []
#	var dir = Directory.new()
#	assert( dir.open(path) == OK )
#	assert( dir.list_dir_begin(true, true) == OK )
#
#	var next = dir.get_next()
#	while !next.empty():
#			if dir.current_is_dir():
#				files += get_files_recursively("%s/%s" % [dir.get_current_dir(), next], type)
#			else:
#				if type.empty() or next.rsplit(".", true, 1)[1] in type:
#					files.append("%s/%s" % [dir.get_current_dir(), next])
#			next = dir.get_next()
#
#	dir.list_dir_end()
#	return files

##Regresa todos los paths dado un directorio
##@param path de un directorio de escenas
##@return los nombres de caminos para instanciar escenas
#func getFullPaths(path: String):
#	if path.ends_with(".tscn"):
#		return [path]
#
#	var files = listFilesInDirectory(path)
#	var paths = []
#	for file in files:
#		paths.append(path+file)
#	return paths
#
#
##Regresa el nombre de todos los caminos en un directorio
##@param path al path de un directorio eg "res://scenes/characters
##@return el nombre de todos los archivos en ese directorio eg["Personaje1.tscn"]
#func listFilesInDirectory(path:String) -> Array:
#	var files: Array = []
#	var dir := Directory.new()
#
#	dir.open(path)
#	dir.list_dir_begin()
#	while true:
#		var file:String = dir.get_next()
#		if file == "":
#			break
#		elif not file.begins_with("."):
#			#if tipo in file and !"remap" in file: #Al exportar goodt hace archivos remap
#			#print(file)
#			#if !file.get_extension() == "import":
#			files.append(file)
#	dir.list_dir_end()
#	return files
