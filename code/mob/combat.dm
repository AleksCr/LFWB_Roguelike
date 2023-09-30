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
	var/time
	if(attack_style == "fast")
		time = 3
	if(attack_style == "normal")
		time = 6
	if(attack_style == "strong")
		time = 6
	if(attack_style == "superhero")
		time = 1
	return time

mob/var/const/str_cant_attack = "You are too tired to attack"
mob/var/attack_num = 1
mob/var/current_attacks = 0
mob/proc/attack(a, b)
	if(alive != 1 || current_attacks >= attack_num)
		return
	//for(var/mob/M in view(3,src)
		//ai_defend_attack()
	var/attack_stamina_cost = list("fast" = 10, "normal" = 5, "strong" = 15)
	current_attacks++
	if(stamina <= attack_stamina_cost[attack_style])
	    usr<< str_cant_attack
		draw_clear()
		current_attacks=0
		return
	stamina -= attack_stamina_cost[attack_style]
	if(alive != 1)
		return
	if(current_attacks == 2)
		return
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
	for(var/mob/m in view(1,src))
		if(m.x == x+a && m.y == y+b)
			spawn() m.dam(src)
		else
			var/sound/S = sound('sounds/punchmiss.ogg')
			play_sound(S)
	if(hand == "left") active_hand = left_hand
	else active_hand = right_hand
	var/obj/item/weapon/O
	for(var/obj/item/weapon/i in active_hand)
		O=i
	if(O != null)
		sleep(O.cooldown)
	current_attacks=0


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

mob/proc/dam(var/mob/M)
	if(M.hand == "left") M.active_hand = M.left_hand
	else M.active_hand = M.right_hand
	var/obj/item/weapon/O
	var/obj/item/weapon/MO
	for(var/obj/item/weapon/i as obj in active_hand)
		MO=i
	for(var/obj/item/weapon/i as obj in M.active_hand)
		O=i
	var/def_wep_type; if(MO) def_wep_type = MO.ret_type()
	var/att_wep_type; if(O) att_wep_type = O.ret_type()
	var/hands_num = 0
	for(var/obj/bodypart/human/right_arm/r in bodyparts) hands_num ++
	for(var/obj/bodypart/human/left_arm/l in bodyparts) hands_num ++
	var/bad_block = 0
	var/bonus = 0
	////смотрим бонус от общего мили
	for(var/datum/skill/melee/m in M.skills)
		bonus += m.skill_lvl
	var/diceroll = d3()
	world<< "dice rolls [diceroll]"

	///////Накидываем бонус от оружия и заодно качаем его навык
	if(att_wep_type == "sword")
		for(var/datum/skill/sword/sword in M.skills)
			bonus += sword.skill_lvl
			M.grind_skill("sword")
	if(att_wep_type == "spear")
		for(var/datum/skill/spear/spear in M.skills)
			bonus += spear.skill_lvl
			M.grind_skill("spear")
	if(att_wep_type == "axe")
		for(var/datum/skill/axe/axe in M.skills)
			bonus += axe.skill_lvl
			M.grind_skill("axe")
	if(att_wep_type == "dagger")
		for(var/datum/skill/dagger/dagger in M.skills)
			bonus += dagger.skill_lvl
			M.grind_skill("dagger")
	if(att_wep_type == "club")
		for(var/datum/skill/club/club in M.skills)
			bonus += club.skill_lvl
			M.grind_skill("club")
	world<< "Бонус к попаданию составил = [bonus]"

		/////�������, ������ ��
	if(diceroll > M.dx + bonus)// || diceroll ==3)
		if(diceroll == 18)
			world<< "Критический провал! [M.name] не попал в цель!"; return
		world<< "[M.name] не попал в цель!"; return


	M.grind_skill("melee")
	if(defending == 1)
		if(M.x != x+def_a || M.y != y+def_b)
			world<< "К сожалению, [name] ставит блок не с той стороны!"
			spawn() get_damage(O,M); hitby = M
			return
		var/xf = 0;
		var/parry_chance;
		if(MO)
			if(!O)
				spawn() M.get_damage(MO,src, "hands")
				return
			if(MO.mass*2 < O.mass)
				if(prob(20))
					Drop(MO)
					del MO
					var/sound/S = sound('sounds/breaksound.ogg')
					play_sound(S)
					return
			/////Повторяем говнокод для защищающегося
			grind_skill("melee")
			var/parry = 0
			if(def_wep_type == "sword")
				for(var/datum/skill/sword/sword in skills)
					parry += sword.skill_lvl
					grind_skill("sword")
			if(def_wep_type == "spear")
				for(var/datum/skill/spear/spear in skills)
					parry += spear.skill_lvl
					grind_skill("spear")
			if(def_wep_type == "axe")
				for(var/datum/skill/axe/axe in skills)
					parry += axe.skill_lvl
					grind_skill("axe")
			if(def_wep_type == "dagger")
				for(var/datum/skill/dagger/dagger in skills)
					parry += dagger.skill_lvl
					grind_skill("dagger")
			if(def_wep_type == "club")
				for(var/datum/skill/club/club in skills)
					parry += club.skill_lvl
					grind_skill("club")
			diceroll = d3()
			for(var/datum/skill/melee/melee in skills)
				parry += melee.skill_lvl
			world<< "Block dice rolls [diceroll]; melee+weapon_skill([parry]) + 3 = [parry+3]"
			if(parry/2 + 3 >= diceroll && diceroll != 18)
				world<< "[name] ��������� �����!"
				var/sound/S = sound('sounds/parry.ogg')
				play_sound(S)
				return
			else world<< "Блок не спасает [name]!"
		else
			xf = dx - M.dx
				//world<< "xf [xf] = (MO.mass [MO.mass] + st [st]) - (O.mass [O.mass] + M.st [M.st]) + (dx [dx] - M.dx [M.dx])"
			parry_chance = 50 + (xf*5)
			//world<< "parry_chance before fix = [parry_chance]"
			if(parry_chance > 80) parry_chance = 80
			if(parry_chance < 5) parry_chance = 5
			//world<< "parry_chance after fix = [parry_chance]"
			if(prob(parry_chance))
				xf = st - M.st
				if(parry_chance > 80) parry_chance = 80
				if(parry_chance < 5) parry_chance = 5
				if(prob(parry_chance))
					world<< "[name] выхватывает оружие из рук [M.name]!"
					var/obj/item/weapon/test = M.Drop(MO)
					Get(test)
					return
				world<< "[name] ловким взмахом ладони отклоняет атаку в сторону!"
				var/sound/S = sound('sounds/parry.ogg')
				play_sound(S)
				return
			else world<< "Блокировать оружие голыми руками было весьма глупой идеей!"
			bad_block = 1
	//var/agi_difference = dx - M.dx
	//var/dodge_chance = agi_difference * 5
	//if(dodge_chance > 80) dodge_chance = 80; if(dodge_chance <= 0) dodge_chance = 0
	//world<< "agi diff = [agi_difference] dodge ch = [dodge_chance]"
	//if(prob(dodge_chance))
	diceroll = d3()
	world<< "Defence dice rolls [diceroll]; base speed of defenser = [(base_speed+3)]"
	if((base_speed+3) >= diceroll && diceroll != 18 && alive)
		M<<"[src] удалось уклониться от удара!"
		for(var/mob/Others in oview(10))
			Others<< "[src] удалось уклониться от удара!"
		return
	if(bad_block && hands_num >0)
		if(hands_num == 0) return
		spawn() get_damage(O,M, "hands"); hitby = M
		return
	spawn() get_damage(O,M); hitby = M//die()

mob/proc/get_damage(obj/item/weapon/wep as obj, mob/M as mob, var/in_zone)
	spawn() draw_damage()
	var/hp_dam
	if(wep && ( (istype(wep,/obj/item/weapon/sword)) || (istype(wep,/obj/item/weapon/axe)) || (istype(wep,/obj/item/weapon/club)) || (istype(wep,/obj/item/weapon/hammer)) ) )
		hp_dam = M.calculate_base_damage(1); world<< "amplitude strike"
	else
		hp_dam = M.calculate_base_damage(0); world<< "direct strike"


	///////////ВЫБОР АТАКУЕМОЙ ЗОНЫ


	var/list/body_zones = list("head","torso")
	for(var/obj/bodypart/human/right_leg/h in bodyparts)
		if("legs" in body_zones)
			break
		else
			body_zones += "legs"
	for(var/obj/bodypart/human/left_leg/h in bodyparts)
		if("legs" in body_zones)
			break
		else
			body_zones += "legs"
	for(var/obj/bodypart/human/right_arm/h in bodyparts)
		if("hands" in body_zones)
			break
		else
			body_zones += "hands"
	for(var/obj/bodypart/human/left_arm/h in bodyparts)
		if("hands" in body_zones)
			break
		else
			body_zones += "hands"


	////////УЧЕТ ОРУЖИЯ

	var/attack_zone
	if(in_zone != null) attack_zone = in_zone
	else attack_zone = pick(body_zones)
	world<< "attack zone: [attack_zone]"
	var/attack_hp_final = 0
	var/attack_stamina_final = 0
	var/bleed_final = 0
	if(wep != null)
		bleed_final = wep.bleed_def
		attack_hp_final -= hp_dam + wep.dam_modifer
		attack_stamina_final -= hp_dam*rand(3,10) + wep.stamina_dam_modifer
		var/sound/S = sound('sounds/sword_hit1.ogg')
		play_sound(S)
	else
		attack_hp_final -= hp_dam
		attack_stamina_final -= hp_dam*rand(3,10)
		var/sound/S = sound('sounds/punch4.ogg')
		play_sound(S)
	if(M.attack_style == "strong")
		attack_hp_final += 2
	var/obj/item/armor/a
	if(attack_zone == "torso")
		for(var/obj/item/armor/i in src.armor) a = i
	if(attack_zone == "head")
		for(var/obj/item/armor/i in src.helmet) a = i
	if(attack_zone == "legs")
		for(var/obj/item/armor/i in src.legs) a = i
	if(attack_zone == "hands")
		for(var/obj/item/armor/i in src.hands) a = i//; Drop()


	///////////////////////////ПРОБИТИЕ БРОНИ


	if(a)
		if(wep && istype(wep,/obj/item/weapon/dagger))// ������� ����� � ������� �����
			a.coverage -= 20
		if(prob(a.coverage))
			if(wep && (istype(wep,/obj/item/weapon/sword)))
				attack_hp_final *= 0.5;
			if(wep && istype(wep,/obj/item/weapon/dagger))
				attack_hp_final *= 0.7;
			if(a.min_damage >= abs(attack_hp_final))
				bleed_final = 0
				attack_stamina_final = 0
				attack_hp_final = 0
				world<<"[a.name] [src.name] полностью блокирует удар!"; M<<"Броня [src.name] полностью блокирует удар!"
			else
				attack_hp_final += a.min_damage
				attack_stamina_final /= 2
				world<<"[a.name] [src.name] частично блокирует удар!"; M<<"Броня [src.name] частично блокирует удар!"
			var/sound/S = sound('sounds/parry.ogg')
			play_sound(S)
		else
			world<<"[M.name] проводит хитрый удар в разрез брони!"
			if(wep && (istype(wep,/obj/item/weapon/axe) || (istype(wep,/obj/item/weapon/sword))))
				attack_hp_final *= 1.5; //world<< "weapon hits with 1.5 dam!!!!!"
			if(wep && istype(wep,/obj/item/weapon/spear))
				attack_hp_final *= 2; //world<< "weapon hits with 2 dam!!!!!!!"
			//if(wep && istype(wep,/obj/item/weapon/dagger))
			//	attack_hp_final *= 0.5;
	else
		if(wep && (istype(wep,/obj/item/weapon/axe) || (istype(wep,/obj/item/weapon/sword))))
			attack_hp_final *= 1.5; //world<< "weapon hits with 1.5 dam!!!!!!"
		if(wep && istype(wep,/obj/item/weapon/spear))
			attack_hp_final *= 1.5; //world<< "weapon hits with 2 dam!!!!!!!"

	if(abs(attack_hp_final) < 1) attack_hp_final = 1
	/////////////////���� � ����������

	if(attack_zone == "torso")
		if(!wep)
			for(var/obj/item/weapon/swep in stucked_weapon)
				swep.loc = M.loc
				stucked_weapon -= swep
				M.Get(swep)
		if(!ribs && abs(attack_hp_final) >= hp)
			ribs = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S);
			world<<"Ребра [src.name] ломаются со звучным хрустом!";
		var/organ_hit_dam = hp_max / 5
		world<< "organ_hit_dam [organ_hit_dam]"
		if(wep && wep.damtype == "stab")
			organ_hit_dam /= 2
		if(ribs)
			organ_hit_dam /= 2
		if(abs(attack_hp_final) >= organ_hit_dam)
			damage_random_organ()
		hp += attack_hp_final
		if(abs(attack_hp_final) >= 3 && wep)
			var/stuck_chance
			if(M.st < 11) stuck_chance = 20
			if(M.st > 11 && M.st < 15) stuck_chance = 10
			if(M.st > 15) stuck_chance = 5
			if((!istype(wep,/obj/item/weapon/dagger) && !istype(wep,/obj/item/weapon/spear) && !istype(wep,/obj/item/weapon/axe)) || (stucked_weapon.len>0)) stuck_chance = 0
			if(prob(stuck_chance))
				damage_random_organ()
				stucked_weapon += wep
				M.Drop(wep)
				wep.loc = src
				hp -= 5
	if(attack_zone == "head")
		var/obj/bodypart/human/head/he
		for(var/obj/bodypart/human/head/h in bodyparts)
			he = h
			if(wep && wep.damtype == "slash") he.slash_hp += attack_hp_final
			else he.hp += attack_hp_final
		if(!he) return
		if(!he.fracture && abs(attack_hp_final) >= he.hp)
			he.fracture = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S); die()
			world<<"Черепушка [src.name] ломается со звучным хрустом!";
		if(!he.artery && wep && (wep.damtype == "slash" || wep.damtype == "stab") && abs(attack_hp_final) >= he.slash_hp)
			he.artery = 1; var/list/str = list('sounds/throat.ogg','sounds/throat2.ogg','sounds/throat3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S)
		if(he.slash_hp <= 0)
			slash_limb("head")
			bodyparts -= he
			die()
		if(he.hp <= 0)
			explode_limb("head")
			bodyparts -= he
			die()
	if(attack_zone == "legs")
		var/list/leg_limbs = list()
		var/obj/bodypart/human/attacked_leg
		for(var/obj/bodypart/human/right_leg/h in bodyparts)
			leg_limbs += h
		for(var/obj/bodypart/human/left_leg/h in bodyparts)
			leg_limbs += h
		if(!leg_limbs.len)
			return
		attacked_leg = pick(leg_limbs)
		if(wep && wep.damtype == "slash") attacked_leg.slash_hp += attack_hp_final
		else attacked_leg.hp += attack_hp_final
		if(!attacked_leg.fracture && abs(attack_hp_final) >= attacked_leg.hp)
			attacked_leg.fracture = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S)
			world<<"Ножка [src.name] ломается со звучным хрустом!";
		if(!attacked_leg.artery && wep && (wep.damtype == "slash" || wep.damtype == "stab") && abs(attack_hp_final) >= attacked_leg.slash_hp)
			attacked_leg.artery = 1; var/sound/S = sound('sounds/blood_splat.ogg'); usr.play_sound(S)
		if(attacked_leg.slash_hp <= 0)
			bodyparts -= attacked_leg
			if(istype(attacked_leg,/obj/bodypart/human/right_leg))
				slash_limb("right leg")
			else
				slash_limb("left leg")
		if(attacked_leg.hp <= 0)
			bodyparts -= attacked_leg
			if(istype(attacked_leg,/obj/bodypart/human/right_leg))
				explode_limb("right leg")
			else
				explode_limb("left leg")
	if(attack_zone == "hands")
		var/list/hand_limbs = list()
		var/obj/bodypart/human/attacked_hand
		for(var/obj/bodypart/human/right_arm/h in bodyparts)
			hand_limbs += h
		for(var/obj/bodypart/human/left_arm/h in bodyparts)
			hand_limbs += h
		if(!hand_limbs.len)
			return
		attacked_hand = pick(hand_limbs)
		if(wep && wep.damtype == "slash") attacked_hand.slash_hp += attack_hp_final
		else attacked_hand.hp += attack_hp_final
		if(!attacked_hand.fracture && abs(attack_hp_final) >= attacked_hand.hp)
			attacked_hand.fracture = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S)
			world<<"Ручка [src.name] ломается со звучным хрустом!"; Drop()
		if(!attacked_hand.artery && wep && (wep.damtype == "slash" || wep.damtype == "stab") && abs(attack_hp_final) >= attacked_hand.slash_hp)
			attacked_hand.artery = 1; var/sound/S = sound('sounds/blood_splat.ogg'); usr.play_sound(S)
		if(attacked_hand.slash_hp <= 0)
			bodyparts -= attacked_hand
			if(istype(attacked_hand,/obj/bodypart/human/right_arm))
				slash_limb("right arm")
			else
				slash_limb("left arm")
			hand = "left"; Drop(); hand = "right"; Drop()
		if(attacked_hand.hp <= 0)
			bodyparts -= attacked_hand
			if(istype(attacked_hand,/obj/bodypart/human/right_arm))
				explode_limb("right arm")
			else
				explode_limb("left arm")
			hand = "left"; Drop(); hand = "right"; Drop()
	//stamina += attack_stamina_final
	//hp += attack_hp_final
	bleed_size = bleed_final
	//if(stamina <= 0 && recreating == 0 && alive == 1)
	//	recreating = 1
	//	spawn() recreate()
	if(abs(attack_hp_final) > st * 1.5) spawn() discard(M)
	usr<< "M.st = [M.st] hp_dam = [attack_hp_final]; [src] stamina [stamina]"
	draw_mob()
	if(hp <= 0)
		die()

obj/choped_limb
	icon = 'img/mob.dmi'

mob/proc/slash_limb(var/limb as text)
	var/sound/S = sound('sounds/chop.ogg')
	usr.play_sound(S)
	var/obj/choped_limb/cl = new
	if(limb == "head")
		head_artery = 1; cl.name = "head"; cl.icon_state = "head_underlay"
	if(limb == "left arm")
		left_arm_artery = 1; cl.name = "left arm"; cl.icon_state = "left_arm_c"
	if(limb == "right arm")
		right_arm_artery = 1; cl.name = "right arm"; cl.icon_state = "right_arm_c"
	if(limb == "left leg")
		left_leg_artery = 1; cl.name = "left leg"; cl.icon_state = "left_leg_c"
	if(limb == "right leg")
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
		mob_UNEQUIP(o)
		Get(o)
		Drop()
	for(var/obj/o in src)
		del o
	draw_mob()
	var/matrix/M = matrix()//var/icon/i = new(src.icon,src.icon_state)
	M.Turn(90)
	src.transform = M
	draw_mob()