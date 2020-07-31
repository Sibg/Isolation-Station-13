/decl/hierarchy/outfit/job/isolation
	l_ear = /obj/item/device/radio/headset/contractor
	flags = OUTFIT_HAS_BACKPACK
	pda_slot = slot_l_store
	pda_type = /obj/item/device/radio //WE ARE POOR OKAY?

//big boss
/decl/hierarchy/outfit/job/isolation/manager
	name = OUTFIT_JOB_NAME("Expedition Leader")
	uniform = /obj/item/clothing/under/XIV/xionplus
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/XIV/manager
	r_pocket = /obj/item/weapon/gun/projectile/revolver/holdout

//little boss
/decl/hierarchy/outfit/job/isolation/amanager
	name = OUTFIT_JOB_NAME("Navigations Officer")
	uniform = /obj/item/clothing/under/XIV/xionplus
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/XIV/amanager

//senior engineer
/decl/hierarchy/outfit/job/isolation/senior_engineer
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL
	name = OUTFIT_JOB_NAME("Systems Engineer")
	uniform = /obj/item/clothing/under/XIV/xion
	shoes = /obj/item/clothing/shoes/workboots
	id_type = /obj/item/weapon/card/id/XIV/senior_engineer
	gloves = /obj/item/clothing/gloves/thick/duty
	belt = /obj/item/weapon/storage/belt/utility/full/XIV

/decl/hierarchy/outfit/job/isolation/senior_engineer/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

//engineer
/decl/hierarchy/outfit/job/isolation/techie
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL
	name = OUTFIT_JOB_NAME("Engineering Technician")
	uniform = /obj/item/clothing/under/XIV/xion
	shoes = /obj/item/clothing/shoes/workboots
	id_type = /obj/item/weapon/card/id/XIV/engineer
	gloves = /obj/item/clothing/gloves/thick/duty
	belt = /obj/item/weapon/storage/belt/utility/full/XIV

/decl/hierarchy/outfit/job/isolation/techie/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

//doctor
/decl/hierarchy/outfit/job/isolation/doctor
	name = OUTFIT_JOB_NAME("Field Medic")
	uniform = /obj/item/clothing/under/rank/medical/XIV
	shoes = /obj/item/clothing/shoes/white
	id_type = /obj/item/weapon/card/id/XIV/doctor

/decl/hierarchy/outfit/job/isolation/doctor/New()
	..()
	BACKPACK_OVERRIDE_MEDICAL

//fabtec
/decl/hierarchy/outfit/job/isolation/science
	name = OUTFIT_JOB_NAME("Perseverance Scientist")
	uniform = /obj/item/clothing/under/rank/scientist_new
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	glasses = /obj/item/clothing/glasses/science
	id_type = /obj/item/weapon/card/id/XIV/fabtec
	shoes = /obj/item/clothing/shoes/dutyboots

//crewman
/decl/hierarchy/outfit/job/isolation/crewman
	name = OUTFIT_JOB_NAME("Perseverance Crewman")
	uniform = /obj/item/clothing/under/XIV/xion
	shoes = /obj/item/clothing/shoes/workboots
	id_type = /obj/item/weapon/card/id/XIV/assistant
	gloves = /obj/item/clothing/gloves/thick