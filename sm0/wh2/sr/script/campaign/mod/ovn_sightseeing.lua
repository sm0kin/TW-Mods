local function ovn_sightseeing()
    if cm:model():campaign_name("main_warhammer") then
        if cm:is_new_game() then
            cm:override_building_chain_display(
                "wh_main_GREENSKIN_settlement_minor",
                "wh_main_VAMPIRES_settlement_major",
                "wh_main_southern_grey_mountains_karak_azgaraz"
            )
            cm:override_building_chain_display(
                "wh_main_DWARFS_settlement_minor",
                "wh_main_VAMPIRES_settlement_major",
                "wh_main_desolation_of_nagash_spitepeak"
            )
            cm:override_building_chain_display(
                "wh_main_DWARFS_settlement_minor",
                "wh2_dlc09_tmb_settlement_minor",
                "wh_main_the_vaults_zarakzil"
            )
            cm:override_building_chain_display(
                "wh_main_DWARFS_settlement_minor",
                "wh2_main_lzd_settlement_minor",
                "wh_main_desolation_of_nagash_black_iron_mine"
            )
            cm:override_building_chain_display(
                "wh_main_GREENSKIN_settlement_minor",
                "wh_dlc05_wef_oak_of_ages",
                "wh_main_western_badlands_dragonhorn_mines"
            )
            cm:override_building_chain_display(
                "wh2_dlc09_tmb_settlement_minor",
                "wh_main_BRETONNIA_settlement_major",
                "wh2_main_shifting_sands_antoch"
            )

            local region_list = cm:model():world():region_manager():region_list()
            for i = 0, region_list:num_items() - 1 do
                cm:heal_garrison(region_list:item_at(i):cqi())
            end
        end
    end
end

cm:add_first_tick_callback(
    function()
        ovn_sightseeing()
    end
)
