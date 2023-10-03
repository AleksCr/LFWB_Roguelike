client
	view = "13x13"

	var
		// Create new instances of backgrounds and display HUDs
		// whenever a new client is created.
		obj/hud_left_hand/left_hand = new()
		obj/hud_right_hand/right_hand = new()
		obj/hud/cloth/cloth = new()
		obj/hud/armor/armor = new()
		obj/hud/helmet/helmet = new()
		obj/hud/legs/legs = new()
		obj/hud/pocket/pocket = new()
		obj/hud/another_pocket/another_pocket = new()
		obj/hud/hands/hands = new()
		obj/hud/belt/belt = new()
		obj/hud_drop/hud_drop = new()

		display_hud/left_hand/left_hand_h = new()
		display_hud/right_hand/right_hand_h = new()
		display_hud/armor/armor_h = new()
		display_hud/helmet/helmet_h = new()
		display_hud/legs/legs_h = new()
		display_hud/hands/hands_h = new()
		display_hud/pocket/pocket_h = new()
		display_hud/another_pocket/another_pocket_h = new()
		display_hud/belt/belt_h = new()
		display_hud/cloth/clothes_h = new()



	New()
		..()

		// Add the backgrounds to the new client's screen.
		src.screen += left_hand
		src.screen += right_hand
		src.screen += cloth
		src.screen += armor
		src.screen += helmet
		src.screen += legs
		src.screen += pocket
		src.screen += another_pocket
		src.screen += hands
		src.screen += belt
		src.screen += hud_drop

mob/var/display_hud/right_hand/right_hand_mob = new()
mob/var/display_hud/left_hand/left_hand_mob = new()
mob/var/display_hud/cloth/clothes_mob = new()
mob/var/display_hud/armor/armor_mob = new()
mob/var/display_hud/helmet/helmet_mob = new()
mob/var/display_hud/legs/legs_mob = new()
mob/var/display_hud/hands/hands_mob = new()
mob/var/display_hud/pocket/pocket_mob = new()
mob/var/display_hud/another_pocket/another_pocket_mob = new()
mob/var/display_hud/belt/belt_h = new()

mob/verb/check_armor()
	for(var/obj/O in src) world<< "[O.name]"

mob/var/hand = "right"
mob/var/hand_alt


mob/var/list
		// Lists for housing clothes and keys HUD lists.
	clothes = list()
	armor = list()
	helmet = list()
	legs = list()
	hands = list()
	pocket = list()
	another_pocket = list()
	belt = list()
	active_hand = list()
	left_hand = list()
	right_hand = list()

obj/hud
	Click()
		..()
		spawn(5) usr.draw_mob()
obj/hud/cloth
	icon = 'test.dmi'
	icon_state = "hud_cloth"
	screen_loc = "3,1"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("cloth")
obj/hud/armor
	icon = 'test.dmi'
	icon_state = "hud_armor"
	screen_loc = "3,2"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("armor")
obj/hud/pocket
	icon = 'test.dmi'
	icon_state = "hud_pocket"
	screen_loc = "5,1"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("pocket")
obj/hud/another_pocket
	icon = 'test.dmi'
	icon_state = "hud_pocket"
	screen_loc = "6,1"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("another_pocket")
obj/hud/belt
	icon = 'test.dmi'
	icon_state = "hud_belt"
	screen_loc = "4,1"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("belt")
obj/hud/helmet
	icon = 'test.dmi'
	icon_state = "hud_helmet"
	screen_loc = "3,3"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("helmet")
obj/hud/legs
	icon = 'test.dmi'
	icon_state = "hud_legs"
	screen_loc = "4,2"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("legs")
obj/hud/hands
	icon = 'test.dmi'
	icon_state = "hud_hands"
	screen_loc = "2,2"
	layer = TURF_LAYER
	Click()
		..()
		usr.equip("hands")
obj/hud_left_hand
	icon = 'test.dmi'
	icon_state = "background2"
	screen_loc = "8,1"
	layer = TURF_LAYER
	Click()
		world<< "Left hand"
		usr.hand = "left"
obj/hud_right_hand
	icon = 'test.dmi'
	icon_state = "background2"
	screen_loc = "9,1"
	layer = TURF_LAYER
	Click()
		world<< "Right hand"
		usr.hand = "right"
obj/hud_drop
	icon = 'test.dmi'
	icon_state = "hud_drop"
	screen_loc = "2,1"
	layer = TURF_LAYER
	//Click()
// Background objects (not important)
obj/hud_background
	icon = 'test.dmi'
	icon_state = "background"
	//screen_loc = "1,5 to 4,8"
	layer = TURF_LAYER
obj/hud_background2
	icon = 'test.dmi'
	icon_state = "background2"
	//screen_loc = "1:16,2:16 to 3:16,3:16"
	layer = TURF_LAYER
obj/hud_background3
	icon = 'test.dmi'
	icon_state = "background3"
	//screen_loc = "1,1 to 4,1"
	layer = TURF_LAYER




// Display HUD Datums

display_hud/left_hand
	start_x = 8
	start_y = 1

	end_x = 8
	end_y = 1

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0

display_hud/right_hand
	start_x = 9
	start_y = 1

	end_x = 9
	end_y = 1

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0

display_hud/armor
	start_x = 3
	start_y = 2

	end_x = 3
	end_y = 2

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0

display_hud/helmet
	start_x = 3
	start_y = 3

	end_x = 3
	end_y = 3

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0

display_hud/cloth
	start_x = 3
	start_y = 1

	end_x = 3
	end_y = 1

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0
display_hud/legs
	start_x = 4
	start_y = 2

	end_x = 4
	end_y = 2

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0
display_hud/hands
	start_x = 2
	start_y = 2

	end_x = 2
	end_y = 2

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0
display_hud/belt
	start_x = 4
	start_y = 1

	end_x = 4
	end_y = 1

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0
display_hud/pocket
	start_x = 5
	start_y = 1

	end_x = 5
	end_y = 1

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0
display_hud/another_pocket
	start_x = 6
	start_y = 1

	end_x = 6
	end_y = 1

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0
/*
display_hud/backpack
	// Starting screen_loc is the top left corner where objects begin accumulating.
	// If start_x is 5 and start_y is 8, the starting screen_loc will be "5,8"
	start_x = 1
	start_y = 8

	// Ending screen_loc is the bottom right corner where the display list ends.
	// If end_x is 5 and end_y is 8, the final screen_loc will be "5,8"
	end_x = 4
	end_y = 5

	// If these values are used, pixel offsets for x and y values will be appended
	// to each of the screen_locs used by the hud.
	pixel_offset_x = 0
	pixel_offset_y = 0

	// If this is true, objects will be added by column first instead of by rows.
	vertical = 0
*/

mob/proc/active_hand_add(var/obj/obj as obj)
	if(usr.hand == "left")
		left_hand_mob.Add(src, obj, src.active_hand)//usr.client.left_hand_h.Add(usr, O, usr.active_hand)
	else
		world<< "test"
		right_hand_mob.Add(src, obj, src.active_hand)//usr.client.right_hand_h.Add(usr, O, usr.active_hand)

mob/proc/active_hand_remove(var/obj/obj as obj)
	if(usr.hand == "left")
		src.left_hand_mob.Remove(src, obj, src.active_hand)//usr.client.left_hand_h.Remove(usr, O, usr.active_hand)
	else
		src.right_hand_mob.Remove(src, obj, src.active_hand)//usr.client.right_hand_h.Remove(usr, O, usr.active_hand)

mob/proc/equip(var/text as text)
	if(src.hand == "left") src.active_hand = src.left_hand
	else src.active_hand = src.right_hand
	var/obj/obj = src.active_hand.len == 1 ? src.active_hand[1] : null
	if(!obj) return
	src.active_hand_remove(obj)
	obj.loc = src
	if(text == "armor" && istype(obj,/obj/item/armor/breastplate))
		src.armor_mob.Add(src, obj, src.armor); return
	if(text == "helmet" && istype(obj,/obj/item/armor/helmet))
		src.helmet_mob.Add(src, obj, src.helmet); return
	if(text == "hands" && istype(obj,/obj/item/armor/hands))
		src.hands_mob.Add(src, obj, src.hands); return
	if(text == "legs" && istype(obj,/obj/item/armor/boots))
		src.legs_mob.Add(src, obj, src.legs); return
	//if(t == "belt" && istype(O,/obj/item/holders))
		//src.belt_mob.Add(src, O, src.belt); return
	if(text == "pocket")
		src.pocket_mob.Add(src, obj, src.pocket); return
	if(text == "another_pocket")
		src.another_pocket_mob.Add(src, obj, src.another_pocket); return
	if(text == "cloth" && istype(obj, /obj/item/armor/cloth))
		src.clothes_mob.Add(src, obj, src.clothes); return
	src.active_hand_add(obj)

client/verb/UNEQUIP(var/obj/O)
	spawn(5) usr.draw_mob()
	if(istype(O,/obj/item/armor/breastplate))
		src.armor_h.Remove(usr, O, usr.armor)
	if(istype(O,/obj/item/armor/cloth))
		src.clothes_h.Remove(usr, O, usr.clothes)
	if(istype(O,/obj/item/armor/boots))
		src.legs_h.Remove(usr, O, usr.legs)
	if(istype(O,/obj/item/armor/hands))
		src.hands_h.Remove(usr, O, usr.hands)
	if(istype(O,/obj/item/armor/helmet))
		src.helmet_h.Remove(usr, O, usr.helmet)
	if(istype(O,/obj/item/holders/belt))
		src.belt_h.Remove(usr, O, usr.belt)

mob/verb/mob_UNEQUIP(var/obj/O)
	spawn(5) src.draw_mob()
	if(istype(O,/obj/item/armor/breastplate))
		src.armor_mob.Remove(src, O, src.armor)
	if(istype(O,/obj/item/armor/cloth))
		src.clothes_mob.Remove(src, O, src.clothes)
	if(istype(O,/obj/item/armor/boots))
		src.legs_mob.Remove(src, O, src.legs)
	if(istype(O,/obj/item/armor/hands))
		src.hands_mob.Remove(src, O, src.hands)
	if(istype(O,/obj/item/armor/helmet))
		src.helmet_mob.Remove(src, O, src.helmet)
	//if(istype(O,/obj/item/holders/belt))
		//src.belt_mob.Remove(usr, O, usr.belt)


mob
	verb/Get(obj/O as obj)
		if(hand == "left")
			for(var/obj/bodypart/human/left_arm/h in bodyparts)
				if(src.left_hand_mob.Add(src, O, src.left_hand) && !h.fracture)
					src << "You acquired [O]!"
					O.loc = src
				else
					src << "You don't have any more room!"
		if(hand == "right")
			for(var/obj/bodypart/human/right_arm/h in bodyparts)
				if(src.right_hand_mob.Add(src, O, src.right_hand) && !h.fracture)
					world << "You acquired [O]!"
					O.loc = src
				else
					world << "You don't have any more room!"
		draw_mob()

mob
	verb/Drop()
		if(hand == "left") active_hand = left_hand
		else active_hand = right_hand
		var/obj/O
		for(var/obj/i as obj in src.active_hand)
			O = i
		if(src.left_hand_mob.Remove(src, O, src.active_hand))
			O.loc = src.loc
			src << "You dropped [O]."
		else
			src << "You can not drop [O]!"
		draw_mob()
		return O



/*// Functions for adding and removing objects from any of the
// display HUD lists.
client/verb/AddItem(listname as text)

	var/obj/O = new()
	O.icon = 'test.dmi'

	var/list/L
	var/display_hud/HUD


	if(HUD.Add(src, O, L))
		world << "Item added!"
	else
		world << "Item was not added."


client/verb/RemoveItem(listname as text)

	var/list/L
	var/display_hud/HUD


	if(!L.len)
		return

	var/atom/movable/A = pick(L)

	if(!A)
		return

	if(HUD.Remove(src, A, L))
		world << "Item removed!"
	else
		world << "Item was not removed."*/


/************************************************************************

Display HUD Library

This is used to create a HUD display which lists objects, such as for an
on-HUD inventory. When you add an new object, it will start in the corner
which you define and every new object you add to the HUD will be added to
that row, either progressively left or right depending on where your
start corner is, until the row is full and then it will either move up
or down a column and fill in another row. When the entire box that you've
defined is full, you will not be able to add more objects to the display.

Instructions:

______
Step 1:

	You need to define a new display_hud, which should look like this:

		display_hud/backpack

			start_x = 1
			start_y = 8

			end_x = 4
			end_y = 5

			pixel_offset_x = 0
			pixel_offset_y = 0

			vertical = 0

	The start_x and start_y values represent the corner where objects will
	start being added first - typically the top-left, but this is up to
	user preference. The end_x and end_y values should be the opposite corner,
	so if your start corner is the top-left, then your ending corner should
	be the bottom-right. Assign the coordinates for where you want the start
	and ending corners to be located.

	If your HUD uses pixel offsets, you can offset the display HUD's objects
	using the pixel_offset_x and pixel_offset_y values.

	If you want items to be added by columns instead of by rows (meaning that
	objects are added first up or down instead of left or right), then set
	the vertical value to 1.

______
Step 2:

	You need to create the display HUD for the client that will be using it.
	If this is something which will be used for all players, then you might
	use something like this:

		client
			var/display_hud/backpack/backpack = new()

	Make sure you have a list to store objects in, since that is not
	included as part of this library.

______
Step 3:

	As an example, if each player has their own backpack display HUD which
	is going to display the player's contents list, then we can add new
	items to the display HUD like this:

		mob
			verb/Get(obj/O as obj in view(src, 1))
				if(src.client.backpack.Add(src, O, src.contents))
					src << "You acquired [O]!"
				else
					src << "You don't have any more room!"

	The display_hud.Add() function will add the object to the contents list,
	but it will NOT call the Move() proc. If you want to use Move() to check
	whether an item can be added to the list, you'll have to do that yourself.

	If you want to remove an item from the list, you can do that like this:

		mob
			verb/Drop(obj/O as obj in src.contents)
				if(src.client.backpack.Remove(src, O, src.contents))
					O.loc = src.loc
					src << "You dropped [O]."
				else
					src << "You can not drop [O]!"


	And that's all there is to it!


************************************************************************/

