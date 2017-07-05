obj/workshop
	icon = 'craft.dmi'
	Click()
		craft()
obj/workshop/forge
	icon_state = "forge"
obj/workshop/smelter
	icon_state = "smelter"

mob/verb/craft()

obj/workshop/proc/craft()
	if(istype(src,/obj/workshop/smelter))
		world<< "Smelting"
	if(istype(src,/obj/workshop/forge))
		world<< "Forging"