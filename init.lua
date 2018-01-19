--
--lib_shapes
--copyright 2017 ShadMOrdre@gmail.com
--
--A mod for Minetest that provides various nodeboxes that can then be applied to any "materials" type
--node.  The "materials" are generally defined as stone, metal, tree, wood, and glass.  The shapes are
--nodeboxes, and a shape node is created and presented in a users inventory.  Shapes are created in separate
--mods, organized according to below.  The entire collection is included in the modpack.

--Among the shapes provided are:
--	Columns, Pillars, Beams
--	Doors  (Solid, Windowed, Sliding, and larger doors of sizes 3x1.5 and 4x2)
--	Fences	(Includes railing nodes as well as standard fencing)
--	Furniture	(Chairs, Tables, Sofa section pieces, a (currently) non working bed
--	Gates	(Solid and Railed type gates, with attached support post.  These are essentially half-height doors, thus, will be merged)
--	General	(Cylinders, Linkages, various other standard shapes)
--	Lights	(Dekstop, Hanging, Wall-Mounted, an Overhead strip light, and a "magic" bulb that can attach to most materials)
--	Religious	(Various religous themed shapes.  Currently, a cross, a tombstone, and a tomb.)
--	Slabs	(Slabs of thicknesses: 1/16, 1/8, 1/4, 1/2)
--	Stairs	(Includes standard 2 step stairs, and custom 4 step stairs, of various designs)
--	Tree	(These nodes connect only to tree, leaves and themselves.  Designed for creating more elaborate trees)
--	Wall	(Walls of thicknesses: 1/16, 1/8, 1/4, 1/2, 3/4

--**LICENSING**
--For the sections of code copied from minetest_game, the code is licensed LGPL2.1.
--For the sections of code copied from xdecor, the code is licensed ###############.
--For all other code, license is MIT.

--All graphics are original works by ShadMOrdre@gmail.com, and are licensed CC-BY-SA.


lib_shapes = {}

local S
if minetest.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end

lib_shapes.registered_shapes = {}

local modpath = minetest.get_modpath("lib_shapes")
local applicable_nodes = {}
lib_shapes.registered_doors = {}

lib_shapes.shapes_created = 0
lib_shapes.nodes_used = 0
lib_shapes.nodes_created = 0

dofile(modpath.."/craftitems.lua")
dofile(modpath.."/utility.lua")

function lib_shapes.get_shapes()

	--local shape_list = {}
	
	for shape, def in pairs(registered_shapes) do

		lib_shapes.shapes_created = lib_shapes.shapes_created + 1

		minetest.debug(lib_shapes.shapes_created)
		
	end

end


lib_shapes.register_shape = function(shape_name, shape_def)

	local new_shape_name = ""
	local new_shape_def = {}

	new_shape_name = "shape_" .. shape_name
	new_shape_def = {
		description = shape_def.description .. " Shape",
		drawtype = "nodebox",
		tiles = {
			"dk_grey_noise.png^align_grid_ypos.png",
			"dk_grey_noise.png^align_grid_yneg.png",
			"dk_grey_noise.png^align_grid_xpos.png",
			"dk_grey_noise.png^align_grid_xneg.png",
			"dk_grey_noise.png^align_grid_zpos.png",
			"dk_grey_noise.png^align_grid_zneg.png",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		connects_to = { "group:lib_shapes_library" },
		is_ground_content = false,
		walkable = true,
		climbable = false,
		buildable_to = false,
		groups = { oddly_breakable_by_hand = 3, lib_shapes_library = 3 },
		node_box = shape_def.node_box,
		selection_box = shape_def.selection_box,
		collision_box = shape_def.collision_box,

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
	}


	minetest.register_node("lib_shapes:" .. new_shape_name, new_shape_def)
	minetest.register_craft({
		output = new_shape_name .. " 1",
		recipe = {
			{ 'lib_shapes:blueprint', 'lib_shapes:blueprint', 'lib_shapes:blueprint' },
			{ '', 'lib_shapes:blueprint', ''},
			{ '', '', ''},
		}
	})
	
	lib_shapes.registered_shapes[new_shape_name] = shape_def

	lib_shapes.shapes_created = lib_shapes.shapes_created + 1

	minetest.log("NEW SHAPE:     = " .. new_shape_name)
	--lib_shapes.register_shaped_nodes(shape_name, shape_def)

end


dofile(modpath.."/architecture.lua")
dofile(modpath.."/doors.lua")
dofile(modpath.."/fences.lua")
dofile(modpath.."/furniture.lua")
dofile(modpath.."/general.lua")
dofile(modpath.."/lights.lua")
