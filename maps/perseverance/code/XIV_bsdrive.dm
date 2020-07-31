/obj/machinery/bluespacedrive
	name = "Bluespace drive"
	desc = "This complex device permits a safe entry into bluespace."
	icon = 'maps/perseverance/icons/bsdrive.dmi'
	icon_state = "dmdrive_base"//for mapping, shouldn't be used in general
	density = 1
	anchored = 1
	var/gauge_icon = null
	var/phcheck = 0//checks phoron
	var/busycheck = 0//dont want people wrenching/poking it while we're jumping
	var/mode = 0 //1 is active, acively takes phoron from the air, takes minor coordination for a massive speed increase.
	// 0 is passive, it requires some phoron to be present only when jumping, but also needs a much longer spoolup time .

/obj/machinery/bluespacedrive/Process()

	var/turf/T=get_turf(src)
	var/datum/gas_mixture/air = T.return_air()
	var/phinair = air.gas[GAS_PHORON]

	if (phinair > 55)
		phcheck = 1
		if (phinair > 55)
			overlays = list("ind1")
		if (phinair > 65)
			overlays = list("ind2")
		if (phinair > 75)
			overlays = list("ind3")
		if (phinair > 85)
			overlays = list("ind4")
		if (phinair > 95)
			overlays = list("uhoh")
			phcheck = 2
	else
		phcheck = 0
		overlays = list("ind0")
//I did the indicator wrong, thankfully we have overlays


/obj/machinery/bluespacedrive/attackby(obj/item/P as obj, mob/user as mob)

	if(busycheck != 0)
		user.visible_message("[user] attempts to unwrench the anchoring bolts on [src], but they don't budge.", "You try unwrenching the anchoring bolts, but they don't budge.")
		return
	if(isWrench(P))
		if(anchored == 1)
			user.visible_message("[user] begins unwrenching the anchoring bolts on [src].", "You begin unwrenching the anchoring bolts...")
		else
			user.visible_message("[user] begins wrenching the anchoring bolts on [src].", "You begin wrenching the anchoring bolts...")
		if(do_after(user, 50, src))
			if(!src || !user) return
			if(anchored == 1)
				user.visible_message("[user] unwrenches the anchoring bolts on [src].", "You unwrench the anchoring bolts.")
				anchored = 0
			else
				user.visible_message("[user] wrenches the anchoring bolts on [src].", "You wrench the anchoring bolts.")
				anchored = 1

/obj/machinery/bluespacedrive/physical_attack_hand(mob/user)

	if(busycheck == 0 && anchored == 1)
		user.visible_message("[user] flips the control switch on [src].", "You flip the control switch.")
		if (mode == 1)
			mode = 0
		if (mode == 0)
			mode = 1