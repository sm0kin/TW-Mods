local regions_buildings = {
    -- DWARFS
    {"wh_main_the_silver_road_karaz_a_karak", "wh_main_special_settlement_karaz_a_karak_4_dwf"},
    {"wh_main_the_vaults_karak_izor", "wh_main_dwf_settlement_major_4"},
    {"wh_main_peak_pass_karak_kadrin", "wh_main_dwf_settlement_major_4"},
    -- WOOD ELVES
    {"wh_main_athel_loren_waterfall_palace", "wh_dlc05_wef_settlement_major_main_4"},
    {"wh_main_athel_loren_yn_edryl_korian", "wh_dlc05_wef_settlement_major_main_4"},
    -- BRETONNIA
    {"wh_main_carcassone_et_brionne_castle_carcassonne", "wh_main_brt_settlement_major_4"},
    {"wh_main_bordeleaux_et_aquitaine_bordeleaux", "wh_main_brt_settlement_major_4_coast"},
    {"wh_main_couronne_et_languille_couronne", "wh_main_special_settlement_couronne_4_brt"},
    -- EMPIRE / TEB / KISLEV
    {"wh_main_reikland_altdorf", "wh_main_special_settlement_altdorf_4_emp"},
    {"wh_main_middenland_middenheim", "wh_main_emp_settlement_major_4"},
    {"wh_main_estalia_magritta", "wh_main_emp_settlement_major_4_coast"},
    {"wh_main_wissenland_nuln", "wh_main_emp_settlement_major_4"},
    {"wh_main_the_wasteland_marienburg", "wh_main_emp_settlement_major_4_coast"},
    {"wh_main_southern_oblast_kislev", "wh_main_special_settlement_kislev_4_ksl"},
    {"wh_main_talabecland_talabheim", "wh_main_emp_settlement_major_4"},
    {"wh_main_tilea_miragliano", "wh_main_special_settlement_miragliano_4_teb"},
    -- VAMPIRE COUNTS
    {"wh_main_eastern_sylvania_castle_drakenhof", "wh_main_special_settlement_castle_drakenhof_4_vmp"},
    {"wh_main_northern_grey_mountains_blackstone_post", "wh_main_vmp_settlement_major_4"},
    -- GREENSKINS
    {"wh_main_death_pass_karak_drazh", "wh_main_special_settlement_black_crag_4_grn"},
    {"wh_main_western_badlands_ekrund", "wh_main_grn_settlement_major_4_wurrzag"},
    {"wh_main_southern_grey_mountains_karak_azgaraz", "wh_main_grn_settlement_minor_4_skarsnik"},
    -- SKAVEN
    {"wh2_main_charnel_valley_karag_orrud", "wh2_main_skv_settlement_major_4"},
    {"wh2_main_vor_southern_jungles_yuatek", "wh2_main_skv_settlement_major_4"},
    {"wh2_main_hell_pit_hell_pit", "wh2_main_special_settlement_hellpit_4"},
    {"wh2_main_the_clawed_coast_hoteks_column", "wh2_main_skv_settlement_major_4"},
    {"wh2_main_vor_the_clawed_coast_hoteks_column", "wh2_main_skv_settlement_major_4"},
    {"wh2_main_headhunters_jungle_oyxl", "wh2_main_skv_settlement_major_4"},
    {"wh2_main_vor_the_lost_valleys_oyxl", "wh2_main_skv_settlement_major_4"},
    {"wh2_main_skavenblight_skavenblight", "wh2_main_special_settlement_skavenblight_4"},
    {"wh2_main_vor_the_vampire_coast_the_star_tower", "wh2_main_special_settlement_colony_major_other_4"},
    -- DARK ELVES	
    {"wh2_main_iron_mountains_naggarond", "wh2_main_special_settlement_naggarond_4"},
    {"wh2_main_vor_naggarond_naggarond", "wh2_main_special_settlement_naggarond_4"},
    {"wh2_main_titan_peaks_ancient_city_of_quintex", "wh2_main_def_settlement_major_4"},
    {"wh2_main_vor_iron_peaks_ancient_city_of_quintex", "wh2_main_def_settlement_major_4"},
    {"wh2_main_the_road_of_skulls_har_ganeth", "wh2_main_def_settlement_major_4"},
    {"wh2_main_vor_the_road_of_skulls_har_ganeth", "wh2_main_def_settlement_major_4"},
    {"wh2_main_headhunters_jungle_chupayotl", "wh2_main_def_settlement_minor_4_coast"},
    {"wh2_main_vor_culchan_plains_chupayotl", "wh2_main_def_settlement_major_4_coast"},
    -- LIZARDMEN
    {"wh2_main_isthmus_of_lustria_hexoatl", "wh2_main_special_settlement_hexoatl_hexoatl_4"},
    {"wh2_main_vor_isthmus_of_lustria_hexoatl", "wh2_main_special_settlement_hexoatl_hexoatl_4"},
    {"wh2_main_kingdom_of_beasts_temple_of_skulls", "wh2_main_lzd_settlement_major_4"},
    {"wh2_main_vor_kingdom_of_beasts_temple_of_skulls", "wh2_main_lzd_settlement_major_4"},
    {"wh2_main_southern_great_jungle_itza", "wh2_main_special_settlement_itza_itza_4"},
    {"wh2_main_vor_northern_great_jungle_itza", "wh2_main_special_settlement_itza_itza_4"},
    {"wh2_main_northern_great_jungle_xlanhuapec", "wh2_main_lzd_settlement_major_4"},
    {"wh2_main_vor_culchan_plains_kaiax", "wh2_main_lzd_settlement_major_4_coast"},
    {"wh2_main_western_jungles_tlaqua", "wh2_main_lzd_settlement_major_4"},
    {"wh2_main_vor_western_jungles_tlaqua", "wh2_main_lzd_settlement_major_4"},
    -- TOMB KINGS
    {"wh2_main_vor_copper_desert_the_forgotten_isles", "wh2_dlc09_tmb_settlement_major_coast_4"},
    {"wh2_main_vor_ashen_coast_scarpels_lair", "wh2_dlc09_tmb_settlement_major_4"},
    {"wh2_main_vor_land_of_the_dead_khemri", "wh2_dlc09_special_settlement_khemri_tmb_4"},
    {"wh2_main_land_of_the_dead_khemri", "wh2_dlc09_special_settlement_khemri_tmb_4"},
    {"wh2_main_land_of_assassins_palace_of_the_wizard_caliph", "wh2_dlc09_tmb_settlement_major_4"},
    {"wh2_main_vor_land_of_assassins_palace_of_the_wizard_caliph", "wh2_dlc09_tmb_settlement_major_4"},
    {"wh2_main_blackspine_mountains_plain_of_spiders", "wh2_dlc09_tmb_settlement_minor_4"},
    {"wh2_main_devils_backbone_lybaras", "wh2_dlc09_tmb_settlement_minor_4"},
    -- NORSCA
    {"wh_main_mountains_of_hel_winter_pyre", "wh_main_nor_settlement_minor_4_coast"},
    {"wh_main_ice_tooth_mountains_icedrake_fjord", "wh_main_nor_settlement_major_4_coast"},
    -- HIGH ELVES
    {"wh2_main_eataine_lothern", "wh2_main_special_settlement_lothern_4"},
    {"wh2_main_vor_straits_of_lothern_lothern", "wh2_main_special_settlement_lothern_4"},
    {"wh2_main_volcanic_islands_the_star_tower", "wh2_main_special_settlement_colony_major_hef_4"},
    {"wh2_main_vor_the_turtle_isles_great_turtle_isle", "wh2_main_special_settlement_colony_major_hef_4"},
    {"wh2_main_avelorn_gaean_vale", "wh2_main_special_settlement_gaean_vale_4"},
    {"wh2_main_vor_the_broken_land_black_creek_spire", "wh2_main_hef_settlement_minor_4"},
    {"wh2_main_the_black_coast_arnheim", "wh2_main_special_settlement_colony_major_hef_4"},
    -- VAMPIRE COAST
    {"wh2_main_vor_sartosa_sartosa", "wh2_main_special_settlement_sartosa_cst_4"},
    {"wh2_main_sartosa_sartosa", "wh2_main_special_settlement_sartosa_cst_4"},
    {"wh2_main_vampire_coast_the_awakening", "wh2_main_special_settlement_the_awakening_cst_4"},
    {"wh2_main_vor_the_vampire_coast_the_awakening", "wh2_main_special_settlement_the_awakening_cst_4"},
    {"wh2_main_the_galleons_graveyard", "wh2_dlc11_special_settlement_galleons_graveyard_4"},
    {"wh2_main_vor_the_galleons_graveyard", "wh2_dlc11_special_settlement_galleons_graveyard_4"},
    {"wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon", "wh2_dlc11_vampirecoast_settlement_minor_coast_4"},
    {"wh2_main_vor_grey_guardians_grey_rock_point", "wh2_dlc11_vampirecoast_settlement_minor_coast_4"}
} --: vector<vector<string>>

--v function(tier: string, scope: string)
function upgrade_capitals(tier, scope)
    for _, region_building in ipairs(regions_buildings) do
        local currentRegion = region_building[1];
        local currentBuilding = region_building[2];
        currentBuilding = string.gsub(currentBuilding, "_%d", "_"..tier);
        local regionCA = cm:get_region(currentRegion);
        if regionCA and not regionCA:is_abandoned() then
            local slots = regionCA:slot_list();
            currentSlot = slots:item_at(0);
            currentBuilding = currentSlot:building():name()
            out("sm0/building = "..currentBuilding);
            currentBuilding = string.gsub(currentBuilding, "_%d", "_"..tier); --is_province_capital
            if (scope == "playerOnly" and regionCA and regionCA:owning_faction():is_human()) or (scope == "aiOnly" and regionCA and not regionCA:owning_faction():is_human()) or scope == "both" then
                cm:instantly_upgrade_building_in_region(currentRegion, 0, currentBuilding);
            end
        end
    end
end

--v function(tier: string, scope: string)
function upgrade_horde(tier, scope)
    local factionList = cm:model():world():faction_list();
    for i = 0, factionList:num_items() - 1 do
        local currentFaction = factionList:item_at(i);
        if (scope == "playerOnly" and currentFaction and currentFaction:is_human()) or (scope == "aiOnly" and currentFaction and not currentFaction:is_human()) or scope == "both" then
            if currentFaction and currentFaction:culture() == "wh_main_chs_chaos" then
                local characterList = currentFaction:character_list();
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j);
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index();
                        cm:add_building_to_force(mfCQI, "wh_main_horde_chaos_settlement_"..tier); 
                    end
                end
            elseif currentFaction and currentFaction:culture() == "wh_dlc03_bst_beastmen" then
                local characterList = currentFaction:character_list();
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j);
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index();
                        cm:add_building_to_force(mfCQI, "wh_dlc03_horde_beastmen_herd_"..tier); 
                    end
                end
            elseif currentFaction and currentFaction:culture() == "wh2_dlc11_cst_vampire_coast" then
                local characterList = currentFaction:character_list();
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j);
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index();
                        cm:add_building_to_force(mfCQI, "wh2_dlc11_vampirecoast_ship_captains_cabin_"..tier); 
                    end
                end
            end
        end
    end
end

function frosty_tiers()
    local mcm = _G.mcm;
	if not not mcm then
        local frostyTiers = mcm:register_mod("frostyTiers", "Higher Tier Starting Capitals/Hordes", "With this mod your starting settlements/horde can be set at a higher tier from the get-go");
        local settlementScope = frostyTiers:add_tweaker("settlementScope", "Settlement Scope", "Higher Tier Settlements for Player-only, AI-only or both Players & AI?");
		settlementScope:add_option("both", "Both", "Changes apply to both the AI and the Players.");
        settlementScope:add_option("playersOnly", "Players-Only", "Changes only apply to Player factions.");
        settlementScope:add_option("aiOnly", "AI-Only", "Changes only apply to AI factions.");
        local settlementTier = frostyTiers:add_tweaker("settlementTier", "Settlement Starting Tier", "Set the Settlement Starting Tier.");
        settlementTier:add_option("4", "Tier IV", "Sets the Settlement Starting Tier to IV.");
		settlementTier:add_option("2", "Tier II", "Sets the Settlement Starting Tier to II.");
        settlementTier:add_option("3", "Tier III", "Sets the Settlement Starting Tier to III.");
        settlementTier:add_option("5", "Tier V", "Sets the Settlement Starting Tier to V.");
        
        local hordeScope = frostyTiers:add_tweaker("hordeScope", "Horde Scope", "Higher Tier Hordes for Player-only, AI-only or both Players & AI?");
        hordeScope:add_option("playersOnly", "Players-Only", "Changes only apply to Player factions.");
        hordeScope:add_option("both", "Both", "Changes apply to both the AI and the Players.");
        hordeScope:add_option("aiOnly", "AI-Only", "Changes only apply to AI factions.");
        local hordeTier = frostyTiers:add_tweaker("hordeTier", "Horde Starting Tier", "Set the Horde Starting Tier.");
        hordeTier:add_option("4", "Tier IV", "Sets the Horde Starting Tier to IV.");
		hordeTier:add_option("2", "Tier II", "Sets the Horde Starting Tier to II.");
        hordeTier:add_option("3", "Tier III", "Sets the Horde Starting Tier to III.");
        hordeTier:add_option("5", "Tier V", "Sets the Horde Starting Tier to V.");
		mcm:add_post_process_callback(
            function()
                if cm:is_new_game() then 
                    upgrade_capitals(cm:get_saved_value("mcm_tweaker_frostyTiers_settlementTier_value"), cm:get_saved_value("mcm_tweaker_frostyTiers_settlementScope_value")); 
                    upgrade_horde(cm:get_saved_value("mcm_tweaker_frostyTiers_hordeTier_value"), cm:get_saved_value("mcm_tweaker_frostyTiers_hordeScope_value"));
                end
			end
        )
    else
        if cm:is_new_game() then 
            upgrade_capitals("4", "both");    
            upgrade_horde("4", "playerOnly");
        end
    end
end