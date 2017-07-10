mob
	var
		dx = 10
		st = 10
		ht = 10
		int = 10
		lvl = 1
		base_speed = 5

mob/var/stamina_regen = 3

mob/verb/calculate_base_damage()//var/swing as num)
	var/dam
	if(1)//swing)
		switch(st)
			if(1)	dam = roll(1,6)-5
			if(2)	dam = roll(1,6)-5
			if(3)	dam = roll(1,6)-4
			if(4)	dam = roll(1,6)-4
			if(5)	dam = roll(1,6)-3
			if(6)	dam = roll(1,6)-3
			if(7)	dam = roll(1,6)-2
			if(8)	dam = roll(1,6)-2
			if(9)	dam = roll(1,6)-1
			if(10)	dam = roll(1,6)
			if(11)	dam = roll(1,6)+1
			if(12)	dam = roll(1,6)+2
			if(13)	dam = roll(2,6)-1
			if(14)	dam = roll(2,6)
			if(15)	dam = roll(2,6)+1
			if(16)	dam = roll(2,6)+2
			if(17)	dam = roll(3,6)-1
			if(18)	dam = roll(3,6)
			if(19)	dam = roll(3,6)+1
			if(20)	dam = roll(3,6)+2
			if(21)	dam = roll(4,6)-1
			if(22)	dam = roll(4,6)
			if(23)	dam = roll(4,6)+1
			if(24)	dam = roll(4,6)+2
			if(25)	dam = roll(5,6)-1
			if(26)	dam = roll(5,6)
			if(27)	dam = roll(5,6)+1
			if(28)	dam = roll(5,6)+1
			if(29)	dam = roll(5,6)+2
			if(30)	dam = roll(5,6)+2
			if(31)	dam = roll(6,6)-1
			if(32)	dam = roll(6,6)-1
			if(33)	dam = roll(6,6)
			if(34)	dam = roll(6,6)
			if(35)	dam = roll(6,6)+1
			if(36)	dam = roll(6,6)+1
			if(37)	dam = roll(6,6)+2
			if(38)	dam = roll(6,6)+2
			if(39)	dam = roll(7,6)-1
			if(40)	dam = roll(7,6)-1
		if(st>40) 	dam = roll(7,6)-1
	else
		switch(st)
			if(1)	dam = roll(1,6)-6
			if(2)	dam = roll(1,6)-6
			if(3)	dam = roll(1,6)-5
			if(4)	dam = roll(1,6)-5
			if(5)	dam = roll(1,6)-4
			if(6)	dam = roll(1,6)-4
			if(7)	dam = roll(1,6)-3
			if(8)	dam = roll(1,6)-3
			if(9)	dam = roll(1,6)-2
			if(10)	dam = roll(1,6)-2
			if(11)	dam = roll(1,6)-1
			if(12)	dam = roll(1,6)-1
			if(13)	dam = roll(1,6)
			if(14)	dam = roll(1,6)
			if(15)	dam = roll(1,6)+1
			if(16)	dam = roll(1,6)+1
			if(17)	dam = roll(1,6)+2
			if(18)	dam = roll(1,6)+2
			if(19)	dam = roll(2,6)-1
			if(20)	dam = roll(2,6)-1
			if(21)	dam = roll(2,6)
			if(22)	dam = roll(2,6)
			if(23)	dam = roll(2,6)+1
			if(24)	dam = roll(2,6)+1
			if(25)	dam = roll(2,6)+2
			if(26)	dam = roll(2,6)+2
			if(27)	dam = roll(3,6)-1
			if(28)	dam = roll(3,6)-1
			if(29)	dam = roll(3,6)
			if(30)	dam = roll(3,6)
			if(31)	dam = roll(3,6)+1
			if(32)	dam = roll(3,6)+1
			if(33)	dam = roll(3,6)+2
			if(34)	dam = roll(3,6)+2
			if(35)	dam = roll(4,6)-1
			if(36)	dam = roll(4,6)-1
			if(37)	dam = roll(4,6)
			if(38)	dam = roll(4,6)
			if(39)	dam = roll(4,6)+1
			if(40)	dam = roll(4,6)+1
		if(st>40)	dam = roll(4,6)+1
		dam = 0
	if(dam<0) dam = 0
	world<< "uron = [dam]"
	return dam

mob/proc/recalculate(var/update as num)
	hp_max = st
	if(update)
		hp = hp_max
	stamina_max = ht*10
	if(update)
		stamina = stamina_max
	stamina_regen = ht/4
	if(update)
		for(var/obj/bodypart/human/b in bodyparts)
			b.hp_max = st; b.slash_hp_max = st; b.hp = hp_max; b.slash_hp = b.slash_hp_max
	base_speed = (ht+dx)/4

