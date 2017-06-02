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
	x = 1
	y = 1
	z = 1


var/bloodlust = 0
mob/verb/RAAGEEE()
	world<< "РЯЯЯЯЯЯЯЯЯЯЯЯ"
	if(bloodlust == 1)
		bloodlust = 0
	else bloodlust = 1

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
			for(var/mob/M in view(14, src))
				if(M.team != team && M.alive == 1)
					if(!targets) targets = new
					targets += M
			if(targets != null && target == null)
				target = pick(targets)
				world<< "[name] смотрит на [target.name]"
				say("Иди сюда - убивать тебя буду!")
				has_task = 1
		if(target != null && alive == 1)
			if(ai_imitate_human != 1) // НА РЕСТАРВРАЦИИ
				while(x != target.x || y != target.y)
					if(target.run == 1)
						run = 1
					else run = 0
					if(target.alive == 0)
						run = 0
						target = null
						has_task = 0
						return
					step_to(src,locate(target.x,target.y,1), 1)
					if(get_dist(target,src) == 1)
						attack(get_dir_a(target),get_dir_b(target))
					sleep(calcutale_step())
			else
				if(prob(70))
					var/turf/move_target
					for(var/turf/T in view(3,target))
						if(get_dist(src, T) < 2) continue
						if(!move_target_list) move_target_list = new
						move_target_list += T
					move_target = pick(move_target_list)
					move_target_list = null
					if(x != move_target.x || y != move_target.y)
						if(ai_move_delay == 0)
							step_to(src,locate(move_target.x,move_target.y,1), 1)
							ai_move_delay += calcutale_step()
						if(ai_attack_delay <= 0 || get_dist(src, target) == 1)
							attack(get_dir_a(target),get_dir_b(target))
							ai_attack_delay += 10
						has_task = 0
				else
					if(x != target.x || y != target.y)
						if(target.run == 1 && stamina > stamina_max/2)
							run = 1
						else run = 0
						if(target.alive == 0)
							run = 0
							target = null
							has_task = 0
							return
						if(ai_move_delay == 0)
							step_to(src,locate(target.x,target.y,1), 1)
							if(get_dist(target,src) == 1)
								if(ai_attack_delay <= 0)
									attack(get_dir_a(target),get_dir_b(target))
									ai_attack_delay += 10
									has_task = 0
		if(has_task == 0 && alive == 1) //imitate walking
			has_task = 1
			ai_imitate_walking()
			has_task = 0
	/*if(ai_coolness == "oligofren")
		if(bloodlust == 1 && has_task == 0)
			for(var/mob/M in view(14, src))
				if(M.team != team && M.alive == 1)
					if(!targets) targets = new
					targets += M
			if(targets != null)
				target = pick(targets)
				world<< "[name] смотрит на [target.name]"
				say("Я тя щас выебу иди сюда сука.")
				has_task = 1
		if(target != null && alive == 1)
			while(x != target.x || y != target.y)
				if(target.alive == 0)
					target = null
					has_task = 0
					return
				step_to(src,locate(target.x,target.y,1), 1)
				if(get_dist(target,src) == 1)
					attack(get_dir_a(target),get_dir_b(target))
				sleep(calcutale_step())
		if(has_task == 0) //imitate walking
			has_task = 1
			ai_imitate_walking()
			has_task = 0*/
	spawn(ai_reaction_time) found_task()

//уровни ИИ: Даун->Олигофрен->Дебил->Почти человек->Среднячок->Смертоносный->Демон
/*
Даун - ходит по прямой и пиздит. Ноу моар
Олигофрен - может ставить блоки, если в него целят, рашит бегом, если стамина >70
Дебил - держится на расстоянии, имитируя человечка
Почти человек - поумнее, побыстрее
Среднячок - Не отстаёт от человека характеристиками
Смертоносный - Один на один запиздит чуть ли не любого
Демон - может сражаться с несколькими противниками, ограничен только своими физическими статами. При наличии бесконечной стаминки теоритически способен запиздить произвольное кол-во игроков, атакующих его.
*/

mob/proc/ai_imitate_walking()
	if(prob(10))
		say("Мне приказали. Я делаю.")
	var/rand_x = rand(1, 14)
	var/rand_y = rand(1, 14)
	while(x != rand_x || y != rand_y)
		step_to(src,locate(rand_x,rand_y,1), 0)
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