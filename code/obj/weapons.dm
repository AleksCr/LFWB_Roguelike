obj/item/var/mass
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
	proc/ret_type()
		var/txt
		if(istype(src,/obj/item/weapon/dagger)) txt = "dagger"
		if(istype(src,/obj/item/weapon/sword)) txt = "sword"
		if(istype(src,/obj/item/weapon/axe)) txt = "axe"
		if(istype(src,/obj/item/weapon/spear)) txt = "spear"
		if(istype(src,/obj/item/weapon/hammer)) txt = "club"
		if(istype(src,/obj/item/weapon/club)) txt = "club"
		return txt
	dagger
		dam_modifer = 1.25
		bleed_def = 1
		cooldown = 1
		mass = 0.5
		damtype = "stab"
		icon = 'meele_weapons.dmi'
		icon_state = "dagger"
	sword
		dam_modifer = 2
		bleed_def = 2
		cooldown = 2
		mass = 1
		damtype = "slash"
		icon = 'meele_weapons.dmi'
		icon_state = "sword"
	axe
		dam_modifer = 2.5
		bleed_def = 1.5
		cooldown = 4
		mass = 2
		damtype = "slash"
		icon = 'meele_weapons.dmi'
		icon_state = "axe"
	spear
		dam_modifer = 2
		bleed_def = 0.3
		cooldown = 3
		mass = 2
		damtype = "stab"
		icon = 'meele_weapons.dmi'
		icon_state = "spear"
	hammer
		dam_modifer = 3
		bleed_def = 0
		cooldown = 5
		mass = 5
		damtype = "bash"
		icon = 'meele_weapons.dmi'
		icon_state = "masonhammer"
	club
		dam_modifer = 3
		bleed_def = 0
		cooldown = 10
		mass = 10
		damtype = "bash"
		icon = 'meele_weapons.dmi'
		icon_state = "sclub"

mob/var/Overlay/o_left
mob/var/Overlay/o_right


