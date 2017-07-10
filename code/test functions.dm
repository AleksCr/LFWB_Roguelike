/*mob/verb/respawn()
	if(alive != 0)
		usr<< "Сначала нужно умереть"
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
	var/index = findtext(message, "я")
	while(index)
		message = copytext(message, 1, index) + "&#255;" + copytext(message, index+1)
		index = findtext(message, "я")
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
			usr<< "Тебе его не жалко?"
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
			var/obj/item/armor/boots/bo = new(M.loc); M.Get(bo); M.mob_equip("legs")
		if(cloth_type == "full armor")
			var/obj/item/armor/cloth/c = new(M.loc); M.Get(c); M.mob_equip("cloth")
			var/obj/item/armor/boots/bo = new(M.loc); M.Get(bo); M.mob_equip("legs")
			var/obj/item/armor/hands/ha = new(M.loc); M.Get(ha); M.mob_equip("hands")
			var/obj/item/armor/helmet/he = new(M.loc); M.Get(he); M.mob_equip("helmet")
			var/obj/item/armor/breastplate/br = new(M.loc); M.Get(br); M.mob_equip("armor")
		M.Get(w)
		M.draw_mob()
		if(guy_team == "1") M.team = "1"
		if(guy_team == "2") M.team = "2"
		if(guy_team == "player") M.team = "player"

proc/d3()
	var/d = rand(3,18)
	return d

//mob/verb/puk()
//	bleed()