#define STATION_Z 1
#define TELECOMM_Z 1

/obj/machinery/telecomms/server/blackbox
	name = "Blackbox"
	icon = 'maps/perseverance/icons/obj/blackbox.dmi'
	icon_state = "blackbox"
	desc = "A sturdy machine which utilizes phoron to record subspace data without needing power, with a delay. It has been modified to interface with modern computers."
	id = "Blackbox"
	network = "Blackbox"
	integrity = 10000 //I did say it was sturdy
	density = 1
	anchored = 1
	idle_power_usage = 0
	machinetype = 4
	circuitboard = /obj/item/weapon/stock_parts/circuitboard/telecomms/server
	base_type = /obj/machinery/telecomms/server/blackbox
	New()
		for(var/i = PUBLIC_LOW_FREQ, i < PUBLIC_HIGH_FREQ, i += 2)
			freq_listening |= i
		..()

/obj/machinery/telecomms/attackby(obj/item/P as obj, mob/user as mob)

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

/obj/machinery/telecomms/server/blackbox/receive_signal(datum/signal/signal, obj/machinery/telecomms/machine_from)

	sleep (400)

	signal.data["compression"] = 0

	// channel tag the signal
	var/list/data = get_channel_info(signal.frequency)
	signal.data["channel_tag"] = data[1]
	signal.data["channel_color"] = data[2]

	//Is this a test signal? Bypass logging
	if(signal.data["type"] != 4)

		// If signal has a message and appropriate frequency

		var/datum/comm_log_entry/log = new
		var/mob/M = signal.data["mob"]

		// Copy the signal.data entries we want
		log.parameters["mobtype"] = signal.data["mobtype"]
		log.parameters["job"] = signal.data["job"]
		log.parameters["key"] = signal.data["key"]
		log.parameters["vmessage"] = signal.data["message"]
		log.parameters["vname"] = signal.data["vname"]
		log.parameters["message"] = signal.data["message"]
		log.parameters["name"] = signal.data["name"]
		log.parameters["realname"] = signal.data["realname"]
		log.parameters["language"] = signal.data["language"]

		var/race = "Unknown"
		if(ishuman(M) || isbrain(M))
			race = "Sapient Race"
			log.parameters["intelligible"] = 1
		else if(M.isMonkey())
			race = "Monkey"
		else if(issilicon(M))
			race = "Artificial Life"
			log.parameters["intelligible"] = 1
		else if(isslime(M))
			race = "Slime"
		else if(isanimal(M))
			race = "Domestic Animal"

		log.parameters["race"] = race

		if(!istype(M, /mob/new_player) && M)
			log.parameters["uspeech"] = M.universal_speak
		else
			log.parameters["uspeech"] = 0

		// If the signal is still compressed, make the log entry gibberish
		if(signal.data["compression"] > 0)
			log.parameters["message"] = Gibberish(signal.data["message"], signal.data["compression"] + 50)
			log.parameters["job"] = Gibberish(signal.data["job"], signal.data["compression"] + 50)
			log.parameters["name"] = Gibberish(signal.data["name"], signal.data["compression"] + 50)
			log.parameters["realname"] = Gibberish(signal.data["realname"], signal.data["compression"] + 50)
			log.parameters["vname"] = Gibberish(signal.data["vname"], signal.data["compression"] + 50)
			log.input_type = "Corrupt File"

		// Log and store everything that needs to be logged
		log_entries.Add(log)
		if(!(signal.data["name"] in stored_names))
			stored_names.Add(signal.data["name"])
		logs++
		signal.data["server"] = src

		// Give the log a name
		var/identifier = num2text( rand(-1000,1000) + world.time )
		log.name = "data packet ([md5(identifier)])"


//-----------------------------------------------------------------------------------------------------------//

obj/machinery/computer/telecomms/server/blackbox
	req_access = list()
	network = "Blackbox"

/obj/item/weapon/stock_parts/circuitboard/bboxmonitor
	name = T_BOARD("black box reader console")
	build_path = /obj/machinery/computer/telecomms/server/blackbox
	origin_tech = list(TECH_DATA = 3)