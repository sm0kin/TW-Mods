local regions_table = {
    -- DWARFS
    "wh_main_the_silver_road_karaz_a_karak", --Thorgrim ME
    "wh_main_the_vaults_karak_izor", --Belegar ME
    "wh_main_peak_pass_karak_kadrin", --Ungrim ME
    -- WOOD ELVES
    "wh_main_athel_loren_waterfall_palace", --Durthu ME
    "wh_main_athel_loren_yn_edryl_korian", --Orion ME
    -- BRETONNIA
    "wh_main_carcassone_et_brionne_castle_carcassonne", --Louen ME 
    "wh_main_bordeleaux_et_aquitaine_bordeleaux", --Alberic ME
    "wh_main_couronne_et_languille_couronne", --Morgianna ME
    "wh2_main_coast_of_araby_copher",  --Repanse ME
"wh2_main_vor_coast_of_araby_copher", --Repanse Vortex
    -- EMPIRE / TEB / KISLEV
    "wh_main_reikland_altdorf", --Franz ME
    "wh_main_middenland_middenheim", --Todbringer ME
    "wh_main_estalia_magritta", 
    "wh_main_wissenland_nuln",
    "wh_main_the_wasteland_marienburg", 
    "wh_main_southern_oblast_kislev", 
    "wh_main_talabecland_talabheim", 
    "wh_main_tilea_miragliano",
    "wh2_main_solland_pfeildorf",  --(Gelt ME)
    "wh2_main_the_creeping_jungle_temple_of_kara",  --(Markus ME)
    "wh2_main_vor_scorpion_coast_temple_of_tlencan",  --(Markus Vor)
    -- VAMPIRE COUNTS
    "wh_main_eastern_sylvania_castle_drakenhof",  --Mannfred ME
    "wh_main_northern_grey_mountains_blackstone_post", --Kemmler ME
    -- GREENSKINS
    "wh_main_death_pass_karak_drazh", --Grimgor ME
    "wh_main_western_badlands_ekrund", --Wurrzag ME
    "wh_main_southern_grey_mountains_karak_azgaraz", --Skarsnik ME
    -- SKAVEN
    "wh2_main_charnel_valley_karag_orrud", --Queek ME
    "wh2_main_vor_southern_jungles_yuatek", --Queek Vor 
    "wh2_main_hell_pit_hell_pit",
    "wh2_main_the_clawed_coast_hoteks_column", --Tretch ME
    "wh2_main_vor_the_clawed_coast_hoteks_column", --Tretch Vor
    "wh2_main_headhunters_jungle_oyxl", --Skrolk ME
    "wh2_main_vor_the_lost_valleys_oyxl", --Skrolk Vor
    "wh2_main_skavenblight_skavenblight", --Ikit ME
    "wh2_main_vor_the_vampire_coast_the_star_tower", --Ikit Vor
    "wh2_main_gnoblar_country_flayed_rock", --Snikch ME
"wh2_main_vor_land_of_the_dervishes_el-kalabad", --Snikch Vortex
    -- DARK ELVES	
    "wh2_main_iron_mountains_naggarond", --Malekith ME
    "wh2_main_vor_naggarond_naggarond", --Malekith Vor
    "wh2_main_titan_peaks_ancient_city_of_quintex", 
    "wh2_main_vor_iron_peaks_ancient_city_of_quintex", 
    "wh2_main_the_road_of_skulls_har_ganeth", 
    "wh2_main_vor_the_road_of_skulls_har_ganeth", 
    "wh2_main_headhunters_jungle_chupayotl", 
    "wh2_main_vor_culchan_plains_chupayotl",
    "wh2_main_the_black_flood_hag_graef", --Malus ME
    "wh2_main_vor_the_black_flood_hag_graef", --Malus Vortex
    -- LIZARDMEN
    "wh2_main_isthmus_of_lustria_hexoatl", --Mazdamundi ME
    "wh2_main_vor_isthmus_of_lustria_hexoatl", --Mazdamundi Vortex
    "wh2_main_kingdom_of_beasts_temple_of_skulls", --Dinoriderman --ME
    "wh2_main_vor_kingdom_of_beasts_temple_of_skulls", --Dinoriderman --Vor
    "wh2_main_southern_great_jungle_itza", --Gor Rok ME
    "wh2_main_vor_northern_great_jungle_itza", --Gor Rok Vor
    "wh2_main_northern_great_jungle_xlanhuapec", 
    "wh2_main_vor_culchan_plains_kaiax", 
    "wh2_main_western_jungles_tlaqua", --Pun ME
    "wh2_main_vor_western_jungles_tlaqua", --Pun Vor
    -- TOMB KINGS
    "wh2_main_vor_copper_desert_the_forgotten_isles",
    "wh2_main_vor_ashen_coast_scarpels_lair", 
    "wh2_main_vor_land_of_the_dead_khemri", --Settra Vor
    "wh2_main_land_of_the_dead_khemri", --Setra ME
    "wh2_main_land_of_assassins_palace_of_the_wizard_caliph", 
    "wh2_main_vor_land_of_assassins_palace_of_the_wizard_caliph", 
    "wh2_main_blackspine_mountains_plain_of_spiders", 
    "wh2_main_devils_backbone_lybaras", 
    -- NORSCA
    "wh_main_mountains_of_hel_winter_pyre", 
    "wh_main_ice_tooth_mountains_icedrake_fjord", 
    -- HIGH ELVES
    "wh2_main_eataine_lothern", 
    "wh2_main_vor_straits_of_lothern_lothern", 
    "wh2_main_volcanic_islands_the_star_tower", 
    "wh2_main_vor_the_turtle_isles_great_turtle_isle", 
    "wh2_main_avelorn_gaean_vale",
    "wh2_main_vor_avelorn_gaean_vale", 
    "wh2_main_vor_the_broken_land_black_creek_spire", 
    "wh2_main_the_black_coast_arnheim", 
    -- VAMPIRE COAST
    "wh2_main_vor_sartosa_sartosa", 
    "wh2_main_sartosa_sartosa", 
    "wh2_main_vampire_coast_the_awakening", 
    "wh2_main_vor_the_vampire_coast_the_awakening", 
    "wh2_main_the_galleons_graveyard", 
    "wh2_main_vor_the_galleons_graveyard", 
    "wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon", 
    "wh2_main_vor_grey_guardians_grey_rock_point"
} --: vector<string>

--v function(tier: string, ownerScope: string, settlementScope: string)
local function upgrade_capitals(tier, ownerScope, settlementScope)
    --v function(currentRegion: string)
    local function upgrade(currentRegion)
        local regionCA = cm:get_region(currentRegion)
        if regionCA and not regionCA:is_abandoned() then
            local settlement = regionCA:settlement()
            if (ownerScope == "playersOnly" and regionCA and regionCA:owning_faction():is_human()) or (ownerScope == "aiOnly" and regionCA and not regionCA:owning_faction():is_human()) or ownerScope == "both" then
                cm:instantly_set_settlement_primary_slot_level(settlement, tonumber(tier))
            end
        end
    end
    if settlementScope == "all" or settlementScope == "all_province" then
        local region_list = cm:model():world():region_manager():region_list()
        for i=0, region_list:num_items() - 1 do
            if settlementScope == "all" or (settlementScope == "all_province" and region_list:item_at(i):is_province_capital()) then
                upgrade(region_list:item_at(i):name())
            end
        end
    else
        for _, region in ipairs(regions_table) do
            upgrade(region)
        end
    end
end

--v function(tier: string, scope: string)
local function upgrade_horde(tier, scope)
    local factionList = cm:model():world():faction_list()
    for i = 0, factionList:num_items() - 1 do
        local currentFaction = factionList:item_at(i)
        if (scope == "playersOnly" and currentFaction and currentFaction:is_human()) or (scope == "aiOnly" and currentFaction and not currentFaction:is_human()) or scope == "both" then
            if currentFaction and currentFaction:culture() == "wh_main_chs_chaos" then
                local characterList = currentFaction:character_list()
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j)
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index()
                        cm:add_building_to_force(mfCQI, "wh_main_horde_chaos_settlement_"..tier) 
                    end
                end
            elseif currentFaction and currentFaction:culture() == "wh_dlc03_bst_beastmen" then
                local characterList = currentFaction:character_list()
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j)
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index()
                        cm:add_building_to_force(mfCQI, "wh_dlc03_horde_beastmen_herd_"..tier) 
                    end
                end
            elseif currentFaction and currentFaction:culture() == "wh2_dlc11_cst_vampire_coast" then
                local characterList = currentFaction:character_list()
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j)
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index()
                        cm:add_building_to_force(mfCQI, "wh2_dlc11_vampirecoast_ship_captains_cabin_"..tier) 
                    end
                end
            elseif currentFaction and currentFaction:culture() == "wh2_main_lzd_lizardmen" then
                local characterList = currentFaction:character_list()
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j)
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index()
                        cm:add_building_to_force(mfCQI, "wh2_dlc13_horde_lizardmen_ziggurat_"..tier) 
                    end
                end
            end
        end
    end
end

--v function()
function frosty_tiers()
    local mcm = _G.mcm
	if not not mcm then
        local frostyTiers = mcm:register_mod("frostyTiers", "Higher Tier Starting Capitals/Hordes", "With this mod your starting settlements/horde can be set at a higher tier from the get-go.")
        local ownerScope = frostyTiers:add_tweaker("ownerScope", "Ownership Scope", "Higher Tier Settlements for Player-only, AI-only or both Players & AI?")
		ownerScope:add_option("both", "Both", "Changes apply to both the AI and the Players.")
        ownerScope:add_option("playersOnly", "Players-Only", "Changes only apply to Player factions.")
        ownerScope:add_option("aiOnly", "AI-Only", "Changes only apply to AI factions.")
        local settlementScope = frostyTiers:add_tweaker("settlementScope", "Settlement Scope", "Only Starting settlements of the playable factions or all province capitals.")
		settlementScope:add_option("table", "Playable Faction Capitals", "The higher tier upgrade also extends to a small handful of cities that have exceptionally high est. populations in the lore: Hellpit, Itza, Kislev, Magritta, Marienburg, Miragliano, Nuln, Skavenblight and Talabheim.")
        settlementScope:add_option("all_province", "All Province Capitals", "All province capitals start at a higher tier.")
        settlementScope:add_option("all", "All Settlements", "All settlement main buildings start at a higher tier.")
        local settlementTier = frostyTiers:add_tweaker("settlementTier", "Settlement Starting Tier", "Set the Settlement Starting Tier.")
        settlementTier:add_option("4", "Tier IV", "Sets the Settlement Starting Tier to IV.")
		settlementTier:add_option("2", "Tier II", "Sets the Settlement Starting Tier to II.")
        settlementTier:add_option("3", "Tier III", "Sets the Settlement Starting Tier to III.")
        settlementTier:add_option("5", "Tier V", "Sets the Settlement Starting Tier to V.")
        local hordeScope = frostyTiers:add_tweaker("hordeScope", "Horde Scope", "Higher Tier Hordes for Player-only, AI-only or both Players & AI?")
        hordeScope:add_option("playersOnly", "Players-Only", "Changes only apply to Player factions.")
        hordeScope:add_option("both", "Both", "Changes apply to both the AI and the Players.")
        hordeScope:add_option("aiOnly", "AI-Only", "Changes only apply to AI factions.")
        local hordeTier = frostyTiers:add_tweaker("hordeTier", "Horde Starting Tier", "Set the Horde Starting Tier.")
        hordeTier:add_option("4", "Tier IV", "Sets the Horde Starting Tier to IV.")
		hordeTier:add_option("2", "Tier II", "Sets the Horde Starting Tier to II.")
        hordeTier:add_option("3", "Tier III", "Sets the Horde Starting Tier to III.")
        hordeTier:add_option("5", "Tier V", "Sets the Horde Starting Tier to V.")
		mcm:add_new_game_only_callback(
            function()
                upgrade_capitals(cm:get_saved_value("mcm_tweaker_frostyTiers_settlementTier_value"), cm:get_saved_value("mcm_tweaker_frostyTiers_ownerScope_value"), cm:get_saved_value("mcm_tweaker_frostyTiers_settlementScope_value")) 
                upgrade_horde(cm:get_saved_value("mcm_tweaker_frostyTiers_hordeTier_value"), cm:get_saved_value("mcm_tweaker_frostyTiers_hordeScope_value"))
			end
        )
    else
        if cm:is_new_game() then 
            upgrade_capitals("4", "both", "table")    
            upgrade_horde("4", "playersOnly")
        end
    end
end