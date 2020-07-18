cm:add_first_tick_callback(function()
    if cm:get_local_faction(true) == "wh2_main_ovn_chaos_dwarfs" 
    or cm:get_local_faction(true) == "wh2_main_arb_aswad_scythans" 
    or cm:get_local_faction(true) == "wh2_main_arb_caliphate_of_araby" 
    or cm:get_local_faction(true) == "wh2_main_arb_flaming_scimitar" 
    or cm:get_local_faction(true) == "wh2_main_wef_treeblood" 
    or cm:get_local_faction(true) == "wh_dlc08_nor_naglfarlings" 
    or cm:get_local_faction(true) == "wh_dlc08_nor_goromadny_tribe" 
    then

        local button_slaves = find_uicomponent(
            core:get_ui_root(),
            "layout", "faction_buttons_docker", "button_group_management", "button_slaves"
        )
        if button_slaves then
            button_slaves:SetImagePath("ui\\skins\\default\\icon_postbattle_enslave.png", 0)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_selected_inactive.png", 1)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_pressed.png", 2)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_selected_hover.png", 3)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_hover.png", 4)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_active.png", 5)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_inactive.png", 6)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_selected.png", 7)
            button_slaves:SetImagePath("ui\\skins\\default\\button_round_large_selected_pressed.png", 8)
            button_slaves:SetImagePath("ui\\skins\\default\\spell_dial_frame.png", 9)
        end
    
        core:add_listener(
            "pj_chorfs_fix_settlement_panel_slaves_buttons",
            "PanelOpenedCampaign",
            function(context)
                return context.string == "settlement_panel"
            end,
            function()
                cm:callback(function()
                    local slaves_buttonset = find_uicomponent(
                        core:get_ui_root(),
                        "layout", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "ProvinceInfoPopup", "panel", "frame_PO_income", "slaves_buttonset"
                    )
                    if not slaves_buttonset then
                        return
                    end
        
                    local req = find_uicomponent(slaves_buttonset, "button_request")
                    local stop = find_uicomponent(slaves_buttonset, "button_no_more")
                    local recieve = find_uicomponent(slaves_buttonset, "button_recieve")
                    if req and stop and recieve then
                        req:SetImagePath("ui\\skins\\warhammer2\\icon_slave_options_request.png", 0)
                        stop:SetImagePath("ui\\skins\\warhammer2\\icon_slave_options_stop.png", 0)
                        recieve:SetImagePath("ui\\skins\\warhammer2\\icon_slave_options_receive.png", 0)
                    end
                end, 0.1)
            end,
            true
        )

    end
end)