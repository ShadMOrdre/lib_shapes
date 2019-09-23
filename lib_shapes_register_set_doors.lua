


local _lib_doors = {}
lib_shapes.registered_doors = {}

local nodes_created = 0


lib_shapes.register_door_node = function(node_mat, shape)

	local node_mod = ""
	local node_name = ""
	local node_def = {}
	local new_node = {}
	local new_node_name = ""
	local new_node_def = {}
	local new_node_tiles = {}
	local new_node_groups = {}

	local shape_def = {}
	--local shape_tiles = {}
	local shape_node_box = {}
	local shape_selection_box = {}
	local shape_open_node_box = {}
	local shape_open_selection_box = {}
	--local shape_collision_box = {}

	shape_def = lib_shapes.registered_shapes["shape_" .. shape]
	--shape_tiles = shape_def.tiles
	shape_node_box = shape_def.node_box
	shape_selection_box = shape_def.selection_box
	shape_open_node_box = shape_def.open_node_box
	shape_open_selection_box = shape_def.open_selection_box
	--shape_collision_box = shape_def.collision_box

	node_mod, node_name = unpack(node_mat:split(":", true))
	node_def = minetest.registered_nodes[node_mat]

	new_node_name = node_mod .. ":" .. node_name .. "_" .. shape

	new_node_groups = node_def.groups
	--new_node_groups.not_in_creative_inventory = 1
	new_node_groups.lib_shaped_node = 3
	new_node_groups.lib_doors = 1
	
	local name_closed = new_node_name
	local name_opened = new_node_name.."_open"
	local skel_key = false
	local temp_tile
	
	if node_def.tiles then
		if node_def.tiles[1] then
			new_node_tiles[1] = node_def.tiles[1] .. ""
		else
			new_node_tiles[1] = node_def.tiles .. ""
		end
		if node_def.tiles[2] then
			new_node_tiles[2] = node_def.tiles[2] .. ""
		else
			new_node_tiles[2] = new_node_tiles[1]
		end
		if node_def.tiles[3] then
			temp_tile = node_def.tiles[3]
			new_node_tiles[3] = "([combine:16x16:-8,0=" .. node_def.tiles[3] .. ":8,0=" .. node_def.tiles[3] .. ""
		else
			temp_tile = new_node_tiles[2]
			new_node_tiles[3] = "[combine:16x16:-8,0=" .. new_node_tiles[2] .. ":8,0=" .. new_node_tiles[2] .. ""
		end
		if node_def.tiles[4] then
			new_node_tiles[4] = "([combine:16x16:8,0=" .. node_def.tiles[4] .. ":-8,0=" .. node_def.tiles[4] .. ""
		else
			new_node_tiles[4] = new_node_tiles[3]
		end
		if node_def.tiles[5] then
			new_node_tiles[5] = node_def.tiles[5] .. ""
		else
			new_node_tiles[5] = temp_tile
		end
		if node_def.tiles[6] then
			new_node_tiles[6] = node_def.tiles[6] .. ""
		else
			new_node_tiles[6] = temp_tile
		end


		if shape_def.shape_type == "tree" then
			new_node_tiles[1] = node_def.tiles[1]
			new_node_tiles[2] = node_def.tiles[2]
			new_node_tiles[3] = node_def.tiles[3]
			new_node_tiles[4] = node_def.tiles[3]
			new_node_tiles[5] = node_def.tiles[3]
			new_node_tiles[6] = node_def.tiles[3]
		end
		if shape_def.shape_type == "light" then
		end
	end

	new_node_def = {
		description = node_def.description .. "_" .. shape_def.description,
		drawtype = "nodebox",
		tiles = new_node_tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general", "group:lib_shaped_node" },
		is_ground_content = false,
		walkable = true,
		groups = new_node_groups,
		sounds = node_def.sounds,
		sound_open = "doors_door_open",
		sound_close = "doors_door_close",
		protected = false,
		
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			lib_shapes.door_toggle(pos, node, clicker)
			return itemstack
		end,
	}
	if skel_key then
		new_node_def.can_dig = can_dig_door
		new_node_def.after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pn = placer:get_player_name()
			local meta = minetest.get_meta(pos)
			meta:set_string("doors_owner", pn)
			meta:set_string("infotext", "Owned by "..pn)

			return minetest.setting_getbool("creative_mode")
		end

		new_node_def.on_blast = function() end
		new_node_def.on_key_use = function(pos, player)
			local door = lib_doors.get(pos)
			--lib_doors:toggle(player)
			lib_shapes.door_toggle(pos, node, clicker)
		end
		new_node_def.on_skeleton_key_use = function(pos, player, newsecret)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("doors_owner")
			local pname = player:get_player_name()

			-- verify placer is owner of lockable door
			if owner ~= pname then
				minetest.record_protection_violation(pos, pname)
				minetest.chat_send_player(pname, "You do not own this trapdoor.")
				return nil
			end

			local secret = meta:get_string("key_lock_secret")
			if secret == "" then
				secret = newsecret
				meta:set_string("key_lock_secret", secret)
			end

			return secret, "a locked trapdoor", owner
		end
	else
		new_node_def.on_blast = function(pos, intensity)
			minetest.remove_node(pos)
			return {name}
		end
	end

	local def_opened = table.copy(new_node_def)
	local def_closed = table.copy(new_node_def)

	def_closed.node_box = shape_node_box
	def_closed.selection_box = shape_selection_box

	def_opened.node_box = shape_open_node_box
	def_opened.selection_box = shape_open_selection_box

	def_opened.drop = name_closed
	def_opened.groups.not_in_creative_inventory = 1

	minetest.register_node(name_opened, def_opened)
	minetest.register_node(name_closed, def_closed)

	lib_shapes.registered_doors[name_opened] = true
	lib_shapes.registered_doors[name_closed] = true


	minetest.register_craft({
		output = new_node_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', 'lib_shapes:shape_' .. shape, ''},
			{ '', node_mat, ''},
		}
	})

end


lib_shapes.register_doors_set = function(node_mat)

	lib_shapes.register_door_node(node_mat, "door_centered")
	lib_shapes.register_door_node(node_mat, "door_centered_right")
	
	lib_shapes.register_door_node(node_mat, "door_centered_with_window")
	lib_shapes.register_door_node(node_mat, "door_centered_with_window_right")
	
	lib_shapes.register_door_node(node_mat, "door_centered_sliding")
	lib_shapes.register_door_node(node_mat, "door_centered_sliding_right")
	
	lib_shapes.register_door_node(node_mat, "door_centered_300_height_150_width")
	lib_shapes.register_door_node(node_mat, "door_centered_300_height_150_width_right")
	
	lib_shapes.register_door_node(node_mat, "door_centered_400_height_200_width")
	lib_shapes.register_door_node(node_mat, "door_centered_400_height_200_width_right")
	
	lib_shapes.register_door_node(node_mat, "door_centered_400_height_250_width")
	lib_shapes.register_door_node(node_mat, "door_centered_400_height_250_width_right")
	
	lib_shapes.register_door_node(node_mat, "trapdoor_solid")
	lib_shapes.register_door_node(node_mat, "trapdoor_with_window")
	
	lib_shapes.register_door_node(node_mat, "fencegate_centered")
	lib_shapes.register_door_node(node_mat, "fencegate_centered_right")
	
	lib_shapes.register_door_node(node_mat, "fencegate_centered_solid")
	lib_shapes.register_door_node(node_mat, "fencegate_centered_solid_right")
	
	nodes_created = nodes_created + 1

end













