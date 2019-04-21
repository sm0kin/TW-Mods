-- Script by FrostyDemise
-- To any scripters sneaking a peek, feel free to hola at me
-- if you got suggestions on how to improve the script

----------------------------------
-- PHASE ONE: INITIALIZE SCRIPT
----------------------------------

function legendary_confeds_vor()
    out("########## INITIALIZING SCRIPT ##########");   
    
    if cm:is_new_game() then
    cm:callback(
    function()confed_commands_vor();
    end,1.0);
    
    confed_penalties();
    
    end;
    end;
    
    ----------------------------------
    -- PHASE TWO: EXCUTE ORDER 66
    ----------------------------------
    
    function confed_commands_vor()
        out("########## CONFEDERATING PLAYER FACTIONS ##########");
    
-- WH2 FACTIONS DEFINITIONS --

local teclis = cm:get_faction("wh2_main_hef_order_of_loremasters");
local tyrion = cm:get_faction("wh2_main_hef_eataine");
local alarielle = cm:get_faction("wh2_main_hef_avelorn");
local alith_anar = cm:get_faction("wh2_main_hef_nagarythe");

local mazdamundi = cm:get_faction("wh2_main_lzd_hexoatl");
local kroq_gar = cm:get_faction("wh2_main_lzd_last_defenders");

local malekith = cm:get_faction("wh2_main_def_naggarond");
local morathi = cm:get_faction("wh2_main_def_cult_of_pleasure");
local hellebron = cm:get_faction("wh2_main_def_har_ganeth");
local lokhir = cm:get_faction("wh2_dlc11_def_the_blessed_dread")

local queek = cm:get_faction("wh2_main_skv_clan_mors");
local skrolk = cm:get_faction("wh2_main_skv_clan_pestilens");
local tretch = cm:get_faction("wh2_dlc09_skv_clan_rictus");

-- TOMB KINGS PLACEHOLDER

-- VAMPIRE COAST PLACEHOLDER

-- CONFEDERATION COMMANDS --

 -- DARK ELVES
 if malekith:is_human() then
    cm:force_confederation("wh2_main_def_naggarond", "wh2_main_def_cult_of_pleasure");
    cm:force_confederation("wh2_main_def_naggarond", "wh2_main_def_har_ganeth");
    cm:force_confederation("wh2_main_def_naggarond", "wh2_dlc11_def_the_blessed_dread");

elseif morathi:is_human() then
    cm:force_confederation("wh2_main_def_cult_of_pleasure", "wh2_main_def_naggarond");
    cm:force_confederation("wh2_main_def_cult_of_pleasure", "wh2_main_def_har_ganeth");
    cm:force_confederation("wh2_main_def_cult_of_pleasure", "wh2_dlc11_def_the_blessed_dread");

elseif hellebron:is_human() then
    cm:force_confederation("wh2_main_def_har_ganeth", "wh2_main_def_naggarond");
    cm:force_confederation("wh2_main_def_har_ganeth", "wh2_main_def_cult_of_pleasure");
    cm:force_confederation("wh2_main_def_har_ganeth", "wh2_dlc11_def_the_blessed_dread");

elseif lokhir:is_human() then
    cm:force_confederation("wh2_dlc11_def_the_blessed_dread", "wh2_main_def_naggarond");
    cm:force_confederation("wh2_dlc11_def_the_blessed_dread", "wh2_main_def_cult_of_pleasure");
    cm:force_confederation("wh2_dlc11_def_the_blessed_dread", "wh2_main_def_har_ganeth");

    -- HIGH ELVES
elseif tyrion:is_human() then
    cm:force_confederation("wh2_main_hef_eataine", "wh2_main_hef_order_of_loremasters");
    cm:force_confederation("wh2_main_hef_eataine", "wh2_main_hef_avelorn");
    cm:force_confederation("wh2_main_hef_eataine", "wh2_main_hef_nagarythe");

elseif teclis:is_human() then
    cm:force_confederation("wh2_main_hef_order_of_loremasters", "wh2_main_hef_eataine");
    cm:force_confederation("wh2_main_hef_order_of_loremasters", "wh2_main_hef_avelorn");
    cm:force_confederation("wh2_main_hef_order_of_loremasters", "wh2_main_hef_nagarythe");
   --Alastar for Teclis
   cm:spawn_character_to_pool("wh2_main_hef_order_of_loremasters", "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "");

elseif alarielle:is_human() then
    cm:force_confederation("wh2_main_hef_avelorn", "wh2_main_hef_eataine");
    cm:force_confederation("wh2_main_hef_avelorn", "wh2_main_hef_order_of_loremasters");
    cm:force_confederation("wh2_main_hef_avelorn", "wh2_main_hef_nagarythe");
    --Alastar for Alarielle
    cm:spawn_character_to_pool("wh2_main_hef_avelorn", "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "");

elseif alith_anar:is_human() then
    cm:force_confederation("wh2_main_hef_nagarythe", "wh2_main_hef_eataine");
    cm:force_confederation("wh2_main_hef_nagarythe", "wh2_main_hef_order_of_loremasters");
    cm:force_confederation("wh2_main_hef_nagarythe", "wh2_main_hef_avelorn");
   --Alastar for Alith Anar
   cm:spawn_character_to_pool("wh2_main_hef_nagarythe", "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "");

-- LIZARDMEN

 elseif mazdamundi:is_human() then
    cm:force_confederation("wh2_main_lzd_hexoatl", "wh2_main_lzd_last_defenders");

elseif kroq_gar:is_human() then
    cm:force_confederation("wh2_main_lzd_last_defenders", "wh2_main_lzd_hexoatl");

-- SKAVEN

elseif queek:is_human() then
    cm:force_confederation("wh2_main_skv_clan_mors", "wh2_main_skv_clan_pestilens");
    cm:force_confederation("wh2_main_skv_clan_mors", "wh2_dlc09_skv_clan_rictus");

elseif skrolk:is_human() then
    cm:force_confederation("wh2_main_skv_clan_pestilens", "wh2_main_skv_clan_mors");
    cm:force_confederation("wh2_main_skv_clan_pestilens", "wh2_dlc09_skv_clan_rictus");

elseif tretch:is_human() then
    cm:force_confederation("wh2_dlc09_skv_clan_rictus", "wh2_main_skv_clan_mors");
    cm:force_confederation("wh2_dlc09_skv_clan_rictus", "wh2_main_skv_clan_pestilens");

-- VAMPIRE COAST PLACEHOLDER

-- TOMB KINGS PLACEHOLDER
    
    end;
    end; 
    
    
    ----------------------------------
    -- PHASE THREE: FINAL TOUCHES
    ----------------------------------
    
    -- CANCEL CONFEDERATION PENALTIES --
    
    function confed_penalties()
        out("########## REMOVING PENALTIES ##########")
    
        local faction_keys = {
        "wh2_main_hef_order_of_loremasters",
        "wh2_main_hef_eataine",
        "wh2_main_hef_avelorn",
        "wh2_main_hef_nagarythe",
       
        "wh2_main_lzd_hexoatl",
        "wh2_main_lzd_last_defenders",
       
        "wh2_main_def_naggarond",
        "wh2_main_def_cult_of_pleasure",
        "wh2_main_def_har_ganeth",
        "wh2_dlc11_def_the_blessed_dread",
       
        "wh2_main_skv_clan_mors",
        "wh2_main_skv_clan_pestilens",
        "wh2_dlc09_skv_clan_rictus",
    
        };
    
        local bundles = {
            "wh2_main_bundle_confederation_skv",
            "wh2_main_bundle_confederation_lzd",
            "wh2_main_bundle_confederation_hef",
            "wh2_main_bundle_confederation_def"
            };
        
            for i = 1, #bundles do
                for j = 1, #faction_keys do
                    
                cm:callback(
                function()
                cm:remove_effect_bundle(bundles[i], faction_keys[j]);
        end,
        1.5);
    
    end;
    end;
    end;
    
    -- PICK-ME UPS PLACEHOLDER --
    
    -- TESTING AREA --