@tool
extends EditorScenePostImport

func _post_import(scene):
	var path = get_source_file()
	print("Running post import script on file '{file}'".format({'file': path}))
	
	path = path.substr(0, path.rfind('/'));
	path = path.substr(0, path.rfind('/'));
		
	var packed = PackedScene.new()
	packed.pack(scene)
	var scene_path = "{path}/scenes/{name}.scn".format({'path': path, 'name': scene.name})
	print(scene.name, " -> ", scene_path)
	ResourceSaver.save(packed, scene_path)
	
	return scene

func set_owner_on_node_descendents(node : Node, owner : Node):
	for child in node.get_children():
		child.owner = owner
		set_owner_on_node_descendents(child, owner)
