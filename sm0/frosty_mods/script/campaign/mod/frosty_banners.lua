--TODO
--Better to go after character subtype?


---------------------------------------------------------------
--FROSTY LOGFILE GENERATION (thanks Sm0kin!)
---------------------------------------------------------------

--v function()
local function frosty_log_reset()
  if not __write_output_to_logfile then
    --return
  end
  local logTimeStamp = os.date("%d, %m %Y %X")
  --# assume logTimeStamp: string
  local popLog = io.open("sm0_log.txt", "w+")
  popLog:write("NEW LOG [" .. logTimeStamp .. "] \n")
  popLog:flush()
  popLog:close()
end

--v function(text: string | number | boolean | CA_CQI)
local function frosty_log(text)
  if not __write_output_to_logfile then
    --return
  end
  local logText = tostring(text)
  local logTimeStamp = os.date("%d, %m %Y %X")
  local popLog = io.open("frosty_log.txt", "a")
  --# assume logTimeStamp: string
  popLog:write(
    "FROSTY:  [" ..
      logTimeStamp ..
        "] [Turn: " .. tostring(cm:turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  " .. logText .. "  \n"
  )
  popLog:flush()
  popLog:close()
end

local ancillaries = {
  {ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "wh2_main_def_malekith"},
  --{ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "", rank_requirement = 10},
  --{ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "", rank_requirement = 10},
  --{ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "", rank_requirement = 10},
  --{ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "", rank_requirement = 10},
  --{ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "", rank_requirement = 10},
  --{ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "", rank_requirement = 10},
  --{ancillary_key = "frosty_black_guard_banner", faction_key = "wh2_main_def_naggarond", character_subtype_key = "", rank_requirement = 10},
  {ancillary_key = "frosty_red_guard_banner", faction_key = "wh2_main_skv_clan_mors", character_subtype_key = "wh2_main_skv_queek_headtaker", rank_requirement = 10}
} --:vector<{ancillary_key:string, faction_key: string, character_subtype_key: string, rank_requirement: number?}>

function frosty_banners()
  if cm:is_new_game() then
    frosty_log_reset()
  end
  for i = 1, #ancillaries do
    local ancillary_key = ancillaries[i].ancillary_key
    local faction_key = ancillaries[i].faction_key
    local character_subtype_key = ancillaries[i].character_subtype_key
    local rank_requirement = ancillaries[i].rank_requirement

    if not rank_requirement and not cm:get_saved_value(ancillary_key) then
      local faction = cm:get_faction(faction_key)
      local character_list = faction:character_list()
      for j = 0, character_list:num_items() - 1 do
        local current_char = character_list:item_at(j)
        local current_char_subtype_key = current_char:character_subtype_key()
        frosty_log("char_subtype_key = "..tostring(current_char_subtype_key))

        if current_char_subtype_key == character_subtype_key then
          cm:force_add_ancillary(current_char, ancillary_key, true, true)
          cm:set_saved_value(ancillary_key, true)
          frosty_log("ancillary = "..ancillary_key.." | current_char_subtype_key = "..current_char_subtype_key)
        end
      end
    elseif rank_requirement and not cm:get_saved_value(ancillary_key) then
      core:add_listener(
          "frosty_"..ancillary_key.."_CharacterTurnStart",
          "CharacterTurnStart",
          function(context)
              return context:character():character_subtype(character_subtype_key) and context:character():rank() >= rank_requirement 
          end,
          function(context)
            if not cm:get_saved_value(ancillary_key) then
              cm:force_add_ancillary(context:character(), "frosty_red_guard_banner", true, true)
              cm:set_saved_value(ancillary_key, true)
              frosty_log("ancillary = "..ancillary_key.." | current_char_subtype_key = "..character_subtype_key)
              --core:remove_listener("frosty_"..ancillary_key.."_CharacterTurnStart")
            end
          end,
          false
        )
    end
  end
end