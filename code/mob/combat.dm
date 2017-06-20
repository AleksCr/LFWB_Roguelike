mob/var/alive = 1
mob/var/hp_max = 35
mob/var/hp = 35
mob/var/recreating = 0
var/defend_time = 5

mob/var/attack_style = "normal"
mob/New()
	..()
	attack_style = pick("fast","normal","strong")
mob/verb/choose_combat_style()
	switch(alert("Choose combat style:","Ударчики","Fast strikes","Normal","Strong and technical strikes"))
		if("Fast strikes")
			attack_style = "fast"
		if("Normal")
			attack_style = "normal"
		if("Strong and technical strikes")
			attack_style = "strong"

mob/proc/calculate_strike_time()
	var/time
	if(attack_style == "fast")
		time = 3
	if(attack_style == "normal")
		time = 6
	if(attack_style == "strong")
		time = 6
	return time

mob/var/attack_num = 1
mob/var/current_attacks = 0
mob/proc/attack(a, b)
	if(alive != 1 || current_attacks >= attack_num)
		return
	//for(var/mob/M in view(3,src)
		//ai_defend_attack()
	current_attacks++
	if(attack_style == "fast")
		if(stamina <=10)
			usr<< "Ты не находишь в себе сил на эту атаку"
			draw_clear()
			current_attacks=0
			return
		stamina -= 10
	if(attack_style == "normal")
		if(stamina <=5)
			usr<< "Ты не находишь в себе сил на эту атаку"
			draw_clear()
			current_attacks=0
			return
		stamina -= 5
	if(attack_style == "strong")
		if(stamina <=15)
			usr<< "Ты не находишь в себе сил на эту атаку"
			draw_clear()
			current_attacks=0
			return
		stamina -= 15
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
	for(var/obj/item/weapon/i as obj in M.active_hand)
		O=i
	if(defending == 1)
		if(M.x != x+def_a || M.y != y+def_b)
			world<< "К сожалению, [name] ставит блок не с той стороны!"
			spawn() get_damage(O,M)
			return
		var/r = rand (10, 30)
		if(attack_style == "normal")
			r += 5
		if(attack_style == "strong")
			r += 10
		if(r <= 24 )
			world<< "[name] блокирует атаку!"
			var/sound/S = sound('sounds/parry.ogg')
			play_sound(S)
			return
		if(r >= 25 && r <= 29)
			world<< "[name] блокирует атаку ценой сбитого блока!"
			var/sound/S = sound('sounds/parry.ogg')
			play_sound(S)
			defending = 0
			draw_clear()
			return
		if(r >= 30)
			world<< "Блок не спасает [name]!"
	var/agi_difference = dx - M.dx
	var/dodge_chance = agi_difference * 5
	if(dodge_chance > 80) dodge_chance = 80; if(dodge_chance <= 0) dodge_chance = 0
	//world<< "agi diff = [agi_difference] dodge ch = [dodge_chance]"
	if(prob(dodge_chance))
		if(stamina >= 30)
			M<<"[src] удалось уклонитьс&#255; от удара!"
			for(var/mob/Others in oview(10))
				Others<< "[src] удалось уклонитьс&#255; от удара!"
			return
	spawn() get_damage(O,M)//die()

mob/proc/get_damage(obj/item/weapon/wep as obj, mob/M as mob)
	spawn() draw_damage()
	var/attack_suc
	if(M.dx > dx)
		attack_suc = rand((M.dx - dx/2),5)
		if(attack_suc < 1)
			attack_suc = 1
		if(attack_suc > 4)
			attack_suc = 4
	else attack_suc = rand(1,5)
	attack_suc = attack_suc/10
	var/hp_dam = attack_suc*M.st


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

	var/attack_zone = pick(body_zones)
	world<< "attack zone: [attack_zone]"
	var/attack_hp_final = 0
	var/attack_stamina_final = 0
	var/bleed_final = 0
	if(wep != null)
		bleed_final = wep.bleed_def
		attack_hp_final -= hp_dam * wep.dam_modifer
		attack_stamina_final -= hp_dam*rand(3,10) * wep.stamina_dam_modifer
		var/sound/S = sound('sounds/sword_hit1.ogg')
		play_sound(S)
	else
		attack_hp_final -= hp_dam
		attack_stamina_final -= hp_dam*rand(3,10)
		var/sound/S = sound('sounds/punch4.ogg')
		play_sound(S)
	if(M.attack_style == "strong")
		attack_hp_final *= 1.5
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
		if(prob(a.coverage))
			if(a.min_damage >= abs(attack_hp_final))
				bleed_final = 0
				attack_stamina_final = 0
				attack_hp_final = 0
				world<<"[a.name] [src.name] полностью блокирует удар!"; M<<"Брон&#255; [src.name] полностью блокирует удар!"
			else
				attack_hp_final += a.min_damage
				attack_stamina_final /= 2
				world<<"[a.name] [src.name] частично блокирует удар!"; M<<"Брон&#255; [src.name] частично блокирует удар!"
			var/sound/S = sound('sounds/parry.ogg')
			play_sound(S)
		else
			world<<"[M.name] проводит хитрый удар в разрез брони!"

	/////////////////УРОН В КОНЕЧНОСТЬ

	if(attack_zone == "torso")
		var/organ_hit_dam = hp_max / 5
		world<< "organ_hit_dam [organ_hit_dam]"
		if(wep && wep.damtype == "stab")
			organ_hit_dam /= 2
		if(!ribs)
			organ_hit_dam /= 2
		if(abs(attack_hp_final) >= organ_hit_dam)
			damage_random_organ()
		hp += attack_hp_final
	if(attack_zone == "head")
		var/obj/bodypart/human/head/he
		for(var/obj/bodypart/human/head/h in bodyparts)
			he = h
			if(wep && wep.damtype == "slash") he.slash_hp += attack_hp_final
			else he.hp += attack_hp_final
		if(!he.fracture && abs(attack_hp_final) >= he.hp)
			he.fracture = 1; var/list/str = list('sounds/trauma1.ogg','sounds/trauma2.ogg','sounds/trauma3.ogg'); var/sound/S = sound(pick(str)); usr.play_sound(S); die()
			world<<"Черепушка [src.name] ломаетс&#255; со звучным хрустом!";
		if(!he.artery && wep && wep.damtype == "slash" && abs(attack_hp_final) >= he.slash_hp)
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
			world<<"Ножка [src.name] ломаетс&#255; со звучным хрустом!";
		if(!attacked_leg.artery && wep && wep.damtype == "slash" && abs(attack_hp_final) >= attacked_leg.slash_hp)
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
			world<<"Ручка [src.name] ломаетс&#255; со звучным хрустом!";
		if(!attacked_hand.artery && wep && wep.damtype == "slash" && abs(attack_hp_final) >= attacked_hand.slash_hp)
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
	//bleed_size = bleed_final
	if(stamina <= 0 && recreating == 0 && alive == 1)
		recreating = 1
		spawn() recreate()
	usr<< "M.st = [M.st] hp_dam = [hp_dam]; [src] stamina [stamina]"
	draw_mob()
	if(hp <= 0)
		die()

obj/choped_limb
	icon = 'mob.dmi'

mob/proc/slash_limb(var/limb as text)
	var/sound/S = sound('sounds/chop.ogg')
	usr.play_sound(S)
	var/obj/choped_limb/cl = new
	if(limb == "head")
		cl.name = "head"; cl.icon_state = "head_underlay"
	if(limb == "left arm")
		cl.name = "left arm"; cl.icon_state = "left_arm_c"
	if(limb == "right arm")
		cl.name = "right arm"; cl.icon_state = "right_arm_c"
	if(limb == "left leg")
		cl.name = "left leg"; cl.icon_state = "left_leg_c"
	if(limb == "right leg")
		cl.name = "right leg"; cl.icon_state = "right_leg_c"
	var/list/near_turfs = list()
	for(var/turf/t in orange(1))
		near_turfs += t
	var/turf/end_turf = pick(near_turfs)
	cl.x = end_turf.x; cl.y = end_turf.y; cl.z = end_turf.z

mob/proc/explode_limb(var/limb as text)
	var/sound/S = sound('sounds/chop3.ogg')
	usr.play_sound(S)

//mob/proc/damage_limb(var/obj/bodypart/b, var/)

mob/proc/armor_calc(var/attack_hp_final, var/attack_stamina_final)


mob/proc/dodge(var/dox, var/doy)
	if(stamina <= 0) return
	var/sound/S = sound('sounds/jump_male.ogg')
	usr.play_sound(S)
	usr.stamina -= 10
	usr.x += dox
	usr.y += doy


mob/var/blood = 500
mob/var/bleed_size = 0

obj/blood_drip
	icon = 'test.dmi'
	icon_state = "blood_drips"

obj/blood_pool
	icon = 'mob.dmi'
	icon_state = "pool5"
	var/pool_size

mob/proc/bleed(var/btype)
	/*if(btype == 1)
		for(var/obj/blood_drip/b in orange(0))
		new/obj/blood_drip(src.loc)
	if(btype == 2 || btype == 2)
		new/obj/blood_pool(src.loc)*/
	hp -= bleed_size
	if(hp <= 0)
		die()

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

mob/proc/die()
	if(ai == 1)
		say("Кхааа")
	ai = 0
	draw_clear()
	alive = 0
	allow_move = 0
	density = 0
	//icon = 'mob.dmi'
	//icon_state = "corpse"
	for(var/obj/o as obj in src.active_hand)
		Drop()
	for(var/obj/o in src)
		Get(o)
		Drop()
	draw_mob()
	var/matrix/M = matrix()//var/icon/i = new(src.icon,src.icon_state)
	M.Turn(90)
	src.transform = M
	draw_mob()