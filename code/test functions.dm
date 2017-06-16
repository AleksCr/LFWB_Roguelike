mob/verb/respawn()
	if(alive != 0)
		usr<< "Сначала нужно умереть"
		return
	x = 1
	y = 1
	z = 1
	icon_state = "body_m_s"
	allow_move = 1
	density = 1
	alive = 1
	stamina = stamina_max
	hp = 35

mob/verb/chage_atributes()
	var/inst = input("st") as num
	st = inst
	var/indx = input("dx") as num
	dx = indx
	var/inht = input("ht") as num
	ht = inht
	recalculate(1)

mob/verb/rotate_test()
	var/icon/i = new(src.icon,src.icon_state)
	i.Turn(90)
	src.icon = i

mob/verb/off_ai()
	for(var/mob/M in world)
		M.ai = 0

mob/verb/change_time_scale()
	//set hidden = 1
	var/input = input("1 - normal speed") as num
	time_scale = input

mob/verb/say(message as text)
	var/index = findtext(message, "я")
	while(index)
		message = copytext(message, 1, index) + "&#255;" + copytext(message, index+1)
		index = findtext(message, "я")
	world<< "[name] says, [message]"

mob/verb/spawn_ai_human()
	var/mob/M = new
	M.x = 1
	M.y = 1
	M.z = 1
	M.icon_state = "team1"

mob/verb/spawn_ai_human_another_team()
	var/mob/M = new
	M.x = 14
	M.y = 14
	M.z = 1
	M.team = "2"
	M.icon_state = "team2"

mob/var/ai_coolness = "dawn"

mob/verb/spawn_special_ai()
	var/obj/item/weapon/w
	switch(input("Choose a weapon for you opponent") in list("dagger","sword","axe","spear","hammer","club"))
		if("dagger")
			var/obj/item/weapon/dagger/wo = new
			w = wo
		if("sword")
			var/obj/item/weapon/sword/wo = new
			w = wo
		if("axe")
			var/obj/item/weapon/axe/wo = new
			w = wo
		if("spear")
			var/obj/item/weapon/spear/wo = new
			w = wo
		if("hammer")
			var/obj/item/weapon/hammer/wo = new
			w = wo
		if("club")
			var/obj/item/weapon/club/wo = new
			w = wo
	var/mob/M = new
	M.x = 1
	M.y = 1
	M.z = 1
	w.x = M.x; w.y = M.y; w.z = M.z
	var/obj/item/armor/cloth/c = new
	c.loc = M.loc
	sleep(1)
	M.Get(c)
	sleep(1)
	M.mob_equip("cloth")
	sleep(5)
	M.Drop()
	M.Get(w)
	M.draw_mob()
	M.team = "3"


mob/verb/puk()
	alpha = 100