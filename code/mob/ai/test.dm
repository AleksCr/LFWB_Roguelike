mob/var/ai = 1
mob/var/team = "ai"
mob/var/has_task = 0

mob/Login()
	..()
	if(ckey != null)
		ai = 0
		team = "player"
	x = 255
	y = 255
	z = 255
	name = input("Напиши тут свой никнейм на латинице") as text
	if(name == "")
		name = "player"
	x = 1
	y = 1
	z = 1


var/bloodlust = 0
mob/verb/RAAGEEE()
	if(bloodlust == 1)
		bloodlust = 0
		world<< "Вскоре враги успокоятся"
	else
		bloodlust = 1
		world<< "Теперь они злятся"

client/verb/initiate_turn_based_mode()
	global_turn_base_mode = 1

mob/var/mob/target
//mob/var/turf/move_target
mob/var/list/targets = new()
var/turf/move_target_list = list()
mob/var/ai_imitate_human = 0

mob/New()
	..()
	spawn() found_task()

var/mob/ai_attack_delay = 0
var/mob/ai_move_delay = 0
var/mob/ai_reaction_time = 3
mob/proc/found_task()
	if(ai != 1)
		return
	else
		if(ai_attack_delay >= 0)
			ai_attack_delay -= ai_reaction_time
			if(ai_attack_delay < 0)
				ai_attack_delay = 0
		if(ai_move_delay >= 0)
			ai_move_delay -= ai_reaction_time
			if(ai_move_delay < 0)
				ai_move_delay = 0
	targets = null
	//bloodlust fighting
	if(ai_coolness == "dawn")
		if(bloodlust == 1 && has_task == 0 && alive == 1)
			for(var/mob/M in view(10, src))
				if(M.team != team && M.alive == 1)
					if(!targets) targets = new
					targets += M
			if(targets != null && target == null)
				target = pick(targets)
				world<< "[name] смотрит на [target.name]"
				say("Иди сюда - убивать тебя буду!")
				has_task = 1
				spawn() fight_ai()
	if(has_task == 0 && alive == 1) //imitate walking
		has_task = 1
		ai_imitate_walking()
		has_task = 0
		spawn(ai_reaction_time) found_task()

mob/proc/fight_ai()
	if(target != null && alive == 1)
		if(x != target.x || y != target.y)
			if(target.run == 1)
				run = 1
			else run = 0
			if(target.alive == 0)
				run = 0
				target = null
				has_task = 0
				spawn(ai_reaction_time) found_task()
				return
			if(!step_to(src,locate(target.x,target.y,1), 1) && get_dist(target,src) > 10)
				run = 0
				target = null
				has_task = 0
				spawn(ai_reaction_time) found_task()
			if(get_dist(target,src) == 1)
				if(prob(stamina*100/stamina_max)) attack(get_dir_a(target),get_dir_b(target))
				else spawn() defend(get_dir_a(target),get_dir_b(target))
				step_rand(src)
			sleep(ai_reaction_time)//sleep(calcutale_step())
			spawn() fight_ai()



mob/proc/ai_imitate_walking()
	if(prob(10))
		say("Мне приказали. Я делаю.")
	var/rand_x = rand(1, global_map_x)
	var/rand_y = rand(1, global_map_y)
	//var/current_x = x, current_y = y
	//var/patience = 3
	while(x != rand_x || y != rand_y)
		//if(patience<1) return
		if(!step_to(src,locate(rand_x,rand_y,1), 0)) return
		else step_to(src,locate(rand_x,rand_y,1), 0)
		sleep(calcutale_step())


////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
mob/proc/get_dir_a(var/mob/target)
	var/a
	if(get_dir(src,target) == NORTH)
		a = 0
	if(get_dir(src,target) == SOUTH)
		a = 0
	if(get_dir(src,target) == EAST)
		a = 1
	if(get_dir(src,target) == WEST)
		a = -1
	if(get_dir(src,target) == NORTHWEST)
		a = -1
	if(get_dir(src,target) == NORTHEAST)
		a = 1
	if(get_dir(src,target) == SOUTHWEST)
		a = -1
	if(get_dir(src,target) == SOUTHEAST)
		a = 1
	return a
mob/proc/get_dir_b(var/mob/target)
	var/b
	if(get_dir(src,target) == NORTH)
		b = 1
	if(get_dir(src,target) == SOUTH)
		b = -1
	if(get_dir(src,target) == EAST)
		b = 0
	if(get_dir(src,target) == WEST)
		b = 0
	if(get_dir(src,target) == NORTHWEST)
		b = 1
	if(get_dir(src,target) == NORTHEAST)
		b = 1
	if(get_dir(src,target) == SOUTHWEST)
		b = -1
	if(get_dir(src,target) == SOUTHEAST)
		b = -1
	return b