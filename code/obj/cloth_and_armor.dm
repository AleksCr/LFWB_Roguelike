obj/item/armor/var/const
	LIGHT = "LIGHT"
	MEDIUM = "MEDIUM"
	HEAVY = "HEAVY"


obj/item/var/value = 20
obj/item/armor
	var
		class = LIGHT
		AC_bonus = 1
		stand_state
		overpic
	icon = 'img/clothes.dmi'
	Click()
		..()
		if(src.loc == usr) usr.unequip(src)
		usr.Get(src)

obj/item/armor/cloth
	icon_state = "cloth1"
	layer = MOB_LAYER
	New()
		..()
		icon_state = pick("cloth1","cloth2")


obj/item/armor/boots
	icon_state = "iron_boots"
	overpic = "o_legs"

	copper
		name = "copper boots"
		icon_state = "copper_boots"

	iron
		name = "iron boots"
		icon_state = "iron_boots"

	steel
		name = "steel boots"
		icon_state = "steel_boots"


obj/item/armor/hands
	icon_state = "iron"
	overpic = "o_hands"

	copper
		name = "copper gloves"
		icon_state = "copper_gloves"
		overpic = "copper_hands"

	iron
		name = "iron gloves"
		icon_state = "iron_gloves"
		overpic = "iron_hands"

	steel
		name = "steel gloves"
		icon_state = "steel_gloves"
		overpic = "steel_hands"

obj/item/armor/helmet
	icon_state = "castellan"

	open_copper
		name = "copper open helm"
		icon_state = "copper_open_helm"
	open_iron
		name = "iron open helm"
		icon_state = "iron_open_helm"
	open_steel
		name = "steel open helm"
		icon_state = "steel_open_helm"

	closed_copper
		name = "copper close helmet"
		icon_state = "copper_close_helmet"
	closed_iron
		name = "iron close helmet"
		icon_state = "iron_close_helmet"
	closed_steel
		name = "steel close helmet"
		icon_state = "steel_close_helmet"

obj/item/holders
	Click()
		..()
		if(src.loc == usr) usr.unequip(src)
		usr.Get(src)

obj/item/holders/belt
	icon = 'img/clothes.dmi'
	icon_state = "belt"
obj/item/armor/breastplate
	icon = 'img/clothes.dmi'
	icon_state = "armor"
	layer = MOB_LAYER + 1

	fur_vest
		name = "fur vest"
		icon_state = "fur_vest"
	scale_vest
		name = "scale vest"
		icon_state = "scale_vest"
	chain_vest
		name = "chain vest"
		icon_state = "chain_vest"
	copper_cuirass
		name = "copper cuirass"
		icon_state = "copper_cuirass"
	iron_cuirass
		name = "iron cuirass"
		icon_state = "iron_cuirass"
	steel_cuirass
		name = "steel cuirass"
		icon_state = "steel_cuirass"

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
	if(artery_head) del artery_head
	if(artery_right_arm) del artery_right_arm
	if(artery_left_arm) del artery_left_arm
	if(artery_right_leg) del artery_right_leg
	if(artery_left_leg) del artery_left_leg
	if(o_stucked_weapon) del o_stucked_weapon
	draw_bodyparts()
	for(var/obj/item/armor/i in src.clothes)
		o_cloth = overlay('img/clothes.dmi', i.icon_state)
	for(var/obj/item/armor/i in src.armor)
		o_armor = overlay('img/clothes.dmi', i.icon_state)
	for(var/obj/item/armor/i in src.helmet)
		o_helmet = overlay('img/clothes.dmi', i.icon_state)
	for(var/obj/item/armor/i in src.legs)
		o_boots = overlay('img/clothes.dmi', i.overpic)
	for(var/obj/item/armor/i in src.hands)
		o_hands = overlay('img/clothes.dmi', i.overpic)
	for(var/obj/item/i in src.right_hand)
		if(istype(i,/obj/item/weapon/dagger))
			o_right = overlay('img/meele_weapons.dmi', "knife_r")
		if(istype(i,/obj/item/weapon/sword))
			o_right = overlay('img/meele_weapons.dmi', "claymore_r")
		if(istype(i,/obj/item/weapon/axe))
			o_right = overlay('img/meele_weapons.dmi', "axe_r")
		if(istype(i,/obj/item/weapon/spear))
			o_right = overlay('img/meele_weapons.dmi', "spear_r")
		if(istype(i,/obj/item/weapon/hammer))
			o_right = overlay('img/meele_weapons.dmi', "hammer_r")
		if(istype(i,/obj/item/weapon/club))
			o_right = overlay('img/meele_weapons.dmi', "club_r")
	for(var/obj/item/i in src.left_hand)
		if(istype(i,/obj/item/weapon/dagger))
			o_left = overlay('img/meele_weapons.dmi', "knife_l")
		if(istype(i,/obj/item/weapon/sword))
			o_left = overlay('img/meele_weapons.dmi', "claymore_l")
		if(istype(i,/obj/item/weapon/axe))
			o_left = overlay('img/meele_weapons.dmi', "axe_l")
		if(istype(i,/obj/item/weapon/spear))
			o_left = overlay('img/meele_weapons.dmi', "spear_l")
		if(istype(i,/obj/item/weapon/hammer))
			o_left = overlay('img/meele_weapons.dmi', "hammer_l")
		if(istype(i,/obj/item/weapon/club))
			o_left = overlay('img/meele_weapons.dmi', "club_l")
	/////////////////��� �������� �������
	for(var/obj/bodypart/human/head/h in bodyparts)
		if(h.artery) artery_head = overlay('img/mob.dmi', "head_s1")
	for(var/obj/bodypart/human/right_arm/h in bodyparts)
		if(h.artery) artery_right_arm = overlay('img/mob.dmi', "r_arm_s1")
	for(var/obj/bodypart/human/left_arm/h in bodyparts)
		if(h.artery) artery_left_arm = overlay('img/mob.dmi', "l_arm_s1")
	for(var/obj/bodypart/human/right_leg/h in bodyparts)
		if(h.artery) artery_right_leg = overlay('img/mob.dmi', "r_leg_s1")
	for(var/obj/bodypart/human/left_leg/h in bodyparts)
		if(h.artery) artery_left_leg = overlay('img/mob.dmi', "l_leg_s1")
	if(head_artery) artery_head = overlay('img/mob.dmi', "head_s1")
	if(right_arm_artery) artery_right_arm = overlay('img/mob.dmi', "r_arm_s1")
	if(left_arm_artery) artery_left_arm = overlay('img/mob.dmi', "l_arm_s1")
	if(right_leg_artery) artery_right_leg = overlay('img/mob.dmi', "r_leg_s1")
	if(left_leg_artery) artery_left_leg = overlay('img/mob.dmi', "l_leg_s1")
	for(var/obj/item/weapon/wep in stucked_weapon)
		if(istype(wep,/obj/item/weapon/dagger)) o_stucked_weapon = overlay('img/mob.dmi', "edged")
		if(istype(wep,/obj/item/weapon/spear)) o_stucked_weapon = overlay('img/mob.dmi', "spear")
		if(istype(wep,/obj/item/weapon/axe)) o_stucked_weapon = overlay('img/mob.dmi', "axe")



mob/var/Overlay/o_armor
mob/var/Overlay/o_helmet
mob/var/Overlay/o_boots
mob/var/Overlay/o_hands
mob/var/Overlay/o_cloth

