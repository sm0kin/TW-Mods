function mcm_unlocker()
    local mcm = _G.mcm;

    -- Input Variables, also used as Default Values
    CHAOS_INVASION_CHOICE__DEFAULT = true --:bool
    CHAOS_INVASION_CHOICE__NO_CHAOS_INVASION = false --:bool
    CHAOS_INVASION_CHOICE__TURN_BASED_INVASION = false --:bool

    CHAOS_FIRST_WAVE_TURN = 100 --:number

    CHAOS_SECOND_WAVE_TURN = 150 --:number

    KARAK_EIGHT_PEAKS__CLAN_ANGRUND = true  --:bool --Karak_Eight_Peaks___Belegar_Ironhammer = ?
    KARAK_EIGHT_PEAKS__CROOKED_MOON = true --:bool --Karak_Eight_Peaks___Skarsnik = ?
    KARAK_EIGHT_PEAKS__CLAN_MORS = true --:bool --Karak_Eight_Peaks___Queek_Headtaker = ?
    KARAK_EIGHT_PEAKS__CROOKED_MOON_MUTINOUS_GITS = true --:bool --Karak_Eight_Peaks___Crooked_Moon_Mutinous_Gits = ?

    NEW_FACTIONS__BRETONNIA_DUKEDOMS = true --:bool --New_Factions___Bretonnia_Dukedoms = ?
    NEW_FACTIONS__OLD_WORLD_SKAVEN = true --:bool --New_Factions___Old_World_Skaven = ?
    NEW_FACTIONS__SOUTHERN_REALMS = true --:bool --New_Factions___Southern_Realms = ?

    NEW_FACTIONS__BREGONNE = true --:bool --New_Factions___Bregonne = ?
    NEW_FACTIONS__ERENGRAD = true --:bool --New_Factions___Erengrad = ?
    NEW_FACTIONS__KONQUATA = true --:bool --New_Factions___Konquata = ?
	NEW_FACTIONS__THE_BRASS_LEGION = true --:bool --New_Factions___The_Brass_Legion = ?


    -- MCM CFU Settings


    if not not mcm and (mcm:started_with_mod("crynsos_faction_unlocker") or cm:is_new_game()) then
        local cfu = mcm:register_mod("crynsos_faction_unlocker", "Crynsos Faction Unlocker", "Settings to define various optional changes to the campaign.")		-- Register CFU into the MCM List
        
        if cm:get_campaign_name() == "main_warhammer" then
            
            -- Chaos Invasion Choice
            if not (cm:get_faction("wh_main_chs_chaos"):is_human() or
                    cm:get_faction("wh_main_chs_chaos_separatists"):is_human()) then
                
                -- How do you want the Chaos Invasion mechanic to work?
                local Chaos_Invasion_Choice = cfu:add_tweaker("MCM_Chaos_Invasion_Choice", "How do you want the Chaos Invasion mechanic to work?", "The Turn Selection below will only work if you select Turn Based Invasion.")
                
                Chaos_Invasion_Choice:add_option("Default", "Default (Imperium Level)", "You will require a high Imperium level to trigger the Chaos Invasion. This is done by controlling a large amount of Settlements around the world (30+) or by turn 150, whichever comes first. Archaon will appear at turn 200."):add_callback(function(context) CHAOS_INVASION_CHOICE__DEFAULT = true end)
                Chaos_Invasion_Choice:add_option("No_Chaos_Invasion", "No Chaos Invasion", "No Chaos Invasion will ever occur during this campaign."):add_callback(function(context) CHAOS_INVASION_CHOICE__NO_CHAOS_INVASION = true end)
                Chaos_Invasion_Choice:add_option("Turn_Based_Invasion", "Turn Based Invasion", "The Invasion will be triggered entirely based on the chosen turns, the Imperium Level Check will be disabled."):add_callback(function(context) CHAOS_INVASION_CHOICE__TURN_BASED_INVASION = true end)
                
                
                
                -- Chaos Invasion Choice - First Wave							Minimum / Maximum / Default / Stepping
                local Chaos_Invasion_Choice_First_Wave = cfu:add_variable("MCM_Chaos_Invasion_Choice_First_Wave", 10, 250, 100, 10, "Chaos Invasion Turn", "Select on which turn the first Chaos Invasion wave occurs."):add_callback(function(context)
                    CHAOS_FIRST_WAVE_TURN = context:get_mod("crynsos_faction_unlocker"):get_variable_with_key("MCM_Chaos_Invasion_Choice_First_Wave"):current_value() end)
                
                
                
                -- Chaos Invasion Choice - Second Wave						Minimum / Maximum / Default / Stepping
                local Chaos_Invasion_Choice_Second_Wave = cfu:add_variable("MCM_Chaos_Invasion_Choice_Second_Wave", 10, 300, 150, 10, "Chaos Invasion Turn - Legendary Lords", "Select on which turn the second Chaos Invasion wave occurs."):add_callback(function(context)
                    CHAOS_SECOND_WAVE_TURN = context:get_mod("crynsos_faction_unlocker"):get_variable_with_key("MCM_Chaos_Invasion_Choice_Second_Wave"):current_value() end)
            end
            
                       
            
            -- Who controls Karak Eight Peaks?
            local Karak_Eight_Peaks = cfu:add_tweaker("MCM_Karak_Eight_Peaks", "Who controls Karak Eight Peaks?", "The selected faction will control Karak Eight Peaks.")
            
            Karak_Eight_Peaks:add_option("Crooked_Moon_Mutinous_Gits", "Crooked Moon Mutinous Gits", "Crooked Moon Mutinous Gits"):add_callback(function(context) KARAK_EIGHT_PEAKS__CROOKED_MOON_MUTINOUS_GITS = true end)
            Karak_Eight_Peaks:add_option("Clan_Mors", "Queek Headtaker (Clan Mors)", "Clan Mors"):add_callback(function(context) KARAK_EIGHT_PEAKS__CLAN_MORS = true end)
            Karak_Eight_Peaks:add_option("Crooked_Moon", "Skarsnik (Crooked Moon)", "Crooked Moon"):add_callback(function(context) KARAK_EIGHT_PEAKS__CROOKED_MOON = true end)
            Karak_Eight_Peaks:add_option("Clan_Angrund", "Belegar Ironhammer (Clan Angrund)", "Clan Angrund"):add_callback(function(context) KARAK_EIGHT_PEAKS__CLAN_ANGRUND = true end)
            
            
            
            
            -- Aquitaine, Brionne, Gisoreux, L'Anguille, Montfort, Quenelles
            if not (cm:get_faction("wh_main_brt_aquitaine"):is_human() or
                    cm:get_faction("wh_main_brt_brionne"):is_human() or
                    cm:get_faction("wh_main_brt_gisoreux"):is_human() or
                    cm:get_faction("wh_main_brt_languille"):is_human() or
                    cm:get_faction("wh_main_brt_montfort"):is_human() or
                    cm:get_faction("wh_main_brt_quenelles"):is_human()) then
                local Bretonnia_Dukedoms = cfu:add_tweaker("MCM_New_Factions_Bretonnia_Dukedoms", "New Factions: All Bretonnia Dukedoms \n (Aquitaine, Brionne, Gisoreux, L'Anguille, Montfort, Quenelles)", "Do you want to keep these factions alive?")
                
                Bretonnia_Dukedoms:add_option("false", "No", "All of the new Bretonnian Factions will be removed."):add_callback(function(context) NEW_FACTIONS__BRETONNIA_DUKEDOMS = false end)
                Bretonnia_Dukedoms:add_option("true", "Yes", "The new Bretonnian Factions will remain alive."):add_callback(function(context) NEW_FACTIONS__BRETONNIA_DUKEDOMS = true end)
            end
            
            -- Clan Ferrik, Clan Fester, Clan Krizzor, Clan Volkn
            if not (cm:get_faction("wh2_main_skv_clan_ferrik"):is_human() or
                    cm:get_faction("wh2_main_skv_clan_fester"):is_human() or
                    cm:get_faction("wh2_main_skv_clan_krizzor"):is_human() or
                    cm:get_faction("wh2_main_skv_clan_volkn"):is_human()) then
                local Old_World_Skaven = cfu:add_tweaker("MCM_New_Factions_Old_World_Skaven", "New Factions: Old World Skaven \n (Clan Ferrik, Clan Fester, Clan Krizzor, Clan Volkn)", "Do you want to keep these factions alive?")
                
                Old_World_Skaven:add_option("true", "Yes", "The new Skaven Factions will remain alive."):add_callback(function(context) NEW_FACTIONS__OLD_WORLD_SKAVEN = true end)
                Old_World_Skaven:add_option("false", "No", "All of the new Skaven Factions will be removed."):add_callback(function(context) NEW_FACTIONS__OLD_WORLD_SKAVEN = false end)
            end
            
            
            -- Bilbali, Lichtenburg Confederacy, Luccini, Tobaro
            if not (cm:get_faction("wh_main_teb_bilbali"):is_human() or
                    cm:get_faction("wh_main_teb_lichtenburg_confederacy"):is_human() or
                    cm:get_faction("wh_main_teb_luccini"):is_human() or
                    cm:get_faction("wh_main_teb_tobaro"):is_human()) then
                local Southern_Realms = cfu:add_tweaker("MCM_New_Factions_Southern_Realms", "New Factions: All Southern Realms Factions \n (Bilbali, Lichtenburg Confederacy, Luccini, Tobaro)", "Do you want to keep these factions alive?")
                
                Southern_Realms:add_option("true", "Yes", "The new Southern Realms Factions will remain alive."):add_callback(function(context) NEW_FACTIONS__SOUTHERN_REALMS = true end)
                Southern_Realms:add_option("false", "No", "All of the new Southern Realms Factions will be removed."):add_callback(function(context) NEW_FACTIONS__SOUTHERN_REALMS = false end)
            end
            
            
            
            
            
            -- Bregonne
            if not cm:get_faction("wh2_main_brt_bregonne"):is_human() then
                local Bregonne = cfu:add_tweaker("MCM_New_Faction_Bregonne", "New Faction: Bregonne (Bretonnian Colony in Lustria)", "Do you want to keep this faction alive?")
                
                Bregonne:add_option("true", "Yes", "Bregonne will remain alive."):add_callback(function(context) NEW_FACTIONS__BREGONNE = true end)
                Bregonne:add_option("false", "No", "Bregonne will be removed."):add_callback(function(context) NEW_FACTIONS__BREGONNE = false end)
            end
            
            
            
            -- Erengrad
            if not cm:get_faction("wh_main_ksl_erengrad"):is_human() then
                local Erengrad = cfu:add_tweaker("MCM_New_Faction_Erengrad", "New Faction: Erengrad (Kislevite Rival Faction)", "Do you want to keep this faction alive?")
                
                Erengrad:add_option("true", "Yes", "Erengrad will remain alive."):add_callback(function(context) NEW_FACTIONS__ERENGRAD = true end)
                Erengrad:add_option("false", "No", "Erengrad will be removed."):add_callback(function(context) NEW_FACTIONS__ERENGRAD = false end)
            end
            
            
            
            -- Konquata
            if not cm:get_faction("wh2_main_lzd_konquata"):is_human() then
                local Konquata = cfu:add_tweaker("MCM_New_Faction_Konquata", "New Faction: Konquata (Lizardmen in Albion)", "Do you want to keep this faction alive?")
                
                Konquata:add_option("true", "Yes", "Konquata will remain alive."):add_callback(function(context) NEW_FACTIONS__KONQUATA = true end)
                Konquata:add_option("false", "No", "Konquata will be removed."):add_callback(function(context) NEW_FACTIONS__KONQUATA = false end)
            end
            
            
            
            -- The Brass Legion
            if not cm:get_faction("wh_main_chs_the_brass_legion"):is_human() then
                local The_Brass_Legion = cfu:add_tweaker("MCM_New_Faction_The_Brass_Legion", "New Faction: The Brass Legion (Chaos Fortress in Hochland)", "Do you want to keep this faction alive?")
                
                The_Brass_Legion:add_option("true", "Yes", "The Brass Legion will remain alive."):add_callback(function(context) NEW_FACTIONS__THE_BRASS_LEGION = true end)
                The_Brass_Legion:add_option("false", "No", "The Brass Legion will be removed."):add_callback(function(context) NEW_FACTIONS__THE_BRASS_LEGION = false end)
            end
            
            
            
            
            
        elseif cm:get_campaign_name() == "wh2_main_great_vortex" then
            
            -- Bregonne
            local Bregonne = cfu:add_tweaker("MCM_New_Faction_Bregonne", "New Faction: Bregonne (Bretonnian Colony in Lustria)", "Do you want to keep this faction alive?")
            
            Bregonne:add_option("true", "Yes", "Bregonne will remain alive."):add_callback(function(context) NEW_FACTIONS__BREGONNE = true end)
            Bregonne:add_option("false", "No", "Bregonne will be removed."):add_callback(function(context) NEW_FACTIONS__BREGONNE = false end)
        end
        
        
        
        
        
        -- Output Variables
        if CHAOS_INVASION_CHOICE__DEFAULT then
            cm:set_saved_value("chaos_first_wave_turn", 150)
            cm:set_saved_value("chaos_second_wave_turn", 200)
        end
        
        if CHAOS_INVASION_CHOICE__NO_CHAOS_INVASION then
            cm:set_saved_value("chaos_first_wave_spawned", true)
            cm:set_saved_value("chaos_second_wave_spawned", true)
        end
        
        if CHAOS_INVASION_CHOICE__TURN_BASED_INVASION then
            cm:set_saved_value("chaos_first_wave_turn", CHAOS_FIRST_WAVE_TURN)
            cm:set_saved_value("chaos_second_wave_turn", CHAOS_SECOND_WAVE_TURN)
            cm:set_saved_value("check_imperium_level", false)
        end
        
        
        
        Karak_Eight_Peaks___Belegar_Ironhammer = KARAK_EIGHT_PEAKS__CLAN_ANGRUND
        Karak_Eight_Peaks___Skarsnik = KARAK_EIGHT_PEAKS__CROOKED_MOON
        Karak_Eight_Peaks___Queek_Headtaker = KARAK_EIGHT_PEAKS__CLAN_MORS
        Karak_Eight_Peaks___Crooked_Moon_Mutinous_Gits = KARAK_EIGHT_PEAKS__CROOKED_MOON_MUTINOUS_GITS
        
        New_Factions___Bretonnia_Dukedoms = NEW_FACTIONS__BRETONNIA_DUKEDOMS
        New_Factions___Old_World_Skaven = NEW_FACTIONS__OLD_WORLD_SKAVEN
        New_Factions___Southern_Realms = NEW_FACTIONS__SOUTHERN_REALMS
        
        New_Factions___Bregonne = NEW_FACTIONS__BREGONNE
        New_Factions___Erengrad = NEW_FACTIONS__ERENGRAD
        New_Factions___Konquata = NEW_FACTIONS__KONQUATA
        New_Factions___The_Brass_Legion = NEW_FACTIONS__THE_BRASS_LEGION

    end

    if not not mcm then						-- If MCM is active, wait for the MCM window to be closed until the functions which read the MCM Variables is started
        mcm:add_post_process_callback(function(context)
                    -- Output Variables
            if CHAOS_INVASION_CHOICE__DEFAULT then
                cm:set_saved_value("chaos_first_wave_turn", 150)
                cm:set_saved_value("chaos_second_wave_turn", 200)
            end
            
            if CHAOS_INVASION_CHOICE__NO_CHAOS_INVASION then
                cm:set_saved_value("chaos_first_wave_spawned", true)
                cm:set_saved_value("chaos_second_wave_spawned", true)
            end
            
            if CHAOS_INVASION_CHOICE__TURN_BASED_INVASION then
                cm:set_saved_value("chaos_first_wave_turn", CHAOS_FIRST_WAVE_TURN)
                cm:set_saved_value("chaos_second_wave_turn", CHAOS_SECOND_WAVE_TURN)
                cm:set_saved_value("check_imperium_level", false)
            end
            
			mcm:log("chaos_first_wave_turn = "..tostring(cm:get_saved_value("chaos_first_wave_turn")));
			mcm:log("chaos_second_wave_turn = "..tostring(cm:get_saved_value("chaos_second_wave_turn")));
			mcm:log("check_imperium_level = "..tostring(cm:get_saved_value("check_imperium_level")));

            
            Karak_Eight_Peaks___Belegar_Ironhammer = KARAK_EIGHT_PEAKS__CLAN_ANGRUND
            Karak_Eight_Peaks___Skarsnik = KARAK_EIGHT_PEAKS__CROOKED_MOON
            Karak_Eight_Peaks___Queek_Headtaker = KARAK_EIGHT_PEAKS__CLAN_MORS
            Karak_Eight_Peaks___Crooked_Moon_Mutinous_Gits = KARAK_EIGHT_PEAKS__CROOKED_MOON_MUTINOUS_GITS
            
            New_Factions___Bretonnia_Dukedoms = NEW_FACTIONS__BRETONNIA_DUKEDOMS
            New_Factions___Old_World_Skaven = NEW_FACTIONS__OLD_WORLD_SKAVEN
            New_Factions___Southern_Realms = NEW_FACTIONS__SOUTHERN_REALMS
            
            New_Factions___Bregonne = NEW_FACTIONS__BREGONNE
            New_Factions___Erengrad = NEW_FACTIONS__ERENGRAD
            New_Factions___Konquata = NEW_FACTIONS__KONQUATA
            New_Factions___The_Brass_Legion = NEW_FACTIONS__THE_BRASS_LEGION

            mcm:log("CHAOS_INVASION_CHOICE__DEFAULT = "..tostring(CHAOS_INVASION_CHOICE__DEFAULT));
            mcm:log("CHAOS_FIRST_WAVE_TURN = "..tostring(CHAOS_FIRST_WAVE_TURN));
            mcm:log("CHAOS_SECOND_WAVE_TURN = "..tostring(CHAOS_SECOND_WAVE_TURN));
            mcm:log("CHAOS_INVASION_CHOICE__NO_CHAOS_INVASION = "..tostring(CHAOS_INVASION_CHOICE__NO_CHAOS_INVASION));
            mcm:log("CHAOS_INVASION_CHOICE__TURN_BASED_INVASION = "..tostring(CHAOS_INVASION_CHOICE__TURN_BASED_INVASION));
            mcm:log("KARAK_EIGHT_PEAKS__CLAN_ANGRUND = "..tostring(KARAK_EIGHT_PEAKS__CLAN_ANGRUND));
            mcm:log("KARAK_EIGHT_PEAKS__CROOKED_MOON = "..tostring(KARAK_EIGHT_PEAKS__CROOKED_MOON));
            mcm:log("KARAK_EIGHT_PEAKS__CLAN_MORS = "..tostring(KARAK_EIGHT_PEAKS__CLAN_MORS));
            mcm:log("KARAK_EIGHT_PEAKS__CROOKED_MOON_MUTINOUS_GITS = "..tostring(KARAK_EIGHT_PEAKS__CROOKED_MOON_MUTINOUS_GITS));
            mcm:log("NEW_FACTIONS__BRETONNIA_DUKEDOMS = "..tostring(NEW_FACTIONS__BRETONNIA_DUKEDOMS));
            mcm:log("NEW_FACTIONS__OLD_WORLD_SKAVEN = "..tostring(NEW_FACTIONS__OLD_WORLD_SKAVEN));
            mcm:log("NEW_FACTIONS__SOUTHERN_REALMS = "..tostring(NEW_FACTIONS__SOUTHERN_REALMS));
            mcm:log("NEW_FACTIONS__BREGONNE = "..tostring(NEW_FACTIONS__BREGONNE));
            mcm:log("NEW_FACTIONS__ERENGRAD = "..tostring(NEW_FACTIONS__ERENGRAD));
            mcm:log("NEW_FACTIONS__KONQUATA = "..tostring(NEW_FACTIONS__KONQUATA));
			mcm:log("NEW_FACTIONS__THE_BRASS_LEGION = "..tostring(NEW_FACTIONS__THE_BRASS_LEGION));
			--MCM_CFU_Settings()								-- Function which reads MCM variables and runs command with them
            --ci_setup()
        end)
    else							-- If MCM is not active, run the functions at First Tick
        cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = function(context)
            --MCM_CFU_Settings()								-- Function which reads MCM variables and runs command with them
            --ci_setup()
        end
    end

end