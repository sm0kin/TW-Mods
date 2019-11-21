-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --
--                                                              AZRIK & SARTHORAEL SCRIPT                                                                --
-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- FROSTY LOGFILE GENERATION (thanks Sm0kin!)
-----------------------------------------------------------------------------------------------------------------------------------------------------------

local function frosty_log_reset()
    if not __write_output_to_logfile then
        --return
    end
    local logTimeStamp = os.date("%d, %m %Y %X")
    --# assume logTimeStamp: string
    local popLog = io.open("frosty_azrik_mod_log.txt", "w+")
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
    local popLog = io.open("frosty_azrik_mod_log.txt", "a")
    --# assume logTimeStamp: string
    popLog:write(
        "FROSTY:  [" ..
            logTimeStamp ..
                "] [Turn: " ..
                    tostring(cm:turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  " .. logText .. "  \n"
    )
    popLog:flush()
    popLog:close()
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG MODE (SET THIS = true TO ENABLE)
local enable_debug_mode = false
------------------------------------
local human_faction = cm:get_human_factions()
------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOINTS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

--WHO?
------------------------------------

--SARTHORAEL
--v function()
local function frosty_spawn_sarth()
    if
        not cm:get_saved_value("sarthorael_unlocked") and
            cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_Which_bird_value") ~= "Option_only_get_azrik"
     then
        cm:spawn_character_to_pool(
            "wh_main_chs_chaos",
            "names_name_2147357518",
            "names_name_2147357523",
            "",
            "",
            18,
            true,
            "general",
            "chs_lord_of_change",
            true,
            ""
        )
        frosty_log("### SARTHORAEL ADDED TO ROSTER! ####")
        cm:set_saved_value("sarthorael_unlocked", true)
    end
end

--AZRIK
--v function()
local function frosty_spawn_azrik()
    if
        not cm:get_saved_value("azrik_unlocked") and
            cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_Which_bird_value") ~= "Option_only_get_sarthorael"
     then
        cm:spawn_character_to_pool(
            "wh_main_chs_chaos",
            "names_name_1019189048",
            "",
            "",
            "",
            18,
            true,
            "general",
            "wh_dlc08_nor_arzik",
            true,
            ""
        )
        frosty_log("### AZRIK ADDED TO ROSTER! ####")
        cm:set_saved_value("azrik_unlocked", true)
    end
end

--v function(Tweaker_Which_bird: string, Tweaker_Boost: string, Tweaker_When: string)
local function frosty_checkpoints(Tweaker_Which_bird, Tweaker_Boost, Tweaker_When)
    --WHEN?
    ------------------------------------

    if cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_When_value") == "Option_now" then
        frosty_spawn_sarth()
        frosty_spawn_azrik()
    else
        core:add_listener(
            "lord_of_change_defeated",
            "BattleCompleted",
            function()
                local chaos_seps = cm:get_faction("wh_main_chs_chaos_separatists")
                return (chaos_seps:faction_leader():is_null_interface() or
                    not chaos_seps:faction_leader():has_military_force()) and
                    cm:pending_battle_cache_faction_is_involved("wh_main_chs_chaos_separatists")
            end,
            function(context)
                frosty_spawn_sarth()
                frosty_spawn_azrik()
                frosty_log("LORD OF CHANGE IS DEFEATED! BIRDS ARE SPAWNED!")
            end,
            false
        )
    end
end

--XP OVERRIDE CA scripts\campaign\main_warhammer\wh_dlc08_norscan_gods.lua
------------------------------------
--v function(context: CA_CHAR_CONTEXT)
function Norsca_CharacterCreated(context)
	local agent = context:character();
	
    if agent:is_null_interface() == false and agent:character_subtype("wh_dlc08_nor_arzik") or agent:character_subtype("chs_lord_of_change") then
        if cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_Boost_value") ~= "Option_no_boost" then
		out("AZRIK SPAWNED!");
		    if agent:rank() < 30 then
			    local cqi = agent:cqi();
			    cm:add_agent_experience("character_cqi:"..cqi, 30, true);
            end
        end
    end
end



-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDCENTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------

function lords_of_change()
    -----------------------------------------------------------------------------------------------------------------------------------------------------------
    -- MISC
    -----------------------------------------------------------------------------------------------------------------------------------------------------------
    --CHAOS IS HUMAN?
    if cm:get_faction("wh_main_chs_chaos"):is_human() then


        --DEBUG MODE
        if enable_debug_mode == true then
            frosty_spawn_azrik()
            frosty_spawn_sarth()
            frosty_log("DEBUG MODE: SPAWNING BIRDS IMMEDIATELY")
        end

        --GAME IN PROGRESS: SARTHORAEL ALREADY DEAD
        if cm:get_saved_value("lord_of_change_killed") and not cm:get_saved_value("sarthorael_unlocked") then
            frosty_spawn_azrik()
            frosty_spawn_sarth()
            frosty_log("LORD OF CHANGE IS ALREADY DEAD! BIRDS ARE SPAWNED!")
        end

        --OR ELSE WE WAIT FOR THE LISTENER TO FIRE

        -----------------------------------------------------------------------------------------------------------------------------------------------------------
        -- MCM OPTIONS
        -----------------------------------------------------------------------------------------------------------------------------------------------------------

        local mcm = _G.mcm
        if not (not mcm) then
            frosty_log("### SCRIPT IS RUNNING!###")
            local Lordsofchange =
                mcm:register_mod(
                "Lordsofchange",
                "Lords of Change",
                "Adds the possibility to gain the Lords of Change."
            )
            --What Lords of Change do you want?
            --mcm_tweaker_Lordsofchange_Tweaker_Which_bird_value
            local Tweaker_Which_bird = Lordsofchange:add_tweaker("Tweaker_Which_bird", "One or Both?", "")
            --(default)
            Tweaker_Which_bird:add_option("Option_get_both", "Both", "")
            Tweaker_Which_bird:add_option("Option_only_get_sarthorael", "Sarthorael Only", "")
            Tweaker_Which_bird:add_option("Option_only_get_azrik", "Azrik Only", "")
            --Boosted?
            --mcm_tweaker_Lordsofchange_Tweaker_Boost_value
            local Tweaker_Boost =
                Lordsofchange:add_tweaker(
                "Tweaker_Boost",
                "Empowered? (Lords of Change start at lvl 30 on recruitment)",
                ""
            )
            --(default)
            Tweaker_Boost:add_option("Option_yes_boost", "Yes", "")
            Tweaker_Boost:add_option("Option_no_boost", "No", "")
            --After Civil War?
            --mcm_tweaker_Lordsofchange_Tweaker_When_value
            local Tweaker_When =
                Lordsofchange:add_tweaker("Tweaker_When", "When are Lords of Change available?", "Text")
            --(default)
            Tweaker_When:add_option("Option_after", "After Civil War Event", "")
            Tweaker_When:add_option("Option_now", "Immediately", "")
            if cm:is_new_game() then
                mcm:add_new_game_only_callback(
                    function()
                        frosty_checkpoints(
                            cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_Which_bird_value"),
                            cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_Boost_value"),
                            cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_When_value")
                        )
                    end
                )
            else
                frosty_checkpoints(
                    cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_Which_bird_value"),
                    cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_Boost_value"),
                    cm:get_saved_value("mcm_tweaker_Lordsofchange_Tweaker_When_value")
                )
            end
        else
            frosty_checkpoints("Option_get_both", "Option_yes_boost", "Option_after")
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTES & CREDITS
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Authored by FrostyDemise
-- Troubleshooting assistance by Sm0kin
-- Partly based on the scriptwork by Scipion

-- Contact @FrostyDemise for suggestions/script usage
-----------------------------------------------------------------------------------------------------------------------------------------------------------
