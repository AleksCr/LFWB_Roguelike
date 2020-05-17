var/birth_limit = 4
var/death_limit = 3
var/num_of_steps = 2
var/inital_chance = 40

obj/ladder
	icon = 'img/caves.dmi'
	icon_state = "ladder"
	Click()
		..()
		gen_caves()

obj/item/ore
	icon = 'img/caves.dmi'
	Click(var/mob/M)
		usr.Get(src)
obj/item/ore/copper
	icon_state = "copper_ore"
obj/item/ore/iron
	icon_state = "iron_ore"
obj/item/ore/silver
	icon_state = "silver_ore"
obj/item/coal
	icon = 'img/caves.dmi'
	icon_state = "coal"
	Click(var/mob/M)
		usr.Get(src)
obj/item/stone
	icon = 'img/caves.dmi'
	icon_state = "stone"
	Click(var/mob/M)
		usr.Get(src)


obj/wall/cave
	icon = 'img/caves.dmi'
	icon_state = "wall"
	density = 1
	opacity = 0
	Click()
		..()
		if(get_dist(src,usr) == 1 && usr.stamina > 30)
			usr.stamina -= 30
			var/r = rand(1,4)
			if(prob(20))
				if(r==1) new/obj/item/ore/copper(src.loc)
				if(r==2) new/obj/item/ore/iron(src.loc)
				if(r==3) new/obj/item/ore/silver(src.loc)
				if(r==4) new/obj/item/coal(src.loc)
			else new/obj/item/stone(src.loc)
			usr.grind_skill("mining")
			del src


obj/cell_automato
	var/cell_is_alive = 0
	var/cell_is_alive_processing = 0
	icon = 'test.dmi'; //icon_state = "background"
	alpha=100
	proc/count_cells()
		var/i = 0
		for(var/obj/cell_automato/C in range(1,src))
			if(C.cell_is_alive)
				i++
		return i
obj/floor/cave
	icon = 'img/caves.dmi'
	icon_state = "floor"

obj/green/bush
	icon = 'img/caves.dmi'
	icon_state = "bush"
	Click()
		del src

obj/item/log
	icon = 'img/caves.dmi'
	icon_state = "log"
obj/green/bigshroom
	icon = 'img/caves.dmi'
	icon_state = "bigshroom"
	Click()
		new/obj/item/log(src.loc)
		del src
obj/green/smallshroom
	icon = 'img/caves.dmi'
	icon_state = "smallshroom"
	New()
		..()
		icon_state = pick("smallshroom","smallshroom1","smallshroom2","smallshroom3","smallshroom4")
obj/spawn_point


obj/ladder/proc/gen_caves()
	var/inter_point_x = x; var/inter_point_y = y;
	x = rand(3,mapx); y = rand(4,mapy)
	clear_map()
	for(var/obj/floor/cave/f in world)
		var/obj/cell_automato/C = new(f.loc)
		if(prob(inital_chance))
			C.cell_is_alive = 1
			//C.icon_state = "background2"
			C.cell_is_alive_processing = 1

	for(var/i = 0; i<num_of_steps; i++)
		cave_cell_sim_step()
	////SIMULATION STEP
	//последовательно для каждого объекта клеток проверяем по алгоритму состояние и убиваем/оживляем/не трогаем этот объект
	//правила проверки:
	//1 - Если у !живой! клетки меньше 2 соседей, она умирает
	//2 - Если у !живой! клетки 2 или 3 соседа, она остается живой
	//3 - Если у !живой! клетки больше 3 соседей, она умирает
	//4 - Если у !мертвой! клетки ровно 3 соседа, она оживает


	//Рисуем пещеры, удаляем автоматы
	for(var/obj/cell_automato/C in world)
		if(C.cell_is_alive) new/obj/wall/cave(C.loc)
	for(var/obj/cell_automato/C in world) del C

	//Рисуем пещерную растительность
	for(var/obj/floor/cave/f in world)
		var/obj/wall/cave/WW = null
		for(var/obj/wall/cave/W in range(0,f))
			WW = W
			continue
		if(WW!=null)
			continue
		if(prob(15))
			var/list/green = list("bush","bigshroom","smallshroom")
			var/r = pick(green)
			switch(r)
				if("bush")
					new/obj/green/bush(f.loc)
				if("bigshroom")
					new/obj/green/bigshroom(f.loc)
				if("smallshroom")
					new/obj/green/smallshroom(f.loc)

	for(var/obj/wall/cave/C in range (0,src))
		del C

	//Перемещаем игроков
	var/ingen = 0
	var/obj/exit/e = new; e.x = inter_point_x; e.y = inter_point_y; e.z = 1
	for(var/mob/M in world)
		if(!M.ai && M.alive)
			M.x = inter_point_x; M.y = inter_point_y
		else del M
		if(!ingen)
			ingen = 1
			for(var/obj/wall/cave/C in range (1,M))
				del C


	//делаем дырки-спавн-точки с мобами
	for(var/i =0;i<1;i++)
		var/obj/spawn_point/SP = new (locate(rand(1,mapx),rand(1,mapy),1))
		for(var/obj/wall/cave/C in range (1,SP)) del C
		spawn() spawn_special_ai(SP,1, pick("bare hands","dagger","sword","axe","spear","hammer","club"), pick("nothing","cloth","full armor"), 1) //pick("nothing","cloth","full_armor"), 1)

proc/clear_map()
	for(var/obj/exit/E in world)
		if(E.z != 1) continue
		del E
	for(var/obj/wall/cave/W in world) del W//Удаляем пещеры и чистим массив состояний клеток, сохранившиеся с прошлой генерации
	for(var/obj/green/G in world) del G
	for(var/obj/workshop/W in world) del W
	for(var/obj/choped_limb/L in world) del L
	for(var/obj/vomit/W in world) del W
	for(var/obj/item/i in world)
		if(i.z != 1) continue
		if(!istype(i.loc,/mob))
			del i

proc/cave_cell_sim_step()
	for(var/obj/cell_automato/C in world)
		//sleep(0.1)
		//world<< "[C.x] [C.y]"
		if(C.cell_is_alive)
			if(C.count_cells() < death_limit)
				C.cell_is_alive_processing = 0
			else
				C.cell_is_alive_processing = 1
		else
			if(C.count_cells() > birth_limit)
				C.cell_is_alive_processing = 1
			else
				C.cell_is_alive_processing = 0
		C.cell_is_alive = C.cell_is_alive_processing
		//if(!C.cell_is_alive) C.icon_state = "background"
		//if(C.cell_is_alive) C.icon_state = "background2"
