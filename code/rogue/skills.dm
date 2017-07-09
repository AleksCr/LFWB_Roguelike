datum/skill
	var
		skill_name
		skill_lvl = 0
		progress = 0
		learn_mdf
	proc
		return_lvl_txt()
			var/txtret
			switch(skill_lvl)
				if(0)
					txtret = "Жалкий"
				if(1)
					txtret = "Новичок"
				if(2)
					txtret = "Неопытный"
				if(3)
					txtret = "Опытный"
				if(4)
					txtret = "Опытный"
				if(5)
					txtret = "Адепт"
				if(6)
					txtret = "Адепт"
				if(7)
					txtret = "Эксперт"
				if(8)
					txtret = "Мастер"
				if(9)
					txtret = "Мастер"
				if(10)
					txtret = "Легендарный"
			return txtret

		grinding()
			var/progress_text = "Я учусь: "
			progress += 5
			if(progress > 0 && progress < 100)
				var/stars = progress/10
				var/points = 10
				for(var/i = 100; i>0; i-=10)
					while(stars>0)
						progress_text += "*"
						stars--; points--
					while(points>0)
						progress_text += "."
						points--
			usr<< progress_text
			if(progress >= 100)
				usr<< "Мой навык заметно улучшилс&#255;!"
				progress = 0
				skill_lvl++

datum/skill/mining
	skill_name = "Шахтерство"
datum/skill/melee
	skill_name = "Ближний бой"
datum/skill/sword
	skill_name = "Мечи"
datum/skill/spear
	skill_name = "Копь&#255;"
datum/skill/axe
	skill_name = "Топоры"
datum/skill/dagger
	skill_name = "Ножи"
datum/skill/club
	skill_name = "Дубинки"

mob/proc/grind_skill(var/skill)
	switch(skill)
		if("mining")
			for(var/datum/skill/mining/mining in skills)
				mining.grinding()
		if("melee")
			for(var/datum/skill/melee/melee in skills)
				melee.grinding()
		if("sword")
			for(var/datum/skill/sword/sword in skills)
				sword.grinding()
		if("spear")
			for(var/datum/skill/spear/spear in skills)
				spear.grinding()
		if("axe")
			for(var/datum/skill/axe/axe in skills)
				axe.grinding()
		if("dagger")
			for(var/datum/skill/dagger/dagger in skills)
				dagger.grinding()
		if("club")
			for(var/datum/skill/club/club in skills)
				club.grinding()

mob/verb/check_my_skills()
	for(var/datum/skill/s in skills)
		usr<< "[s.skill_name] : [s.return_lvl_txt()]"


mob/var/list/skills = list()
mob
	New()
		..()
		var/datum/skill/melee/melee = new; skills += melee; //melee.skill_lvl = 10
		var/datum/skill/sword/sword = new; skills += sword
		var/datum/skill/spear/spear = new; skills += spear
		var/datum/skill/axe/axe = new; skills += axe
		var/datum/skill/dagger/dagger = new; skills += dagger
		var/datum/skill/club/club = new; skills += club

		var/datum/skill/mining/mining = new; skills += mining
