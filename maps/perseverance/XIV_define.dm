/datum/map/isolation
	name = "Perseverance"
	full_name = "IEV Perseverance"
	path = "isolation"
	flags = MAP_HAS_BRANCH | MAP_HAS_RANK

	id_hud_icons = 'maps/torch/icons/assignment_hud.dmi'

	station_name  = "XIV Perseverance"
	station_short = "Perseverance"

	dock_name     = "STNDRD"
	boss_name     = "Xion Headquarters"
	boss_short    = "HQ"
	company_name  = "Xion Industries"
	company_short = "Xion"

	admin_levels = list()
	empty_levels = list()
	accessible_z_levels = list("1"=1,"2"=1)
	overmap_size = 40
	overmap_event_areas = 30
	usable_email_tlds = list("freemail.net")

	default_law_type = /datum/ai_laws/corporate

	allowed_spawns = list("Cryogenic Storage")
	default_spawn = "Cryogenic Storage"

	evac_controller_type = /datum/evacuation_controller/starship

	shuttle_docked_message = "Attention all hands: Jump preparation complete. The bluespace drive is now spooling up, secure all stations for departure. Time to jump: approximately %ETD%."
	shuttle_leaving_dock = "Attention all hands: Jump initiated, exiting bluespace in %ETA%."
	shuttle_called_message = "Attention all hands: Jump sequence initiated. Transit procedures are now in effect. Jump in %ETA%."
	shuttle_recall_message = "Attention all hands: Jump sequence aborted, return to normal operating conditions."

	use_overmap = 1
	num_exoplanets = 0
	away_site_budget = 0
	welcome_sound = 'sound/AI/welcome.ogg'

	department_money = 0
	salary_modifier = 0.4


//Images 2-4 are from starsector, image 1 I have no idea, couldn't really find who made it, but it's def. Alien: Isolation themed
	lobby_screens = list('maps/perseverance/lobby/Menu1.png', 'maps/perseverance/lobby/Menu2.jpg', 'maps/perseverance/lobby/Menu3.jpg', 'maps/perseverance/lobby/Menu4.jpg')
	lobby_tracks = list(
		/music_track/torch,
		/music_track/human,
		/music_track/marhaba,
		/music_track/treacherous_voyage,
		/music_track/comet_haley,
		/music_track/lysendraa,
		/music_track/lasers,
		/music_track/martiancowboy,
		/music_track/monument,
		/music_track/asfarasitgets,
		/music_track/eighties,
		/music_track/torn,
		/music_track/nebula,
		/music_track/epicintro2015,
		/music_track/epicintro2017
	)