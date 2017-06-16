
display_hud

	var

		// Starting screen_loc is the top left corner where objects begin accumulating.
		// If start_x is 5 and start_y is 8, the starting screen_loc will be "5,8"
		start_x = 0
		start_y = 0

		// Ending screen_loc is the bottom right corner where the display list ends.
		// If end_x is 5 and end_y is 8, the final screen_loc will be "5,8"
		end_x = 0
		end_y = 0

		// If these values are used, pixel offsets for x and y values will be appended
		// to each of the screen_locs used by the hud.
		pixel_offset_x = 0
		pixel_offset_y = 0

		// If this is true, objects will be added by column first instead of by rows.
		vertical = 0




	// This function calculates how many display slots there are in a given list
	// by calculating the contents of the square measured out by the start/end vars.
	// If you try to add more objects to a list than there are slots, the new objects
	// will not be allowed into the list.
	proc/Slots()

		// Calculate the number of rows and columns.
		var
			rows = abs(src.end_y - src.start_y) + 1
			columns = abs(src.end_x - src.start_x) + 1

		// If there are no rows or columns, there are no display slots.
		if(rows <= 0 || columns <= 0)
			return 0

		// Multiply the rows by the columns to find out how many slots there are.
		return rows * columns




	// Returns the screenloc value that an object will be assigned based on its
	// position and on any pixel offset modifiers.
	proc/SetLoc(x=0, y=0)
		return "[x]:[pixel_offset_x],[y]:[pixel_offset_y]"




	// Add an objec to a list using this display hud.
	// C = The client (or mob) with the HUD that the object will be displayed on.
	// A = The atom/movable being added.
	// L = The list that the object is being added to, such as display.
	proc/Add(client/C, atom/movable/A, list/L)

		// If no client or mob is specified, then don't do anything.
		if(!C)
			return

		// If the "client" specified is a mob, then change it to the mob's client.
		if(!istype(C, /client) && ismob(C))
			var/mob/M = C

			// If the mob doesn't have a client, don't do anything.
			//if(!M.client)
			//	return

			C = M.client

		// If the object is already on the list, don't add it again.
		if(A in L)
			return

		// Check to see if there is room in this list before adding another object.
		if(L.len >= src.Slots())
			return // no room!

		// For each possible slot, loop through each item in the list to check and see
		// if the desired slot is taken or not. If the vertical toggle is true, then
		// slot searches will progress vertically instead of horizontally.
		if(src.vertical)
			var/step_x = end_x > start_x ? 1 : -1
			for(var/x in start_x to end_x step step_x)

				var/step_y = end_y > start_y ? 1 : -1
				for(var/y in start_y to end_y step step_y)

					// Find out if each item slot is open.
					if(src.OccupySlot(C, A, L, x, y))
						return 1
					else
						continue

		else
			var/step_y = end_y > start_y ? 1 : -1
			for(var/y in start_y to end_y step step_y)

				var/step_x = end_x > start_x ? 1 : -1
				for(var/x in start_x to end_x step step_x)

					// Find out if each item slot is open.
					if(src.OccupySlot(C, A, L, x, y))
						return 1
					else
						continue

		// For some reason the object could not be added!
		return 0




	// Thus function checks an item's position in the list to see if the desired slot
	// is occupied by that item. If the slot is taken, it returns false. If the slot
	// is open, it returns true.
	proc/OccupySlot(client/C, atom/movable/A, list/L, x, y)

		// This becomes true if an object is already occupying the slot.
		var/occupied = FALSE

		for(var/atom/movable/a in L)
			if(a.screen_loc == src.SetLoc(x, y))
				occupied = TRUE
				break

		if(occupied)
			return 0


		// This slot was not found to be occupied, so its safe to give the object
		// this screen_loc value and add it to the client's screen.
		world<< "[usr.name] ai = [usr.ai]"
		if(C != null)
			A.screen_loc = src.SetLoc(x, y)
			C.screen += A
		L += A
		return 1




	// Remove an object from the list - Mostly here for completeness.
	// C = The client (or mob) with the HUD that the object will be removed from.
	// A = The atom/movable being removed.
	// L = The list that the object is being removed from, such as display.
	proc/Remove(client/C, atom/movable/A, list/L)

		// If no client or mob is specified, then don't do anything.
		//if(!C)
		//	return

		// If the "client" specified is a mob, then change it to the mob's client.
		if(!istype(C, /client) && ismob(C))
			var/mob/M = C

			// If the mob doesn't have a client, don't do anything.
			//if(!M.client)
			//	return

			C = M.client

		// If the object is already on the list, don't add it again.
		if(!(A in L))
			return

		A.screen_loc = null
		if(C != null)
			C.screen -= A
		L -= A

		// In case removal fails for some reason...
		//if(A in C.screen || A in L)
		//	return 0

		// Successfully removed the object from the list and the HUD.
		return 1