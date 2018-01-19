minetest.register_craftitem("lib_shapes:blueprint", {
	description = "lib_shapes Blueprint",
	inventory_image = "lib_node_shapes_blueprint.png",
})
minetest.register_craft({
	output = 'lib_shapes:blueprint',
	recipe = {
		{'default:paper', 'default:paper', 'default:paper'},
		{'default:paper', 'lib_shapes:pencil', 'default:paper'},
		{'default:paper', 'default:paper', 'default:paper'},
	}
})

minetest.register_craftitem("lib_shapes:pencil", {
	description = "lib_shapes Pencil",
	inventory_image = "lib_node_shapes_pencil.png",
})
minetest.register_craft({
	output = 'lib_shapes:pencil',
	recipe = {
		{'', 'group:stick', ''},
		{'', 'default:coal_lump', ''},
		{'', '', ''},
	}
})

