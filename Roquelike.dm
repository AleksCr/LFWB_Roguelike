/*
	These are simple defaults for your project.
 */


#define DEBUG


world
	fps = 60		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 7		// show up to 6 tiles outward from center (13x13 view)
	New()
		master_controller()

client/show_popup_menus = 0
// Make objects move 8 pixels per tick when walking

mob
	step_size = 32
	icon = 'mob.dmi'
	icon_state = "torso"

obj
	step_size = 32

var/mapx = 14; var/mapy = 14
