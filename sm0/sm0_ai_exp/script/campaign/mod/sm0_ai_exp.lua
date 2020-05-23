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
	pop_log :write("XP:  [".. log_time_stamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..log_text .. "  \n")
	pop_log :flush()
	pop_log :close()
end

function sm0_ai_exp()
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
	end
	core:add_listener(
        "ai_exp_CharacterTurnStart",
        "CharacterTurnStart",
        function(context)
            return not context:character():faction():is_human() and not context:character():faction():is_rebel() and not context:character():faction():is_quest_battle_faction()
        end,
        function(context)
			local char = context:character()
			local character_subtype = char:character_subtype_key()
            if cm:char_is_general(char) and character_subtype ~= "wh2_main_def_black_ark" and character_subtype ~= "wh2_main_skv_plague_priest_ritual" and character_subtype ~= "wh2_main_skv_warlock_engineer_ritual" 
            and ((char:has_military_force() and not char:military_force():is_armed_citizenry() and char:rank() < 20) or (char:is_faction_leader() and char:rank() <= 30)) then
				cm:add_agent_experience(cm:char_lookup_str(char:command_queue_index()), 500)
				if char:is_faction_leader() then
					--sm0_log("EXP | Faction: "..context:character():faction():name().." | Char Subtype: "..char:character_subtype_key().." | Faction Leader | Char Rank: "..tostring(char:rank()))
				else
					--sm0_log("EXP | Faction: "..context:character():faction():name().." | Char Subtype: "..char:character_subtype_key().." | Char Rank: "..tostring(char:rank()))
				end
			else
				--sm0_log("NO_EXP | Faction: "..context:character():faction():name().." | Char Subtype: "..char:character_subtype_key().." | Char Rank: "..tostring(char:rank()))
            end
        end,
        true
    )
end