proc/mob_controller()
	for(var/mob/M in world)
		if(M.stamina < M.stamina_max)
			M.stamina += M.stamina_regen
			if(M.stamina > M.stamina_max)
				M.stamina = M.stamina_max
		if(M.bleed_size > 0)
			M.bleed()
		//if(M.ai == 1 && M.has_task == 0)
		//	spawn() M.found_task()