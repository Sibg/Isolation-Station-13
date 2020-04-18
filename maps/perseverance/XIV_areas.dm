//XIV Perseverance rooms

/area/ship/perseverance/lift
	name = "\improper Perseverance Elevator"
	icon_state = "sleep"
	icon_state = "shuttlered"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/lifttop
	name = "\improper Perseverance Elevator shaft"
	icon_state = "sleep"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/cryos
	name = "\improper Perseverance Starboard Cryogenics"
	icon_state = "sleep"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/cryop
	name = "\improper Perseverance Port Cryogenics"
	icon_state = "sleep"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/chall
	name = "\improper Perseverance Central Hallway"
	icon_state = "hallC3"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/navigation
	name = "\improper Perseverance Navigation Center"
	icon_state = "shuttle"
	req_access = list(access_XIV, access_bridge)
	sound_env = SMALL_ENCLOSED