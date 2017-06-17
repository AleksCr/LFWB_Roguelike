obj/item/armor
	var
		coverage = 0
		min_damage = 0
		stand_state
		overpic
	icon = 'clothes.dmi'
	Click()
		..()
		if(src.loc == usr) usr.client.UNEQUIP(src)
		usr.Get(src)

obj/item/armor/cloth
	icon_state = "meister_s"
	layer = MOB_LAYER
obj/item/armor/boots
	icon_state = "ironboots"
	min_damage = 2
	coverage = 90
	overpic = "o_legs"
obj/item/armor/hands
	icon_state = "iron"
	min_damage = 2
	coverage = 100
	overpic = "o_hands"
obj/item/armor/helmet
	icon_state = "castellan"
	min_damage = 2
	coverage = 70
obj/item/holders
	Click()
		..()
		if(src.loc == usr) usr.client.UNEQUIP(src)
		usr.Get(src)

obj/item/holders/belt
	icon = 'clothes.dmi'
	icon_state = "belt"
obj/item/armor/breastplate
	icon = 'clothes.dmi'
	min_damage = 3
	coverage = 70
	icon_state = "armor"
	layer = MOB_LAYER + 1

var/const
	ARMOR_LAYER = FLOAT_LAYER-1
	CLOTHES_LAYER = FLOAT_LAYER-2

obj/overlay/cloth/var
	s_state
	l_state



mob/proc/draw_mob()
	del o_right
	del o_left
	del o_armor
	del o_helmet
	del o_boots
	del o_hands
	del o_cloth
	draw_bodyparts()
	for(var/obj/item/armor/i in src.clothes)
		o_cloth = overlay('clothes.dmi', i.icon_state)
	for(var/obj/item/armor/i in src.armor)
		o_armor = overlay('clothes.dmi', i.icon_state)
	for(var/obj/item/armor/i in src.helmet)
		o_helmet = overlay('clothes.dmi', i.icon_state)
	for(var/obj/item/armor/i in src.legs)
		o_boots = overlay('clothes.dmi', i.overpic)
	for(var/obj/item/armor/i in src.hands)
		o_hands = overlay('clothes.dmi', i.overpic)
	for(var/obj/item/i in src.right_hand)
		if(istype(i,/obj/item/weapon/dagger))
			o_right = overlay('meele_weapons.dmi', "knife_r")
		if(istype(i,/obj/item/weapon/sword))
			o_right = overlay('meele_weapons.dmi', "claymore_r")
		if(istype(i,/obj/item/weapon/axe))
			o_right = overlay('meele_weapons.dmi', "axe_r")
		if(istype(i,/obj/item/weapon/spear))
			o_right = overlay('meele_weapons.dmi', "spear_r")
		if(istype(i,/obj/item/weapon/hammer))
			o_right = overlay('meele_weapons.dmi', "hammer_r")
		if(istype(i,/obj/item/weapon/club))
			o_right = overlay('meele_weapons.dmi', "club_r")
	for(var/obj/item/i in src.left_hand)
		if(istype(i,/obj/item/weapon/dagger))
			o_left = overlay('meele_weapons.dmi', "knife_l")
		if(istype(i,/obj/item/weapon/sword))
			o_left = overlay('meele_weapons.dmi', "claymore_l")
		if(istype(i,/obj/item/weapon/axe))
			o_left = overlay('meele_weapons.dmi', "axe_l")
		if(istype(i,/obj/item/weapon/spear))
			o_left = overlay('meele_weapons.dmi', "spear_l")
		if(istype(i,/obj/item/weapon/hammer))
			o_left = overlay('meele_weapons.dmi', "hammer_l")
		if(istype(i,/obj/item/weapon/club))
			o_left = overlay('meele_weapons.dmi', "club_l")



mob/var/Overlay/o_armor
mob/var/Overlay/o_helmet
mob/var/Overlay/o_boots
mob/var/Overlay/o_hands
mob/var/Overlay/o_cloth

