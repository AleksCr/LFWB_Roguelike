mob
	var
		dx = 10
		st = 10
		ht = 10
		int = 10
		lvl = 1

mob/var/stamina_regen = 3

mob/proc/recalculate(var/update as num)
	hp_max = ht*3.5
	if(update)
		hp = hp_max
	stamina_max = ht*10
	if(update)
		stamina = stamina_max
	stamina_regen = ht/4

