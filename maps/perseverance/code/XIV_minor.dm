//all the minor overrides and some new stuff

/decl/flooring/reinforced/redgrid//blackgrid is black instead of red and I have no idea why, but I'm not really willing to go diggin through this damned code to find out becauseIcouldntfinditafterafewhours
	name = "processing strata"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_base = "rcircuit"
	build_type = null
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK | TURF_REMOVE_WRENCH
	can_paint = 1
	can_engrave = FALSE

/turf/simulated/floor/redgrid
	name = "mainframe floor"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_state = "rcircuit"
	light_outer_range = 2
	light_max_bright = 2
	light_color = COLOR_RED
	initial_flooring = /decl/flooring/reinforced/redgrid

/obj/machinery/door/airlock/hatch/autoname/command
	stripe_color = COLOR_COMMAND_BLUE

/obj/machinery/door/airlock/hatch/autoname/engineering
	stripe_color = COLOR_AMBER

/obj/machinery/door/airlock/autoname/engineering
	stripe_color = COLOR_AMBER

/obj/machinery/door/airlock/autoname/atmos
	door_color = COLOR_AMBER
	stripe_color = COLOR_CYAN

/obj/machinery/door/airlock/autoname/command
	door_color = COLOR_COMMAND_BLUE

/obj/machinery/door/airlock/autoname/civilian
	stripe_color = COLOR_CIVIE_GREEN

/obj/machinery/door/airlock/autoname/weapons
	stripe_color = COLOR_RED

/obj/machinery/door/airlock/autoname/supply
	door_color = COLOR_PALE_ORANGE
	stripe_color = COLOR_BEASTY_BROWN

/obj/machinery/door/airlock/hatch/ventilation
	name = "Ventilation Hatch"
	stripe_color = COLOR_ORANGE

// Autoname multitile glass airlocks
/obj/machinery/door/airlock/multi_tile/glass/autoname

/obj/machinery/door/airlock/multi_tile/glass/autoname/New()
	var/area/A = get_area(src)
	name = A.name
	..()

/obj/machinery/door/airlock/multi_tile/glass/autoname/engineering
	door_color = COLOR_AMBER
	stripe_color = COLOR_RED

/obj/machinery/door/airlock/multi_tile/glass/autoname/atmos
	door_color = COLOR_AMBER
	stripe_color = COLOR_CYAN

/obj/machinery/door/airlock/multi_tile/glass/autoname/civilian
	stripe_color = COLOR_CIVIE_GREEN

/obj/machinery/door/airlock/multi_tile/glass/autoname/medical
	door_color = COLOR_WHITE
	stripe_color = COLOR_DEEP_SKY_BLUE

/obj/machinery/door/airlock/multi_tile/glass/autoname/supply
	door_color = COLOR_PALE_ORANGE
	stripe_color = COLOR_BEASTY_BROWN

/obj/machinery/door/airlock/multi_tile/glass/autoname/command
	door_color = COLOR_COMMAND_BLUE
	stripe_color = COLOR_SKY_BLUE

///obj/machinery/computer
//	icon = 'maps/perseverance/icons/obj/computer.dmi'
// uncomment once derp does the sprites

/obj/item/device/radio/headset/contractor
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

/obj/machinery/suit_cycler/engineering/alt/XIV
	req_access = list()

/obj/item/device/multitool
	icon = 'maps/perseverance/icons/obj/multitool.dmi'
	icon_state = "multitool"

// The ship has (furure code) been out of power for a bit, these are fairly good at showcasing that

/obj/item/weapon/cell/apc/empty
	charge = 0

/obj/item/weapon/cell/apc/low
	charge = 200

/obj/machinery/power/apc/XIV/empty
	cell_type = /obj/item/weapon/cell/apc/empty

/obj/machinery/power/apc/XIV/low
	cell_type = /obj/item/weapon/cell/apc/low

/obj/machinery/power/apc/high/empty
	cell_type = /obj/item/weapon/cell/high/empty

// Need these for wallframe spawners

/obj/structure/wall_frame/hull/white
	paint_color = COLOR_WHITE

/obj/structure/wall_frame/orange
	paint_color = COLOR_DARK_ORANGE

// For the fuel bay

/obj/effect/wallframe_spawn/reinforced/orange
	name = "white reinforced wall frame window spawner"
	icon_state = "r-wingrille"
	frame_path = /obj/structure/wall_frame/orange

// Setting these two up as hull should make them do the special space-facing decay effet. Addendum: it does! It actually does! Seems to work on area check
/obj/effect/wallframe_spawn/reinforced/hull/white
	name = "white reinforced wall frame window spawner"
	icon_state = "r-wingrille"
	frame_path = /obj/structure/wall_frame/hull/white

/turf/simulated/wall/r_wall/hull/white
	color = COLOR_WHITE

// This one is for areas which would be painted over regularly (in view of people, etc.)

/turf/simulated/wall/prepainted/white
	paint_color = COLOR_WHITE

/turf/simulated/wall/prepainted/hull
	paint_color = COLOR_HULL

/turf/simulated/wall/titanium/hull
	paint_color = COLOR_HULL

/turf/simulated/wall/r_wall/white
	paint_color = COLOR_WHITE

/turf/simulated/wall/r_wall/orange //for fuel tanks
	paint_color = COLOR_DARK_ORANGE

/turf/simulated/wall/ocp_wall/orange
	paint_color = COLOR_DARK_ORANGE

/turf/simulated/wall/ocp_wall/hull
	paint_color = COLOR_HULL

/turf/simulated/wall/ocp_wall/prepainted
	paint_color = COLOR_GUNMETAL

/obj/structure/closet/secure_closet/freezer/kitchen/XIV
	req_access = list()

// This is for the multi-z gas tanks

/turf/simulated/open/XIV/airmix
	initial_gas = list(GAS_OXYGEN = MOLES_O2ATMOS, GAS_NITROGEN = MOLES_N2ATMOS)

/turf/simulated/open/XIV/hydrogen
	initial_gas = list(GAS_HYDROGEN = ATMOSTANK_HYDROGEN)

/turf/simulated/open/XIV/oxygen
	initial_gas = list(GAS_OXYGEN = ATMOSTANK_OXYGEN)

/turf/simulated/open/XIV/carbon_dioxide
	initial_gas = list(GAS_CO2 = ATMOSTANK_CO2)

/turf/simulated/open/XIV/airless//for the aft fuel bay
	initial_gas = null

/turf/simulated/floor/tiled/techfloor/grid/airless
	initial_gas = null

//SMES

/obj/machinery/power/smes/buildable/preset/XIV
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Main Engine output SMES, plus empty version
/obj/machinery/power/smes/buildable/preset/XIV/engine_main
	uncreated_component_parts = list(
		/obj/item/weapon/stock_parts/smes_coil/super_io = 2,
		/obj/item/weapon/stock_parts/smes_coil/super_capacity =	 1)

/obj/machinery/power/smes/buildable/preset/XIV/engine_main/empty
	_fully_charged = FALSE

// Main Engine internal SMES, for powering the gyrotron and the actual room, doesn't need super high capacity, but it does need I/O
/obj/machinery/power/smes/buildable/preset/XIV/engine_central
	uncreated_component_parts = list(
		/obj/item/weapon/stock_parts/smes_coil/super_io = 1)

//Crates

/obj/structure/closet/crate/actual_radiation_gear
	name = "radioactive gear crate"
	desc = "A crate with a radiation sign on it."
	closet_appearance = /decl/closet_appearance/crate/radiation

/obj/structure/closet/crate/actual_radiation_gear/WillContain()
	return list(/obj/item/clothing/suit/radiation = 4,
				/obj/item/clothing/head/radiation = 4) //other radiation closet only gives the suit ??? What???

/obj/structure/closet/crate/fusion
	name = "fusion fuel crate"
	desc = "A crate with a radiation sign on it."
	closet_appearance = /decl/closet_appearance/crate/radiation

/obj/item/stack/material/deuterium/ten //needed for next part
	amount = 10

/obj/structure/closet/crate/fusion/WillContain()
	return list(/obj/item/stack/material/deuterium/ten = 10,
				/obj/item/stack/material/tritium/ten = 4)

//Blue double emergency tank

/obj/item/weapon/tank/emergency/oxygen/double/blue
	icon = 'maps/perseverance/icons/obj/tanks.dmi'
	icon_state = "emergency_double_blue"

//The editor is annoying, I'm not using it anymore, dont really think doing this will cause many issues

obj/machinery/conveyor/XIV/shuttletosci
	id = "shuttletosci"

obj/machinery/conveyor_switch/oneway/XIV/shuttletosci
	id = "shuttletosci"

obj/machinery/conveyor/XIV/scitoshuttle
	id = "scitoshuttle"

obj/machinery/conveyor_switch/oneway/XIV/scitoshuttle
	id = "scitoshuttle"