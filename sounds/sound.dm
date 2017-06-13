///sounds folder

mob/proc/play_sound(sound/S as sound)
	for(var/mob/M in view(10))
		M<< S