mob/var/alive = 1
mob/var/hp_max = 10
mob/var/hp = 10
mob/var/recreating = 0
var/defend_time = 5

mob/var/attack_style = "normal"
mob/New()
	..()
	attack_style = pick("fast","normal","strong")
mob/verb/choose_combat_style()
	switch(alert("Choose combat style:","Combat style","Fast strikes","Normal","Strong and technical strikes"))
		if("Fast strikes")
			attack_style = "fast"
		if("Normal")
			attack_style = "normal"
		if("Strong and technical strikes")
			attack_style = "strong"

mob/verb/superherostyle()
	set hidden = 1
	attack_style = "superhero"
	delay = base_speed

mob/proc/calculate_strike_time()
	var/strike_time = list("fast" = 3, "normal" = 6, "strong" = 6, "superhero" = 1)
	return strike_time[attack_style]

mob/var/const/str_cant_attack = "You are too tired to attack"
mob/var/attack_num = 1
mob/var/is_attacking = 0
mob/proc/attack(a, b)
	if(alive != 1 || is_attacking)
		return
	//for(var/mob/M in view(3,src)
		//ai_defend_attack()
	var/attack_stamina_cost = list("fast" = 10, "normal" = 5, "strong" = 15)
	is_attacking = 1
	if(stamina <= attack_stamina_cost[attack_style])
		usr<< str_cant_attack
		draw_clear()
		is_attacking = 0
		return
	stamina -= attack_stamina_cost[attack_style]
	if(a == 0 && b == 1)
		draw_attack("n", (calculate_strike_time()*time_scale))
	if(a == 0 && b == -1)
		draw_attack("s", (calculate_strike_time()*time_scale))
	if(a == 1 && b == 0)
		draw_attack("e", (calculate_strike_time()*time_scale))
	if(a == -1 && b == 0)
		draw_attack("w", (calculate_strike_time()*time_scale))
	if(a == -1 && b == 1)
		draw_attack("nw", (calculate_strike_time()*time_scale))
	if(a == 1 && b == 1)
		draw_attack("ne", (calculate_strike_time()*time_scale))
	if(a == -1 && b == -1)
		draw_attack("sw", (calculate_strike_time()*time_scale))
	if(a == 1 && b == -1)
		draw_attack("se", (calculate_strike_time()*time_scale))
	for(var/mob/mob in view(1,src))
		if(mob.x == x+a && mob.y == y+b)
			spawn() mob.process_attack(src)
		else
			var/sound/S = sound('sounds/punchmiss.ogg')
			play_sound(S)
	if(hand == LEFT_HAND) active_hand = left_hand
	else active_hand = right_hand
	var/obj/item/weapon/O
	for(var/obj/item/weapon/i in active_hand)
		O=i
	if(O != null)
		sleep(O.cooldown)
	is_attacking=0


mob/var/def_num = 1
mob/var/defending = 0
mob/var/def_a = 0
mob/var/def_b = 0
mob/proc/defend(a, b)
	if(alive != 1)
		return
	if(defending == 1)
		return
	if(a == 0 && b == 1)
		def_a = 0; def_b = 1
		defending = 1
		draw_defend("n", defend_time*time_scale)
		defending = 0
	if(a == 0 && b == -1)
		def_a = 0; def_b = -1
		defending = 1
		draw_defend("s", defend_time*time_scale)
		defending = 0
	if(a == 1 && b == 0)
		def_a = 1; def_b = 0
		defending = 1
		draw_defend("e", defend_time*time_scale)
		defending = 0
	if(a == -1 && b == 0)
		def_a = -1; def_b = 0
		defending = 1
		draw_defend("w", defend_time*time_scale)
		defending = 0
	if(a == -1 && b == 1)
		def_a = -1; def_b = 1
		defending = 1
		draw_defend("nw", defend_time*time_scale)
		defending = 0
	if(a == 1 && b == 1)
		def_a = 1; def_b = 1
		defending = 1
		draw_defend("ne", defend_time*time_scale)
		defending = 0
	if(a == -1 && b == -1)
		def_a = -1; def_b = -1
		defending = 1
		draw_defend("sw", defend_time*time_scale)
		defending = 0
	if(a == 1 && b == -1)
		def_a = 1; def_b = -1
		defending = 1
		draw_defend("se", defend_time*time_scale)
		defending = 0


var/bodyparts_mapping = list(
		"TORSO" = /obj/bodypart/human/torso,
		"HEAD" = /obj/bodypart/human/head,
		"RIGHT_ARM" = /obj/bodypart/human/right_arm,
		"LEFT_ARM" = /obj/bodypart/human/left_arm,
		"RIGHT_LEG" = /obj/bodypart/human/right_leg,
		"LEFT_LEG" = /obj/bodypart/human/left_leg,
	)


mob/proc/get_armor_from_body_zone(var/body_zone) // -> list
	var/armor
	if(body_zone == "head")
		for(var/obj/item/armor/i in src.helmet) armor = i
	if(body_zone == "torso")
		for(var/obj/item/armor/i in src.armor) armor = i
	if(body_zone in list("left_leg","right_leg"))
		for(var/obj/item/armor/i in src.legs) armor = i
	if(body_zone in list("left_arm","right_arm"))
		for(var/obj/item/armor/i in src.hands) armor = i
	world<< "[armor]"
	return armor

mob/proc/get_body_obj_from_body_zone(var/body_zone) // -> list
	var/body_obj
	if(body_zone == "head")
		for(var/obj/bodypart/human/head/obj in bodyparts) body_obj = obj
	if(body_zone == "torso")
		for(var/obj/bodypart/human/torso/obj in bodyparts) body_obj = obj
	if(body_zone == "left_leg")
		for(var/obj/bodypart/human/left_leg/obj in bodyparts) body_obj = obj
	if(body_zone == "right_leg")
		for(var/obj/bodypart/human/right_leg/obj in bodyparts) body_obj = obj
	if(body_zone == "left_arm")
		for(var/obj/bodypart/human/left_arm/obj in bodyparts) body_obj = obj
	if(body_zone == "right_arm")
		for(var/obj/bodypart/human/right_arm/obj in bodyparts) body_obj = obj
	return body_obj

mob/proc/get_available_body_zones() // -> list
	var/list/body_zones = list()
	for(var/obj/bodypart/human/torso/torso in bodyparts)
		body_zones.Add("torso")
	for(var/obj/bodypart/human/head/head in bodyparts)
		body_zones.Add("head")
	for(var/obj/bodypart/human/right_leg/right_leg in bodyparts)
		body_zones.Add("right_leg")
	for(var/obj/bodypart/human/left_leg/left_leg in bodyparts)
		body_zones.Add("left_leg")
	for(var/obj/bodypart/human/right_arm/right_arm in bodyparts)
		body_zones.Add("right_arm")
	for(var/obj/bodypart/human/left_arm/left_arm in bodyparts)
		body_zones.Add("left_arm")
	return body_zones
//	world<<"test: [pick(body_zones)]"


mob/proc/process_attack(var/mob/attacker as mob)
	if(attacker.hand == LEFT_HAND) attacker.active_hand = attacker.left_hand
	else attacker.active_hand = attacker.right_hand
	var/obj/item/weapon/attacker_weapon
	for(var/obj/item/weapon/i as obj in attacker.active_hand)
		attacker_weapon=i

//	var/att_wep_type; if(attacker_weapon) att_wep_type = attacker_weapon.ret_type()
	var/hands_num = 0
	for(var/obj/bodypart/human/right_arm/r in bodyparts) hands_num ++
	for(var/obj/bodypart/human/left_arm/l in bodyparts) hands_num ++
	////смотрим бонус от общего мили
	var/body_zones = get_available_body_zones()
	var/attack_zone = pick(body_zones)
	world<< "attack_zone: [attack_zone]"
	var/base_attack_roll = roll_dice(1, 20)
	world<< "base_attack_roll: [base_attack_roll]"
	if(base_attack_roll == 20)
		spawn() process_damage(attacker_weapon, attacker, TRUE, attack_zone)
		return
	var/attack_roll = base_attack_roll
	world<< "attack_roll: [attack_roll]"
	var/obj/item/armor/attack_zone_armor = get_armor_from_body_zone(attack_zone)
	var/attack_zone_AC = default_AC + (attack_zone_armor != null ? attack_zone_armor.AC_bonus : 0)
	if(attack_roll >= attack_zone_AC)
		spawn() process_damage(attacker_weapon, attacker, attack_zone=attack_zone); hitby = attacker//die()
		return
	world<< "Miss. attack_roll: [attack_roll]. AC: [attack_zone_AC]"


mob/proc/process_damage(obj/item/weapon/wep as obj, mob/attacker as mob, var/is_critical_strike = FALSE, var/attack_zone)
	spawn() draw_damage()
	var/damage_count = rand(1, wep.damage)
	if(is_critical_strike)
		damage_count *= 2

	world<<"damage: [damage_count]"
	world<< "attack zone: [attack_zone]"
	var/obj/bodypart/attack_zone_obj = get_body_obj_from_body_zone(attack_zone)
	attack_zone_obj.hp -= damage_count
	world<< "attack zone obj: [attack_zone_obj] body zone hp: [attack_zone_obj.hp]"

	if(attack_zone_obj.hp <= 0)
		slash_limb(attack_zone)
		bodyparts -= attack_zone_obj

	if(wep != null)
		play_sound(sound('sounds/sword_hit1.ogg'))
	else
		play_sound(sound('sounds/punch4.ogg'))

	var/attack_zone2 = bodyparts_mapping[attack_zone]
	if(attack_zone in list("torso", "head"))
		if(attack_zone_obj.hp <= 0)
			die()
	draw_mob()
//	bodyparts_mapping[bodypart]
//	if(attack_zone == "torso")
//		if(!wep)
//			for(var/obj/item/weapon/swep in stucked_weapon)
//				swep.loc = attacker.loc
//				stucked_weapon -= swep
//				attacker.Get(swep)
//		if(!ribs && abs(attack_hp_final) >= hp)
//			ribs = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S);
//			world<<"Ребра [src.name] ломаются со звучным хрустом!";
//		var/organ_hit_dam = hp_max / 5
//		world<< "organ_hit_dam [organ_hit_dam]"
//		if(wep && wep.damtype == "stab")
//			organ_hit_dam /= 2
//		if(ribs)
//			organ_hit_dam /= 2
//		if(abs(attack_hp_final) >= organ_hit_dam)
//			damage_random_organ()
//		hp += attack_hp_final
//			if(prob(stuck_chance))
//				damage_random_organ()
//				stucked_weapon += wep
//				attacker.Drop(wep)
//				wep.loc = src
//				hp -= 5
//	if(attack_zone == "head")
//		var/obj/bodypart/human/head/head
//		for(var/obj/bodypart/human/head/h in bodyparts)
//			head = h
//			if(wep && wep.damtype == "slash") head.slash_hp += attack_hp_final
//			else head.hp += attack_hp_final
//		if(!head) return
//		if(!head.fracture && abs(attack_hp_final) >= head.hp)
//			head.fracture = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S); die()
//			world<<"Черепушка [src.name] ломается со звучным хрустом!";
//		if(!head.artery && wep && (wep.damtype == "slash" || wep.damtype == "stab") && abs(attack_hp_final) >= head.slash_hp)
//			head.artery = 1; var/list/str = list('sounds/throat.ogg','sounds/throat2.ogg','sounds/throat3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S)
//		if(head.slash_hp <= 0)
//			slash_limb("head")
//			bodyparts -= head
//			die()
//		if(head.hp <= 0)
//			explode_limb("head")
//			bodyparts -= head
//			die()
//	if(attack_zone == "legs")
//		var/list/leg_limbs = list()
//		var/obj/bodypart/human/attacked_leg
//		for(var/obj/bodypart/human/right_leg/h in bodyparts)
//			leg_limbs += h
//		for(var/obj/bodypart/human/left_leg/h in bodyparts)
//			leg_limbs += h
//		if(!leg_limbs.len)
//			return
//		attacked_leg = pick(leg_limbs)
//		if(wep && wep.damtype == "slash") attacked_leg.slash_hp += attack_hp_final
//		else attacked_leg.hp += attack_hp_final
//		if(!attacked_leg.fracture && abs(attack_hp_final) >= attacked_leg.hp)
//			attacked_leg.fracture = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S)
//			world<<"Ножка [src.name] ломается со звучным хрустом!";
//		if(!attacked_leg.artery && wep && (wep.damtype == "slash" || wep.damtype == "stab") && abs(attack_hp_final) >= attacked_leg.slash_hp)
//			attacked_leg.artery = 1; var/sound/S = sound('sounds/blood_splat.ogg'); usr.play_sound(S)
//		if(attacked_leg.slash_hp <= 0)
//			bodyparts -= attacked_leg
//			if(istype(attacked_leg,/obj/bodypart/human/right_leg))
//				slash_limb("right leg")
//			else
//				slash_limb("left leg")
//		if(attacked_leg.hp <= 0)
//			bodyparts -= attacked_leg
//			if(istype(attacked_leg,/obj/bodypart/human/right_leg))
//				explode_limb("right leg")
//			else
//				explode_limb("left leg")
//	if(attack_zone == "hands")
//		var/list/hand_limbs = list()
//		var/obj/bodypart/human/attacked_hand
//		for(var/obj/bodypart/human/right_arm/h in bodyparts)
//			hand_limbs += h
//		for(var/obj/bodypart/human/left_arm/h in bodyparts)
//			hand_limbs += h
//		if(!hand_limbs.len)
//			return
//		attacked_hand = pick(hand_limbs)
//		if(wep && wep.damtype == "slash") attacked_hand.slash_hp += attack_hp_final
//		else attacked_hand.hp += attack_hp_final
//		if(!attacked_hand.fracture && abs(attack_hp_final) >= attacked_hand.hp)
//			attacked_hand.fracture = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S)
//			world<<"Ручка [src.name] ломается со звучным хрустом!"; Drop()
//		if(!attacked_hand.artery && wep && (wep.damtype == "slash" || wep.damtype == "stab") && abs(attack_hp_final) >= attacked_hand.slash_hp)
//			attacked_hand.artery = 1; var/sound/S = sound('sounds/blood_splat.ogg'); usr.play_sound(S)
//		if(attacked_hand.slash_hp <= 0)
//			bodyparts -= attacked_hand
//			if(istype(attacked_hand,/obj/bodypart/human/right_arm))
//				slash_limb("right arm")
//			else
//				slash_limb("left arm")
//			hand = LEFT_HAND; Drop(); hand = RIGHT_HAND; Drop()
//		if(attacked_hand.hp <= 0)
//			bodyparts -= attacked_hand
//			if(istype(attacked_hand,/obj/bodypart/human/right_arm))
//				explode_limb("right arm")
//			else
//				explode_limb("left arm")
//			hand = LEFT_HAND; Drop(); hand = RIGHT_HAND; Drop()
//
//	if(abs(attack_hp_final) > st * 1.5) spawn() discard(attacker)
//	usr<< "attacker.st = [attacker.st] damage_count = [attack_hp_final]; [src] stamina [stamina]"
//	draw_mob()
//	if(hp <= 0)
//		die()

obj/choped_limb
	icon = 'img/mob.dmi'

mob/proc/slash_limb(var/limb as text)
	var/sound/S = sound('sounds/chop.ogg')
	usr.play_sound(S)
	var/obj/choped_limb/cl = new
	if(limb == "head")
		head_artery = 1; cl.name = "head"; cl.icon_state = "head_underlay"
	if(limb == "left_arm")
		left_arm_artery = 1; cl.name = "left arm"; cl.icon_state = "left_arm_c"
	if(limb == "right_arm")
		right_arm_artery = 1; cl.name = "right arm"; cl.icon_state = "right_arm_c"
	if(limb == "left_leg")
		left_leg_artery = 1; cl.name = "left leg"; cl.icon_state = "left_leg_c"
	if(limb == "right_leg")
		right_leg_artery = 1; cl.name = "right leg"; cl.icon_state = "right_leg_c"
	var/list/near_turfs = list()
	for(var/turf/t in range(1,src))
		near_turfs += t
	var/turf/end_turf = pick(near_turfs)
	cl.x = end_turf.x; cl.y = end_turf.y; cl.z = end_turf.z

mob/proc/explode_limb(var/limb as text)
	var/sound/S = sound('sounds/chop3.ogg')
	usr.play_sound(S)
	if(limb == "head")
		head_artery = 1
	if(limb == "left arm")
		left_arm_artery = 1
	if(limb == "right arm")
		right_arm_artery = 1
	if(limb == "left leg")
		left_leg_artery = 1
	if(limb == "right leg")
		right_leg_artery = 1

mob/proc/discard(var/mob/M)
	world<< "Discard"
	var/fly_x = 3, fly_y = 3
	if(get_dir(M,src) == NORTH)
		fly_x = 0; fly_y = 1*fly_y
	if(get_dir(M,src) == SOUTH)
		fly_x = 0; fly_y = -1*fly_y//usr.dodge(0, -1)
	if(get_dir(M,src) == EAST)
		fly_x = 1*fly_x; fly_y = 0//usr.dodge(1, 0)
	if(get_dir(M,src) == WEST)
		fly_x = -1*fly_x; fly_y = 0//usr.dodge(-1, 0)
	if(get_dir(M,src) == NORTHWEST)
		fly_x = -1*fly_x; fly_y = 1*fly_y//usr.dodge(-1, 1)
	if(get_dir(M,src) == NORTHEAST)
		fly_x = 1*fly_x; fly_y = 1*fly_y//usr.dodge(1, 1)
	if(get_dir(M,src) == SOUTHWEST)
		fly_x = -1*fly_x; fly_y = -1*fly_y//M.dodge(-1, -1)
	if(get_dir(usr,src) == SOUTHEAST)
		fly_x = 1*fly_x; fly_y = -1*fly_y//M.dodge(1, -1)
	var/abs_fly_x = abs(fly_x), abs_fly_y = abs(fly_y)
	while(abs_fly_x != 0 || abs_fly_y != 0)
		sleep(2)
		if(fly_x > 0)
			if(!is_fly_way(src.x + 1, src.y)) return
			src.x += 1
		else
			if(fly_x != 0)
				if(!is_fly_way(src.x - 1, src.y)) return
				src.x -= 1
		if(fly_y > 0)
			if(!is_fly_way(src.x, src.y + 1)) return
			src.y += 1
		else
			if(fly_y != 0)
				if(!is_fly_way(src.x, src.y - 1)) return
				src.y -= 1
		if(abs_fly_x > 0) abs_fly_x--
		if(abs_fly_y > 0) abs_fly_y--


mob/proc/dodge(var/dox, var/doy)
	if(stamina <= 0) return
	var/sound/S = sound('sounds/jump_male.ogg')
	usr.play_sound(S)
	src.stamina -= 10
	var/newx = src.x + dox; var/newy = src.y + doy
	if(is_fly_way(newx, newy))
		src.x += dox
		src.y += doy

mob/proc/is_fly_way(var/newx, var/newy)
	var/ouch = 0
	for(var/obj/wall/cave/W in locate(newx,newy,src.z)) ouch = 1
	for(var/mob/M in locate(newx,newy,src.z)) ouch = 1
	if(ouch)
		return 0
	else return 1


mob/proc/recreate()
	var/matrix/M = matrix()//var/icon/i = new(src.icon,src.icon_state)
	M.Turn(90)
	src.transform = M//src.icon = i
	while(stamina <= 0 && hp >=0)
		sleep(10)
		if(alive == 0)
			return
	M.Turn(-90)
	//i += overlays
	src.transform = M//src.icon = i
	recreating = 0
	if(hp <= 0)
		die()

mob/var/mob/hitby
mob/var/kill_count = 0

mob/proc/die()
	if(hitby)
		hitby.kill_count++
		hitby = null
	if(ai == 1)
		say("Кхааа")
	ai = 0
	draw_clear()
	alive = 0
	allow_move = 0
	density = 0
	//icon = 'img/mob.dmi'
	//icon_state = "corpse"
	for(var/obj/o as obj in src.active_hand)
		Drop()
	for(var/obj/o in src)
		//Get(o)
		unequip(o)
		Get(o)
		Drop()
	for(var/obj/o in src)
		del o
	draw_mob()
	var/matrix/M = matrix()//var/icon/i = new(src.icon,src.icon_state)
	M.Turn(90)
	src.transform = M
	draw_mob()