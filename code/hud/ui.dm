



client
	view = "4x8"

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
		//display_hud/drop/drop_h = new()





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



mob/var/hand = "right"
mob/var/hand_alt

mob/verb/hand_check()
	if(hand == "left") active_hand = left_hand
	else active_hand = right_hand
	usr<< "active hand: [hand]"
	var/bad_code = 0
	for(var/obj/O in active_hand)
		bad_code++
		usr<< "weapon in hand: [O.name]"
	if(bad_code == 0)
		usr<< "weapon in hand: fists"


mob

	var

		// Lists for housing clothes and keys HUD lists.
		list/clothes = list()
		list/keys = list()
		list/active_hand() = list()
		list/left_hand() = list()
		list/right_hand() = list()

obj/hud/cloth
	icon = 'test.dmi'
	icon_state = "hud_cloth"
	screen_loc = "3,1"
	layer = TURF_LAYER
obj/hud/armor
	icon = 'test.dmi'
	icon_state = "hud_armor"
	screen_loc = "3,2"
	layer = TURF_LAYER
	Click()
		..()

obj/hud/pocket
	icon = 'test.dmi'
	icon_state = "hud_pocket"
	screen_loc = "5,1"
	layer = TURF_LAYER
obj/hud/another_pocket
	icon = 'test.dmi'
	icon_state = "hud_pocket"
	screen_loc = "6,1"
	layer = TURF_LAYER
obj/hud/belt
	icon = 'test.dmi'
	icon_state = "hud_belt"
	screen_loc = "4,1"
	layer = TURF_LAYER
obj/hud/helmet
	icon = 'test.dmi'
	icon_state = "hud_helmet"
	screen_loc = "3,3"
	layer = TURF_LAYER
obj/hud/legs
	icon = 'test.dmi'
	icon_state = "hud_legs"
	screen_loc = "4,2"
	layer = TURF_LAYER
obj/hud/hands
	icon = 'test.dmi'
	icon_state = "hud_hands"
	screen_loc = "2,2"
	layer = TURF_LAYER

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
	start_x = 3
	start_y = 2

	end_x = 3
	end_y = 2

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0

display_hud/armor
	start_x = 8
	start_y = 1

	end_x = 8
	end_y = 1

	pixel_offset_x = 1
	pixel_offset_y = 1

	vertical = 0


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

mob/verb/ARMORADD()
	if(hand == "left") active_hand = left_hand
	else active_hand = right_hand
	var/obj/O
	for(var/obj/i as obj in src.active_hand) O = i
	var/list/L
	var/display_hud/HUD
	HUD.Add(src, O, L)
		//switch(listname)
		//if("backpack")
		//	L = mob.contents
			//HUD = src.backpack
		//	O.icon_state = "item[rand(1,4)]"

mob
	verb/Get(obj/O as obj)
		if(hand == "left")
			if(src.client.left_hand_h.Add(src, O, src.left_hand))
				src << "You acquired [O]!"
				O.loc = src.contents
			else
				src << "You don't have any more room!"
		if(hand == "right")
			if(src.client.right_hand_h.Add(src, O, src.right_hand))
				src << "You acquired [O]!"
				O.loc = src.contents
			else
				src << "You don't have any more room!"

mob
	verb/Drop()
		if(hand == "left") active_hand = left_hand
		else active_hand = right_hand
		var/obj/O
		for(var/obj/i as obj in src.active_hand)
			O = i
		if(src.client.left_hand_h.Remove(src, O, src.active_hand))
			O.loc = src.loc
			src << "You dropped [O]."
		else
			src << "You can not drop [O]!"



// Functions for adding and removing objects from any of the
// display HUD lists.
client/verb/AddItem(listname as text)

	var/obj/O = new()
	O.icon = 'test.dmi'

	var/list/L
	var/display_hud/HUD
	//switch(listname)
		//if("backpack")
		//	L = mob.contents
			//HUD = src.backpack
		//	O.icon_state = "item[rand(1,4)]"
		/*if("clothes")
			L = mob.clothes
			HUD = src.clothes
			O.icon_state = "armor[rand(1,4)]"
		if("keys")
			L = mob.keys
			HUD = src.keys
			O.icon_state = "key[rand(1,4)]"
		if("left_hand")
			L = mob.left_hand
			HUD = src.left_hand
			O.icon_state = "item[rand(1,4)]"*/

	if(HUD.Add(src, O, L))
		world << "Item added!"
	else
		world << "Item was not added."


client/verb/RemoveItem(listname as text)

	var/list/L
	var/display_hud/HUD
	//switch(listname)
		//if("backpack")
		//	L = mob.contents
		//	HUD = src.backpack
		/*if("clothes")
			L = mob.clothes
			HUD = src.clothes
		if("keys")
			L = mob.keys
			HUD = src.keys*/

	if(!L.len)
		return

	var/atom/movable/A = pick(L)

	if(!A)
		return

	if(HUD.Remove(src, A, L))
		world << "Item removed!"
	else
		world << "Item was not removed."


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

