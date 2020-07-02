//XIV Perseverance

//lift stuff

/area/ship/perseverance/lift
	name = "\improper Perseverance Elevator"
	icon_state = "sleep"
	icon_state = "shuttlered"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/lifttop
	name = "\improper Perseverance Elevator shaft"
	icon_state = "sleep"
	sound_env = SMALL_ENCLOSED

//rooms

/area/ship/perseverance/cryos
	name = "\improper Perseverance Starboard Cryogenics"
	icon_state = "crew_quarters"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/cryop
	name = "\improper Perseverance Port Cryogenics"
	icon_state = "Sleep"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/navigation
	name = "\improper Perseverance Navigation Center"
	icon_state = "shuttle"
	req_access = list(access_XIV, access_bridge)
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/canteen
	name = "\improper Perseverance canteen"
	icon_state = "cafeteria"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/infirmary
	name = "\improper Perseverance Infirmary"
	icon_state = "medbay"
	req_access = list(access_XIV)
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/bathroom
	name = "\improper Perseverance Bathroom"
	icon_state = "toilet"
	sound_env = SMALL_ENCLOSED

//engineering

/area/ship/perseverance/eng/reactor
	name = "\improper Perseverance Engineering"
	icon_state = "engine"
	req_access = list(access_XIV, access_engine)
	sound_env = LARGE_ENCLOSED

/area/ship/perseverance/eng/atmos_out
	name = "\improper Perseverance Atmospherics Distribution"
	icon_state = "atmos"
	req_access = list(access_XIV, access_engine)
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/eng/atmos_in
	name = "\improper Perseverance Atmospherics Filtering"
	icon_state = "atmos"
	req_access = list(access_XIV, access_engine)
	sound_env = SMALL_ENCLOSED

//hallways

/area/ship/perseverance/hall/chall
	name = "\improper Perseverance Central Hallway"
	icon_state = "hallC3"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/hall/phall
	name = "\improper Perseverance Port Hallway"
	icon_state = "hallF"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/hall/shall
	name = "\improper Perseverance Starboard Hallway"
	icon_state = "hallA"
	sound_env = SMALL_ENCLOSED

/area/ship/perseverance/hall/ehall
	name = "\improper Perseverance Aft Hallway"
	icon_state = "hallC3"
	sound_env = SMALL_ENCLOSED