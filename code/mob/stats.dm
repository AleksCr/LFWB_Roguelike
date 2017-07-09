mob
	var
		dx = 10
		st = 10
		ht = 10
		int = 10
		lvl = 1
		base_speed = 5

mob/var/stamina_regen = 3

mob/proc/recalculate(var/update as num)
	hp_max = ht*3.5
	if(update)
		hp = hp_max
	stamina_max = ht*10
	if(update)
		stamina = stamina_max
	stamina_regen = ht/4
	if(update)
		for(var/obj/bodypart/human/b in bodyparts)
			b.hp_max = ht; b.slash_hp_max = ht / 3; b.hp = hp_max; b.slash_hp = b.slash_hp_max
	base_speed = (ht+dx)/4

