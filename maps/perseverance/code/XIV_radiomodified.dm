// This is an override, but uh, I can't override it without copying everything, actual change is at line 160

/obj/item/device/radio/talk_into(mob/living/M, message, channel, var/verb = "says", var/datum/language/speaking = null)
	if(!on) return 0 // the device has to be on
	//  Fix for permacell radios, but kinda eh about actually fixing them.
	if(!M || !message) return 0

	if(speaking && (speaking.flags & (NONVERBAL|SIGNLANG))) return 0

	if (!broadcasting)
		// Sedation chemical effect should prevent radio use (Chloral and Soporific)
		var/mob/living/carbon/C = M
		if ((istype(C)) && (C.chem_effects[CE_SEDATE] || C.incapacitated(INCAPACITATION_DISRUPTED)))
			to_chat(M, SPAN_WARNING("You're unable to reach \the [src]."))
			return 0

		if((istype(C)) && C.radio_interrupt_cooldown > world.time)
			to_chat(M, SPAN_WARNING("You're disrupted as you reach for \the [src]."))
			return 0

		if(istype(M)) M.trigger_aiming(TARGET_CAN_RADIO)

	//  Uncommenting this. To the above comment:
	// 	The permacell radios aren't suppose to be able to transmit, this isn't a bug and this "fix" is just making radio wires useless. -Giacom
	if(wires.IsIndexCut(WIRE_TRANSMIT)) // The device has to have all its wires and shit intact
		return 0

	if(!radio_connection)
		set_frequency(frequency)


	if(power_usage)
		var/obj/item/weapon/cell/has_cell = get_cell()
		if(!has_cell)
			return 0
		if(!has_cell.checked_use(power_usage * CELLRATE))
			return 0

	if(loc == M)
		playsound(loc, 'sound/effects/walkietalkie.ogg', 20, 0, -1)


	/* Quick introduction:
		This new radio system uses a very robust FTL signaling technology unoriginally
		dubbed "subspace" which is somewhat similar to 'blue-space' but can't
		actually transmit large mass. Headsets are the only radio devices capable
		of sending subspace transmissions to the Communications Satellite.

		A headset sends a signal to a subspace listener/reciever elsewhere in space,
		the signal gets processed and logged, and an audible transmission gets sent
		to each individual headset.
	*/

	//#### Grab the connection datum ####//
	var/datum/radio_frequency/connection = handle_message_mode(M, message, channel)
	if (!istype(connection))
		return 0

	var/turf/position = get_turf(src)

	//#### Tagging the signal with all appropriate identity values ####//

	// ||-- The mob's name identity --||
	var/displayname = M.name	// grab the display name (name you get when you hover over someone's icon)
	var/real_name = M.real_name // mob's real name
	var/mobkey = "none" // player key associated with mob
	var/voicemask = 0 // the speaker is wearing a voice mask
	if(M.client)
		mobkey = M.key // assign the mob's key


	var/jobname // the mob's "job"

	// --- Human: use their actual job ---
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		jobname = H.get_assignment()

	// --- Carbon Nonhuman ---
	else if (iscarbon(M)) // Nonhuman carbon mob
		jobname = "No id"

	// --- AI ---
	else if (isAI(M))
		jobname = "AI"

	// --- Cyborg ---
	else if (isrobot(M))
		jobname = "Robot"

	// --- Personal AI (pAI) ---
	else if (istype(M, /mob/living/silicon/pai))
		jobname = "Personal AI"

	// --- Unidentifiable mob ---
	else
		jobname = "Unknown"


	// --- Modifications to the mob's identity ---

	// The mob is disguising their identity:
	if (ishuman(M) && M.GetVoice() != real_name)
		displayname = M.GetVoice()
		jobname = "Unknown"
		voicemask = 1



  /* ###### Radio headsets can only broadcast through subspace ###### */
	if(subspace_transmission)
		// First, we want to generate a new radio signal
		var/datum/signal/signal = new
		signal.transmission_method = 2 // 2 would be a subspace transmission.
									   // transmission_method could probably be enumerated through #define. Would be neater.

		// --- Finally, tag the actual signal with the appropriate values ---
		signal.data = list(
		  // Identity-associated tags:
			"mob" = M, // store a reference to the mob
			"mobtype" = M.type, 	// the mob's type
			"realname" = real_name, // the mob's real name
			"name" = displayname,	// the mob's display name
			"job" = jobname,		// the mob's job
			"key" = mobkey,			// the mob's key
			"vmessage" = pick(M.speak_emote), // the message to display if the voice wasn't understood
			"vname" = M.voice_name, // the name to display if the voice wasn't understood
			"vmask" = voicemask,	// 1 if the mob is using a voice gas mask

			// We store things that would otherwise be kept in the actual mob
			// so that they can be logged even AFTER the mob is deleted or something

		  // Other tags:
			"compression" = rand(45,50), // compressed radio signal
			"message" = message, // the actual sent message
			"connection" = connection, // the radio connection to use
			"radio" = src, // stores the radio used for transmission
			"slow" = 0, // how much to sleep() before broadcasting - simulates net lag
			"traffic" = 0, // dictates the total traffic sum that the signal went through
			"type" = 0, // determines what type of radio input it is: normal broadcast
			"server" = null, // the last server to log this signal
			"reject" = 0,	// if nonzero, the signal will not be accepted by any broadcasting machinery
			"level" = position.z, // The source's z level
			"channel_tag" = "[connection.frequency]", // channel tag for the message
			"channel_color" = channel_color_presets["Menacing Maroon"], // radio message color
			"language" = speaking,
			"verb" = verb
		)
		signal.frequency = connection.frequency // Quick frequency set

	  //#### Sending the signal to all subspace receivers ####//

		for(var/obj/machinery/telecomms/receiver/R in telecomms_list)
			R.receive_signal(signal)

		// Allinone can act as receivers.
		for(var/obj/machinery/telecomms/allinone/R in telecomms_list)
			R.receive_signal(signal)

		//Copied everything for this
		for(var/obj/machinery/telecomms/server/blackbox/R in telecomms_list)
			R.receive_signal(signal)

		// Receiving code can be located in Telecommunications.dm
		if(signal.data["done"] && (position.z in signal.data["level"]))
			return TRUE //Huzzah, sent via subspace

		else //Less huzzah, we have to fallback
			for(var/obj/item/device/radio/R in loc)
				if(!R.subspace_transmission)
					return R.talk_into(M, message, channel, verb, speaking)
			return FALSE

  /* ###### Intercoms and station-bounced radios ###### */

	var/filter_type = 2

	/* --- Intercoms can only broadcast to other intercoms, but bounced radios can broadcast to bounced radios and intercoms --- */
	if(istype(src, /obj/item/device/radio/intercom))
		filter_type = 1


	var/datum/signal/signal = new
	signal.transmission_method = 2


	/* --- Try to send a normal subspace broadcast first */

	signal.data = list(

		"mob" = M, // store a reference to the mob
		"mobtype" = M.type, 	// the mob's type
		"realname" = real_name, // the mob's real name
		"name" = displayname,	// the mob's display name
		"job" = jobname,		// the mob's job
		"key" = mobkey,			// the mob's key
		"vmessage" = pick(M.speak_emote), // the message to display if the voice wasn't understood
		"vname" = M.voice_name, // the name to display if the voice wasn't understood
		"vmask" = voicemask,	// 1 if the mob is using a voice gas mas

		"compression" = 0, // uncompressed radio signal
		"message" = message, // the actual sent message
		"connection" = connection, // the radio connection to use
		"radio" = src, // stores the radio used for transmission
		"slow" = 0,
		"traffic" = 0,
		"type" = 0,
		"server" = null,
		"reject" = 0,
		"level" = position.z,
		"channel_tag" = "#unkn",
		"channel_color" = channel_color_presets["Menacing Maroon"],
		"language" = speaking,
		"verb" = verb
	)
	signal.frequency = connection.frequency // Quick frequency set
	var/obj/item/weapon/cell/has_cell = get_cell()
	if(has_cell && has_cell.percent() < 20)
		signal.data["compression"] = max(0, 80 - has_cell.percent()*3)
	for(var/obj/machinery/telecomms/receiver/R in telecomms_list)
		R.receive_signal(signal)

	sleep(rand(10,25)) // wait a little...

	if(signal.data["done"] && (position.z in signal.data["level"]))
		// we're done here.
		return 1

	// Oh my god; the comms are down or something because the signal hasn't been broadcasted yet in our level.
	// Send a mundane broadcast with limited targets:

	//THIS IS TEMPORARY. YEAH RIGHT
	if(!connection)	return 0	//~Carn
	return Broadcast_Message(connection, M, voicemask, pick(M.speak_emote),
					  src, message, displayname, jobname, real_name, M.voice_name,
					  filter_type, signal.data["compression"], GetConnectedZlevels(position.z), connection.frequency, verb, speaking,
					  "[connection.frequency]", channel_color_presets["Menacing Maroon"])