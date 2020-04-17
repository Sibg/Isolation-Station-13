#if !defined(using_map_DATUM)
//    #include "XIV_unit_testing.dm"

    #include "XIV_areas.dm"
    #include "XIV_announcements.dm"
	#include "XIV_overmap.dm"
	#include "XIV_unit_testing.dm"
	#include "XIV_shuttles.dm"
	#include "XIV_ranks.dm"
	#include "XIV_map_templates.dm"
	#include "XIV_setup.dm"
	#include "XIV_define.dm"

	#include "Perseverance_1.dmm"
	#include "Perseverance_2.dmm"

	#include "jobs/XIV_access.dm"
	#include "jobs/XIV_IDs.dm"
	#include "jobs/XIV_jobjobs.dm"
	#include "jobs/XIV_jobs.dm"
	#include "jobs/XIV_outfits.dm"

	#include "language/human/euro.dm"
	#include "language/human/misc/spacer.dm"

	#define using_map_DATUM /datum/map/isolation

	#endif

//all the overrides and new stuff

/obj/machinery/door/airlock/hatch/autoname/command
	stripe_color = COLOR_COMMAND_BLUE

/obj/machinery/door/airlock/hatch/autoname/engineering
	stripe_color = COLOR_AMBER

/obj/machinery/door/airlock/autoname/engineering
	stripe_color = COLOR_AMBER

/obj/machinery/door/airlock/autoname/command
	stripe_color = COLOR_COMMAND_BLUE

/obj/machinery/door/airlock/autoname/civilian
	stripe_color = COLOR_CIVIE_GREEN

/obj/machinery/door/airlock/autoname/weapons
	stripe_color = COLOR_RED

/turf/simulated/wall/r_wall/white
	color = COLOR_WHITE

/obj/item/device/radio/headset/contractor/alt
	name = "contractor headset"
	desc = "A headset often used by contractors on ships where having a full communications system is simply too expensive."
	item_state = "cargo_headset" //not alt headset sprite because they look bad on other species
	icon_state = "cargo_headset"
	max_keys = 3

/obj/item/weapon/storage/belt/utility/full/XIV/New()
	..()
	new /obj/item/device/multitool(src)
	update_icon()

/obj/item/weapon/storage/belt/holster/security/XIV
	name = "combat belt"
	desc = "Can hold security gear like handcuffs and flashes, with extra pouches for more storage."
	icon_state = "swatbelt"
	item_state = "swatbelt"
	storage_slots = 10

/obj/item/weapon/storage/belt/holster/security/XIV/New()
	..()
	new /obj/item/weapon/melee/baton/loaded(src)
	new /obj/item/device/flashlight/maglight(src)
	new /obj/item/device/flash(src)
	new /obj/item/weapon/reagent_containers/spray/pepper(src)
	new /obj/item/weapon/grenade/flashbang(src)
	update_icon()

/obj/machinery/suit_cycler/mining/XIV
	req_access = list()

/obj/item/device/multitool
	icon = 'icons/obj/multitool.dmi'
	icon_state = "multitool"

// The ship's been out for a bit, these are fairly good at showcasing that

/obj/item/weapon/cell/apc/empty
	charge = 0

/obj/item/weapon/cell/apc/low
	charge = 200

/obj/machinery/power/apc/XIV/empty
	cell_type = /obj/item/weapon/cell/apc/empty

/obj/machinery/power/apc/XIV/low
	cell_type = /obj/item/weapon/cell/apc/low

/obj/structure/closet/secure_closet/engineering_personal/XIV
	name = "mechanic's locker"
	req_access = list(access_engine_equip)
	closet_appearance = /decl/closet_appearance/secure_closet/engineering

/obj/structure/closet/secure_closet/engineering_personal/XIV/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/clothing/accessory/storage/brown_vest = 70, /obj/item/clothing/accessory/storage/webbing = 30)),
		new/datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/industrial, /obj/item/weapon/storage/backpack/satchel/eng)),
		new/datum/atom_creator/simple(/obj/item/weapon/storage/backpack/dufflebag/eng, 50),
		/obj/item/weapon/storage/toolbox/mechanical,
		/obj/item/device/radio/headset/contractor/alt,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/mask/gas,
		/obj/item/clothing/head/welding,
		/obj/item/taperoll/engineering
	)