-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --
--                                                              AZRIK & SARTHORAEL SCRIPT                                                                --
-- <><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><><><><><><><><><><><><><><> --

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- FROSTY LOGFILE GENERATION (thanks Sm0kin!)
-----------------------------------------------------------------------------------------------------------------------------------------------------------

local function frosty_log_reset()
    if not __write_output_to_logfile then
        return
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
        return
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

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOINTS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

--WHO?
------------------------------------

--SARTHORAEL
--v function(_01_Tweaker_Which_bird: string)
local function frosty_spawn_sarth(_01_Tweaker_Which_bird)
    if not cm:get_saved_value("sarthorael_unlocked") 
    and (_01_Tweaker_Which_bird == "only_sarthorael" or _01_Tweaker_Which_bird == "both") then
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
        local mct = core:get_static_object("mod_configuration_tool")
        if mct then
            local lords_of_change_mod = mct:get_mod_by_key("lords_of_change")
            local enable_option = lords_of_change_mod:get_option_by_key("a_enable")
            enable_option:set_read_only()
        end 
    end
end

--AZRIK
--v function(_01_Tweaker_Which_bird: string)
local function frosty_spawn_azrik(_01_Tweaker_Which_bird)
    if not cm:get_saved_value("azrik_unlocked") 
    and (_01_Tweaker_Which_bird == "only_azrik" or _01_Tweaker_Which_bird == "both") then
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
        local mct = core:get_static_object("mod_configuration_tool")
        if mct then
            local lords_of_change_mod = mct:get_mod_by_key("lords_of_change")
            local options = {
                "a_enable",
                "a_which_bird",
                "c_when"
            } --: vector<string>
            for i = 1, #options do
                local option = lords_of_change_mod:get_option_by_key(options[i])
                option:set_read_only()
            end
        end 
    end
end

--v function(enable: WHATEVER, _01_Tweaker_Which_bird: WHATEVER, _02_Tweaker_Boost: WHATEVER, _03_Tweaker_When: WHATEVER)
local function frosty_checkpoints(enable, _01_Tweaker_Which_bird, _02_Tweaker_Boost, _03_Tweaker_When)
    core:remove_listener("lord_of_change_defeated")
    core:remove_listener("lord_of_change_Norsca_CharacterCreated")
    if enable then
        if _03_Tweaker_When == "Option_now" or _03_Tweaker_When == true then
            frosty_spawn_sarth(_01_Tweaker_Which_bird)
            frosty_spawn_azrik(_01_Tweaker_Which_bird)
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
                    frosty_spawn_sarth(_01_Tweaker_Which_bird)
                    frosty_spawn_azrik(_01_Tweaker_Which_bird)
                    frosty_log("LORD OF CHANGE IS DEFEATED! BIRDS ARE SPAWNED!")
                end,
                false
            )
        end
        if _02_Tweaker_Boost == "_01_Option_yes_boost" or _02_Tweaker_Boost == true then                    
            core:remove_listener("Norsca_CharacterCreated") --Listener replacement: CA scripts\campaign\main_warhammer\wh_dlc08_norscan_gods.lua
            core:add_listener(
                "lord_of_change_Norsca_CharacterCreated",
                "CharacterCreated",
                true,
                function(context) local agent = context:character()
                    if agent:is_null_interface() == false and (agent:character_subtype("wh_dlc08_nor_arzik") or agent:character_subtype("chs_lord_of_change")) then
                        out("AZRIK/SARTHORAEL SPAWNED!")
                        if agent:rank() < 30 then
                            local cqi = agent:command_queue_index()
                            cm:add_agent_experience("character_cqi:"..cqi, 30, true)
                        end
                    end
                end,
                true
            )
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
    local human_faction = cm:get_human_factions()

    --CHAOS IS HUMAN?
    if cm:get_faction("wh_main_chs_chaos"):is_human() then

        --DEBUG MODE
        if enable_debug_mode == true then
            frosty_spawn_azrik("both")
            frosty_spawn_sarth("both")
            frosty_log("DEBUG MODE: SPAWNING BIRDS IMMEDIATELY")
        end

        --GAME IN PROGRESS: SARTHORAEL ALREADY DEAD
        if cm:get_saved_value("lord_of_change_killed") and not cm:get_saved_value("sarthorael_unlocked") then
            frosty_spawn_azrik("both")
            frosty_spawn_sarth("both")
            frosty_log("LORD OF CHANGE IS ALREADY DEAD! BIRDS ARE SPAWNED!")
        end

        --OR ELSE WE WAIT FOR THE LISTENER TO FIRE

        -----------------------------------------------------------------------------------------------------------------------------------------------------------
        -- MCM OPTIONS
        -----------------------------------------------------------------------------------------------------------------------------------------------------------

        local mcm = _G.mcm
        local mct = core:get_static_object("mod_configuration_tool")
        if mct then
            local lords_of_change_mod = mct:get_mod_by_key("lords_of_change")
            local settings_table = lords_of_change_mod:get_settings() 
            frosty_checkpoints(settings_table.a_enable, settings_table.a_which_bird, settings_table.b_boost, settings_table.c_when)
            core:add_listener(
                "lords_of_change_MctFinalized",
                "MctFinalized",
                true,
                function(context)
                    local mct = get_mct()
                    local lords_of_change_mod = mct:get_mod_by_key("lords_of_change")
                    local settings_table = lords_of_change_mod:get_settings() 

                    frosty_checkpoints(settings_table.a_enable, settings_table.a_which_bird, settings_table.b_boost, settings_table.c_when)
                end,
                true
            )
        elseif not (not mcm) then
            frosty_log("### SCRIPT IS RUNNING!###")
            local Lordsofchange =
                mcm:register_mod(
                "Lordsofchange",
                "Lords of Change",
                "Adds the possibility to gain the Lords of Change."
            )
            --MOD ENABLED?
            local _00_Tweaker_mod_Enabled = Lordsofchange:add_tweaker("_00_Tweaker_mod_Enabled", "Mod Status", "")
            _00_Tweaker_mod_Enabled:add_option("a1_enable", "Enabled", "")
            _00_Tweaker_mod_Enabled:add_option("a2_disable", "Disabled", "")
    
            --What Lords of Change do you want?
            --mcm_tweaker_Lordsofchange__01_Tweaker_Which_bird_value
            local _01_Tweaker_Which_bird = Lordsofchange:add_tweaker("_01_Tweaker_Which_bird", "One or Both?", "")
            --(default)
            _01_Tweaker_Which_bird:add_option("both", "Both", "")
            _01_Tweaker_Which_bird:add_option("only_sarthorael", "Sarthorael Only", "")
            _01_Tweaker_Which_bird:add_option("only_azrik", "Azrik Only", "")
            --Boosted?
            --mcm_tweaker_Lordsofchange__02_Tweaker_Boost_value
            local _02_Tweaker_Boost =
                Lordsofchange:add_tweaker(
                "_02_Tweaker_Boost",
                "Empowered? (Lords of Change start at lvl 30 on recruitment)",
                ""
            )
            --(default)
            _02_Tweaker_Boost:add_option("_01_Option_yes_boost", "Yes", "")
            _02_Tweaker_Boost:add_option("_02_Option_no_boost", "No", "")
            --After Civil War?
            --mcm_tweaker_Lordsofchange__03_Tweaker_When_value
            local _03_Tweaker_When =
                Lordsofchange:add_tweaker("_03_Tweaker_When", "When are Lords of Change available?", "Text")
            --(default)
            _03_Tweaker_When:add_option("Option_after", "After Civil War Event", "")
            _03_Tweaker_When:add_option("Option_now", "Immediately", "")
            if cm:is_new_game() then
                mcm:add_new_game_only_callback(
                    function()
                        if cm:get_saved_value("mcm_tweaker_Lordsofchange__00_Tweaker_mod_Enabled_value") == "a1_enable" then
                        frosty_checkpoints(
                            true,
                            cm:get_saved_value("mcm_tweaker_Lordsofchange__01_Tweaker_Which_bird_value"),
                            cm:get_saved_value("mcm_tweaker_Lordsofchange__02_Tweaker_Boost_value"),
                            cm:get_saved_value("mcm_tweaker_Lordsofchange__03_Tweaker_When_value")
                        )
                    end
                end
                )
            else
                frosty_checkpoints(
                    true,
                    cm:get_saved_value("mcm_tweaker_Lordsofchange__01_Tweaker_Which_bird_value"),
                    cm:get_saved_value("mcm_tweaker_Lordsofchange__02_Tweaker_Boost_value"),
                    cm:get_saved_value("mcm_tweaker_Lordsofchange__03_Tweaker_When_value")
                )
            end
        else
            frosty_checkpoints(true, "both", "_01_Option_yes_boost", "Option_after")
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
