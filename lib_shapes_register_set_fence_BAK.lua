
lib_fences = {}

local _lib_fences = {}



function lib_fences.register_nodes(node_name, node_desc, node_texture, node_craft_mat, node_sounds)


--FENCES
	lib_fences.register_fence(node_name .. "_fence", node_desc .. "Fence", node_texture, node_craft_mat, node_sounds)

	lib_fences.register_rail(node_name .. "_rail", node_desc .. "Rail", node_texture, node_craft_mat, node_sounds)

	lib_fences.register_rail_post(node_name .. "_rail_post", node_desc .. "Rail Post", node_texture, node_craft_mat, node_sounds)

end

lib_fences.register_fence = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_fences:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general", "group:lib_lights"},
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_fences = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "connected",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			},
			connect_front = {
				{-0.0625, 0.1875, -0.5, 0.0625, 0.4375, -0.125}, -- Top
				{-0.0625, -0.3125, -0.5, 0.0625, -0.125, -0.125}, -- Bottom
			},
			connect_back = {
				{-0.0625, 0.1875, 0.125, 0.0625, 0.4375, 0.5}, -- Top
				{-0.0625, -0.3125, 0.125, 0.0625, -0.125, 0.5}, -- Bottom
			},
			connect_left = {
				{-0.5, 0.1875, -0.0625, -0.125, 0.4375, 0.0625}, -- Top
				{-0.5, -0.3125, -0.0625, -0.125, -0.125, 0.0625}, -- Bottom
			},
			connect_right = {
				{0.125, 0.1875, -0.0625, 0.5, 0.4375, 0.0625}, -- Top
				{0.125, -0.3125, -0.0625, 0.5, -0.125, 0.0625}, -- Bottom
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_fences:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_fence", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_fences.register_rail = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_fences:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_fences = 1 },
		sounds = wall_sounds,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, 0.4375, -0.375, 0.375, 0.5}, -- support1 from front
			{-0.1875, -0.5, 0.4375, -0.125, 0.375, 0.5}, -- support2 from front
			{0.0625, -0.5, 0.4375, 0.125, 0.375, 0.5}, -- support3 from front
			{0.3125, -0.5, 0.4375, 0.375, 0.375, 0.5}, -- support4 from front
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, -- top rail
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, 0.4375, -0.375, 0.375, 0.5}, -- support1 from front
			{-0.1875, -0.5, 0.4375, -0.125, 0.375, 0.5}, -- support2 from front
			{0.0625, -0.5, 0.4375, 0.125, 0.375, 0.5}, -- support3 from front
			{0.3125, -0.5, 0.4375, 0.375, 0.375, 0.5}, -- support4 from front
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, -- top rail
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, 0.4375, -0.375, 0.375, 0.5}, -- support1 from front
			{-0.1875, -0.5, 0.4375, -0.125, 0.375, 0.5}, -- support2 from front
			{0.0625, -0.5, 0.4375, 0.125, 0.375, 0.5}, -- support3 from front
			{0.3125, -0.5, 0.4375, 0.375, 0.375, 0.5}, -- support4 from front
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, -- top rail
		},
	},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_fences:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_rail", ''},
			{ '', wall_mat, ''},
		}
	})

end

lib_fences.register_rail_post = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_fences:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = { wall_texture, },
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_fences = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5}, -- support1 from front
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5}, -- support1 from front
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5}, -- support1 from front
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_fences:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', "lib_shapes:shape_rail_post", ''},
			{ '', wall_mat, ''},
		}
	})

end



lib_fences.register_fence_special = function(wall_name, wall_desc, wall_texture, wall_mat, wall_texture2, wall_mat2, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_fences:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = {
			"((fence_post_top_overlay.png^[makealpha:255,126,126)^" .. wall_texture .. "^(fence_post_top_overlay.png^[makealpha:255,126,126))^((fence_rail_top_overlay.png^[makealpha:255,126,126)^" .. wall_texture2 .. "^(fence_rail_top_overlay.png^[makealpha:255,126,126))",
			"((fence_post_top_overlay.png^[makealpha:255,126,126)^" .. wall_texture .. "^(fence_post_top_overlay.png^[makealpha:255,126,126))^((fence_rail_top_overlay.png^[makealpha:255,126,126)^" .. wall_texture2 .. "^(fence_rail_top_overlay.png^[makealpha:255,126,126))",
			"((fence_post_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture .. "^(fence_post_side_overlay.png^[makealpha:255,126,126))^((fence_rail_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture2 .. "^(fence_rail_side_overlay.png^[makealpha:255,126,126))",
			"((fence_post_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture .. "^(fence_post_side_overlay.png^[makealpha:255,126,126))^((fence_rail_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture2 .. "^(fence_rail_side_overlay.png^[makealpha:255,126,126))",
			"((fence_post_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture .. "^(fence_post_side_overlay.png^[makealpha:255,126,126))^((fence_rail_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture2 .. "^(fence_rail_side_overlay.png^[makealpha:255,126,126))",
			"((fence_post_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture .. "^(fence_post_side_overlay.png^[makealpha:255,126,126))^((fence_rail_side_overlay.png^[makealpha:255,126,126)^" .. wall_texture2 .. "^(fence_rail_side_overlay.png^[makealpha:255,126,126))",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:wall", "group:stone", "group:fence", "group:wood", "group:lib_architecture", "group:lib_doors", "group:lib_fences", "group:lib_general", "group:lib_lights", "group:lib_shaped_node"},
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_fences = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "connected",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			},
			connect_front = {
				{-0.0625, 0.1875, -0.5, 0.0625, 0.4375, -0.125}, -- Top
				{-0.0625, -0.3125, -0.5, 0.0625, -0.125, -0.125}, -- Bottom
			},
			connect_back = {
				{-0.0625, 0.1875, 0.125, 0.0625, 0.4375, 0.5}, -- Top
				{-0.0625, -0.3125, 0.125, 0.0625, -0.125, 0.5}, -- Bottom
			},
			connect_left = {
				{-0.5, 0.1875, -0.0625, -0.125, 0.4375, 0.0625}, -- Top
				{-0.5, -0.3125, -0.0625, -0.125, -0.125, 0.0625}, -- Bottom
			},
			connect_right = {
				{0.125, 0.1875, -0.0625, 0.5, 0.4375, 0.0625}, -- Top
				{0.125, -0.3125, -0.0625, 0.5, -0.125, 0.0625}, -- Bottom
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_fences:" .. wall_name .. " 99",
		recipe = {
			{ '', wall_mat2, '' },
			{ '', "lib_shapes:shape_fence", ''},
			{ '', wall_mat, ''},
		}
	})

end


--[[

lib_fences.register_nodes("cobble", "Cobblestone ", "default_cobble.png",
		"default:cobble", default.node_sound_stone_defaults())
lib_fences.register_nodes("mossycobble", "Mossy Cobblestone ", "default_mossycobble.png",
		"default:mossycobble", default.node_sound_stone_defaults())
lib_fences.register_nodes("desertcobble", "Desert Cobblestone ", "default_desert_cobble.png",
		"default:desert_cobble", default.node_sound_stone_defaults())

lib_fences.register_nodes("sandstone", "Sandstone ", "default_sandstone.png",
		"default:sandstone", default.node_sound_stone_defaults())
lib_fences.register_nodes("desert_stone", "Desert Stone ", "default_desert_stone.png",
		"default:desert_stone", default.node_sound_stone_defaults())
lib_fences.register_nodes("stone", "Stone ", "default_stone.png",
		"default:stone", default.node_sound_stone_defaults())
lib_fences.register_nodes("obsidian", "Obsidian ", "default_obsidian.png",
		"default:obsidian", default.node_sound_stone_defaults())

lib_fences.register_nodes("sandstone_block", "Sandstone Block ", "default_sandstone_block.png",
		"default:sandstone_block", default.node_sound_stone_defaults())
lib_fences.register_nodes("desert_stone_block", "Desert Stone Block ", "default_desert_stone_block.png",
		"default:desert_stone_block", default.node_sound_stone_defaults())
lib_fences.register_nodes("stone_block", "Stone Block ", "default_stone_block.png",
		"default:stone_block", default.node_sound_stone_defaults())
lib_fences.register_nodes("obsidian_block", "Obsidian Block ", "default_obsidian_block.png",
		"default:obsidian_block", default.node_sound_stone_defaults())

lib_fences.register_nodes("sandstone_brick", "Sandstone Brick ", "default_sandstone_brick.png",
		"default:sandstonebrick", default.node_sound_stone_defaults())
lib_fences.register_nodes("desertstone_brick", "Desert Stone Brick ", "default_desert_stone_brick.png",
		"default:desert_stonebrick", default.node_sound_stone_defaults())
lib_fences.register_nodes("stone_brick", "Stone Brick ", "default_stone_brick.png",
		"default:stonebrick", default.node_sound_stone_defaults())
lib_fences.register_nodes("obsidian_brick", "Obsidian Brick ", "default_obsidian_brick.png",
		"default:obsidianbrick", default.node_sound_stone_defaults())

--]]


lib_fences.register_nodes("tree", "Tree ", "default_tree.png",
		"default:tree", default.node_sound_stone_defaults())
lib_fences.register_nodes("wood", "Wood ", "default_wood.png",
		"default:wood", default.node_sound_stone_defaults())
lib_fences.register_nodes("jungletree", "Jungle Tree ", "default_jungletree.png",
		"default:jungletree", default.node_sound_stone_defaults())
lib_fences.register_nodes("junglewood", "Jungle Wood ", "default_junglewood.png",
		"default:junglewood", default.node_sound_stone_defaults())

lib_fences.register_nodes("acacia_tree", "Acacia Tree ", "default_acacia_tree.png",
		"default:acacia_tree", default.node_sound_stone_defaults())
lib_fences.register_nodes("acacia_wood", "Acacia Wood ", "default_acacia_wood.png",
		"default:acacia_wood", default.node_sound_stone_defaults())




lib_fences.register_fence_special("stone_block_wood_fence", "Stone Block and Wood Fence", "default_stone_block.png", "default:stone_block", "default_wood.png", "default:wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("stone_block_acacia_wood_fence", "Stone Block and Acacia Wood Fence", "default_stone_block.png", "default:stone_block", "default_acacia_wood.png", "default:acacia_wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("stone_block_jungle_wood_fence", "Stone Block and Jungle Wood Fence", "default_stone_block.png", "default:stone_block", "default_junglewood.png", "default:junglewood", default.node_sound_stone_defaults())

lib_fences.register_fence_special("stone_brick_wood_fence", "Stone Brick and Wood Fence", "default_stone_brick.png", "default:stonebrick", "default_wood.png", "default:wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("stone_brick_acacia_wood_fence", "Stone Brick and Acacia Wood Fence", "default_stone_brick.png", "default:stonebrick", "default_acacia_wood.png", "default:acacia_wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("stone_brick_jungle_wood_fence", "Stone Brick and Jungle Wood Fence", "default_stone_brick.png", "default:stonebrick", "default_junglewood.png", "default:junglewood", default.node_sound_stone_defaults())

lib_fences.register_fence_special("desert_stone_block_wood_fence", "Desert Stone Block and Wood Fence", "default_desert_stone_block.png", "default:desert_stone_block", "default_wood.png", "default:wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("desert_stone_block_acacia_wood_fence", "Desert Stone Block and Acacia Wood Fence", "default_desert_stone_block.png", "desert_default:stone_block", "default_acacia_wood.png", "default:acacia_wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("desert_stone_block_jungle_wood_fence", "Desert Stone Block and Jungle Wood Fence", "default_desert_stone_block.png", "desert_default:stone_block", "default_junglewood.png", "default:junglewood", default.node_sound_stone_defaults())

lib_fences.register_fence_special("desert_stone_brick_wood_fence", "Desert Stone Brick and Wood Fence", "default_desert_stone_brick.png", "default:desert_stonebrick", "default_wood.png", "default:wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("desert_stone_brick_acacia_wood_fence", "Desert Stone Brick and Acacia Wood Fence", "default_desert_stone_brick.png", "default:desert_stonebrick", "default_acacia_wood.png", "default:acacia_wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("desert_stone_brick_jungle_wood_fence", "Desert Stone Brick and Jungle Wood Fence", "default_desert_stone_brick.png", "default:desert_stonebrick", "default_junglewood.png", "default:junglewood", default.node_sound_stone_defaults())

lib_fences.register_fence_special("cobble_wood_fence", "Cobble Wood Fence", "default_cobble.png", "default:cobble", "default_wood.png", "default:wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("cobble_acacia_wood_fence", "Cobble Acacia Wood Fence", "default_cobble.png", "default:cobble", "default_acacia_wood.png", "default:acacia_wood", default.node_sound_stone_defaults())
lib_fences.register_fence_special("cobble" .. "_junglewood_fence", "Cobble Junglewood Fence", "default_cobble.png", "default:cobble", "default_junglewood.png", "ethereal:junglewood", default.node_sound_stone_defaults())















