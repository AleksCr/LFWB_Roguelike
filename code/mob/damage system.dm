mob/var/list/bodyparts = list()
obj/bodypart
	icon = 'test.dmi'
obj/bodypart/human/head
obj/bodypart/human/right_arm
obj/bodypart/human/left_arm
obj/bodypart/human/right_leg
obj/bodypart/human/left_leg

mob/New()
	..()
	bodyparts += /obj/bodypart/human/head
	bodyparts += /obj/bodypart/human/right_arm
	bodyparts += /obj/bodypart/human/left_arm
	bodyparts += /obj/bodypart/human/right_leg
	bodyparts += /obj/bodypart/human/left_leg