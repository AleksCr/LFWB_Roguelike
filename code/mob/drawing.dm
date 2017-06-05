obj/attack
	icon = 'test.dmi'
	s
		icon_state = "attack_s"
	n
		icon_state = "attack_n"
	e
		icon_state = "attack_e"
	w
		icon_state = "attack_w"
	se
		icon_state = "attack_se"
	sw
		icon_state = "attack_sw"
	ne
		icon_state = "attack_ne"
	nw
		icon_state = "attack_nw"
obj/defend
	icon = 'test.dmi'
	s
		icon_state = "defend_s"
	n
		icon_state = "defend_n"
	e
		icon_state = "defend_e"
	w
		icon_state = "defend_w"
	se
		icon_state = "defend_se"
	sw
		icon_state = "defend_sw"
	ne
		icon_state = "defend_ne"
	nw
		icon_state = "defend_nw"
obj/damage
	icon = 'test.dmi'
	icon_state = "hit"
	layer = MOB_LAYER + 1

atom/MouseDown(anything,anything,var/c)
	..()
	c = params2list(c)
	if(c["left"])
		if(get_dir(usr,src) == NORTH)
			usr.attack(0, 1)
		if(get_dir(usr,src) == SOUTH)
			usr.attack(0, -1)
		if(get_dir(usr,src) == EAST)
			usr.attack(1, 0)
		if(get_dir(usr,src) == WEST)
			usr.attack(-1, 0)
		if(get_dir(usr,src) == NORTHWEST)
			usr.attack(-1, 1)
		if(get_dir(usr,src) == NORTHEAST)
			usr.attack(1, 1)
		if(get_dir(usr,src) == SOUTHWEST)
			usr.attack(-1, -1)
		if(get_dir(usr,src) == SOUTHEAST)
			usr.attack(1, -1)

atom/MouseDown(anything,anything,var/c)
	..()
	c = params2list(c)
	if(c["right"])
		if(get_dir(usr,src) == NORTH)
			usr.defend(0, 1)
		if(get_dir(usr,src) == SOUTH)
			usr.defend(0, -1)
		if(get_dir(usr,src) == EAST)
			usr.defend(1, 0)
		if(get_dir(usr,src) == WEST)
			usr.defend(-1, 0)
		if(get_dir(usr,src) == NORTHWEST)
			usr.defend(-1, 1)
		if(get_dir(usr,src) == NORTHEAST)
			usr.defend(1, 1)
		if(get_dir(usr,src) == SOUTHWEST)
			usr.defend(-1, -1)
		if(get_dir(usr,src) == SOUTHEAST)
			usr.defend(1, -1)

atom/MouseDown(anything,anything,var/c)
	..()
	c = params2list(c)
	if(c["middle"])
		if(get_dir(usr,src) == NORTH)
			usr.dodge(0, 1)
		if(get_dir(usr,src) == SOUTH)
			usr.dodge(0, -1)
		if(get_dir(usr,src) == EAST)
			usr.dodge(1, 0)
		if(get_dir(usr,src) == WEST)
			usr.dodge(-1, 0)
		if(get_dir(usr,src) == NORTHWEST)
			usr.dodge(-1, 1)
		if(get_dir(usr,src) == NORTHEAST)
			usr.dodge(1, 1)
		if(get_dir(usr,src) == SOUTHWEST)
			usr.dodge(-1, -1)
		if(get_dir(usr,src) == SOUTHEAST)
			usr.dodge(1, -1)

mob/proc/draw_attack(direct, time)
	if(direct == "n")
		overlays += /obj/attack/n
		sleep(time)
		overlays -= /obj/attack/n
	if(direct == "s")
		overlays += /obj/attack/s
		sleep(time)
		overlays -= /obj/attack/s
	if(direct == "e")
		overlays += /obj/attack/e
		sleep(time)
		overlays -= /obj/attack/e
	if(direct == "w")
		overlays += /obj/attack/w
		sleep(time)
		overlays -= /obj/attack/w
	if(direct == "nw")
		overlays += /obj/attack/nw
		sleep(time)
		overlays -= /obj/attack/nw
	if(direct == "ne")
		overlays += /obj/attack/ne
		sleep(time)
		overlays -= /obj/attack/ne
	if(direct == "sw")
		overlays += /obj/attack/sw
		sleep(time)
		overlays -= /obj/attack/sw
	if(direct == "se")
		overlays += /obj/attack/se
		sleep(time)
		overlays -= /obj/attack/se

mob/proc/draw_defend(direct, time)
	if(direct == "n")
		overlays += /obj/defend/n
		sleep(time)
		overlays -= /obj/defend/n
	if(direct == "s")
		overlays += /obj/defend/s
		sleep(time)
		overlays -= /obj/defend/s
	if(direct == "e")
		overlays += /obj/defend/e
		sleep(time)
		overlays -= /obj/defend/e
	if(direct == "w")
		overlays += /obj/defend/w
		sleep(time)
		overlays -= /obj/defend/w
	if(direct == "nw")
		overlays += /obj/defend/nw
		sleep(time)
		overlays -= /obj/defend/nw
	if(direct == "ne")
		overlays += /obj/defend/ne
		sleep(time)
		overlays -= /obj/defend/ne
	if(direct == "sw")
		overlays += /obj/defend/sw
		sleep(time)
		overlays -= /obj/defend/sw
	if(direct == "se")
		overlays += /obj/defend/se
		sleep(time)
		overlays -= /obj/defend/se

mob/proc/draw_clear()
	overlays -= /obj/attack/n
	overlays -= /obj/attack/s
	overlays -= /obj/attack/e
	overlays -= /obj/attack/w
	overlays -= /obj/attack/nw
	overlays -= /obj/attack/ne
	overlays -= /obj/attack/sw
	overlays -= /obj/attack/se
	overlays -= /obj/defend/n
	overlays -= /obj/defend/s
	overlays -= /obj/defend/e
	overlays -= /obj/defend/w
	overlays -= /obj/defend/nw
	overlays -= /obj/defend/ne
	overlays -= /obj/defend/sw
	overlays -= /obj/defend/se

mob/proc/draw_damage()
	overlays += /obj/damage
	sleep (10)
	overlays -= /obj/damage