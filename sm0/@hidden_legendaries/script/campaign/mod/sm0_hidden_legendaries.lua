--v function()
local function sm0_log_reset()
	if not __write_output_to_logfile then
		return
	end
	local log_time_stamp = os.date("%d, %m %Y %X")
	--# assume log_time_stamp: string
	local pop_log = io.open("sm0_log.txt","w+")
	pop_log :write("NEW LOG ["..log_time_stamp.."] \n")
	pop_log :flush()
	pop_log :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function sm0_log(text)
	if not __write_output_to_logfile then
		return
	end
	local log_text = tostring(text)
	local log_time_stamp = os.date("%d, %m %Y %X")
	local pop_log = io.open("sm0_log.txt","a")
	--# assume log_time_stamp: string
	pop_log :write("HL:  [".. log_time_stamp .. "] [Turn: ".. tostring(cm:turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..log_text .. "  \n")
	pop_log :flush()
	pop_log :close()
end

-- Warhammer II Extra Items
local louen_subtype = "brt_louen_leoncouer"
local tyrion_subtype = "wh2_main_hef_tyrion"
local teclis_subtype = "wh2_main_hef_teclis"
local alith_anar_subtype = "wh2_dlc10_hef_alith_anar"
local malekith_subtype = "wh2_main_def_malekith"
local morathi_subtype = "wh2_main_def_morathi"

local tyrion_extra_items = {
	{"mission", "wh2_main_anc_enchanted_item_heart_of_avelorn", "sm0_tyrion_heart_of_avelorn", "14"}
}

local teclis_extra_items = {
	{"mission", "wh2_main_anc_arcane_item_moon_staff_of_lileath", "sm0_teclis_moon_staff_of_lileath", "14"},
	{"mission", "wh2_main_anc_arcane_item_scroll_of_hoeth", "sm0_teclis_scroll_of_hoeth", "18"}
}

local malekith_extra_items = {
	{"mission", "wh2_main_anc_armour_armour_of_midnight", "sm0_malekith_armour_of_midnight", "18"}
}

local morathi_extra_items = {
	{"mission", "wh2_main_anc_arcane_item_wand_of_the_kharaidon", "sm0_morathi_wand_of_the_kharaidon", "10"},
	{"mission", "wh2_main_anc_talisman_amber_amulet", "sm0_morathi_talisman_amber_amulet", "14"}
}

local louen_extra_items = {
	{"mission", "wh_main_anc_armour_the_lions_shield", "sm0_louen_lions_shield", "13"},
	{"mission", "wh_main_anc_enchanted_item_the_crown_of_bretonnia", "sm0_louen_crown_of_bretonnia", "17"}
}

local alith_anar_extra_items = {
	{"mission", "wh2_dlc10_anc_enchanted_item_the_shadow_crown", "sm0_alith_anar_the_shadow_crown", "9"},
}

--v function(quests: vector<vector<string>>, subtype: string)
local function setupRankListener(quests, subtype)
	for i = 1, #quests do
		-- grab some local data for this quest record
		local current_quest_record = quests[i]
		
		local current_type = current_quest_record[1]
		local current_ancillary_key = current_quest_record[2]
		local current_mission_key = current_quest_record[3]
		local current_rank_req = tonumber(current_quest_record[4])
		local current_intervention_name = "in_" .. current_mission_key
		local current_saved_name = current_mission_key .. "_sm0_issued"
				
		-- establish listeners for this character rank-up event if the quest chain has not already been started
		if cm:get_saved_value(current_saved_name) then
			out("already started")
		else			
			-- listen for the character ranking up
			core:add_listener(
				current_mission_key,
				"CharacterTurnStart",
				function(context)
					return context:character():character_subtype(subtype) and context:character():rank() >= current_rank_req 
				end,
				function(context)
					local character = context:character()
					
					-- save this value in order to not issue this quest multiple times
					cm:set_saved_value(current_saved_name, true)
					
					-- give the ancillary to the character
					cm:force_add_ancillary(character, current_ancillary_key, true, false)
				end,
				false
			)
		end
	end
end

function sm0_hidden_legendaries()
	setupRankListener(tyrion_extra_items, tyrion_subtype)
	setupRankListener(teclis_extra_items, teclis_subtype)
	setupRankListener(malekith_extra_items, malekith_subtype)
	setupRankListener(morathi_extra_items, morathi_subtype)
	setupRankListener(louen_extra_items, louen_subtype)	
	--setupRankListener(alith_anar_extra_items, alith_anar_subtype)
end