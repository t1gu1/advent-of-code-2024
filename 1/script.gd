extends Node

func _ready():
    print_debug('hello')
    run("res://input.txt")
    pass

func run(path: String) -> int:
  var file = FileAccess.open(path, FileAccess.READ)
  assert(file, "Failed to read file")

  var line: String = file.get_line()
	
  while line:
    print_debug(line)

  return 0
