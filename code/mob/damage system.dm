mob/var/list/bodyparts = list()
obj/bodypart
	icon = 'mob.dmi'
	var/hp = 10
	var/slash_hp = 10
	var/artery = 0
	var/fracture = 0
obj/bodypart/human/head
obj/bodypart/human/right_arm
obj/bodypart/human/left_arm
obj/bodypart/human/right_leg
obj/bodypart/human/left_leg

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

obj/vomit
	icon = 'mob.dmi'
	New()
		..()
		icon_state = pick("vomit_1","vomit_2","vomit_3","vomit_4")

mob/verb/CHOKE()
	for(var/mob/M in world)
		M.damage_random_organ()

mob/verb/damage_random_organ()
	var/obj/organ/o = pick(organs)
	if(o.damaged == 1) return
	if(istype(o,/obj/organ/heart))
		usr<< "�-�-� �� ��������!"
	if(istype(o,/obj/organ/lungs))
		usr<< "�-�-� ��� ������!"
	if(istype(o,/obj/organ/liver))
		usr<< "�-�-� ��&#255; ���������!"
		var/obj/vomit/v = new
		v.loc = src.loc
		var/sound/S = sound('sounds/vomit.ogg')
		usr.play_sound(S)
	if(istype(o,/obj/organ/left_kidney))
		usr<< "�-�-� ��&#255; ����&#255; �������!"
	if(istype(o,/obj/organ/right_kidney))
		usr<< "�-�-� ��&#255; �����&#255; �������!"
	if(istype(o,/obj/organ/guts))
		usr<< "�-�-� ��� �������!"
		var/obj/vomit/v = new
		v.loc = src.loc
		var/sound/S = sound('sounds/vomit.ogg')
		usr.play_sound(S)
	if(istype(o,/obj/organ/stomath))
		usr<< "�-�-� ��� �������!"
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
	var/obj/organ/heart/he = new; organs += he
	var/obj/organ/liver/l = new; organs += l
	var/obj/organ/left_kidney/lk = new; organs += lk
	var/obj/organ/right_kidney/rk = new; organs += rk
	var/obj/organ/guts/g = new; organs += g
	var/obj/organ/stomath/s = new; organs += s
	var/obj/organ/lungs/lu = new; organs += lu
	draw_mob()