obj/item/weapon
	//var/damtype
	var/bleed_def //default size of bleed_size for each hitting
	var/dam_modifer = 1
	var/stamina_dam_modifer = 1
	var/overpic_l
	var/overpic_r
	var/cooldown = 0
	var/damtype //slash, stab, bash
	Click(var/mob/M)
		usr.Get(src)
		spawn(5) usr.draw_mob()
	dagger
		dam_modifer = 1.25
		bleed_def = 1
		cooldown = 1
		damtype = "stab"
		icon = 'meele_weapons.dmi'
		icon_state = "dagger"
	sword
		dam_modifer = 2
		bleed_def = 2
		cooldown = 2
		damtype = "slash"
		icon = 'meele_weapons.dmi'
		icon_state = "sword"
	axe
		dam_modifer = 2.5
		bleed_def = 1.5
		cooldown = 3
		damtype = "slash"
		icon = 'meele_weapons.dmi'
		icon_state = "axe"
	spear
		dam_modifer = 2
		bleed_def = 0.3
		cooldown = 3
		damtype = "stab"
		icon = 'meele_weapons.dmi'
		icon_state = "spear"
	hammer
		dam_modifer = 3
		bleed_def = 0
		cooldown = 5
		damtype = "bash"
		icon = 'meele_weapons.dmi'
		icon_state = "masonhammer"
	club
		dam_modifer = 3
		bleed_def = 0
		cooldown = 5
		damtype = "bash"
		icon = 'meele_weapons.dmi'
		icon_state = "sclub"

mob/var/Overlay/o_left
mob/var/Overlay/o_right


