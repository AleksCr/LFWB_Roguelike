mob/verb/town()
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

	<a href=byond://?src=\ref[src]&action=town_interface&value=Search>Обшарить/Шарить</a><br>
	Жить<br>
	Кутить<br>
	Творить<br>
	Служить<br>
	<a href=byond://?src=\ref[src]&action=town_interface&value=Home>Домой сходить</a><br>
	<a href=byond://?src=\ref[src]&action=town_interface&value=Teach>Учить</a><br>
	<a href=byond://?src=\ref[src]&action=town_interface&value=SellShop>Платить</a><br>
	Шалить<br>
	Валить<br>

      </body>
      </html>
    "}
	src<< browse(text,"window=hello;size=500x300")

mob/Topic(href, list/href_list)
	..()
	var/action = href_list["value"]
	if(action == "Search")
		z = 1
		var/obj/ladder/L = new(src.loc)
		L.gen_caves()
	if(action == "Home")
		z = 2
	if(action == "Teach")
		teach()
	if(action == "SellShop")
		shop()

obj/item/Topic(href, list/href_list)
	..()
	var/action = href_list["value"]
	if(action == "Sell")
		usr.backpack -= src
		usr.shop()
		usr.coins += value
		del src


mob/proc/shop()
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

	<table border="1" width="100%" cellpadding="5">
    "}

	for(var/obj/item/i in src.backpack)
		src << browse_rsc(icon(i.icon, i.icon_state), "[i.name]item.png")
		text += "<tr><th>"
		text += {"<img src="[i.name]item.png" width="32px" height="32px" /> [i.name]<br> <a href=byond://?src=\ref[i]&value=Sell>Продать</a><br>"}
		text += "[i.desc]<br>"
		text += "Цена: [i.value]"
		text += "</th></tr>"
	text+= {"
 </table>

      </body>
      </html>
"}
	src<< browse(text,"window=hello;size=500x300")









/*mob/verb/say(message as text)
	var/index = findtext(message, "�")
	while(index)
		message = copytext(message, 1, index) + "&#255;" + copytext(message, index+1)
		index = findtext(message, "�")
	world<< "[name] says, [message]"*/