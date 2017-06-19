mob/var/list/bodyparts = list()
obj/bodypart
	icon = 'mob.dmi'
	var/hp = 10
	var/slash_hp = 10
obj/bodypart/human/head
obj/bodypart/human/right_arm
obj/bodypart/human/left_arm
obj/bodypart/human/right_leg
obj/bodypart/human/left_leg

mob/var/list/organs = list()
obj/organ/brain
obj/organ/heart
obj/organ/liver
obj/organ/left_kidney
obj/organ/right_kidney
obj/organ/guts
obj/organ/stomath

mob/var/Overlay/o_head
mob/var/Overlay/o_right_arm
mob/var/Overlay/o_left_arm
mob/var/Overlay/o_right_leg
mob/var/Overlay/o_left_leg

mob/verb/draw_bodyparts()
	del o_head
	del o_right_arm
	del o_left_arm
	del o_right_leg
	del o_left_leg
	for(var/obj/bodypart/human/head/h in bodyparts)
		o_head = overlay('mob.dmi', "head")
	for(var/obj/bodypart/human/right_arm/h in bodyparts)
		o_right_arm = overlay('mob.dmi', "right_arm")
	for(var/obj/bodypart/human/left_arm/h in bodyparts)
		o_left_arm = overlay('mob.dmi', "left_arm")
	for(var/obj/bodypart/human/right_leg/h in bodyparts)
		o_right_leg = overlay('mob.dmi', "right_leg")
	for(var/obj/bodypart/human/left_leg/h in bodyparts)
		o_left_leg = overlay('mob.dmi', "left_leg")

mob/verb/loose_random_bodypart()
	var/obj/o = pick(bodyparts)
	bodyparts -= o
	//if(var/obj/bodypart/human/right_arm/h in bodyparts)
	draw_mob()

mob/New()
	..()
	var/obj/bodypart/human/head/h = new; bodyparts += h
	var/obj/bodypart/human/right_arm/ra = new; bodyparts += ra
	var/obj/bodypart/human/left_arm/la = new; bodyparts += la
	var/obj/bodypart/human/right_leg/rl = new; bodyparts += rl
	var/obj/bodypart/human/left_leg/ll = new; bodyparts += ll
	for(var/obj/bodypart/human/b in bodyparts)
		b.hp = hp_max; b.slash_hp = hp_max/3;
	draw_mob()