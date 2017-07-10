proc/mob_controller()
	for(var/mob/M in world)
		if(M.stamina < M.stamina_max)
			M.stamina += M.stamina_regen
			if(M.stamina > M.stamina_max)
				M.stamina = M.stamina_max
		if(!M.alive) continue
		for(var/var/obj/organ/lungs/lu in M.organs)
			if(lu.damaged == 0) continue
			M.hp -= 5
			var/str = pick('gasp_male1.ogg','gasp_male2.ogg','gasp_male3.ogg','gasp_male4.ogg','gasp_male5.ogg','gasp_male6.ogg','gasp_male7.ogg')
			var/sound/S = sound(pick(str))
			for(var/mob/MS in world)
				MS<<S
		if(M.blood< 300)
			M.hp -= 1
			var/str = pick('gasp_male1.ogg','gasp_male2.ogg','gasp_male3.ogg','gasp_male4.ogg','gasp_male5.ogg','gasp_male6.ogg','gasp_male7.ogg')
			var/sound/S = sound(pick(str))
			for(var/mob/MS in world)
				MS<<S
		if(M.bleed_size > 0)
			M.bleed(1)
		for(var/obj/bodypart/human/h in M.bodyparts)
			if(h.artery)
				M.bleed(2)
			if(istype(h,/obj/bodypart/human/head) && h.artery)
				M.bleed(3)
		if(M.right_arm_artery) M.bleed(2)
		if(M.left_arm_artery) M.bleed(2)
		if(M.right_leg_artery) M.bleed(2)
		if(M.left_leg_artery) M.bleed(2)
		if(M.hp <= 0)
			M.die()
		//if(M.ai == 1 && M.has_task == 0)
		//	spawn() M.found_task()