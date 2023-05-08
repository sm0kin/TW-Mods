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