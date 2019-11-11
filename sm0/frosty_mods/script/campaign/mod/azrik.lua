-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --
--                                                              AZRIK & SARTHORAEL SCRIPT                                                                --
-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- FROSTY LOGFILE GENERATION (thanks Sm0kin!)
-----------------------------------------------------------------------------------------------------------------------------------------------------------

--v function()
local function frosty_log_reset()
    if not __write_output_to_logfile then
        return
    end
    local logTimeStamp = os.date("%d, %m %Y %X")
    --# assume logTimeStamp: string
    local popLog = io.open("frosty_log.txt", "w+")
    popLog:write("NEW LOG [" .. logTimeStamp .. "] \n")
    popLog:flush()
    popLog:close()
end

--v function(text: string | number | boolean | CA_CQI)
local function frosty_log(text)
    if not __write_output_to_logfile then
        return
    end
    local logText = tostring(text)
    local logTimeStamp = os.date("%d, %m %Y %X")
    local popLog = io.open("frosty_log.txt", "a")
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
-- MCM Options
-----------------------------------------------------------------------------------------------------------------------------------------------------------

--What Lords of Change do you want?
--Both (default)
--Sarthorael
--Azrik

--When should they be recruitable?
--After Civil War Event (default)
--Immediately

--Do they have Tzeentch's favor? (start at level 30)
--Yes (default)
--No

--cm:add_agent_experience("character_cqi:"..cqi, 30, true);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- DEBUG MODE (SET = true TO ENABLE)
------------------------------
local enable_debug_mode = true
------------------------------

local player_faction = cm:get_local_faction(true)

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

local function spawn_birds()
    --Add Sarthorael
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
        frosty_log("### Sarthorael added to roster! ####")
        cm:set_saved_value("sarthorael_unlocked", true)
    
    --Add Azrik
        cm:spawn_character_to_pool(
            "wh_main_chs_chaos",
            "names_name_535773478",
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
        frosty_log("### Azrik added to roster! ####")
        cm:set_saved_value("azrik_unlocked", true)
    
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. LISTENERS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

core:add_listener(
    "lord_of_change_defeated",
    "BattleCompleted",
    function()
        local chaos_seps = cm:get_faction("wh_main_chs_chaos_separatists")
        return (chaos_seps:faction_leader():is_null_interface() or not chaos_seps:faction_leader():has_military_force()) and
            cm:pending_battle_cache_faction_is_involved("wh_main_chs_chaos_separatists")
    end,
    function(context)
        spawn_birds()
        frosty_log("LORD OF CHANGE IS DEFEATED! BIRDS ARE SPAWNED!")
    end,
    false
)

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. COMMAND CENTER
-----------------------------------------------------------------------------------------------------------------------------------------------------------

function azrik()
    frosty_log("### Script is running!###")

    --NEW GAME? LOG RESET!
    if cm:is_new_game() then
        frosty_log_reset()
    end

    --YOU HAVE TO BE HUMAN, LIVING AND CHAOS
    if player_faction == "wh_main_chs_chaos" then
        --DEBUG MODE?
        if enable_debug_mode == true then
            spawn_birds()
            --SARTHORAEL ALREADY DEAD?
            if
                cm:get_saved_value("lord_of_change_killed") and not cm:get_saved_value("sarthorael_unlocked") and
                    not cm:get_saved_value("azrik_unlocked")
             then
                spawn_birds()
                frosty_log("LORD OF CHANGE IS ALREADY DEAD! BIRDS ARE SPAWNED!")
            end
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. OVERRIDE VANILLA FUNCTION GIFTING AZRIK XP
-----------------------------------------------------------------------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- NOTES & CREDITS
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Authored by FrostyDemise
-- Based on the scriptwork by Scipion
-- Special thanks to Sm0kin for troubleshooting assistance and guidance

-- Contact @FrostyDemise for suggestions/script usage
-----------------------------------------------------------------------------------------------------------------------------------------------------------
