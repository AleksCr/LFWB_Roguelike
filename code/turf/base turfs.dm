obj/floor
	icon = 'test.dmi'
	icon_state = "floor"
obj/wall
	icon = 'test.dmi'
	icon_state = "wall"

obj/exit
	icon = 'test.dmi'
	icon_state = "exit"
	Click()
		usr.town()
		usr.z = 3
		for(var/obj/ladder/L in world) del L