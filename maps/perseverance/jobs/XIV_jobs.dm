/datum/map/isolation
    flags = MAP_HAS_BRANCH | MAP_HAS_RANK

/datum/map/isolation
	species_to_job_whitelist = list(
		/datum/species/adherent = list(),
		/datum/species/nabber = list(),
		/datum/species/vox = list(),
		/datum/species/unathi = list(),
		/datum/species/mantid = list(),
		/datum/species/human/mule = list()
	)

	allowed_jobs = list(/datum/job/manager, /datum/job/amanager, /datum/job/engineer, /datum/job/doctor, /datum/job/science
						) //this actually also sets in what order the jobs show on the occupation screen, neat

	access_modify_region = list(
		ACCESS_REGION_SECURITY = list(access_change_ids),
		ACCESS_REGION_MEDBAY = list(access_change_ids),
		ACCESS_REGION_RESEARCH = list(access_change_ids),
		ACCESS_REGION_ENGINEERING = list(access_change_ids),
		ACCESS_REGION_COMMAND = list(access_change_ids),
		ACCESS_REGION_GENERAL = list(access_change_ids),
		ACCESS_REGION_SUPPLY = list(access_change_ids),
		ACCESS_REGION_NT = list(access_change_ids)
	)

/datum/map/isolation/setup_job_lists()
	for(var/job_type in allowed_jobs)
		var/datum/job/job = SSjobs.get_by_path(job_type)
		// Most species are restricted from SCG security and command roles
		if(job && (job.department_flag & COM) && job.allowed_branches.len && !(/datum/mil_branch/civilian in job.allowed_branches))
			for(var/species_name in list(SPECIES_IPC, SPECIES_SKRELL, SPECIES_UNATHI))
				var/datum/species/S = all_species[species_name]
				var/species_blacklist = species_to_job_blacklist[S.type]
				if(!species_blacklist)
					species_blacklist = list()
					species_to_job_blacklist[S.type] = species_blacklist
				species_blacklist |= job.type