obj/item/armor
	var
		coverage = 0
		min_damage = 0
	icon = 'test.dmi'
	Click()
		..()
		if(src.loc == usr) usr.client.UNEQUIP(src)
		usr.Get(src)

obj/item/armor/cloth
	icon_state = "cloth"
obj/item/armor/boots
	icon_state = "boots"
obj/item/armor/hands
	icon_state = "hands"
obj/item/armor/helmet
	icon_state = "helmet"
obj/item/holders
	Click()
		..()
		if(src.loc == usr) usr.client.UNEQUIP(src)
		usr.Get(src)

obj/item/holders/belt
	icon = 'test.dmi'
	icon_state = "belt"
obj/item/armor/breastplate
	min_damage = 3
	coverage = 70
	icon_state = "breastplate"