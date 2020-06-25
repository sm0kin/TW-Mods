------------------------------------------------------------------
--HIGHER STARTING TIER: CAPITALS & HORDES
------------------------------------------------------------------
--original script by FrostyDemise
--reworked script by Sm0kin

--contact Frosty or Sm0kin for permission to re-purpose/utilize the script 
------------------------------------------------------------------


-----------
--REGIONS--
-----------

local regions_table = {
    
    -- DWARFS
    "wh_main_the_silver_road_karaz_a_karak", --Thorgrim (ME)
    "wh_main_the_vaults_karak_izor", --Belegar (ME)
    "wh_main_peak_pass_karak_kadrin", --Ungrim (ME)

    -- WOOD ELVES
    "wh_main_athel_loren_waterfall_palace", --Durthu (ME)
    "wh_main_athel_loren_yn_edryl_korian", --Orion (ME)

    -- BRETONNIA
    "wh_main_carcassone_et_brionne_castle_carcassonne", --Louen (ME)
    "wh_main_bordeleaux_et_aquitaine_bordeleaux", --Alberic (ME)
    "wh_main_couronne_et_languille_couronne", --Morgianna (ME)
    "wh2_main_coast_of_araby_copher",  --Repanse (ME)
    "wh2_main_vor_coast_of_araby_copher", --Repanse (Vortex)

    -- EMPIRE / TEB / KISLEV
    "wh_main_reikland_altdorf", --Franz (ME)
    "wh_main_middenland_middenheim", --Todbringer (ME)
    "wh2_main_solland_pfeildorf",  --Gelt (ME)
    "wh2_main_the_creeping_jungle_temple_of_kara",  --Markus (ME)
    "wh2_main_vor_scorpion_coast_temple_of_tlencan",  --Markus (Vor)
    --LORE
    "wh_main_wissenland_nuln", --EMP
    "wh_main_talabecland_talabheim", --EMP
    "wh_main_estalia_magritta", --TEB
    "wh_main_the_wasteland_marienburg", --TEB 
    "wh_main_tilea_miragliano", --TEB
    "wh_main_southern_oblast_kislev", --Kislev

    -- VAMPIRE COUNTS
    "wh_main_eastern_sylvania_castle_drakenhof",  --Mannfred (ME)
    "wh_main_northern_grey_mountains_blackstone_post", --Kemmler (ME)

    -- GREENSKINS
    "wh_main_death_pass_karak_drazh", --Grimgor (ME)
    "wh_main_western_badlands_ekrund", --Wurrzag (ME)
    "wh_main_southern_grey_mountains_karak_azgaraz", --Skarsnik (ME)
    "wh_main_northern_worlds_edge_mountains_karak_ungor", --Azhag (ME)
    "wh_main_massif_orcal_massif_orcal", --Grom (ME)
    "wh2_main_vor_southlands_world_edge_mountains_karag_orrud", --Grom (Vor)


    -- NORSCA
    "wh_main_mountains_of_hel_winter_pyre", --Wulfrik (ME)
    "wh_main_ice_tooth_mountains_icedrake_fjord", --Throgg (ME)
    
    -- HIGH ELVES
    "wh2_main_eataine_lothern", --Tyrion (ME)
    "wh2_main_vor_straits_of_lothern_lothern", --Tyrion (Vor) 
    "wh2_main_volcanic_islands_the_star_tower", --Teclis (ME)
    "wh2_main_vor_the_turtle_isles_great_turtle_isle", --Teclis (Vor)
    "wh2_main_avelorn_gaean_vale", --Alarielle (ME)
    "wh2_main_vor_avelorn_gaean_vale", --Alariella (Vor)
    "wh2_main_the_black_coast_arnheim", --Alith Anar (ME)
    "wh2_main_vor_the_broken_land_black_creek_spire",  --Alith Anar (Vor)
    "wh2_main_yvresse_tor_yvresse", --Eltharion (ME)
    "wh2_main_vor_northern_yvresse_tor_yvresse",--Eltharion (Vor)
    "wh2_main_the_plain_of_bones_the_fortress_of_vorag",     --Imrik (ME)
    "wh2_main_vor_shifting_sands_ka-sabar",     --Imrik (Vor)


    -- SKAVEN
    "wh2_main_charnel_valley_karag_orrud", --Queek (ME)
    "wh2_main_vor_southern_jungles_yuatek", --Queek (Vor) 
    "wh2_main_the_clawed_coast_hoteks_column", --Tretch (ME)
    "wh2_main_vor_the_clawed_coast_hoteks_column", --Tretch (Vor)
    "wh2_main_headhunters_jungle_oyxl", --Skrolk (ME)
    "wh2_main_vor_the_lost_valleys_oyxl", --Skrolk (Vor)
    "wh2_main_skavenblight_skavenblight", --Ikit (ME)
    "wh2_main_vor_the_vampire_coast_the_star_tower", --Ikit (Vor)
    "wh2_main_gnoblar_country_flayed_rock", --Snikch (ME)
    "wh2_main_vor_land_of_the_dervishes_el-kalabad", --Snikch (Vortex)
    "wh2_main_hell_pit_hell_pit", --LORE

    -- DARK ELVES	
    "wh2_main_iron_mountains_naggarond", --Malekith (ME)
    "wh2_main_vor_naggarond_naggarond", --Malekith (Vor)
    "wh2_main_titan_peaks_ancient_city_of_quintex", --Morathi (ME)
    "wh2_main_vor_iron_peaks_ancient_city_of_quintex", --Morathi (Vor)
    "wh2_main_the_road_of_skulls_har_ganeth", --Hellebron (ME)
    "wh2_main_vor_the_road_of_skulls_har_ganeth", --Hellebron (Vor)
    "wh2_main_headhunters_jungle_chupayotl", --Lokhir (ME)
    "wh2_main_vor_culchan_plains_chupayotl", --Lokhir(Vor)
    "wh2_main_the_black_flood_hag_graef", --Malus ME
    "wh2_main_vor_the_black_flood_hag_graef", --Malus Vortex

    -- LIZARDMEN
    "wh2_main_isthmus_of_lustria_hexoatl", --Mazdamundi ME
    "wh2_main_vor_isthmus_of_lustria_hexoatl", --Mazdamundi Vortex
    "wh2_main_kingdom_of_beasts_temple_of_skulls", --KroqGar (ME)
    "wh2_main_vor_kingdom_of_beasts_temple_of_skulls", --KroqGar (Vor)
    "wh2_main_southern_great_jungle_itza", --Gor Rok (ME)
    "wh2_main_vor_northern_great_jungle_itza", --Gor Rok (Vor)
    "wh2_main_northern_great_jungle_xlanhuapec", --Tehenhauin (ME)
    "wh2_main_vor_culchan_plains_kaiax", --Tehenhauin (Vor)
    "wh2_main_western_jungles_tlaqua", --TiqTaqToe (ME)
    "wh2_main_vor_western_jungles_tlaqua", --TiqTaqToe (Vor)

    -- TOMB KINGS
    "wh2_main_blackspine_mountains_plain_of_spiders", --Khatep (ME)
    "wh2_main_vor_ashen_coast_scarpels_lair", --Khatep (Vor)
    "wh2_main_vor_land_of_the_dead_khemri", --Settra (Vor)
    "wh2_main_land_of_the_dead_khemri", --Setra (ME)
    "wh2_main_land_of_assassins_palace_of_the_wizard_caliph", --Arkhan (ME)
    "wh2_main_vor_land_of_assassins_palace_of_the_wizard_caliph",  --Arkhan (Vor)
    "wh2_main_devils_backbone_lybaras", --Khalida (ME)
    "wh2_main_vor_copper_desert_the_forgotten_isles", --Khalida (Vor)

    -- VAMPIRE COAST
    "wh2_main_sartosa_sartosa", --Aranessa (ME)
    "wh2_main_vor_sartosa_sartosa", --Aranessa (Vor)
    "wh2_main_vampire_coast_the_awakening", --Luthor Harkon (ME) 
    "wh2_main_vor_the_vampire_coast_the_awakening",  --Luthor Harkon (Vor)
    "wh2_main_the_galleons_graveyard", --Noctilus (ME)
    "wh2_main_vor_the_galleons_graveyard", --Noctilus (Vor)
    "wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon", --Cylostra (ME) 
    "wh2_main_vor_grey_guardians_grey_rock_point" --Cylostra (Vor)

} --: vector<string>

------------------------
--upgrade_capitals--
------------------------

--v function(player_tier: string, ai_tier: string, settlementScope: string)
local function upgrade_capitals(player_tier, ai_tier, settlementScope)
    --v function(currentRegion: string)
    local function upgrade(currentRegion)
        local regionCA = cm:get_region(currentRegion)
        if regionCA and not regionCA:is_abandoned() then
            local settlement = regionCA:settlement()
            if (ai_tier ~= "6" and regionCA and not regionCA:owning_faction():is_human()) then
                cm:instantly_set_settlement_primary_slot_level(settlement, tonumber(ai_tier))
            end
            if (player_tier ~= "6" and regionCA and regionCA:owning_faction():is_human()) then
                cm:instantly_set_settlement_primary_slot_level(settlement, tonumber(player_tier))
            end

            ------------------------
            --Eltharion part--
            ------------------------
            
            local building = regionCA:settlement():primary_slot():building()
            local building_chain = building:chain()
            local building_level = building:building_level()
            if building:faction():name() == "wh2_main_hef_yvresse" then
                if currentRegion == "wh2_main_vor_northern_yvresse_tor_yvresse" or currentRegion == "wh2_main_yvresse_tor_yvresse" then
                    if building_chain == "wh2_dlc15_special_settlement_tor_yvresse_eltharion" then
                        if cm:get_saved_value("modified_lair_max_yvresse_level") == 2 and building_level >= 3 then
                            cm:set_saved_value("modified_lair_max_yvresse_level", cm:get_saved_value("modified_lair_max_yvresse_level") + 1)
                            cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 5)                                        
                        end
                        if cm:get_saved_value("modified_lair_max_yvresse_level") == 3 and building_level >= 4 then
                            cm:set_saved_value("modified_lair_max_yvresse_level", cm:get_saved_value("modified_lair_max_yvresse_level") + 1)
                            cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 10)
                        end
                        if cm:get_saved_value("modified_lair_max_yvresse_level") == 4 and building_level == 5 then
                            cm:set_saved_value("modified_lair_max_yvresse_level", cm:get_saved_value("modified_lair_max_yvresse_level") + 1)
                            cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 10)
                        end
                    end
                end
            end
        end
    end
    if settlementScope == "e3_any_settlement" or settlementScope == "e2_provinces_too" then
        local region_list = cm:model():world():region_manager():region_list()
        for i=0, region_list:num_items() - 1 do
            if settlementScope == "e3_any_settlement" or (settlementScope == "e2_provinces_too" and region_list:item_at(i):is_province_capital()) then
                upgrade(region_list:item_at(i):name())
            end
        end
    else
        for _, region in ipairs(regions_table) do
            upgrade(region)
        end
    end
end


------------------------
--upgrade_hordes--
------------------------

--v function(player_tier: string, ai_tier: string)
local function upgrade_horde(player_tier, ai_tier)
    if player_tier then
        local player_factionList = cm:get_human_factions()
        for i = 1, #player_factionList do
            local currentFaction = cm:get_faction(player_factionList[i])
            if currentFaction then
                local characterList = currentFaction:character_list()
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j)
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index()
                        if currentFaction:culture() == "wh_main_chs_chaos" then
                            cm:add_building_to_force(mfCQI, "wh_main_horde_chaos_settlement_"..player_tier) 
                        elseif currentFaction:culture() == "wh_dlc03_bst_beastmen" then
                            cm:add_building_to_force(mfCQI, "wh_dlc03_horde_beastmen_herd_"..player_tier) 
                        elseif currentFaction:culture() == "wh2_dlc11_cst_vampire_coast" then
                            cm:add_building_to_force(mfCQI, "wh2_dlc11_vampirecoast_ship_captains_cabin_"..player_tier) 
                        elseif currentFaction:culture() == "wh2_main_lzd_lizardmen" then
                            cm:add_building_to_force(mfCQI, "wh2_dlc13_horde_lizardmen_ziggurat_"..player_tier) 
                        end
                    end
                end
            end
        end
    end
    if ai_tier then 
        local factionList = cm:model():world():faction_list()
        for i = 0, factionList:num_items() - 1 do
            local currentFaction = factionList:item_at(i)
            if currentFaction and not currentFaction:is_human() then
                local characterList = currentFaction:character_list()
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j)
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index()
                        if currentFaction:culture() == "wh_main_chs_chaos" then
                            cm:add_building_to_force(mfCQI, "wh_main_horde_chaos_settlement_"..ai_tier) 
                        elseif currentFaction:culture() == "wh_dlc03_bst_beastmen" then
                            cm:add_building_to_force(mfCQI, "wh_dlc03_horde_beastmen_herd_"..ai_tier) 
                        elseif currentFaction:culture() == "wh2_dlc11_cst_vampire_coast" then
                            cm:add_building_to_force(mfCQI, "wh2_dlc11_vampirecoast_ship_captains_cabin_"..ai_tier) 
                        elseif currentFaction:culture() == "wh2_main_lzd_lizardmen" then
                            cm:add_building_to_force(mfCQI, "wh2_dlc13_horde_lizardmen_ziggurat_"..ai_tier) 
                        end
                    end
                end
            end
        end
    end
end

--v function()
function frosty_tiers()

    ------------------------------------------------------------------------
    --Vanilla listener replacement (wh2_dlc15_eltharion_lair.lua)--
    ------------------------------------------------------------------------

    if not cm:get_saved_value("modified_lair_max_yvresse_level") then cm:set_saved_value("modified_lair_max_yvresse_level", 2) end
    core:remove_listener("lair_BuildingCompleted")
    core:add_listener(
        "modified_lair_BuildingCompleted",
        "BuildingCompleted",
        true,
        function(context)
            local building = context:building()
            local region_key = context:garrison_residence():region():name()
            local building_chain = building:chain()
            local building_level = building:building_level()
            if building:faction():name() == "wh2_main_hef_yvresse" then
                if region_key == "wh2_main_vor_northern_yvresse_tor_yvresse" or region_key == "wh2_main_yvresse_tor_yvresse" then
                    if building_chain == "wh2_dlc15_special_settlement_tor_yvresse_eltharion" then
                        if cm:get_saved_value("modified_lair_max_yvresse_level") == 4 and building_level == 5 then
                            cm:set_saved_value("modified_lair_max_yvresse_level", cm:get_saved_value("modified_lair_max_yvresse_level") + 1)
                            cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 10)                 
                        elseif cm:get_saved_value("modified_lair_max_yvresse_level") == 3 and building_level == 4 then
                            cm:set_saved_value("modified_lair_max_yvresse_level", cm:get_saved_value("modified_lair_max_yvresse_level") + 1)
                            cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 10)
                        elseif cm:get_saved_value("modified_lair_max_yvresse_level") == 2 and building_level == 3 then
                            cm:set_saved_value("modified_lair_max_yvresse_level", cm:get_saved_value("modified_lair_max_yvresse_level") + 1)
                            cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 5)
                        end
                    end
                end
            end
        end,
        true
    )

    ------------------------
    --MCT OPTIONS--
    ------------------------

    local mcm = _G.mcm
	if mcm then
        local frostyTiers = mcm:register_mod("frostyTiers", "Higher Starting Tier: Capitals & Hordes", "With this mod your starting settlements/horde can be set at a higher tier from the get-go.")
        
        local _01_enableorDisable = frostyTiers:add_tweaker("_01_enableorDisable", "Mod Status", "")
        _01_enableorDisable:add_option("a1_enable", "Enabled", "")
        _01_enableorDisable:add_option("a2_disable", "Disabled", "")

        local _02_settlementTier = frostyTiers:add_tweaker("_02_settlementTier", "Capital Tier (Players)", "Set the Settlement Starting Tier. Keep in mind that a few of the playable factions (e.g. Skarsnik) start with just a minor settlement and these are set at their max tier of III instead.")
        _02_settlementTier:add_option("4", "Tier IV", "")
		_02_settlementTier:add_option("2", "Tier II", "")
        _02_settlementTier:add_option("3", "Tier III", "")
        _02_settlementTier:add_option("5", "Tier V", "")
        _02_settlementTier:add_option("6", "No Changes (Vanilla)", "")
       
        local _03_AI_settlementTier = frostyTiers:add_tweaker("_03_AI_settlementTier", "Capital Tier (Main Factions)", "Set the Settlement Starting Tier of the different main factions. Also includes a few select cities with high est. populations in the lore such as Nuln, Itza, Kislev, Miragliano, etc.")
        _03_AI_settlementTier:add_option("4", "Tier IV", "")
        _03_AI_settlementTier:add_option("2", "Tier II", "")
        _03_AI_settlementTier:add_option("3", "Tier III", "")
        _03_AI_settlementTier:add_option("5", "Tier V", "")
        _03_AI_settlementTier:add_option("6", "No Changes (Vanilla)", "")

        local _04_hordeTier = frostyTiers:add_tweaker("_04_hordeTier", "Horde Tier (Players)", "Set the Horde Starting Tier (only relevant if you are playing as a horde.).")
        _04_hordeTier:add_option("4", "Tier IV", "")
        _04_hordeTier:add_option("6", "No Changes (Vanilla)", "")
		_04_hordeTier:add_option("2", "Tier II", "")
        _04_hordeTier:add_option("3", "Tier III", "")
        _04_hordeTier:add_option("5", "Tier V", "")

        local _05_settlementScope = frostyTiers:add_tweaker("_05_settlementScope", "Include Other City Types? (not recommended)", "This means not just the main capitals but the capitals of every province is upgraded. For the Hardcore who want every province to be a challenge.")
		_05_settlementScope:add_option("e1_faction_capitals", "No", "Only main faction capitals are affected")
        _05_settlementScope:add_option("e2_provinces_too", "Province Capitals", "All province capitals start at a higher tier.")
        _05_settlementScope:add_option("e3_any_settlement", "Any Settlements", "All settlement main buildings start at a higher tier.")
   
		mcm:add_new_game_only_callback(
            function()
                if cm:get_saved_value("mcm_tweaker_frostyTiers__01_enableorDisable_value") == "a1_enable" then
                    upgrade_capitals(cm:get_saved_value("mcm_tweaker_frostyTiers__02_settlementTier_value"), cm:get_saved_value("mcm_tweaker_frostyTiers__03_AI_settlementTier_value"), cm:get_saved_value("mcm_tweaker_frostyTiers__05_settlementScope_value")) 
                    upgrade_horde(cm:get_saved_value("mcm_tweaker_frostyTiers__04_hordeTier_value"), nil)
                end
			end
        )
    end

    ------------------------
    --MCT2 OPTIONS--
    ------------------------
    local mct = core:get_static_object("mod_configuration_tool")
    if mct then
        local frosty_tiers = mct:get_mod_by_key("frosty_tiers")
        local settings_table = frosty_tiers:get_settings()
        --local _01_enableorDisable = frosty_tiers:get_option_by_key("_01_enableorDisable")
        --if cm:is_new_game() and _01_enableorDisable:get_selected_setting() then 
        if cm:is_new_game() and settings_table._01_enableorDisable then 
            upgrade_capitals(settings_table._02_settlementTier, settings_table._03_AI_settlementTier, settings_table._05_settlementScope)    
            upgrade_horde(settings_table._04_hordeTier, nil)
        end
        core:add_listener(
            "frosty_tiers_MctOptionSettingFinalized",
            "MctOptionSettingFinalized",
            true,
            function(context)
                local settings_table = frosty_tiers:get_settings()
                local _01_enableorDisable = frosty_tiers:get_option_by_key("_01_enableorDisable")

                if cm:is_new_game() and _01_enableorDisable:get_selected_setting() then 
                    upgrade_capitals(settings_table._02_settlementTier, settings_table._03_AI_settlementTier, settings_table._05_settlementScope)    
                    upgrade_horde(settings_table._04_hordeTier, nil)
                end
            end,
            true
        )
    end

    ------------------------------------------------
    --NO MCT - DEFAULT OPTIONS--
    ------------------------------------------------

    if not (mct or mcm) then
        if cm:is_new_game() then 
            upgrade_capitals("4", "4", "e1_faction_capitals")    
            upgrade_horde("4", nil)
        end
    end
end