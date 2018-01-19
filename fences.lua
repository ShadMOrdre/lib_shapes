--[[ TEMPLATE
	lib_shapes.register_shape(name, description, node_box, selection_box, collision_box)
		Name			Name of the shape within the library
		Description		Full Text description of above name
		Node_Box		node_box = {
							type = "fixed",
							fixed = {
								{-0.25, 0, -0.5, 0.25, 0.5, 0.5},
							},
						},


							(above example for a static node_box
											OR
							below example for a connected node_box)


						node_box = {
							type = "connected",
							fixed = {
								{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
							},
							connect_front = {
								{-0.125, -0.0625, -0.5, 0.125, 0.0625, -0.0625}, -- Front_h_zneg
							},
							connect_back = {
								{-0.125, -0.0625, 0.0625, 0.125, 0.0625, 0.5}, -- Back_h_zpos
							},
							connect_left = {
								{-0.5, -0.0625, -0.125, -0.0625, 0.0625, 0.125}, -- Left_h_xneg
							},
							connect_right = {
								{0.0625, -0.0625, -0.125, 0.5, 0.0625, 0.125}, -- Right_h_xpos
							},
							connect_bottom = {
								{-0.125, -0.5, -0.0625, 0.125, -0.0625, 0.0625}, -- Bottom_x_yneg
							},
							connect_top = {
								{-0.125, 0.0625, -0.0625, 0.125, 0.5, 0.0625}, -- Top_x_ypos
							},
						},

		Selection_Box	Follows the same as above for fixed node_box.  Standard definition.
		Collision_Box	Follows the same as above for fixed node_box.  Standard definition.

EXAMPLE:

lib_node_shapes.register_shape(
	"shape_somename",					--All shape names WILL BE prefixed with 'shape_'.  This allows shapes to be sorted together in inventory.
	"Unique text description of the shape",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0, -0.5, 0.25, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{ -0.25, 0, -0.5, 0.25, 0.5, 0.5},
		},
	},
)

--]]

local S
if minetest.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end



lib_shapes.register_shape("fence", {
	description = "Fence", 
	shape_type = "connected",
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
	collision_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})


lib_shapes.register_shape("rail", {
	description = "Rail", 
	shape_type = "basic",
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
})

lib_shapes.register_shape("rail_post", {
	description = "Rail Post", 
	shape_type = "basic",
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
})








