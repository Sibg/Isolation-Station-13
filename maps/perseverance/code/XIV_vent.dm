//Vents, lotsa code so I guess I better put it in a seperate part

/obj/structure/vent
	name = "vent"
	desc = "A vent. Watch your step."
	icon_state = "old"
	icon = 'maps/perseverance/icons/vent.dmi'
	density = 0
	opacity = 0
	anchored = 1
	obj_flags = OBJ_FLAG_NOFALL

	var/allowed_directions = DOWN
	var/obj/structure/vent/target_up
	var/obj/structure/vent/target_down

	var/const/climb_time = 2 SECONDS
	var/static/list/climbsounds = list('sound/effects/ladder.ogg','sound/effects/ladder2.ogg','sound/effects/ladder3.ogg','sound/effects/ladder4.ogg')

/obj/structure/vent/Initialize()
	. = ..()
	// the upper will connect to the lower
	if(allowed_directions & DOWN) //we only want to do the top one, as it will initialize the ones before it.
		for(var/obj/structure/vent/L in GetBelow(src))
			if(L.allowed_directions & UP)
				target_down = L
				L.target_up = src
//				var/turf/T = get_turf(src)
//				T.ReplaceWithLattice() (why???)
				return
	update_icon()


	set_extension(src, /datum/extension/turf_hand)


/obj/structure/vent/Destroy()
	if(target_down)
		target_down.target_up = null
		target_down = null
	if(target_up)
		target_up.target_down = null
		target_up = null
	return ..()

/obj/structure/vent/attackby(obj/item/I, mob/user)
	climb(user, I)

/turf/hitby(atom/movable/AM)
	if(isobj(AM))
		var/obj/structure/vent/L = locate() in contents
		if(L)
			L.hitby(AM)
			return
	..()

/obj/structure/vent/hitby(obj/item/I)
	if (istype(src, /obj/structure/vent/up))
		return
	var/area/room = get_area(src)
	if(!room.has_gravity())
		return
	var/atom/blocker
	var/turf/landing = get_turf(target_down)
	for(var/atom/A in landing)
		if(!A.CanPass(I, I.loc, 1.5, 0))
			blocker = A
			break
	if(blocker)
		visible_message(SPAN_WARNING("\The [I] fails to go down \the [src], blocked by the [blocker]!"))
	else
		visible_message(SPAN_WARNING("\The [I] goes down \the [src]!"))
		I.forceMove(landing)
		landing.visible_message(SPAN_WARNING("\The [I] falls from the top of \the [target_down]!"))

/obj/structure/vent/attack_hand(var/mob/M)
	climb(M)

/obj/structure/vent/attack_ai(var/mob/M)
	var/mob/living/silicon/ai/ai = M
	if(!istype(ai))
		return
	var/mob/observer/eye/AIeye = ai.eyeobj
	if(istype(AIeye))
		instant_climb(AIeye)

/obj/structure/vent/attack_robot(var/mob/M)
	climb(M)

/obj/structure/vent/proc/instant_climb(var/mob/M)
	var/atom/target_vent = getTargetVent(M)
	if(target_vent)
		M.dropInto(target_vent.loc)

/obj/structure/vent/proc/climb(mob/M, obj/item/I = null)
	var/area/area = get_area(usr)

	if(allowed_directions == UP && area.has_gravity() && !usr.can_overcome_gravity()) // What in the world makes you think I know what I'm doing?
		to_chat(usr, "<span class='warning'>Gravity stops you from moving upward.</span>")
		return

	if(!M.may_climb_vents(src))
		return

	add_fingerprint(M)
	var/obj/structure/vent/target_vent = getTargetVent(M)
	if(!target_vent)
		return
	if(!M.Move(get_turf(src)))
		to_chat(M, "<span class='notice'>You fail to reach \the [src].</span>")
		return

	for (var/obj/item/grab/G in M)
		G.adjust_position()

	var/direction = target_vent == target_up ? "up" : "down"

	M.visible_message("<span class='notice'>\The [M] begins climbing [direction] \the [src]!</span>",
	"You begin climbing [direction] \the [src]!",
	"You hear the grunting and clanging of a vent being climbed.")

	target_vent.audible_message("<span class='notice'>You hear something coming [direction] \the [src]</span>")

	if(do_after(M, climb_time, src))
		climbVent(M, target_vent, I)
		for (var/obj/item/grab/G in M)
			G.adjust_position(force = 1)

/obj/structure/vent/attack_ghost(var/mob/M)
	instant_climb(M)

/obj/structure/vent/proc/getTargetVent(var/mob/M)
	if((!target_up && !target_down) || (target_up && !istype(target_up.loc, /turf/simulated/open) || (target_down && !istype(target_down.loc, /turf))))
		to_chat(M, "<span class='notice'>\The [src] is incomplete and can't be climbed.</span>")
		return
	if(target_down && target_up)
		var/direction = alert(M,"Do you want to go up or down?", "Vent", "Up", "Down", "Cancel")

		if(direction == "Cancel")
			return

		if(!M.may_climb_vents(src))
			return

		switch(direction)
			if("Up")
				return target_up
			if("Down")
				return target_down
	else
		return target_down || target_up

/mob/proc/may_climb_vents(var/vent)
	if(!Adjacent(vent))
		to_chat(src, "<span class='warning'>You need to be next to \the [vent] to start climbing.</span>")
		return FALSE
	if(incapacitated())
		to_chat(src, "<span class='warning'>You are physically unable to climb \the [vent].</span>")
		return FALSE

	var/carry_count = 0
	for(var/obj/item/grab/G in src)
		if(!G.ladder_carry())
			to_chat(src, "<span class='warning'>You can't carry [G.affecting] up \the [vent].</span>")
			return FALSE
		else
			carry_count++
	if(carry_count > 1)
		to_chat(src, "<span class='warning'>You can't carry more than one person up \the [vent].</span>")
		return FALSE

	return TRUE

/mob/observer/ghost/may_climb_vents(var/vent)
	return TRUE

/obj/structure/vent/proc/climbVent(mob/user, target_vent, obj/item/I = null)
	var/turf/T = get_turf(target_vent)
	for(var/atom/A in T)
		if(!A.CanPass(user, user.loc, 1.5, 0))
			to_chat(user, "<span class='notice'>\The [A] is blocking \the [src].</span>")

			//We cannot use the vent, but we probably can remove the obstruction
			var/atom/movable/M = A
			if(istype(M) && M.movable_flags & MOVABLE_FLAG_Z_INTERACT)
				if(isnull(I))
					M.attack_hand(user)
				else
					M.attackby(I, user)

			return FALSE

	playsound(src, pick(climbsounds), 50)
	playsound(target_vent, pick(climbsounds), 50)
	return user.Move(T)

/obj/structure/vent/CanPass(obj/mover, turf/source, height, airflow)
	return airflow || !density

//defining the actual vents

/obj/structure/vent/down
	desc = "It's a vent. Watch your step, yeah?"
	allowed_directions = DOWN

/obj/structure/vent/down/distribution
	icon_state = "ventdist"

/obj/structure/vent/down/scrubbing
	icon_state = "ventscrub"

//up we go

/obj/structure/vent/up
	desc = "It's a vent. Really dark up there."
	allowed_directions = UP
	alpha = 60

/obj/structure/vent/up/distribution
	icon_state = "ventdist"

/obj/structure/vent/up/scrubbing
	icon_state = "ventscrub"