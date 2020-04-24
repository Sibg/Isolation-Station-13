/obj/machinery/computer/shuttle_control/lift/cargo
	name = "cargo lift controls"
	shuttle_tag = "Cargo Lift"
	ui_template = "shuttle_control_console_lift.tmpl"
	icon_state = "tiny"
	icon_keyboard = "tiny_keyboard"
	icon_screen = "lift"
	density = 1

/datum/shuttle/autodock/ferry/cargo_lift
	name = "Cargo Lift"
	shuttle_area = /area/ship/perseverance/lift
	warmup_time = 3
	waypoint_station = "nav_cargo_lift_top"
	waypoint_offsite = "nav_cargo_lift_bottom"
	sound_takeoff = 'sound/effects/lift_heavy_start.ogg'
	sound_landing = 'sound/effects/lift_heavy_stop.ogg'
	ceiling_type = null
	knockdown = 0

/obj/effect/shuttle_landmark/lift/cargo_top
	name = "Ventilation Deck"
	landmark_tag = "nav_cargo_lift_top"
	base_area = /area/ship/perseverance/lifttop
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/lift/cargo_bottom
	name = "Operations Deck"
	landmark_tag = "nav_cargo_lift_bottom"
	flags = SLANDMARK_FLAG_AUTOSET
	base_area = /area/ship/perseverance/hall/chall
	base_turf = /turf/simulated/floor/plating