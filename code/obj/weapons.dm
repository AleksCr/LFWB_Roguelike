obj/item/weapon
	//var/damtype
	var/bleed_def //default size of bleed_size for each hitting
	var/dam_modifer = 1
	var/stamina_dam_modifer = 1
	dagger
		dam_modifer = 1.25
		bleed_def = 1
		icon = 'test.dmi'
		icon_state = "dagger"
		Click(var/mob/M)
			usr.Get(src)

mob/verb/draw_weapon()
	overlays += /obj/armed/armed_knife_r


obj/armed/armed_knife_r
	icon = 'test.dmi'
	icon_state = "armed_knife_r"
	layer = MOB_LAYER + 1