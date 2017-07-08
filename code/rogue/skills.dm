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
			world<< "PROGRESS = [progress]"
			if(progress > 10 && progress < 100)
				var/stars = progress/10
				var/points = 10
				for(var/i = 100; i>0; i-=10)
					world<< "podozritelno"
					while(stars>0)
						world<< "test"
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

mob/proc/grind_skill(var/skill)
	switch(skill)
		if("mining")
			for(var/datum/skill/mining/mining in skills)
				mining.grinding()

mob/verb/check_my_skills()
	for(var/datum/skill/s in skills)
		usr<< "[s.skill_name] : [s.return_lvl_txt()]"


mob/var/list/skills = list()
mob
	New()
		..()
		var/datum/skill/mining/mining = new
		skills += mining
