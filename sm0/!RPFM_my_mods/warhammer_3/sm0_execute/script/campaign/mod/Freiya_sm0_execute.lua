local enable_value
local blacklisted_value

local blacklisted_subtypes = {
    -- Vanilla unique heroes
    "wh2_dlc12_lzd_lord_kroak",
    "wh2_dlc13_emp_hunter_doctor_hertwig_van_hal",
    "wh2_dlc13_emp_hunter_jorek_grimm",
    "wh2_dlc13_emp_hunter_kalara_of_wydrioth",
    "wh2_dlc13_emp_hunter_rodrik_l_anguille",
    "wh2_dlc14_brt_henri_le_massif",
    "wh2_dlc16_skv_ghoritch",
    "wh2_dlc16_wef_ariel",
    "wh2_dlc16_wef_coeddil",
    "wh2_dlc17_dwf_thane_ghost_artifact",
    "wh2_dlc17_lzd_mon_dread_saurian_qb_boss",
    "wh2_pro08_neu_felix",
    "wh3_main_ie_nor_burplesmirk_spewpit",
    "wh3_main_ie_nor_killgore_slaymaim",
    "wh3_main_pro_ksl_frost_maiden_ice",
    "wh_dlc04_vmp_vlad_von_carstein_hero",
    "wh_dlc07_brt_green_knight",
    "wh_dlc08_nor_kihar",
    "wh_pro02_vmp_isabella_von_carstein_hero"
}

local function delete_trash_ui()
    -- Delete the buttons/checkboxes (mostly triggered when the player opens a fullscreen menu)
	local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
	local dropdown_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units")
	if dropdown_units:Find("trash_bin_button") then 
		local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
		trash_bin_button:Destroy()
		core:remove_listener("sm0_execute_trash_bin_button_ComponentLClickUp")
	end
	if dropdown_units:Find("cross_trash_button") then 
		local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
		cross_trash_button:Destroy()
		core:remove_listener("sm0_execute_cross_trash_button_ComponentLClickUp")
	end
	if dropdown_units:Find("check_trash_button") then 
		local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
		check_trash_button:Destroy()
		core:remove_listener("sm0_execute_check_trash_button_ComponentLClickUp")
	end
	for i = 0, list_box:ChildCount() - 1 do
		local character_row = UIComponent(list_box:Find(i))
		local character_row_len = string.len("character_row_")
		local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
		if character_row:Find("checkbox_toggle_"..cqi_string) then 
			local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
			checkbox_toggle:Destroy()
			core:remove_listener("sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
		end
	end
end

local function create_trash_ui()
    -- Adds buttons/checkboxes in the army list tab
	local player_faction = cm:get_local_faction(true) 
	local icon_delete = "ui/skins/default/icon_delete.png"
	local icon_cross = "ui/skins/default/icon_cross.png"
	local icon_check = "ui/skins/default/icon_check.png"

	local trash_bin_button_disabled = common.get_localised_string("trash_bin_button_disabled_"..player_faction:culture()) 
	if trash_bin_button_disabled == "" then trash_bin_button_disabled = "No Lords or Heroes selected for execution." end
	local trash_bin_button_hover_1 = common.get_localised_string("trash_bin_button_hover_1_"..player_faction:culture()) 
	if trash_bin_button_hover_1 == "" then trash_bin_button_hover_1 = "Are you sure you want to execute all (" end
	local trash_bin_button_hover_2 = common.get_localised_string("trash_bin_button_hover_2_"..player_faction:culture()) 
	if trash_bin_button_hover_2 == "" then trash_bin_button_hover_2 = ") selected Lords/Heroes?" end
	local check_trash_button_hover_1 = common.get_localised_string("check_trash_button_hover_1_"..player_faction:culture()) 
	if check_trash_button_hover_1 == "" then check_trash_button_hover_1 = "Execute all (" end
	local check_trash_button_hover_2 = common.get_localised_string("check_trash_button_hover_2_"..player_faction:culture()) 
	if check_trash_button_hover_2 == "" then check_trash_button_hover_2 = ") selected Lords/Heroes!" end
	local check_trash_button_disabled = common.get_localised_string("check_trash_button_disabled_"..player_faction:culture()) 
	if check_trash_button_disabled == "" then check_trash_button_disabled = "No Lords or Heroes selected." end
	local checkbox_toggle_lord_hover = common.get_localised_string("checkbox_toggle_lord_hover_"..player_faction:culture()) 
	if checkbox_toggle_lord_hover == "" then checkbox_toggle_lord_hover = "Select Lord for Execution." end
	local checkbox_toggle_lord_selected_hover = common.get_localised_string("checkbox_toggle_lord_selected_hover_"..player_faction:culture()) 
	if checkbox_toggle_lord_selected_hover == "" then checkbox_toggle_lord_selected_hover = "Lord selected for Execution." end
	local checkbox_toggle_hero_hover = common.get_localised_string("checkbox_toggle_hero_hover_"..player_faction:culture()) 
	if checkbox_toggle_hero_hover == "" then checkbox_toggle_hero_hover = "Select Hero for Execution." end
	local checkbox_toggle_hero_selected_hover = common.get_localised_string("checkbox_toggle_hero_selected_hover_"..player_faction:culture()) 
	if checkbox_toggle_hero_selected_hover == "" then checkbox_toggle_hero_selected_hover = "Hero selected for Execution." end
	local checkbox_toggle_lord_disabled = common.get_localised_string("checkbox_toggle_lord_disabled_"..player_faction:culture()) 
	if checkbox_toggle_lord_disabled == "" then checkbox_toggle_lord_disabled = "This Lord can't be executed." end
	local checkbox_toggle_hero_disabled = common.get_localised_string("checkbox_toggle_hero_disabled_"..player_faction:culture())
	if checkbox_toggle_hero_disabled == "" then checkbox_toggle_hero_disabled = "This Hero can't be executed." end
	local cross_trash_button_hover = common.get_localised_string("cross_trash_button_hover_"..player_faction:culture()) 
	if cross_trash_button_hover == "" then cross_trash_button_hover = "Cancel." end

	local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
	local dropdown_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel")
	local reference_title = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "tx_title")
	local sort_type = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "headers", "sort_type")
	local sort_type_W, sort_type_H = sort_type:Bounds()
	local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
	
	-- Adds the trash bin button near the title of the army list
	if not dropdown_units:Find("trash_bin_button") then
		trash_bin_button = UIComponent(dropdown_units:CreateComponent("trash_bin_button", "ui/templates/square_medium_button"))
		reference_title:Adopt(trash_bin_button:Address())
		trash_bin_button:SetDockingPoint(4) -- centre left dock
		trash_bin_button:SetCanResizeHeight(true)
		trash_bin_button:SetCanResizeWidth(true)
		trash_bin_button:Resize(sort_type_W * 1.5, sort_type_W * 1.5)
		local trash_bin_button_W, trash_bin_button_H = trash_bin_button:Bounds()
		trash_bin_button:SetDockOffset(trash_bin_button_W * 0.5, 0)
		trash_bin_button:SetImagePath(icon_delete) 
		trash_bin_button:SetState("inactive")
		trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 
	end
    
	--local function create_comboboxes()
    -- Adds checkboxes for each hero/lord in the army list tab
    local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
    local trash_bin_button_W, trash_bin_button_H = trash_bin_button:Bounds()
    for i = 0, list_box:ChildCount() - 1 do
        local character_row = UIComponent(list_box:Find(i))
        local character_row_len = string.len("character_row_")
        local cqi_string = string.sub(character_row:Id(), character_row_len + 1) 

        if not character_row:Find("checkbox_toggle_"..cqi_string) then 
            local reference_uic = find_uicomponent(character_row, "indent_parent", "soldiers")
            local reference_uic_W, reference_uic_H = reference_uic:Bounds()
            local reference_uic_X, reference_uic_Y = reference_uic:Position()
            local reference_uic_2 = find_uicomponent(character_row, "indent_parent", "icon_wounded") 
            local reference_uic_2_X, reference_uic_2_Y = reference_uic_2:Position()

            local checkbox_toggle = core:get_or_create_component("checkbox_toggle_"..cqi_string, "ui/templates/checkbox_toggle", character_row)
            character_row:Adopt(checkbox_toggle:Address())
            checkbox_toggle:PropagatePriority(reference_uic:Priority())
            checkbox_toggle:SetCanResizeHeight(true)
            checkbox_toggle:SetCanResizeWidth(true)
            checkbox_toggle:Resize(trash_bin_button_W, trash_bin_button_H)
            local checkbox_toggle_W, checkbox_toggle_H = checkbox_toggle:Bounds()
            checkbox_toggle:MoveTo(reference_uic_X + reference_uic_W / 2 - checkbox_toggle_W / 2 - 5, reference_uic_2_Y + reference_uic_H/2 + 1)
            reference_uic:MoveTo(reference_uic_X, reference_uic_2_Y - reference_uic_H/2 - 1)

            core:remove_listener("sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
            -- Listener updating the interface when the player clicks on lords/heroes checkboxes
            core:add_listener(
                "sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp",
                "ComponentLClickUp",
                function(context)
                    return context.string == "checkbox_toggle_"..cqi_string
                end,
                function(context)
                    local chars_selected = 0
                    local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
                    for i = 0, list_box:ChildCount() - 1 do
                        local character_row = UIComponent(list_box:Find(i))
                        local character_row_len = string.len("character_row_")
                        local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
                        local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
                        if checkbox_toggle:CurrentState() == "selected" or checkbox_toggle:CurrentState() == "selected_hover" or checkbox_toggle:CurrentState() == "down" then	
                            chars_selected = chars_selected + 1
                        end
                    end
                    if dropdown_units:Find("check_trash_button") then 
                        local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
                        if chars_selected >= 1 then
                            check_trash_button:SetState("hover")
                            check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
                            check_trash_button:SetState("active")
                        else
                            check_trash_button:SetState("inactive")
                            check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
                        end
                    end
                    if dropdown_units:Find("trash_bin_button") then 
                        local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
                        if chars_selected >= 1 then
                            trash_bin_button:SetState("hover")
                            trash_bin_button:SetTooltipText(trash_bin_button_hover_1..chars_selected..trash_bin_button_hover_2, "", false) 
                            trash_bin_button:SetState("active")
                        else
                            trash_bin_button:SetState("inactive")
                            trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 
                        end
                    end
                end,
                true
            )
            
            -- Changes the checkbox tooltip depending on the character status
            local char = cm:get_character_by_cqi(cqi_string)
            checkbox_toggle:SetState("hover")
            if cm:char_is_general(char) then 
                checkbox_toggle:SetTooltipText(checkbox_toggle_lord_hover, "", false) 
                checkbox_toggle:SetState("selected_hover")
                checkbox_toggle:SetTooltipText(checkbox_toggle_lord_selected_hover, "", false) 
            else
                checkbox_toggle:SetTooltipText(checkbox_toggle_hero_hover, "", false) 
                checkbox_toggle:SetState("selected_hover")
                checkbox_toggle:SetTooltipText(checkbox_toggle_hero_selected_hover, "", false) 
            end
            checkbox_toggle:SetState("active")   
        end
        
        -- Disables checkboxes if characters are blacklisted (unique lords, factions leaders and unique heroes/lords defined in the blacklist)
        local checkbox_toggle_ = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
        local char = cm:get_character_by_cqi(cqi_string)
        if not blacklisted_value and (char:character_details():is_unique() or char:is_faction_leader()) then
            checkbox_toggle_:SetState("inactive")
            if cm:char_is_general(char) then 
                checkbox_toggle_:SetTooltipText(checkbox_toggle_lord_disabled, "", false) 
            else
                checkbox_toggle_:SetTooltipText(checkbox_toggle_hero_disabled, "", false) 
            end
        elseif not blacklisted_value then
            for _, subtype in ipairs(blacklisted_subtypes) do
                if char:character_subtype(subtype) then
                    checkbox_toggle_:SetState("inactive")
                    if cm:char_is_general(char) then 
                        checkbox_toggle_:SetTooltipText(checkbox_toggle_lord_disabled, "", false) 
                    else
                        checkbox_toggle_:SetTooltipText(checkbox_toggle_hero_disabled, "", false) 
                    end
                    break
                end
            end
        --else
        --    checkbox_toggle_:SetState("active")
        end
        
    end
    
    -- Updates the interface depending on lords/heroes checkboxes state
    local chars_selected = 0
    local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
    for i = 0, list_box:ChildCount() - 1 do
        local character_row = UIComponent(list_box:Find(i))
        local character_row_len = string.len("character_row_")
        local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
        local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
        if checkbox_toggle:CurrentState() == "selected" or checkbox_toggle:CurrentState() == "selected_hover" or checkbox_toggle:CurrentState() == "down" then	
            chars_selected = chars_selected + 1
        end
    end
    
    if trash_bin_button:Visible() then 
        if chars_selected >= 1 then
            trash_bin_button:SetState("hover")
            trash_bin_button:SetTooltipText(trash_bin_button_hover_1..chars_selected..trash_bin_button_hover_2, "", false) 
            trash_bin_button:SetState("active")
        else
            trash_bin_button:SetState("inactive")
            trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 
        end
    elseif dropdown_units:Find("check_trash_button") then
        local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
        local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
        if chars_selected >= 1 then
            check_trash_button:SetState("hover")
            check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
            check_trash_button:SetState("active")
        else
            check_trash_button:SetState("inactive")
            check_trash_button:SetTooltipText(check_trash_button_disabled, "", false)
            cross_trash_button:SetVisible(false)
            check_trash_button:SetVisible(false)
            trash_bin_button:SetState("inactive")
            trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false)
            trash_bin_button:SetVisible(true)
        end
    end


	core:remove_listener("sm0_execute_trash_bin_button_ComponentLClickUp")
	-- Listener updating the interface when clicking on the trash bin button
	core:add_listener(
		"sm0_execute_trash_bin_button_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			return context.string == "trash_bin_button"
		end,
		function(context)
            -- Create the cancel button and its listener
			local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
			local trash_bin_button_W, trash_bin_button_H = trash_bin_button:Bounds()
			trash_bin_button:SetVisible(false)
			if not dropdown_units:Find("cross_trash_button") then
				dropdown_units:CreateComponent("cross_trash_button", "ui/templates/square_medium_button")
				local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
				reference_title:Adopt(cross_trash_button:Address())
				cross_trash_button:PropagatePriority(dropdown_units:Priority())
				cross_trash_button:SetDockingPoint(4) -- centre left dock
				cross_trash_button:SetCanResizeHeight(true)
				cross_trash_button:SetCanResizeWidth(true)
				cross_trash_button:Resize(trash_bin_button_W, trash_bin_button_H)
				cross_trash_button:SetDockOffset(trash_bin_button_W * 0.5, 0)
				cross_trash_button:SetImagePath(icon_cross) 
				cross_trash_button:SetState("hover")
				cross_trash_button:SetTooltipText(cross_trash_button_hover, "", false) 
				cross_trash_button:SetState("active")
                
                -- Listener updating the interface when clicking on the cancel button
				core:add_listener(
					"sm0_execute_cross_trash_button_ComponentLClickUp",
					"ComponentLClickUp",
					function(context)
						return context.string == "cross_trash_button"
					end,
					function(context)
						local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
						local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
						local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
						if cross_trash_button then cross_trash_button:SetVisible(false) end
						if check_trash_button then check_trash_button:SetVisible(false) end
						if trash_bin_button then trash_bin_button:SetVisible(true) end
					end,
					true
				)
			end
			
			-- Create the confirm button and its listener
			if not dropdown_units:Find("check_trash_button") then
				dropdown_units:CreateComponent("check_trash_button", "ui/templates/square_medium_button")
				local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
				reference_title:Adopt(check_trash_button:Address())
				check_trash_button:PropagatePriority(dropdown_units:Priority())
				check_trash_button:SetDockingPoint(4) -- centre left dock
				check_trash_button:SetCanResizeHeight(true)
				check_trash_button:SetCanResizeWidth(true)
				check_trash_button:Resize(trash_bin_button_W, trash_bin_button_H)
				check_trash_button:SetDockOffset(trash_bin_button_W * 1.5, 0)
				check_trash_button:SetImagePath(icon_check) 
				local chars_selected = 0
				local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
				for i = 0, list_box:ChildCount() - 1 do
					local character_row = UIComponent(list_box:Find(i))
					local character_row_len = string.len("character_row_")
					local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
					local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
					if checkbox_toggle:CurrentState() == "selected" or checkbox_toggle:CurrentState() == "selected_hover" or checkbox_toggle:CurrentState() == "down" then	
						chars_selected = chars_selected + 1
					end
				end
				if chars_selected >= 1 then
					check_trash_button:SetState("hover")
					check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
					check_trash_button:SetState("active")
				else
					check_trash_button:SetState("inactive")
					check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
				end
                
                -- Listener updating the interface and killing heroes/lords when clicking on the confirm button
				core:add_listener(
					"sm0_execute_check_trash_button_ComponentLClickUp",
					"ComponentLClickUp",
					function(context)
						return context.string == "check_trash_button"
					end,
					function(context)
						local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
						for i = 0, list_box:ChildCount() - 1 do
							local character_row = UIComponent(list_box:Find(i))
							local character_row_len = string.len("character_row_")
							local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
							local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
							if checkbox_toggle:CurrentState() == "selected" then												
								local cqi = tonumber(cqi_string)
								local char = cm:get_character_by_cqi(cqi)
								local is_blacklisted = false
								
                                if not blacklisted_value and (char:character_details():is_unique() or char:is_faction_leader()) then
                                    is_blacklisted = true
                                elseif not blacklisted_value then
                                    for _, subtype in ipairs(blacklisted_subtypes) do
                                        if char:character_subtype(subtype) then
                                            is_blacklisted = true
                                            break
                                        end
                                    end
                                end

								if not is_blacklisted then 
									CampaignUI.TriggerCampaignScriptEvent(cqi, "sm0_execute|")
									if character_row:Find("checkbox_toggle_"..cqi_string) then 
										local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
										checkbox_toggle:Destroy()
										core:remove_listener("sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
									end
								end
							end
						end
						local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
						local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
						local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
						if cross_trash_button then cross_trash_button:SetVisible(false) end
						if check_trash_button then check_trash_button:SetVisible(false) end
						if trash_bin_button then 
                            trash_bin_button:SetVisible(true)
                            trash_bin_button:SetState("inactive")
                            trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 
						end
					end,
					true
				)
			end
			local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
			local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
			if cross_trash_button then cross_trash_button:SetVisible(true) end
			if check_trash_button then check_trash_button:SetVisible(true) end
		end,
		true
	)
end

-- Add listeners when clicking on the army list tab or when the player opens any fullscreen campaign menu and to kill characters
local function init_execute_listeners(enable)
	core:remove_listener("sm0_execute_UITrigger")
	core:remove_listener("sm0_execute_dropdown_units_PanelOpenedCampaign")
	core:remove_listener("sm0_execute_dropdown_units_PanelClosedCampaign")
	core:remove_listener("sm0_execute_dropdown_units_ComponentLClickUp")
	if enable then
		-- Listener killing characters compatible with multiplayer
		core:add_listener(
            "sm0_execute_UITrigger",
            "UITrigger",
            function(context)
                return context:trigger():starts_with("sm0_execute|")
            end,
            function(context)
                local cqi = context:faction_cqi()
                cm:disable_event_feed_events(true, "", "", "character_ready_for_duty")
                local chara = cm:get_character_by_cqi(cqi)
                local fm_cqi = chara:family_member():command_queue_index()
                cm:suppress_immortality(fm_cqi, true)
                cm:kill_character(cqi, false)
            end,
            true
        )
        
        -- Listener when any campaign main panel is opened
		core:add_listener(
			"sm0_execute_dropdown_units_PanelOpenedCampaign",
			"PanelOpenedCampaign",
			function(context)		
				return true -- appoint_new_general
			end,
			function(context)
                cm:callback(function()
                    local tab_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "bar_small_top", "TabGroup", "tab_units")
                    if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down" or tab_units:CurrentState() == "down") then 
                        create_trash_ui()
                    else
                        delete_trash_ui()
                    end	
                end, 0.1)
			end,
			true
		)
		
		-- Listener when any campaign main panel is closed
		core:add_listener(
			"sm0_execute_dropdown_units_PanelClosedCampaign",
			"PanelClosedCampaign",
			function(context)		
				return true -- appoint_new_general
			end,
			function(context)
                cm:callback(function()
                    local tab_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "bar_small_top", "TabGroup", "tab_units")
					if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down" or tab_units:CurrentState() == "down") then 
						create_trash_ui()
					else
						delete_trash_ui()
					end	  
                end, 0.1)
			end,
			true
		)
		
		-- Listener when clicking on the army list tab
		core:add_listener(
			"sm0_execute_dropdown_units_ComponentLClickUp",
			"ComponentLClickUp",
			function(context)
				return context.string == "tab_units"
			end,
			function(context)
                cm:callback(function()
                    local tab_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "bar_small_top", "TabGroup", "tab_units")
                    if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down") then 
                        create_trash_ui()
                    else
                        delete_trash_ui()
                    end	
                end, 0.1)
			end,
			true
		)
	end
end

-- Listener getting MCT settings and triggering init listeners
core:add_listener(
     "sm0_execute_MctInitialized",
     "MctInitialized",
     true,
     function(context)
         local mct = get_mct()
         local execute_mod = mct:get_mod_by_key("Freiya_sm0_execute")
         local a_enable = execute_mod:get_option_by_key("a_enable")
         enable_value = a_enable:get_finalized_setting()
         local b_blacklisted = execute_mod:get_option_by_key("b_blacklisted")
 		 blacklisted_value = b_blacklisted:get_finalized_setting()
 		
 		init_execute_listeners(enable_value)
     end,
     true
)
 
-- Listener "saving" MCT settings
core:add_listener(
    "sm0_execute_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        local mct = context:mct()
        local execute_mod = mct:get_mod_by_key("Freiya_sm0_execute")
        local settings_table = execute_mod:get_settings() 
        enable_value = settings_table.a_enable
		blacklisted_value = settings_table.b_blacklisted
		
		init_execute_listeners(enable_value)
        if not enable_value then delete_trash_ui() end
    end,
    true
)

-- Main function
function Freiya_sm0_execute()
	if not get_mct then
		blacklisted_value = false
		init_execute_listeners(true) 
	end
end

cm:add_first_tick_callback(function() Freiya_sm0_execute() end)