/datum/map/isolation/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('sound/AI/torch/commandreport.ogg', volume = 45))

/datum/map/isolation/get_map_info()
	return "You're aboard the <b>[station_name],</b> an old but reliable frontier exploration frigate owned by Xion Industries sent out to locate new mining hotspots."
	. +=  "This area of space is uncharted, away from SCG territory. You might encounter remote outposts or drifting hulks, but no recognized government holds claim on this sector."

/datum/map/isolation/send_welcome()
	var/welcome_text = "<font size = 3><b>XIV Perseverance</b> Sensor Readings:</font><br>"
	welcome_text += "Report generated on [stationdate2text()] at [stationtime2text()]</center><br /><br />"
	welcome_text += "<hr>Current system:<br /><b>[system_name()]</b><br /><br>"

	var/list/space_things = list()
	var/obj/effect/overmap/visitable/torch = map_sectors["1"]

	welcome_text += "Current Coordinates:<br /><b>10:10</b><br /><br>"
	welcome_text += "Next system targeted for jump:<br /><b>[generate_system_name()]</b><br /><br>"
	welcome_text += "Travel time to Sol:<br /><b>[rand(15,45)] days</b><br /><br>"
	welcome_text += "Time since last port visit:<br /><b>[rand(40,200)] days</b><br /><hr>"
	welcome_text += "Scan results show the following points of interest:<br />"

	for(var/zlevel in map_sectors)
		var/obj/effect/overmap/visitable/O = map_sectors[zlevel]
		if(O.name == torch.name)
			continue
		if(istype(O, /obj/effect/overmap/visitable/ship/landable)) //Don't show shuttles
			continue
		if (O.hide_from_reports)
			continue
		space_things |= O

	var/list/distress_calls
	for(var/obj/effect/overmap/visitable/O in space_things)
		var/location_desc = " at present co-ordinates."
		if(O.loc != torch.loc)
			var/bearing = round(90 - Atan2(O.x - torch.x, O.y - torch.y),5) //fucking triangles how do they work
			if(bearing < 0)
				bearing += 360
			location_desc = ", bearing [bearing]."
		if(O.has_distress_beacon)
			LAZYADD(distress_calls, "[O.has_distress_beacon][location_desc]")
		welcome_text += "<li>\A <b>[O.name]</b>[location_desc]</li>"

	if(LAZYLEN(distress_calls))
		welcome_text += "<br><b>Distress calls logged:</b><br>[jointext(distress_calls, "<br>")]<br>"
	else
		welcome_text += "<br>No distress calls logged.<br />"
	welcome_text += "<hr>"

	post_comm_message("XIV Perseverance Status Report", welcome_text)
	minor_announcement.Announce(message = "New Status Update available at all communication consoles.")