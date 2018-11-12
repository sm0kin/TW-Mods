		-- Warhammer II Extra Items
local louen_subtype = "brt_louen_leoncouer";
local tyrion_subtype = "wh2_main_hef_tyrion";
local teclis_subtype = "wh2_main_hef_teclis";
local alith_anar_subtype = "wh2_dlc10_hef_alith_anar";
local malekith_subtype = "wh2_main_def_malekith";
local morathi_subtype = "wh2_main_def_morathi";

local tyrion_extra_items = {
	{"mission", "wh2_main_anc_enchanted_item_heart_of_avelorn", "wh2_main_vortex_narrative_hef_the_phoenix_gate", 14}
};

local teclis_extra_items = {
	{"mission", "wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", 14},
	{"mission", "wh2_main_anc_arcane_item_scroll_of_hoeth", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", 18}
};

local malekith_extra_items = {
	{"mission", "wh2_main_anc_armour_armour_of_midnight", "wh2_main_vortex_narrative_def_hoteks_levy", 18}
};

local morathi_extra_items = {
	{"mission", "wh2_main_anc_arcane_item_wand_of_the_kharaidon", "wh2_main_vortex_narrative_def_a_torturer_has_many_tools", 10},
	{"mission", "wh2_main_anc_talisman_amber_amulet", "wh2_main_vortex_narrative_def_an_age_of_blood", 14}
};

local louen_extra_items = {
	{"mission", "wh_main_anc_armour_the_lions_shield", "sm0_louen_lions_shield", 13},
	{"mission", "wh_main_anc_enchanted_item_the_crown_of_bretonnia", "sm0_louen_crown_of_bretonnia", 17}
};

local alith_anar_extra_items = {
	{"mission", "wh2_dlc10_anc_enchanted_item_the_shadow_crown", "sm0__alith_anar_the_shadow_crown", 9},
};

function setupListener()
	setupRankListener(tyrion_extra_items, tyrion_subtype);
	setupRankListener(teclis_extra_items, teclis_subtype);
	setupRankListener(malekith_extra_items, malekith_subtype);
	setupRankListener(morathi_extra_items, morathi_subtype);
	setupRankListener(louen_extra_items, louen_subtype);	
	setupRankListener(alith_anar_extra_items, alith_anar_subtype);
end

function setupRankListener(quests, subtype)
	for i = 1, #quests do
		-- grab some local data for this quest record
		local current_quest_record = quests[i];
		
		local current_type = current_quest_record[1];
		local current_ancillary_key = current_quest_record[2];
		local current_mission_key = current_quest_record[3];
		local current_rank_req = current_quest_record[4];
		local current_intervention_name = "in_" .. current_mission_key;
		local current_saved_name = current_mission_key .. "_sm0_issued";
				
		-- establish listeners for this character rank-up event if the quest chain has not already been started
		if cm:get_saved_value(current_saved_name) then
			out("")
		else			
			-- listen for the character ranking up
			core:add_listener(
				current_mission_key,
				"CharacterTurnStart",
				function(context)
					return context:character():character_subtype(subtype) and context:character():rank() >= current_rank_req 
				end,
				function(context)
					local character = context:character();
					
					-- save this value in order to not issue this quest multiple times
					cm:set_saved_value(current_saved_name, true);
					
					-- give the ancillary to the character
					cm:force_add_ancillary(cm:char_lookup_str(character), current_ancillary_key);
				end,
				false
			);
		end;
	end;
end;

events.FirstTickAfterWorldCreated[#events.FirstTickAfterWorldCreated+1] = 
function(context) 
	setupListener();
	return true;
end;
