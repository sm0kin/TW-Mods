--v function()
local function sm0_log_reset()
	if not __write_output_to_logfile then
		return
	end
	local logTimeStamp = os.date("%d, %m %Y %X")
	--# assume logTimeStamp: string
	local popLog = io.open("sm0_log.txt","w+")
	popLog :write("NEW LOG ["..logTimeStamp.."] \n")
	popLog :flush()
	popLog :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function sm0_log(text)
	if not __write_output_to_logfile then
		return
	end
	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","a")
	--# assume logTimeStamp: string
	popLog :write("FLAG:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

--v function(hide: bool)
local function toggle_flag(hide)
	local main_settlement_panel = find_uicomponent(core:get_ui_root(), "settlement_panel", "main_settlement_panel")
	if main_settlement_panel then
		if hide then
			for i = 0, main_settlement_panel:ChildCount() - 1 do
				local settlement = UIComponent(main_settlement_panel:Find(i))
				local dy_flag = find_uicomponent(settlement, "dy_flag")
				dy_flag:SetVisible(false)
				cm:set_saved_value("sm0_hide_flag_toggle", true)
			end
		else
			for i = 0, main_settlement_panel:ChildCount() - 1 do
				local settlement = UIComponent(main_settlement_panel:Find(i))
				local dy_flag = find_uicomponent(settlement, "dy_flag")
				dy_flag:SetVisible(true)
				cm:set_saved_value("sm0_hide_flag_toggle", false)
			end
		end
	end
end

local function create_checkbox_toggle()
	local info_holder = find_uicomponent(core:get_ui_root(), "settlement_panel", "main_settlement_panel_header", "info_holder")	
	local reference_uic = find_uicomponent(info_holder, "button_info")
	if cm:get_local_faction(true) == "wh2_main_skv_clan_eshin" then reference_uic = find_uicomponent(core:get_ui_root(), "settlement_panel", "target_shadowy_dealings_button") end
	local reference_uic_W, reference_uic_H = reference_uic:Bounds()
	local reference_uic_X, reference_uic_Y = reference_uic:Position()
	if info_holder:Find("sm0_flag_checkbox_toggle") then 
		local checkbox_toggle = UIComponent(info_holder:Find("sm0_flag_checkbox_toggle"))
		if cm:get_saved_value("sm0_hide_flag_toggle") then
			toggle_flag(true)
			checkbox_toggle:SetState("active")
		else
			toggle_flag(false)
			checkbox_toggle:SetState("selected")
		end
		return
	end
	info_holder:CreateComponent("sm0_flag_checkbox_toggle", "ui/templates/checkbox_toggle")
	local checkbox_toggle = UIComponent(info_holder:Find("sm0_flag_checkbox_toggle"))
	info_holder:Adopt(checkbox_toggle:Address())
	checkbox_toggle:PropagatePriority(reference_uic:Priority())
	checkbox_toggle:SetCanResizeHeight(true)
	checkbox_toggle:SetCanResizeWidth(true)
	checkbox_toggle:Resize(reference_uic_W, reference_uic_H)
	local checkbox_toggle_W, checkbox_toggle_H = checkbox_toggle:Bounds()
	checkbox_toggle:MoveTo(reference_uic_X - reference_uic_W - 2, reference_uic_Y)
	checkbox_toggle:SetState("active")
	checkbox_toggle:SetDisabled(false)
	checkbox_toggle:SetOpacity(255)
	checkbox_toggle:SetState("hover")
	checkbox_toggle:SetTooltipText("Select to show Faction Flags.", "", false) 
	checkbox_toggle:SetState("selected_hover")
	checkbox_toggle:SetTooltipText("Unselect to hide Faction Flags.", "", false)
	if cm:get_saved_value("sm0_hide_flag_toggle") then
		toggle_flag(true)
		checkbox_toggle:SetState("active")
	else
		toggle_flag(false)
		checkbox_toggle:SetState("selected")
	end
	core:add_listener(
		"sm0_flag_checkbox_toggle_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			return context.string == "sm0_flag_checkbox_toggle"
		end,
		function(context)
			--sm0_log("sm0_flag_checkbox_toggle_ComponentLClickUp: "..checkbox_toggle:CurrentState())
			if checkbox_toggle and checkbox_toggle:CurrentState() == "selected_down" then
				toggle_flag(true)
			elseif checkbox_toggle and checkbox_toggle:CurrentState() == "down" then
				toggle_flag(false)
			end
		end,
		true
	)	
end

function sm0_hide_flag()
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
	end
	core:add_listener(
		"sm0_flag_checkbox_toggle_PanelOpenedCampaign",
		"PanelOpenedCampaign",
		function(context)		
			return context.string == "settlement_panel" 
		end,
		function(context)
			cm:callback(function() 
				--sm0_log("sm0_flag_checkbox_toggle_PanelOpenedCampaign")
				create_checkbox_toggle()
			end, 0.1) 	
		end,
		true
	)
	core:add_listener(
		"sm0_flag_checkbox_toggle_SettlementSelected",
		"SettlementSelected",
		true,
		function()
			cm:callback(function() 
				--sm0_log("sm0_flag_checkbox_toggle_SettlementSelected")
				if cm:get_saved_value("sm0_hide_flag_toggle") then
					toggle_flag(true)
				else
					toggle_flag(false)
				end
			end, 0.1) 	
		end,
		true
	)
end