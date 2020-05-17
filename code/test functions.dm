/*mob/verb/respawn()
	if(alive != 0)
		usr<< "������� ����� �������"
		return
	x = 1
	y = 1
	z = 1
	icon_state = "torso"
	allow_move = 1
	density = 1
	alive = 1
	stamina = stamina_max
	hp = 35
	var/obj/bodypart/human/head/resp_head
	var/obj/bodypart/human/right_arm/resp_right_arm
	var/obj/bodypart/human/left_arm/resp_left_arm
	var/obj/bodypart/human/right_leg/resp_right_leg
	var/obj/bodypart/human/left_leg/resp_left_leg
	for(var/obj/bodypart/human/head/h in bodyparts)
		resp_head = h
	for(var/obj/bodypart/human/right_arm/h in bodyparts)
		resp_right_arm = h
	for(var/obj/bodypart/human/left_arm/h in bodyparts)
		resp_left_arm = h
	for(var/obj/bodypart/human/right_leg/h in bodyparts)
		resp_right_leg = h
	for(var/obj/bodypart/human/left_leg/h in bodyparts)
		resp_left_leg = h
	var/obj/bodypart/human/head/h = new; var/obj/bodypart/human/right_arm/ra = new; var/obj/bodypart/human/left_arm/la = new; var/obj/bodypart/human/right_leg/rl = new; var/obj/bodypart/human/left_leg/ll = new;
	if(!resp_head) bodyparts += h; resp_head = h
	if(!resp_right_arm) bodyparts += ra; resp_right_arm = ra
	if(!resp_left_arm)  bodyparts += la; resp_left_arm = la
	if(!resp_right_leg) bodyparts += rl; resp_right_leg = rl
	if(!resp_left_leg) bodyparts += ll; resp_left_leg = ll
	resp_head.hp = resp_head.hp_max; resp_head.slash_hp = resp_head.slash_hp_max; head_artery = 0; resp_head.artery = 0; resp_head.fracture = 0;
	resp_right_arm.hp = resp_right_arm.hp_max; resp_right_arm.slash_hp = resp_right_arm.slash_hp_max; right_arm_artery = 0; resp_right_arm.artery = 0; resp_right_arm.fracture = 0;
	resp_left_arm.hp = resp_left_arm.hp_max; resp_left_arm.slash_hp = resp_left_arm.slash_hp_max; left_arm_artery = 0; resp_left_arm.artery = 0; resp_left_arm.fracture = 0;
	resp_right_leg.hp = resp_right_leg.hp_max; resp_right_leg.slash_hp = resp_right_leg.slash_hp_max; right_leg_artery = 0; resp_right_leg.artery = 0; resp_right_leg.fracture = 0;
	resp_left_leg.hp = resp_left_leg.hp_max; resp_left_leg.slash_hp = resp_left_leg.slash_hp_max; left_leg_artery = 0; resp_left_leg.artery = 0; resp_left_leg.fracture = 0;
	var/matrix/M = matrix()
	M.Turn(0)
	src.transform = M
	draw_mob()
	blood = 500*/

mob/verb/find_ladder()
	for(var/obj/ladder/L in world)
		world<< "[L.x] [L.y] [L.z]"

mob/verb/kill_me()
	die()
	//world<< noclip

mob/verb/kill_all()
	for(var/mob/M in world)
		if(!M.ai) continue
		M.die()

mob/verb/chage_atributes()
	var/inst = input("st") as num
	st = inst
	var/indx = input("dx") as num
	dx = indx
	var/inht = input("ht") as num
	ht = inht
	recalculate(1)

mob/verb/noclip()
	density = 0

mob/verb/heal()
	for(var/obj/bodypart/human/h in bodyparts)
		h.artery = 0
		h.hp = h.hp_max; h.slash_hp = h.slash_hp_max; h.fracture = 0
	artery_head = 0; right_arm_artery = 0; left_arm_artery = 0; right_leg_artery = 0; left_leg_artery = 0;
	blood = 500;
	hp = hp_max
	draw_mob()

mob/verb/off_ai()
	for(var/mob/M in world)
		M.ai = 0

mob/verb/change_time_scale()
	//set hidden = 1
	var/input = input("1 - normal speed") as num
	time_scale = input

mob/verb/say(message as text)
	var/index = findtext(message, "�")
	while(index)
		message = copytext(message, 1, index) + "я" + copytext(message, index+1)
		index = findtext(message, "�")
	world<< "[name] says, [message]"

mob/var/ai_coolness = "dawn"



proc/spawn_special_ai(var/obj/l, var/num, var/holding_weapon, var/cloth_type, var/guy_team)
	if(!num) num = input("how many dydes you wish spawn?") as num
	if(!holding_weapon)holding_weapon = input("Choose a weapon for you opponent") in list("bare hands","dagger","sword","axe","spear","hammer","club")
	if(!cloth_type)cloth_type = input("Choose a suit for you opponent") in list("nothing","cloth","full armor")
	if(!guy_team)guy_team = input("Choose a team for this guy") in list("1","2","player")
	for(var/i = 0; i<num; i++)
		var/obj/item/weapon/w
		if(holding_weapon == "bare hands")
			usr<< "���� ��� �� �����?"
		if(holding_weapon == "dagger")
			var/obj/item/weapon/dagger/wo = new
			w = wo
		if(holding_weapon == "sword")
			var/obj/item/weapon/sword/wo = new
			w = wo
		if(holding_weapon == "axe")
			var/obj/item/weapon/axe/wo = new
			w = wo
		if(holding_weapon == "spear")
			var/obj/item/weapon/spear/wo = new
			w = wo
		if(holding_weapon == "hammer")
			var/obj/item/weapon/hammer/wo = new
			w = wo
		if(holding_weapon == "club")
			var/obj/item/weapon/club/wo = new
			w = wo
		var/mob/M = new
		M.loc = l.loc
		w.x = M.x; w.y = M.y; w.z = M.z
		if(cloth_type == "cloth")
			var/obj/item/armor/cloth/c = new(M.loc); M.Get(c); M.mob_equip("cloth")
			var/obj/bo
			var/new_boots = pick("copper","iron","steel")//var/obj/item/armor/boots/bo = new(M.loc); M.Get(bo); M.mob_equip("legs")
			switch(new_boots)
				if("copper") bo = new/obj/item/armor/boots/copper(M.loc)// = new(M.loc)
				if("iron") bo = new/obj/item/armor/boots/iron(M.loc)
				if("steel") bo = new/obj/item/armor/boots/steel(M.loc)
			M.Get(bo); M.mob_equip("legs")

		if(cloth_type == "full armor")
			var/obj/item/armor/cloth/c = new(M.loc); M.Get(c); M.mob_equip("cloth")
			var/obj/bo
			var/new_boots = pick("copper","iron","steel")//var/obj/item/armor/boots/bo = new(M.loc); M.Get(bo); M.mob_equip("legs")
			switch(new_boots)
				if("copper") bo = new/obj/item/armor/boots/copper(M.loc)// = new(M.loc)
				if("iron") bo = new/obj/item/armor/boots/iron(M.loc)
				if("steel") bo = new/obj/item/armor/boots/steel(M.loc)
			M.Get(bo); M.mob_equip("legs")

			var/obj/ha
			var/new_hand = pick("copper","iron","steel")
			switch(new_hand)//var/obj/item/armor/hands/ha = new(M.loc); M.Get(ha); M.mob_equip("hands")
				if("copper") ha = new/obj/item/armor/hands/copper(M.loc)
				if("iron") ha = new/obj/item/armor/hands/iron(M.loc)
				if("steel") ha = new/obj/item/armor/hands/steel(M.loc)
			M.Get(ha); M.mob_equip("hands")

			var/obj/he
			var/new_helm = pick("open_copper","open_iron","open_steel","closed_copper","closed_iron","closed_steel")
			switch(new_helm)
				if("open_copper") he = new/obj/item/armor/helmet/open_copper(M.loc)
				if("open_iron") he = new/obj/item/armor/helmet/open_iron(M.loc)
				if("open_steel") he = new/obj/item/armor/helmet/open_steel(M.loc)
				if("closed_copper") he = new/obj/item/armor/helmet/closed_copper(M.loc)
				if("closed_iron") he = new/obj/item/armor/helmet/closed_iron(M.loc)
				if("closed_steel") he = new/obj/item/armor/helmet/closed_steel(M.loc)//var/obj/item/armor/helmet/he = new(M.loc); M.Get(he); M.mob_equip("helmet")
			M.Get(he); M.mob_equip("helmet")

			var/obj/br
			var/new_breast = pick("fur_vest","scale_vest","chain_vest","copper_cuirass","iron_cuirass","steel_cuirass")
			switch(new_breast)//var/obj/item/armor/breastplate/br = new(M.loc); M.Get(br); M.mob_equip("armor")
				if("fur_vest") br = new/obj/item/armor/breastplate/fur_vest(M.loc)
				if("scale_vest")br = new/obj/item/armor/breastplate/scale_vest(M.loc)
				if("chain_vest")br = new/obj/item/armor/breastplate/chain_vest(M.loc)
				if("copper_cuirass")br = new/obj/item/armor/breastplate/copper_cuirass(M.loc)
				if("iron_cuirass")br = new/obj/item/armor/breastplate/iron_cuirass(M.loc)
				if("steel_cuirass")br = new/obj/item/armor/breastplate/steel_cuirass(M.loc)
			M.Get(br); M.mob_equip("armor")
		M.Get(w)
		M.draw_mob()
		if(guy_team == "1") M.team = "1"
		if(guy_team == "2") M.team = "2"
		if(guy_team == "player") M.team = "player"

proc/d3()
	var/d = rand(3,18)
	return d

mob/verb/puk()
	alpha =100

mob/var/list/Overlay/wound = list()
obj/wound
	icon = 'img/mob.dmi'
	icon_state = "wound"
	layer = MOB_LAYER+1

mob/verb/new_wounds()
	var/choose
	choose = input("Test") in list("make wound","del all wounds")
	if(choose == "make wound")
		var/icon/mask = new('img/mob.dmi',"torso_mask")
		var/mask_x = list()
		var/mask_y = list()
		var/megamask[32][32]
		var/counter
		for(var/i=1; i<33; i++)
			for(var/j = 1; j<33; j++)
				if(mask.GetPixel(i,j) != null)
					counter++
					megamask[i][j] = 1
					mask_x += i
					mask_y += j
		world<< counter
		var/icon/w = new('img/mob.dmi',"wound")
		var/wound_x = pick(mask_x); var/wound_y = pick(mask_y)
		w.Shift(NORTH,wound_y)
		w.Shift(EAST,wound_x)
		var/down = wound_y; var/sides = wound_x+1; var/before_turn = rand(2,4)
		spawn() techka(down, sides, before_turn, megamask, w)
		/*while(down>1 && megamask[sides][down] == 1)
			w.DrawBox(rgb(255,0,0),sides,down)
			down--
			before_turn--
			if(before_turn <1)
				sides = rand(sides-1,sides+1)
				before_turn = rand(2,4)
			sleep(1)
			wound = overlay(w)//wound = overlay(w.icon, w.icon_state)//wound = overlay('img/mob.dmi',"wound")
			*/

mob/proc/techka(var/down, var/sides, var/before_turn = rand(2,4), var/list/megamask, var/icon/w)
	while(down>1 && megamask[sides][down] == 1)
		w.DrawBox(rgb(180,0,0,200),sides,down)
		down--
		before_turn--
		if(before_turn <1)
			if(prob(50))
				sides = rand(sides-1,sides+1)
				before_turn = rand(2,4)
			else
				spawn() techka(down, sides, before_turn, megamask, w)
				sides = rand(sides-1,sides+1)
				before_turn = rand(2,4)
		sleep(2)
		wound = overlay(w)//wound = overlay(w.icon, w.icon_state)//wound = overlay('img/mob.dmi',"wound")