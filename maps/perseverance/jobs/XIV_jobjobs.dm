//big boss
/datum/job/manager
	title = "Operations Manager"
	supervisors = "money"
	department = "Command"
	total_positions = 1
	spawn_positions = 1
	department_flag = COM
	selection_color = "#2f2f7f"
	minimal_player_age = 1
	economic_power = 4
	alt_titles = list()
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/isolation/manager
	access = list(access_XIV, access_engine, access_bridge, access_security, access_medical, access_change_ids, access_engine_equip, access_brig)
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/contractor
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC)

	max_skill = list(   SKILL_SCIENCE     = SKILL_MAX)
	skill_points = 25

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

/datum/job/manager/get_description_blurb()
	return "You are the Operations manager, one of the most competent persons employed by Xion. You are in charge of all the contractors in this small ship of yours, and now you just have to make sure they do their job, pilot the ship, and preserve crew cohesion."

/datum/job/captain/post_equip_rank(var/mob/person, var/alt_title)
	var/sound/announce_sound = (GAME_STATE <= RUNLEVEL_SETUP)? null : sound('sound/misc/boatswain.ogg', volume=20)
	captain_announcement.Announce("All hands, [alt_title || title] [person.real_name] on deck!", new_sound = announce_sound)
	..()

//navigations officer
/datum/job/navigation
	title = "Navigations Officer"
	department = "Command"
	department_flag = COM
	selection_color = "#2f2f7f"
	total_positions = 1
	spawn_positions = 1
	hud_icon = "hudmedicaldoctor"
	supervisors = "the Operations manager"
	economic_power = 2
	alt_titles = list()
	ideal_character_age = 24
	minimal_player_age = 0
	outfit_type = /decl/hierarchy/outfit/job/isolation/navigation
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/contractor
	)
	min_skill = list(   SKILL_PILOT       = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	access = list(access_XIV, access_bridge)
	minimal_access = list()

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)
	skill_points = 18

/datum/job/doctor/get_description_blurb()
	return "You are the Navigations Officer, specialized in piloting the craft and operating sensors. You are subordinate to the Operations Manager and are expected to follow them."

//doctor
/datum/job/doctor
	title = "Medical Officer"
	department = "Medical"
	department_flag = MED
	total_positions = 2
	spawn_positions = 2
	hud_icon = "hudmedicaldoctor"
	supervisors = "the Operations manager"
	economic_power = 2
	alt_titles = list()
	ideal_character_age = 24
	minimal_player_age = 0
	outfit_type = /decl/hierarchy/outfit/job/isolation/doctor
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/contractor
	)
	min_skill = list(   SKILL_EVA     = SKILL_BASIC,
	                    SKILL_MEDICAL = SKILL_BASIC,
	                    SKILL_ANATOMY = SKILL_BASIC)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX,
	                    SKILL_ANATOMY    = SKILL_MAX)

	access = list(access_XIV, access_medical)
	minimal_access = list()

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)
	skill_points = 20

/datum/job/doctor/get_description_blurb()
	return "You are the Doctor, specialized in keeping your fellow cremembers operational. You are subordinate to the Operations Manager and are expected to follow them."

//researcher
/datum/job/researcher
	title = "Researcher"
	department = "Research"
	department_flag = SCI
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Operations manager"
	selection_color = "#633d63"
	economic_power = 3
	skill_points = 25
	ideal_character_age = 20
	alt_titles = list()

	outfit_type = /decl/hierarchy/outfit/job/isolation/researcher
	allowed_branches = list(
		/datum/mil_branch/civilian,
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/contractor
	)
	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	access = list(access_XIV, access_research)

/datum/job/researcher/get_description_blurb()
	return "You are the Researcher, brought here to find ways to make the miners' lives easier. You are subordinate to the Operations manager and are expected to follow them."

//mechanic
/datum/job/mechanic
	title = "Mechanic"
	department = "Engineering"
	department_flag = ENG
	total_positions = 4
	spawn_positions = 4
	hud_icon = "hudengineer"
	supervisors = "the Operations Manager"
	selection_color = COLOR_DARK_BROWN
	economic_power = 2
	alt_titles = list()
	minimal_player_age = 0
	ideal_character_age = 24
	outfit_type = /decl/hierarchy/outfit/job/isolation/mechanic
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/contractor
	)
	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_EVA          = SKILL_BASIC,
	                    SKILL_CONSTRUCTION = SKILL_BASIC,
	                    SKILL_ELECTRICAL   = SKILL_BASIC,
	                    SKILL_ATMOS        = SKILL_BASIC,
	                    SKILL_ENGINES      = SKILL_BASIC)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)
	skill_points = 18

	access = list(access_XIV, access_engine_equip)

	software_on_spawn = list(/datum/computer_file/program/power_monitor,
							 /datum/computer_file/program/supermatter_monitor,
							 /datum/computer_file/program/alarm_monitor,
							 /datum/computer_file/program/atmos_control,
							 /datum/computer_file/program/rcon_console,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/shields_monitor)

/datum/job/mechanic/get_description_blurb()
	return "You are the Ship Mechanic, you're not a not top of the line engineer but you can get the job done. You are subordinate to the Operations Manager and are expected to follow them."

//miner
/datum/job/assistant
	title = "Mining Technician"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Operations Manager"
	economic_power = 1
	ideal_character_age = 24
	minimal_player_age = 0
	outfit_type = /decl/hierarchy/outfit/job/isolation/miner
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/contractor
	)
	alt_titles = list()

	access = list(access_XIV)
	minimal_access = list()

	skill_points = 18

/datum/job/assistant/get_description_blurb()
	return "You are the Miner. You are hired to extract minerals from various asteroids and operate heavy machinery."

/datum/job/ai
	minimal_player_age = 7
	allowed_ranks = list(
		/datum/mil_rank/civ/synthetic
	)