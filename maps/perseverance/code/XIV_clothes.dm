/obj/item/clothing/under/XIV
	icon = 'maps/perseverance/icons/clothes/XIVitem.dmi'
	item_icons = list(slot_w_uniform_str = 'maps/perseverance/icons/clothes/XIVunder.dmi')

/obj/item/clothing/under/XIV/xion
	name = "xion jumpsuit"
	desc = "A relatively protecive utility jumpsuit produced by Xion Industries."
	icon_state = "xion"
	item_state = "xion"
	worn_state = "xionsuit_s"
	siemens_coefficient = 0.8
	armor = list(
		rad = ARMOR_RAD_MINOR
		)

/obj/item/clothing/under/XIV/xionplus
	name = "xion padded suit"
	desc = "A special suit used by higher-ranking xion employees."
	icon = 'maps/perseverance/icons/clothes/XIVunder.dmi'
	icon_state = "manage"
	item_state = "manage"
	worn_state = "manage"
	gender_icons = 1
	armor = list(
		energy = ARMOR_ENERGY_SMALL,
		rad = ARMOR_RAD_MINOR,
		bio = ARMOR_BIO_SMALL,
		melee = ARMOR_MELEE_SMALL
		)

/obj/item/clothing/under/rank/medical/XIV
	name = "field physicians jumpsuit"