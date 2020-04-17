/datum/map/isolation/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('sound/AI/torch/commandreport.ogg', volume = 45))

/datum/map/isolation/get_map_info()
	return "You're aboard the <b>[station_name],</b> a repurposed frontier exploration frigate owned by Xion Industries on its way to a newly discovered mining hotspot \
	somwhere in the Theia galaxy. This area is well within SCG borders, and you are expected to obey the law."

/datum/map/isolation/send_welcome()
	var/welcome_text = "<center><img src = sollogo.png /><br /><font size = 3><b>XIV Perseverance</b> Sensor Readings:</font><br>"
	welcome_text += "Report generated on [stationdate2text()] at [stationtime2text()]</center><br /><br />"
	welcome_text += "<hr>Current system:<br /><b>[system_name()]</b><br /><br>"

	welcome_text += "Target system:<br /><b>[generate_system_name()]</b><br /><br>"
	welcome_text += "Travel time to Sol:<br /><b>[rand(5,9)] days</b><br /><br>"
	welcome_text += "Time since last port visit:<br /><b>[rand(8,9)] days</b><br /><hr>"
	welcome_text += "<br>WARN: Critical system failures detected.<br />"
	welcome_text += "<hr>"

	post_comm_message("XIV Perseverance Status Report", welcome_text)
	minor_announcement.Announce(message = "New Status Update available at all communication consoles.")