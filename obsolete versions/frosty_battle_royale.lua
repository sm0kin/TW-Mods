-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --
--                                                      BATTLE ROYALE SCRIPT
-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --

------------------------------------------------------------------------------------------------------------------------------------
-- FROSTY LOGFILE GENERATION (thanks Sm0kin!)
------------------------------------------------------------------------------------------------------------------------------------

local function frosty_log_reset()
    if not __write_output_to_logfile then
    --return
    end
    local logTimeStamp = os.date("%d, %m %Y %X")
    --# assume logTimeStamp: string
    local popLog = io.open("frosty_battle_royale_mod_log.txt", "w+")
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
    local popLog = io.open("frosty_battle_royale_mod_log.txt", "a")
    --# assume logTimeStamp: string
    popLog:write("FROSTY:  [" .. logTimeStamp .. "] [Turn: " .. tostring(cm:turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  " .. logText .. "  \n")
    popLog:flush()
    popLog:close()
end

------------------------------------------------------------------------------------------------------------------------------------
--CHECKPOINTS
------------------------------------------------------------------------------------------------------------------------------------

local function frosty_trigger_wars()
    frosty_log("<<>><<>><<>><<>><<>><<>> frosty_trigger_wars() called <<>><<>><<>><<>><<>><<>>")

    local faction_list = cm:model():world():faction_list()

    --DRAFT TWO LISTS OF CANDIDATES
    -----------------------------
    for i = 0, faction_list:num_items() - 1 do
        local faction_l1 = faction_list:item_at(i)
        if not faction_l1:is_dead() then
            for j = 0, faction_list:num_items() - 1 do
                local faction_l2 = faction_list:item_at(j)

                --PAPERS PLEASE
                -----------------------------
                if not faction_l2:is_dead() and (faction_l1:name() ~= faction_l2:name()) and not faction_l1:at_war_with(faction_l2) then
                    --SETTINGS AND FILTERS
                    -----------------------------
                    --	if (faction_list:item_at(i):subculture() ~= restricted then
                    -- if player_only

                    --MATCH CANDIDATES
                    -----------------------------
                    --cm:callback(
                    --function()
                    frosty_log("Matching [" .. faction_l1:name() .. "] with [" .. faction_l2:name() .. "]")
                    cm:force_declare_war(faction_l1:name(), faction_l2:name(), false, false)
                    frosty_log("Attempting to declare war between [" .. faction_l1:name() .. "] and [" .. faction_l2:name() .. "]")
                    if faction_l1:at_war_with(faction_l2) == true then
                        frosty_log("Success! Faction [" .. faction_l1:name() .. "] declares war on [" .. faction_l2:name() .. "]!")
                    elseif faction_l1:at_war_with(faction_l2) == false then
                        frosty_log("Failure! Faction [" .. faction_l1:name() .. "] is not at war with [" .. faction_l2:name() .. "]!")
                    end

                    --end,
                    --0.15
                    --)
                    end
                end
            end
        end
    end

------------------------------------------------------------------------------------------------------------------------------------
--CALL CENTER
------------------------------------------------------------------------------------------------------------------------------------

function frosty_battle_royale()
    frosty_log("<<>><<>><<>><<>><<>><<>> frosty_battle_royale() called <<>><<>><<>><<>><<>><<>>")

    --script active check
    cm:treasury_mod(cm:get_local_faction(), 444444)

    --if cm:is_new_game() then
    --frosty_log_reset()

    cm:force_diplomacy("all", "all", "peace", false, false, true)
    frosty_log("########################### No peace, just war! ###########################")

    cm:force_diplomacy("all", "all", "war", true, true, true)
    frosty_log("########################### I SAID JUST WAR! ###########################")

    --if cm:is_new_game() or not cm:get_saved_value("world_war_triggered") then
    --cm:callback(
    --function()
    frosty_trigger_wars()
    --end,
    --1
    --)
    cm:set_saved_value("world_war_triggered", true)
    --else
    --frosty_log("########################### script not activated ###########################")
    --end
end
------------------------------------------------------------------------------------------------------------------------------------
-- MCM OPTIONS
------------------------------------------------------------------------------------------------------------------------------------

--end
