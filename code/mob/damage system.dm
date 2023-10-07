mob/var/list/bodyparts = list()
obj/bodypart
	icon = 'img/mob.dmi'
	var/hp = 10
	var/hp_max = 10
	var/artery = 0
	var/fracture = 0
obj/bodypart/human/torso
obj/bodypart/human/head
obj/bodypart/human/right_arm
obj/bodypart/human/left_arm
obj/bodypart/human/right_leg
obj/bodypart/human/left_leg

mob
	var/head_artery = 0
	var/right_arm_artery = 0
	var/left_arm_artery = 0
	var/right_leg_artery = 0
	var/left_leg_artery = 0
	var/AC = 10
	var/default_AC = 10

mob/var/ribs = 0

mob/var/list/organs = list()
obj/organ/var/damaged = 0
obj/organ/var/effect_showed = 0
//obj/organ/brain
obj/organ/heart
obj/organ/liver
obj/organ/left_kidney
obj/organ/right_kidney
obj/organ/guts
obj/organ/stomath
obj/organ/lungs

mob/var/Overlay/o_head
mob/var/Overlay/o_right_arm
mob/var/Overlay/o_left_arm
mob/var/Overlay/o_right_leg
mob/var/Overlay/o_left_leg
mob/var/Overlay/artery_head
mob/var/Overlay/artery_right_arm
mob/var/Overlay/artery_left_arm
mob/var/Overlay/artery_right_leg
mob/var/Overlay/artery_left_leg
mob/var/Overlay/head_wound
mob/var/Overlay/chest_wound
mob/var/Overlay/right_arm_wound
mob/var/Overlay/left_arm_wound
mob/var/Overlay/right_leg_wound
mob/var/Overlay/left_leg_wound
mob/var/Overlay/o_stucked_weapon

mob/var/list/stucked_weapon = list()

obj/vomit
	icon = 'img/mob.dmi'
	New()
		..()
		icon_state = pick("vomit_1","vomit_2","vomit_3","vomit_4")

mob/proc/damage_random_organ()
	var/obj/organ/o = pick(organs)
	if(o.damaged == 1) return
	if(istype(o,/obj/organ/heart))
		usr<< "О-о-о моё сердечко!"
	if(istype(o,/obj/organ/lungs))
		usr<< "О-о-о мои легкие!"
	if(istype(o,/obj/organ/liver))
		usr<< "О-о-о моя печеночка!"
		var/obj/vomit/v = new
		v.loc = src.loc
		var/sound/S = sound('sounds/vomit.ogg')
		usr.play_sound(S)
	if(istype(o,/obj/organ/left_kidney))
		usr<< "О-о-о моя левая почечка!"
	if(istype(o,/obj/organ/right_kidney))
		usr<< "О-о-о моя правая почечка!"
	if(istype(o,/obj/organ/guts))
		usr<< "О-о-о мои кишочки!"
		var/obj/vomit/v = new
		v.loc = src.loc
		var/sound/S = sound('sounds/vomit.ogg')
		usr.play_sound(S)
	if(istype(o,/obj/organ/stomath))
		usr<< "О-о-о мой животик!"
		var/obj/vomit/v = new
		v.loc = src.loc
		var/sound/S = sound('sounds/vomit.ogg')
		usr.play_sound(S)
	o.damaged = 1

//mob/proc/organs_effects()
//

mob/verb/draw_bodyparts()
	del o_head
	del o_right_arm
	del o_left_arm
	del o_right_leg
	del o_left_leg
	del head_wound
	del chest_wound
	del right_arm_wound
	del left_arm_wound
	del right_leg_wound
	del left_leg_wound
	world<< "test bodyparts: [bodyparts]"
	for(var/obj/bodypart/human/head/h in bodyparts)
		o_head = overlay('img/mob.dmi', "head")
	for(var/obj/bodypart/human/right_arm/h in bodyparts)
		o_right_arm = overlay('img/mob.dmi', "right_arm")
	for(var/obj/bodypart/human/left_arm/h in bodyparts)
		o_left_arm = overlay('img/mob.dmi', "left_arm")
	for(var/obj/bodypart/human/right_leg/h in bodyparts)
		o_right_leg = overlay('img/mob.dmi', "right_leg")
	for(var/obj/bodypart/human/left_leg/h in bodyparts)
		o_left_leg = overlay('img/mob.dmi', "left_leg")
	/////////////////тут и далее рисовать раны
	for(var/obj/bodypart/human/torso/h in bodyparts)
		if((h.hp< h.hp_max && h.hp > 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > 2*h.hp_max/3))
			head_wound = overlay('img/mob.dmi', "chest_10")
		if((h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3))
			head_wound = overlay('img/mob.dmi', "chest_20")
		if((h.hp< h.hp_max && h.hp < h.hp_max/3) || (h.hp< h.hp_max && h.hp < h.hp_max/3))
			head_wound = overlay('img/mob.dmi', "chest_30")
	for(var/obj/bodypart/human/head/h in bodyparts)
		if((h.hp< h.hp_max && h.hp > 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > 2*h.hp_max/3))
			head_wound = overlay('img/mob.dmi', "head_10")
		if((h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3))
			head_wound = overlay('img/mob.dmi', "head_20")
		if((h.hp< h.hp_max && h.hp < h.hp_max/3) || (h.hp< h.hp_max && h.hp < h.hp_max/3))
			head_wound = overlay('img/mob.dmi', "head_30")
	for(var/obj/bodypart/human/right_arm/h in bodyparts)
		if((h.hp< h.hp_max && h.hp > 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > 2*h.hp_max/3))
			right_arm_wound = overlay('img/mob.dmi', "r_arm_10")
		if((h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3))
			right_arm_wound = overlay('img/mob.dmi', "r_arm_20")
		if((h.hp< h.hp_max && h.hp < h.hp_max/3) || (h.hp< h.hp_max && h.hp < h.hp_max/3))
			right_arm_wound = overlay('img/mob.dmi', "r_arm_30")
	for(var/obj/bodypart/human/left_arm/h in bodyparts)
		if((h.hp< h.hp_max && h.hp > 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > 2*h.hp_max/3))
			left_arm_wound = overlay('img/mob.dmi', "l_arm_10")
		if((h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3))
			left_arm_wound = overlay('img/mob.dmi', "l_arm_20")
		if((h.hp< h.hp_max && h.hp < h.hp_max/3) || (h.hp< h.hp_max && h.hp < h.hp_max/3))
			left_arm_wound = overlay('img/mob.dmi', "l_arm_30")
	for(var/obj/bodypart/human/right_leg/h in bodyparts)
		if((h.hp< h.hp_max && h.hp > 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > 2*h.hp_max/3))
			right_leg_wound = overlay('img/mob.dmi', "r_leg_10")
		if((h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3))
			right_leg_wound = overlay('img/mob.dmi', "r_leg_20")
		if((h.hp< h.hp_max && h.hp < h.hp_max/3) || (h.hp< h.hp_max && h.hp < h.hp_max/3))
			right_leg_wound = overlay('img/mob.dmi', "r_leg_30")
	for(var/obj/bodypart/human/left_leg/h in bodyparts)
		if((h.hp< h.hp_max && h.hp > 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > 2*h.hp_max/3))
			left_leg_wound = overlay('img/mob.dmi', "l_leg_10")
		if((h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3) || (h.hp< h.hp_max && h.hp > h.hp_max/3 && h.hp < 2*h.hp_max/3))
			left_leg_wound = overlay('img/mob.dmi', "l_leg_20")
		if((h.hp< h.hp_max && h.hp < h.hp_max/3) || (h.hp< h.hp_max && h.hp < h.hp_max/3))
			left_leg_wound = overlay('img/mob.dmi', "l_leg_30")

mob/verb/loose_random_bodypart()
	var/obj/o = pick(bodyparts)
	bodyparts -= o
	//if(var/obj/bodypart/human/right_arm/h in bodyparts)
	draw_mob()

mob/New()
	..()
	var/obj/bodypart/human/head/head = new; bodyparts += head
	var/obj/bodypart/human/torso/torso = new; bodyparts += torso
	var/obj/bodypart/human/right_arm/right_arm = new; bodyparts += right_arm
	var/obj/bodypart/human/left_arm/left_arm = new; bodyparts += left_arm
	var/obj/bodypart/human/right_leg/right_leg = new; bodyparts += right_leg
	var/obj/bodypart/human/left_leg/left_leg = new; bodyparts += left_leg
	for(var/obj/bodypart/human/b in bodyparts)
		b.hp = hp_max; b.hp_max = hp_max;
	var/obj/organ/heart/he = new; organs += he
	var/obj/organ/liver/l = new; organs += l
	var/obj/organ/left_kidney/lk = new; organs += lk
	var/obj/organ/right_kidney/rk = new; organs += rk
	var/obj/organ/guts/g = new; organs += g
	var/obj/organ/stomath/s = new; organs += s
	var/obj/organ/lungs/lu = new; organs += lu
	draw_mob()

mob/var/blood = 500
mob/var/bleed_size = 0

obj/blood_drip
	icon = 'test.dmi'
	icon_state = "blood_drips"

obj/blood_pool
	icon = 'img/mob.dmi'
	icon_state = "pool5"
	var/pool_size

mob/proc/bleed(var/btype)
	if(btype == 1)
		blood -= bleed_size
		//for(var/obj/blood_drip/b in range(0,src))
		//new/obj/blood_drip(src.loc)
	if(btype == 2)
		blood -= 10
	if(btype == 3)
		blood -= 30
		//new/obj/blood_pool(src.loc)