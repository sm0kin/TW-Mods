local subtype_to_mount_list = {
    ["wh2_main_def_dreadlord"] = {
        skill = 		"wh2_main_skill_def_dreadlord_mount_cold_one",
        ancillary =		"wh2_main_anc_mount_def_dreadlord_cold_one"
    },
    ["wh2_main_def_dreadlord_fem"] = {
        skill = 		"wh2_main_skill_def_dreadlord_fem_mount_cold_one",
        ancillary =		"wh2_main_anc_mount_def_dreadlord_fem_cold_one"
    },
    ["wh2_dlc10_def_supreme_sorceress_beasts"] = {
        skill = 		"wh2_dlc10_skill_def_sorceress_beasts_mount_cold_one",
        ancillary =		"wh2_dlc10_anc_mount_def_supreme_sorceress_beasts_cold_one"
    },
    ["wh2_dlc10_def_supreme_sorceress_dark"] = {
        skill = 		"wh2_dlc10_skill_def_supreme_sorceress_dark_mount_cold_one",
        ancillary =		"wh2_dlc10_anc_mount_def_supreme_sorceress_dark_cold_one"
    },
    ["wh2_dlc10_def_supreme_sorceress_death"] = {
        skill = 		"wh2_dlc10_skill_def_supreme_sorceress_death_mount_cold_one",
        ancillary =		"wh2_dlc10_anc_mount_def_supreme_sorceress_death_cold_one"
    },
    ["wh2_dlc10_def_supreme_sorceress_fire"] = {
        skill = 		"wh2_dlc10_skill_def_supreme_sorceress_fire_mount_cold_one",
        ancillary =		"wh2_dlc10_anc_mount_def_supreme_sorceress_fire_cold_one"
    },
    ["wh2_dlc10_def_supreme_sorceress_shadow"] = {
        skill = 		"wh2_dlc10_skill_def_supreme_sorceress_shadow_mount_cold_one",
        ancillary =		"wh2_dlc10_anc_mount_def_supreme_sorceress_shadow_cold_one"
    },
    ["wh2_dlc10_def_sorceress_beasts"] = {
        skill = 		"wh2_dlc10_skill_def_sorceress_beasts_mount_cold_one",
        ancillary =		"wh2_dlc10_anc_mount_def_sorceress_beasts_cold_one"
    },
    ["wh2_dlc10_def_sorceress_death"] = {
        skill = 		"wh2_dlc10_skill_def_sorceress_death_mount_cold_one",
        ancillary =		"wh2_dlc10_anc_mount_def_sorceress_death_cold_one"
    },
    ["wh2_main_def_sorceress_dark"] = {
        skill = 		"wh2_main_skill_def_sorceress_dark_mount_cold_one",
        ancillary =		"wh2_main_anc_mount_def_sorceress_dark_cold_one"
    },
    ["wh2_main_def_sorceress_fire"] = {
        skill = 		"wh2_main_skill_def_sorceress_fire_mount_cold_one",
        ancillary =		"wh2_main_anc_mount_def_sorceress_fire_cold_one"
    },
    ["wh2_main_def_sorceress_shadow"] = {
        skill = 		"wh2_main_skill_def_sorceress_shadow_mount_cold_one",
        ancillary =		"wh2_main_anc_mount_def_sorceress_shadow_cold_one"
	}
} --:map<string, map<WHATEVER, string>>    

--v function(character: CA_CHAR)
function AddMount(character)
	local subtype_key = character:character_subtype_key()
	
    if subtype_to_mount_list[subtype_key] then
        out("* AddMount is adding skill " .. subtype_to_mount_list[subtype_key].skill .. " and ancillary " 
        .. subtype_to_mount_list[subtype_key].ancillary .. " to character with subtype " .. subtype_key 
        .. ", forename " .. tostring(character:get_forename()) .. ", surname " .. tostring(character:get_surname()) 
        .. ", position [" .. character:logical_position_x() .. ", " .. character:logical_position_y() .. "], faction " 
        .. character:faction():name() .. ", cqi " .. tostring(character:command_queue_index()))
		--cm:force_add_skill(cm:char_lookup_str(character), subtype_to_mount_list[subtype_key].skill)
		cm:force_add_ancillary(character, subtype_to_mount_list[subtype_key].ancillary, true, true)
	end
end
 
function add_mounts_experiment()
	out("#### Adding Mount Upgrade Listeners ####")
	
	core:add_listener(
		"MountListener",
		"CharacterCreated",
		function(context)
			local character = context:character()
			local faction = character:faction()
			local culture = faction:culture()
			
			return culture == "wh2_main_def_dark_elves"
		end,
		function(context)
			AddMount(context:character())
		end,
		true
	)
    	
	if cm:is_new_game() then
		local faction_list = cm:model():world():faction_list()
		
		for i = 0, faction_list:num_items() - 1 do
			local current_faction = faction_list:item_at(i)
			local current_faction_culture = current_faction:culture()
			
			if current_faction_culture == "wh2_main_def_dark_elves" then
				local character_list = current_faction:character_list()
				
				for j = 0, character_list:num_items() - 1 do
					AddMount(character_list:item_at(j))
				end
			end
		end
	end
end