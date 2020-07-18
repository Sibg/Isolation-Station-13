// I hate the map editor when it comes to linking airlocks, pumps and such, this should be an easy way of tracking and setting everything up without losing my sanity, copy n paste for the win, hope this works!

/obj/machinery/atmospherics/unary/vent_pump/XIV/ventilation/output
	use_power = 1
	icon_state = "map_vent_out"
	external_pressure_bound = 1.2 * ONE_ATMOSPHERE

/obj/machinery/atmospherics/unary/vent_pump/XIV/ventilation/siphon
	pump_direction = 0
	use_power = 1
	icon_state = "map_vent_in"
	external_pressure_bound = 0.8 * ONE_ATMOSPHERE

/obj/machinery/atmospherics/omni/mixer/XIV/fuelbay
	tag_south = 2