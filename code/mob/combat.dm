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
		time = 10
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
	if(wep != null)
		bleed_size = wep.bleed_def
		hp -= hp_dam * wep.dam_modifer
		stamina -= hp_dam*rand(3,10) * wep.stamina_dam_modifer
		var/sound/S = sound('sounds/sword_hit1.ogg')
		play_sound(S)
	else
		hp -= hp_dam
		stamina -= hp_dam*rand(3,10)
		var/sound/S = sound('sounds/punch4.ogg')
		play_sound(S)
	if(stamina <= 0 && recreating == 0 && alive == 1)
		recreating = 1
		spawn() recreate()
	usr<< "M.st = [M.st] hp_dam = [hp_dam]; [src] stamina [stamina]"
	if(hp <= 0)
		die()


mob/proc/dodge(var/dox, var/doy)
	if(stamina <= 0) return
	var/sound/S = sound('sounds/jump_male.ogg')
	usr.play_sound(S)
	usr.stamina -= 10
	usr.x += dox
	usr.y += doy


//mob/var/blood = 500
mob/var/bleed_size = 0

obj/blood_drip
	icon = 'test.dmi'
	icon_state = "blood_drips"

mob/proc/bleed()
	new/obj/blood_drip(src.loc)
	hp -= bleed_size
	if(hp <= 0)
		die()

mob/proc/recreate()
	var/icon/i = new(src.icon,src.icon_state)
	i.Turn(90)
	src.icon = i
	while(stamina <= 0 && hp >=0)
		sleep(10)
		if(alive == 0)
			return
	i.Turn(-90)
	src.icon = i
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
	icon = 'test.dmi'
	icon_state = "corpse"