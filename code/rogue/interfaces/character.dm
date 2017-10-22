mob/var/coins = 0
mob/var/exp_for_up = 1000
mob/var/cur_exp = 0
mob/var/level_points = 0

mob/var/list/backpack = list()
mob/verb/put_in_backpack()
	for(var/obj/item/o in orange(1))
		backpack += o
		o.loc = backpack
mob/verb/take_from_backpack()
	var/obj/o = input("Choose item") in backpack
	if(!o) return
	backpack -= o
	o.loc = src.loc

mob/verb/character_info()
	var/text = {"
      <html>
      <head>
        <style>
          body {
            background-color: '#696969';
            color: '#ffffff'
          }
        </style>
      </head>
      <body>

	name: [name]<br>
	coins: [coins]<br>
	kills: [kill_count]<br><br>

	st: [st]<br>
	dx: [dx]<br>
	ht: [ht]<br><br>

	<a href=byond://?src=\ref[src]&action=town_interface&value=lvl_window>lvl_up</a>

      </body>
      </html>
	"}
	src<< browse(text,"window=hello;size=500x300")

mob/proc/level_up()
	var/text = {"
      <html>
      <head>
        <style>
          body {
            background-color: '#696969';
            color: '#ffffff'
          }
        </style>
      </head>
      <body>
	free points: [level_points]

	st: [st] <a href=byond://?src=\ref[src]&action=town_interface&value=upst>up</a>
	dx: [dx] <a href=byond://?src=\ref[src]&action=town_interface&value=updx>up</a>
	ht: [ht] <a href=byond://?src=\ref[src]&action=town_interface&value=upht>up</a>



      </body>
      </html>
	"}
	src<< browse(text,"window=hello;size=500x300")

mob/proc/teach()
	var/text = {"
      <html>
      <head>
        <style>
          body {
            background-color: '#696969';
            color: '#ffffff'
          }
        </style>
      </head>
      <body>
	<a href=byond://?src=\ref[src]&value=teach_melee>melee</a><br>
	<a href=byond://?src=\ref[src]&value=teach_sword>sword</a><br>
	<a href=byond://?src=\ref[src]&value=teach_spear>spear</a><br>
	<a href=byond://?src=\ref[src]&value=teach_axe>axe</a><br>
	<a href=byond://?src=\ref[src]&value=teach_dagger>knife</a><br>
	<a href=byond://?src=\ref[src]&value=teach_club>club</a><br>

      </body>
      </html>
"}
	src<< browse(text,"window=hello;size=500x300")

mob/Topic(href, list/href_list)
	..()
	var/action = href_list["value"]
	if(action == "lvl_window")
		level_up()
	if(action == "upst")
		st++; recalculate(1); level_up()
	if(action == "updx")
		dx++; recalculate(1); level_up()
	if(action == "upht")
		ht++; recalculate(1); level_up()
	if(action == "teach_melee")
		for(var/datum/skill/melee/melee in skills)
			melee.skill_lvl++; usr<< "Мой навык заметно улучшилс&#255;!"; melee.progress = 0
	if(action == "teach_sword")
		for(var/datum/skill/sword/sword in skills)
			sword.skill_lvl++; usr<< "Мой навык заметно улучшилс&#255;!"; sword.progress = 0
	if(action == "teach_spear")
		for(var/datum/skill/spear/spear in skills)
			spear.skill_lvl++; usr<< "Мой навык заметно улучшилс&#255;!"; spear.progress = 0
	if(action == "teach_axe")
		for(var/datum/skill/axe/axe in skills)
			axe.skill_lvl++; usr<< "Мой навык заметно улучшилс&#255;!"; axe.progress = 0
	if(action == "teach_dagger")
		for(var/datum/skill/dagger/dagger in skills)
			dagger.skill_lvl++; usr<< "Мой навык заметно улучшилс&#255;!"; dagger.progress = 0
	if(action == "teach_club")
		for(var/datum/skill/club/club in skills)
			club.skill_lvl++; usr<< "Мой навык заметно улучшилс&#255;!"; club.progress = 0