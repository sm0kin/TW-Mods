core:add_listener(
	"hkrul_jk_special_2_3_2_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		return skill == "hkrul_jk_special_2_3_2"
	end,
	function(context)
		local character = context:character()
		local faction = character:faction()
		local faction_name = faction:name()
		local skaeling_interface = cm:get_faction("wh_main_nor_skaeling")
		
		if skaeling_interface and not skaeling_interface:is_dead() then
			cm:force_make_trade_agreement(faction_name, "wh_main_nor_skaeling")
		end
	end,
	true
)

core:add_listener(
	"hkrul_jk_special_2_3_1_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		return skill == "hkrul_jk_special_2_3_1"
	end,
	function(context)
		local character = context:character()
		local faction = character:faction()
		local faction_name = faction:name()
		local orthodoxy_interface = cm:get_faction("wh3_main_ksl_the_great_orthodoxy")
		
		if orthodoxy_interface and not orthodoxy_interface:is_dead() then
			cm:force_make_trade_agreement(faction_name, "wh3_main_ksl_the_great_orthodoxy")
            cm:make_diplomacy_available(faction_name, "wh3_main_ksl_the_great_orthodoxy")
		end
	end,
	true
)

core:add_listener(
    "hkrul_jk_special_2_2_2_CharacterSkillPointAllocated",
    "CharacterSkillPointAllocated",
    function(context)
        local skill = context:skill_point_spent_on()
        return skill == "hkrul_jk_special_2_2_2"
    end,
    function(context)
        local character = context:character()
        local faction = character:faction()
        local faction_name = faction:name()
        local estalia_interface = cm:get_faction("wh_main_teb_estalia")
        
        if estalia_interface and not estalia_interface:is_dead() then
            cm:force_make_trade_agreement(faction_name, "wh_main_teb_estalia")
            cm:make_diplomacy_available(faction_name, "wh_main_teb_estalia")
        end
    end,
    true
)

core:add_listener(
	"hkrul_jk_special_2_2_1_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		return skill == "hkrul_jk_special_2_2_1"
	end,
	function(context)
		local character = context:character()
		local faction = character:faction()
		local faction_name = faction:name()
		local tilea_interface = cm:get_faction("wh_main_teb_tilea")
		
		if tilea_interface and not tilea_interface:is_dead() then
			cm:force_make_trade_agreement(faction_name, "wh_main_teb_tilea")
            cm:make_diplomacy_available(faction_name, "wh_main_teb_tilea")
		end
	end,
	true
)

core:add_listener(
	"hkrul_jk_special_2_1_1_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		return skill == "hkrul_jk_special_2_1_1"
	end,
	function(context)
		local character = context:character()
		local faction = character:faction()
		local faction_name = faction:name()
		local averland_interface = cm:get_faction("wh_main_emp_averland")
		
		if averland_interface and not averland_interface:is_dead() then
			cm:force_alliance(faction_name, "wh_main_emp_averland", false)
		end
	end,
	true
)

core:add_listener(
	"hkrul_jk_special_2_1_2_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		return skill == "hkrul_jk_special_2_1_2"
	end,
	function(context)
		local character = context:character()
		local faction = character:faction()
		local faction_name = faction:name()
		local ostland_interface = cm:get_faction("wh_main_emp_ostland")
		
		if ostland_interface and not ostland_interface:is_dead() then
			cm:force_alliance(faction_name, "wh_main_emp_ostland", false)
		end
	end,
	true
)


core:add_listener(
    "hkrul_jk_special_0_5_CharacterSkillPointAllocated", --change for actual skill_key
    "CharacterSkillPointAllocated",
    function(context)
        local skill = context:skill_point_spent_on()
        return skill == "hkrul_jk_special_0_5" --change for actual skill_key
    end,
    function(context)
        local character = context:character()
        local faction_key = character:faction():name()
        local reikland_faction = cm:get_faction("wh_main_emp_empire")
        local money = -5000
        
        if reikland_faction and not reikland_faction:is_dead() then
            local target_region = cm:get_region("wh3_main_combi_region_eilhart") --change for actual region_key
            if target_region:owning_faction() ~= reikland_faction then
                if reikland_faction:has_home_region() then
                    target_region = reikland_faction:home_region()
                else
                    target_region = nil
                end
            end
            if target_region then
				local mf = cm:force_rebellion_with_faction(target_region, "wh_main_emp_empire_rebels", 20, true, false)
				cm:callback(
					function() 
						local unit_list = mf:unit_list()
						for i = 0, unit_list:num_items() - 1 do
							local unit = unit_list:item_at(i)
							cm:add_experience_to_unit(unit, 5)
						end
						cm:apply_effect_bundle_to_force("hkrul_mar_rebel", mf:command_queue_index(), 0)
					end, 0.1
				)
				cm:treasury_mod(faction_key, money)
			end
		end
	end,
	true
)

core:add_listener(
    "hkrul_aldred_special_3_1_CharacterSkillPointAllocated",
    "CharacterSkillPointAllocated",
    function(context)
        local skill = context:skill_point_spent_on()
        return skill == "hkrul_aldred_special_3_1"
    end,
    function(context)
        local character = context:character()
        local faction = character:faction()
        
		cm:add_unit_to_faction_mercenary_pool(
			faction,
			"wh2_dlc13_emp_inf_greatswords_ror_0",
			"imperial_supply",
			1,
			100, 
			2,
			1, --change to 0.0667 for 1 ror in 15 turns
			"",
			"",
			"",
			false,
			"wh2_dlc13_emp_inf_greatswords_ror_0"
		)
    end,
    true
)

local aldred_dilemma_key = "" --TODO:please add the correct dilemma_key
local aldred_updated_dilemma_key = "" --TODO:please add the correct dilemma_key
local aldred_subtype_key = "hkrul_aldred" --TODO: correct?
local rebel_skill_key = "hkrul_jk_special_0_5" --TODO: correct?
local rebel_skill_updated_key = "hkrul_jk_special_0_6" --TODO: correct?
local turns_until_next_dilemma = 10 --TODO: correct?

core:add_listener(
    rebel_skill_key.."_CharacterSkillPointAllocated", 
    "CharacterSkillPointAllocated",
    function(context)
        local skill = context:skill_point_spent_on()
        return skill == rebel_skill_key
    end,
    function(context)
		local faction_key = context:character():faction():name()
		local character = context:character()
		if not character:has_skill(rebel_skill_updated_key) then
			cm:trigger_dilemma(faction_key, aldred_dilemma_key)
		end
    end,
    true
)

core:add_listener(
    rebel_skill_updated_key.."_CharacterSkillPointAllocated", 
    "CharacterSkillPointAllocated",
    function(context)
        local skill = context:skill_point_spent_on()
        return skill == rebel_skill_updated_key
    end,
    function(context)
		local faction_key = context:character():faction():name()
		cm:trigger_dilemma(faction_key, aldred_updated_dilemma_key)
    end,
    true
)

core:add_listener(
	rebel_skill_key.."_CharacterTurnStart",
	function(context)
		local character = context:character()
		return character:character_subtype_key() == aldred_subtype_key and character:has_skill(rebel_skill_key) and not character:has_skill(rebel_skill_updated_key)
		and cm:get_saved_value("hkrul_aldred_next_rebel_dilemma_turn") and cm:model():turn_number() >= cm:get_saved_value("hkrul_aldred_next_rebel_dilemma_turn")
	end,
	function(context)
		local faction_key = context:character():faction():name()
		cm:trigger_dilemma(faction_key, aldred_dilemma_key)
	end,
	true
)

core:add_listener(
	rebel_skill_updated_key.."_CharacterTurnStart",
	function(context)
		local character = context:character()
		return character:character_subtype_key() == aldred_subtype_key and character:has_skill(rebel_skill_updated_key)
		and cm:get_saved_value("hkrul_aldred_next_rebel_dilemma_turn") and cm:model():turn_number() >= cm:get_saved_value("hkrul_aldred_next_rebel_dilemma_turn")
	end,
	function(context)
		local faction_key = context:character():faction():name()
		cm:trigger_dilemma(faction_key, aldred_updated_dilemma_key)
	end,
	true
)

local function process_rebel_dilemma(faction_key, target_faction_key, target_region_key)
	local reikland_faction = cm:get_faction(target_faction_key)
	
	if faction_key ~= target_faction_key and reikland_faction and not reikland_faction:is_dead() then
		local target_region = cm:get_region(target_region_key)
		if target_region:owning_faction() ~= reikland_faction then
			if reikland_faction:has_home_region() then
				target_region = reikland_faction:home_region()
			else
				target_region = nil
			end
		end
		if target_region then
		local mf = cm:force_rebellion_with_faction(target_region, "wh_main_emp_empire_rebels", 20, true, false)
			cm:callback(
				function() 
					local unit_list = mf:unit_list()
					for i = 0, unit_list:num_items() - 1 do
						local unit = unit_list:item_at(i)
						cm:add_experience_to_unit(unit, 5)
					end
					cm:apply_effect_bundle_to_force("hkrul_mar_rebel", mf:command_queue_index(), 0)
				end, 0.1
			)
		end
	end	
end

core:add_listener(
	rebel_skill_key.."_DilemmaChoiceMadeEvent", 
	"DilemmaChoiceMadeEvent",
	function(context)
		return context:dilemma() == aldred_dilemma_key
	end,
	function(context)
		local choice = context:choice()
		cm:set_saved_value("hkrul_aldred_next_rebel_dilemma_turn", cm:model():turn_number() + turns_until_next_dilemma)

		if choice == 1 then	
			--A. Eilhart (as is)
			process_rebel_dilemma(context:faction():name(), "wh_main_emp_empire", "wh3_main_combi_region_eilhart")
		elseif choice == 2 then
			--B. Carroburg (Eilhart copy - but targets Middenland)
			process_rebel_dilemma(context:faction():name(), "wh_main_emp_middenland", "wh3_main_combi_region_carroburg")
		elseif choice == 3 then
			--C. Spawn Ogre camp in province Reikland
		elseif choice == 4 then
			--D. Do nothing 
		end
	end,
	true
)

core:add_listener(
	rebel_skill_updated_key.."_DilemmaChoiceMadeEvent", 
	"DilemmaChoiceMadeEvent",
	function(context)
		return context:dilemma() == aldred_updated_dilemma_key
	end,
	function(context)
		local choice = context:choice()
		cm:set_saved_value("hkrul_aldred_next_rebel_dilemma_turn", cm:model():turn_number() + turns_until_next_dilemma)

		if choice == 1 then	
			--A. Rebel at Altdorf (as is)
			process_rebel_dilemma(context:faction():name(), "wh_main_emp_empire", "wh3_main_combi_region_altdorf")
		elseif choice == 2 then
			--B. Rebel at Middenheim (Altdorf copy)
			process_rebel_dilemma(context:faction():name(), "wh_main_emp_middenland", "wh3_main_combi_region_middenheim")
		elseif choice == 3 then
			--C. Spawn Ogre army that is at war with Reikland at X
		elseif choice == 4 then
			--D. Do nothing			
		end
	end,
	true
)

local function get_character_by_subtype(subtype, faction)
	local character_list = faction:character_list()
	
	for i = 0, character_list:num_items() - 1 do
		local character = character_list:item_at(i)
		
		if character:character_subtype(subtype) then
			return character
		end
	end
	return false
end

core:add_listener(
	"xou_zintler_ludder_bundle_skill",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()		
		return skill == "skill_zintler_second_command"
	end,
	function(context)
		local character = context:character()	
		local faction = character:faction()
		local helborg = get_character_by_subtype("emp_cha_helborg", faction)

		if helborg and helborg:has_military_force() and not helborg:has_effect_bundle("xou_campaign_bundle_zintler_second_command") then
			cm:apply_effect_bundle_to_character("xou_campaign_bundle_zintler_second_command", helborg, 0)
		end
	end,
	true
)

core:add_listener(
	"xou_zintler_bundle_backup",
	"CharacterTurnStart",
	function(context)
		local character = context:character()
		return character:character_subtype("emp_cha_helborg")
	end,
	function(context)
		local character = context:character()	
		local faction = character:faction()
		local zintler = get_character_by_subtype("emp_cap_zintler", faction)
		if zintler and zintler:has_skill("skill_zintler_second_command") and not character:has_effect_bundle("xou_campaign_bundle_zintler_second_command") then
			cm:apply_effect_bundle_to_character("xou_campaign_bundle_zintler_second_command", character, 0)
		end
	end,
	true
)


local function add_mackensen_marauder_ror()
    -- Easy data table for faction info and unit info

    local ror_table = { -- A table of many RoR's ---- BEGIN REWRITE
        { -- This is the first RoR we wish to spawn
            faction_key = "wh_main_emp_empire", -- The faction we're adding this RoR to from `factions`
            unit_key = "hkrul_mackensens_marauders", -- The unit key from `main_units`
            merc_pool = "renown", -- The mercenary pool we're adding this RoR to from `recruitment_sources`
            merc_group = "hkrul_mackensens_marauders", -- The mercenary pool group this unit belongs to in `mercenary_unit_groups`
            count = 1, -- The number of RoRs we're adding this will be 1 by default, only put this line if you're seeking to change the number added
        }, -- and you can make a new table for each other RoR you're seeking to add!
                { -- This is the first RoR we wish to spawn
            faction_key = "wh_main_emp_empire_separatists", -- The faction we're adding this RoR to from `factions`
            unit_key = "hkrul_mackensens_marauders", -- The unit key from `main_units`
            merc_pool = "renown", -- The mercenary pool we're adding this RoR to from `recruitment_sources`
            merc_group = "hkrul_mackensens_marauders", -- The mercenary pool group this unit belongs to in `mercenary_unit_groups`
            count = 1, -- The number of RoRs we're adding this will be 1 by default, only put this line if you're seeking to change the number added
        }, -- and you can make a new table for each other RoR you're seeking to add!
    } -- Closing out the ror_table variable!

    ---- END REWRITE.

    -- List of default values to shove into the function before shouldn't need to be changed, usecase may vary.
    local defaults = {
        replen_chance = 100,
        max = 1,
        max_per_turn = 0.1,
        xp_level = 0,
        faction_restriction = "", 
        subculture_restriction = "",
        tech_restriction = "",
        partial_replenishment = true,
    }

    for i, ror in pairs(ror_table) do
        local faction_key, unit_key = ror.faction_key, ror.unit_key
        local merc_pool, merc_group = ror.merc_pool, ror.merc_group
        local count = ror.count or 1 -- if ror.count is undefined, we'll just use the default of 1!

        local faction = cm:get_faction(faction_key)
        if faction then
            cm:add_unit_to_faction_mercenary_pool(
                faction,
                unit_key,
                merc_pool,
                count,
                defaults.replen_chance,
                defaults.max,
                defaults.max_per_turn,
                defaults.faction_restriction,
                defaults.subculture_restriction,
                defaults.tech_restriction,
                defaults.partial_replenishment,
                merc_group
            )
        end
    end
end

cm:add_first_tick_callback(function()
    core:call_once(
        "add_mackensens_ror", -- RENAME this to a unique string this is what the game uses to determine if the below code has been run before, must be unique per instance!
        add_mackensen_marauder_ror -- Run the above function, rename if you've changed the name of the function above!
    ) 
end)


core:add_listener(
    "landship_ror_unlock",
    "RitualCompletedEvent",
    function(context)
        return context:performing_faction():is_human() and context:ritual():ritual_key() == "hkrul_mar_ritual_rebels"
    end,
    function(context)
        cm:remove_event_restricted_unit_record_for_faction("snek_hkrul_mar_ror_landship", context:performing_faction():name())
    end,
    true
)

cm:add_first_tick_callback(function()
    if cm:is_new_game() then
        cm:add_event_restricted_unit_record_for_faction("snek_hkrul_mar_ror_landship", "wh_main_emp_marienburg", "hkrul_mar_lock_landship_ror")
    end
end)    