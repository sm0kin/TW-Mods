--v function()
function sm0_delete()

	
	local player_Faction = cm:get_faction(cm:get_local_faction(true))
	--local faction_leader = player_Faction:faction_leader()
	--out("sm0/faction_leader_cqi: "..tostring(faction_leader:command_queue_index()))
	--ui\skins\default\icon_delete.png

	--uic = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "units_dropdown", "panel")

	core:add_listener(
		"units_dropdown_PanelOpenedCampaign",
		"PanelOpenedCampaign",
		function(context)		
			return true
		end,
		function(context)
			--root > layout > bar_small_top > TabGroup > tab_units
			--tab_events
			--tab_regions
			--tab_factions
			cm:callback(function() 
			local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
				if tab_units then 
					out("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
				else
					out("sm0/tab_units|state: disabled")
				end	
			end, 0.5) 						
		end,
		true
	)
	core:add_listener(
		"units_dropdown_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			--root > layout > bar_small_top > TabGroup > tab_units
			return context.string == "tab_events" or context.string == "tab_units" or context.string == "tab_regions" or context.string == "tab_factions"
		end,
		function(context)
			out("sm0/ComponentLClickUp: "..context.string)
			cm:callback(function() 
				local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
				if tab_units then 
					out("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
				else
					out("sm0/tab_units|state: disabled")
				end	
				--root > layout > radar_things > dropdown_parent > units_dropdown > panel > panel_clip > sortable_list_units > list_clip > list_box > character_row_9 > action_points > frame
				local list_box = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
				--local character_row_8 = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box", "character_row_8")
				--local parent = UIComponent(character_row_8:Parent())
				--if parent then 
				--	out("sm0/character_row_8: "..character_row_8:Id().." |Parent: "..tostring(parent:Id())) 	
				--end
				out("sm0/list_box: "..list_box:Id().." |childCount: "..tostring(list_box:ChildCount())) 	

				for i = 0, list_box:ChildCount() - 1 do
					local character_row = UIComponent(list_box:Find(i))
					--out("sm0/character_row: "..character_row:Id()) 	
					--local character_row_start = string.find(character_row:Id(), "character_row_")
					local character_row_len = string.len("character_row_")
					local cqi = string.sub(character_row:Id(), character_row_len + 1) 
					out("sm0/cqi: "..tostring(cqi))
					--#assume cqi: CA_CQI
					local char = cm:get_character_by_cqi(cqi)
					if cm:char_is_general(char) then
						local reference_uic = find_uicomponent(character_row, "action_points", "frame")
						local reference_uic_W, reference_uic_H = reference_uic:Bounds()
						local reference_uic_X, reference_uic_Y = reference_uic:Position()
						character_row:CreateComponent("trash_button", "ui/templates/square_medium_button")
						trash_button = UIComponent(character_row:Find("trash_button"))
						character_row:Adopt(trash_button:Address())
						trash_button:PropagatePriority(reference_uic:Priority())
						--if (core:svr_load_bool("primary_defender_is_player") and string.find(core:svr_load_string("primary_defender_subculture"), "wh_")) or 
						--        (core:svr_load_bool("primary_attacker_is_player") and string.find(core:svr_load_string("primary_attacker_subculture"), "wh_")) then
						--    applyButton:SetImagePath("ui/skins/default/icon_check.png") 
						--else
						--    applyButton:SetImagePath("ui/skins/warhammer2/icon_check.png") 
						--end
						--local reference_imagepath = referenceButton:GetImagePath()
						--out("sm0/reference_imagepath: "..tostring(reference_imagepath))
						if string.find(player_Faction:culture(), "wh2_") then 
							trash_button:SetImagePath("ui/skins/warhammer2/icon_check.png") 
						else
							trash_button:SetImagePath("ui/skins/default/icon_check.png")
						end
						trash_button:Resize(reference_uic_W, reference_uic_H)
						trash_button:MoveTo(reference_uic_X + reference_uic_W, reference_uic_Y)
						trash_button:SetState("hover")
						trash_button:SetTooltipText("Put in the trash can!")
						trash_button:SetState("active")
						core:add_listener(
							"sm0_applyButton",
							"ComponentLClickUp",
							function(context)
								return context.string == "trash_button"
							end,
							function(context)
								-- yes / no
							end,
							true
						)
					end				
				end
			end, 0.1) 	
		end,
		true
	)
end