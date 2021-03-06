# lib_shapes
A library of nodebox shapes that can be registered by mods in the same way that the stairs mod is currently used.

The basic shapes include stairs, slabs, walls, columns, and beams.

Extended shapes include architecural elements, doors, furniture, fences, and some general shapes like cylinder and connecting nodeboxes.

The doors use standard doors code, and should work as expected, with the only difference being that this mod does not check for, or ensure, that space is available for the nodebox.  Doors and beds are nodeboxes that are larger than the typical 1mx1m block.  Some doors are 2m wide x 4m height.

lib_shapes

Inspired by default:walls, Columnia, Castles, xdecor, and others, for their immense and invaluable creative value and the frustration of scrolling
through their countless repetitive pages of the same shaped nodes.  With much love to their respective creators!

This mod provides a library of nodebox shapes.  Types of shapes included are slabs, stairs, columns, fences, walls, beams, furniture, various custom shapes, as well as a library of general, simple and common shapes.  Shapes are organized into various sub-mods, and currently there are 75+ shapes from which to choose.  Also included are nodes that are designed to be used as drop in replacements to build L-tree trees, using connected nodeboxes.

Using a pencil and paper, one creates blueprints, which are then arranged in the craft grid to build
various shape_nodes.  These shape_nodes can be placed in world, but are otherwise useless, unless used in the craft grid.

In the craft grid, placing a shape_node, (in the center), and any stone, wood, tree, or glass node, (bottom center, directly below shape_node), from a supported mod gives the user a node of that type, shaped like the shape_node.

Only the various shape_nodes appear in inventory, while the actual shaped nodes do not.  This prevents adding numerous
unnecessary pages to a players inventory, while still granting additional gameplay value.

My personal hope is that is used by players to grant them more artistic freedom, and thus more elegance in Minetest architecture.
