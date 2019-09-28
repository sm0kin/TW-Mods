--Drunk Flamingo's log script
--All credits to Drunk Flamingo
--v function()
local function mlLOG_reset()
	if not __write_output_to_logfile then
		return
	end
	
	local logTimeStamp = os.date("%d, %m %Y %X")
	--# assume logTimeStamp: string
	
	local popLog = io.open("ml_log.txt","w+")
	popLog :write("NEW LOG ["..logTimeStamp.."] \n")
	popLog :flush()
	popLog :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function mlLOG(text)
	if not __write_output_to_logfile then
		return
	end

	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("ml_log.txt","a")
	--# assume logTimeStamp: string
	popLog :write("ML:  [".. logTimeStamp .. "]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

--v function()
local function mlDEBUG()
	--Vanish's PCaller
	--All credits to vanish
	--v function(func: function) --> any
	local function safeCall(func)
		--out("safeCall start")
		local status, result = pcall(func)
		if not status then
			mlLOG("ERROR")
			mlLOG(tostring(result))
			mlLOG(debug.traceback())
		end
		--out("safeCall end")
		return result
	end

	--local oldTriggerEvent = core.trigger_event

	--v [NO_CHECK] function(...: any)
	local function pack2(...) return {n=select('#', ...), ...} end
	--v [NO_CHECK] function(t: vector<WHATEVER>) --> vector<WHATEVER>
	local function unpack2(t) return unpack(t, 1, t.n) end

	--v [NO_CHECK] function(f: function(), argProcessor: function()) --> function()
	local function wrapFunction(f, argProcessor)
		return function(...)
			--out("start wrap ")
			local someArguments = pack2(...)
			if argProcessor then
				safeCall(function() argProcessor(someArguments) end)
			end
			local result = pack2(safeCall(function() return f(unpack2( someArguments )) end))
			--for k, v in pairs(result) do
			--    out("Result: " .. tostring(k) .. " value: " .. tostring(v))
			--end
			--out("end wrap ")
			return unpack2(result)
			end
	end

	-- function myTriggerEvent(event, ...)
	--     local someArguments = { ... }
	--     safeCall(function() oldTriggerEvent(event, unpack( someArguments )) end)
	-- end

	--v [NO_CHECK] function(fileName: string)
	local function tryRequire(fileName)
		local loaded_file = loadfile(fileName)
		if not loaded_file then
			out("Failed to find mod file with name " .. fileName)
		else
			out("Found mod file with name " .. fileName)
			out("Load start")
			local local_env = getfenv(1)
			setfenv(loaded_file, local_env)
			loaded_file()
			out("Load end")
		end
	end

	--v [NO_CHECK] function(f: function(), name: string)
	local function logFunctionCall(f, name)
		return function(...)
			out("function called: " .. name)
			return f(...)
		end
	end

	--v [NO_CHECK] function(object: any)
	local function logAllObjectCalls(object)
		local metatable = getmetatable(object)
		for name,f in pairs(getmetatable(object)) do
			if is_function(f) then
				out("Found " .. name)
				if name == "Id" or name == "Parent" or name == "Find" or name == "Position" or name == "CurrentState"  or name == "Visible"  or name == "Priority" or "Bounds" then
					--Skip
				else
					metatable[name] = logFunctionCall(f, name)
				end
			end
			if name == "__index" and not is_function(f) then
				for indexname,indexf in pairs(f) do
					out("Found in index " .. indexname)
					if is_function(indexf) then
						f[indexname] = logFunctionCall(indexf, indexname)
					end
				end
				out("Index end")
			end
		end
	end

	-- logAllObjectCalls(core)
	-- logAllObjectCalls(cm)
	-- logAllObjectCalls(game_interface)

	core.trigger_event = wrapFunction(
		core.trigger_event,
		function(ab)
			--out("trigger_event")
			--for i, v in pairs(ab) do
			--    out("i: " .. tostring(i) .. " v: " .. tostring(v))
			--end
			--out("Trigger event: " .. ab[1])
		end
	)

	cm.check_callbacks = wrapFunction(
		cm.check_callbacks,
		function(ab)
			--out("check_callbacks")
			--for i, v in pairs(ab) do
			--    out("i: " .. tostring(i) .. " v: " .. tostring(v))
			--end
		end
	)

	local currentAddListener = core.add_listener
	--v [NO_CHECK] function(core: any, listenerName: any, eventName: any, conditionFunc: (function(context: WHATEVER?) --> boolean) | boolean, listenerFunc: function(context: WHATEVER?), persistent: any)
	local function myAddListener(core, listenerName, eventName, conditionFunc, listenerFunc, persistent)
		local wrappedCondition = nil
		if is_function(conditionFunc) then
			--wrappedCondition =  wrapFunction(conditionFunc, function(arg) out("Callback condition called: " .. listenerName .. ", for event: " .. eventName) end)
			wrappedCondition =  wrapFunction(conditionFunc)
		else
			wrappedCondition = conditionFunc
		end
		currentAddListener(
			core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc), persistent
			--core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc, function(arg) out("Callback called: " .. listenerName .. ", for event: " .. eventName) end), persistent
		)
	end
	core.add_listener = myAddListener
end

mlDEBUG()
local ColouredTextButton = require("ml_coloured_text_button")
--#assume ColouredTextButton: COLOURED_TEXT_BUTTON
local loreButton_charPanel = nil --:BUTTON
local loreButton_preBattle = nil --:CA_UIC
local loreButton_unitsPanel = nil --:BUTTON
local spellBrowserButton = nil --:CA_UIC
local optionButton = nil --:CA_UIC
local resetButton = nil --:CA_UIC
local frameButtonContainer = nil --:CONTAINER
local returnButton = nil --:BUTTON
local loreFrame = nil --:FRAME
local spellButtonContainer = nil --:CONTAINER
local loreButtonContainer = nil --:CONTAINER
local spellSlotButtonContainer = nil --:CONTAINER
local homeIconPath = "ui/icon_home_small2.png"
local bookIconPath = "ui/icon_lorebook2.png"
local browserIconPath = "ui/icon_spell_browser2.png"
local optionsIconPath = "ui/icon_options2.png"
local resetIconPath = "ui/icon_stats_reset_small2.png"
local shuffleIconPath = "ui/icon_swap_small2.png"
local playerFaction = cm:get_faction(cm:get_local_faction(true))
if string.find(playerFaction:name(), "wh_") then
	homeIconPath = "ui/icon_home_small.png"
	bookIconPath = "ui/icon_lorebook.png"
	browserIconPath = "ui/icon_spell_browser.png"
	optionsIconPath = "ui/icon_options.png"
	resetIconPath = "ui/icon_stats_reset_small.png"
	shuffleIconPath = "ui/icon_swap_small.png"
end
local ml_tables --:ml_tables
local spellSlotButtons = {} --:vector<TEXT_BUTTON>
local pX --:number
local pY --:number
local dummyButton = ColouredTextButton.new("dummyButton", core:get_ui_root(), "ui/templates/square_large_text_button_grey", "dummy")
local dummyButtonX, dummyButtonY = dummyButton:Bounds()
dummyButton:Delete()
local file_str = cm:get_game_interface():filesystem_lookup("/script/ml_tables", "ml*")
local createSpellSlotButtonContainer --:function(char: CA_CHAR, spellSlots: vector<string>)

--v function(char: CA_CHAR) --> bool
local function is_mlChar(char)
	if is_character(char) and string.find(file_str, char:character_subtype_key()) then
		--mlLOG("is_mlChar = "..char:character_subtype_key())
		return true
	else
		return false
	end
end

--v function(char: CA_CHAR) --> WHATEVER
local function ml_force_require(char)
	if is_mlChar(char) then
		local file = "ml_tables/ml_"..char:character_subtype_key()
		package.loaded[file] = nil
		return require(file)
	else
		return nil
	end
end

--v function(char: CA_CHAR)
local function resetSaveTable(char)
	local spellSlots = {"Spell Slot - 1 -", "Spell Slot - 2 -", "Spell Slot - 3 -", "Spell Slot - 4 -", "Spell Slot - 5 -", "Spell Slot - 6 -"} --:vector<string>
	local saveString = "return {"..cm:process_table_save(spellSlots).."}"
	cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_spellSlots", saveString)
end

--v function() --> CA_CHAR					
local function getSelectedCharacter()
	local selectedCharacterCqi = cm:get_campaign_ui_manager():get_char_selected_cqi()
	return cm:get_character_by_cqi(selectedCharacterCqi)
end

--v function(textObj: CA_UIC) --> CA_CHAR
local function getCharByStateText(textObj)
	local char = nil --:CA_CHAR
	if textObj then
		local text = textObj:GetStateText()
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)
			charStr = effect.get_localised_string(currentChar:get_forename()).." "..effect.get_localised_string(currentChar:get_surname())
			if text == charStr then	
				char = currentChar
			end
		end
	end
	return char
end

--v function(char: CA_CHAR) --> bool
local function is_agentSelected(char)
	local units = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units")
	--local character_list = char:military_force():character_list()
	local is_selected = false
	for i = 0, units:ChildCount() - 1 do
		local unit = UIComponent(units:Find(i))
		if string.find(unit:Id(), "Agent") and unit:CurrentState() == "Selected" then
			is_selected = true
			--for i = 0, character_list:num_items() - 1 do
				--
			--end
		end
	end
	return is_selected
end

--v function() --> CA_CHAR
local function getmlChar()
	local char --:CA_CHAR
	local pb = cm:model():pending_battle()
	if not pb:is_null_interface() and not pb:is_active() then
		selectedChar = getSelectedCharacter()
		if is_character(selectedChar) and is_mlChar(selectedChar) then
			char = selectedChar
		end
		if not is_character(char) then
			local focusButton = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt") 
			local charByUnitPanel = getCharByStateText(focusButton)
			local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name")
			local charByCharPanel = getCharByStateText(namePanel)
			if charByUnitPanel and is_mlChar(charByUnitPanel) then
				char = charByUnitPanel
			elseif not char and charByCharPanel and is_mlChar(charByCharPanel) then
				char = charByCharPanel
			end
		end
	elseif not is_character(char) and not pb:is_null_interface() and is_mlChar(pb:attacker()) and pb:attacker():faction():is_human() then
		char = pb:attacker()
		if not is_mlChar(char) and pb:secondary_attackers():num_items() >= 1 then 
			local attackers = pb:secondary_attackers()
			for i = 0, attackers:num_items() - 1 do
				if attackers:item_at(i):faction():is_human() and is_mlChar(attackers:item_at(i)) then
					char = attackers:item_at(i)
				end
			end
		end
	elseif not is_character(char) and not not pb:is_null_interface() and is_mlChar(pb:defender()) and pb:defender():faction():is_human() then
		char = pb:defender()
		if not is_mlChar(char) and pb:secondary_defenders():num_items() >= 1 then
			local defenders = pb:secondary_defenders()
			for i = 0, defenders:num_items() - 1 do
				if defenders:item_at(i):faction():is_human() and is_mlChar(defenders:item_at(i)) then
					char = defenders:item_at(i)
				end
			end
		end
	end
	if is_character(char) then
		mlLOG("getmlChar: "..char:character_subtype_key())
	else
		mlLOG("getmlChar: "..tostring(char))
	end
	return char
end

--v function()
local function re_init()
	--loreButtonContainer = nil
	--spellButtonContainer = nil
	--spellSlotButtonContainer = nil
	--optionButton = nil
	--spellBrowserButton = nil
	--resetButton = nil
	returnButton = nil
	loreFrame = nil
end

--v function(char: CA_CHAR)
local function updateSkillTable(char)
	if ml_tables then
		for skill, _ in pairs(ml_tables.has_skills) do
			if char:has_skill(skill) then
				ml_tables.has_skills[skill] = true
			else
				ml_tables.has_skills[skill] = false
			end
		end
	end
end

--v function(table: table, element: any) --> bool
local function tableContains(table, element)
	for _, value in pairs(table) do
		if value == element then
		return true
		end
	end
	return false
end

--v function(char: CA_CHAR, spellSlots: vector<string>)					
local function applySpellDisableEffect(char, spellSlots)
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
	local charCqi = char:command_queue_index()
	CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "MixedLores|"..tostring(charCqi))
end

--v [NO_CHECK] function(spellName: any, selectedSpellSlot: any, char: CA_CHAR) --> vector<string>
local function updateSaveTable(spellName, selectedSpellSlot, char)
	local savedValue = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_spellSlots")
	if not savedValue then
		resetSaveTable(char)
	end
	local spellSlots = loadstring(cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_spellSlots"))()
	if spellName and selectedSpellSlot then
		for i, spellSlot in ipairs(spellSlots) do
			if  "Spell Slot - "..i.." -" == selectedSpellSlot then
				spellSlots[i] = spellName
				local saveString = "return {"..cm:process_table_save(spellSlots).."}"
				cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_spellSlots", saveString)
			end
		end
	end
	return spellSlots
end

--Multiplayer listener
core:add_listener(
    "MixedLoresMultiplayer",
    "UITriggerScriptEvent",
    function(context)
        return context:trigger():starts_with("MixedLores|")
    end,
    function(context)
		local str = context:trigger() --:string
		if context:trigger():starts_with("MixedLores|apply") or context:trigger():starts_with("MixedLores|remove") then
			local info = string.gsub(str, "MixedLores|", "")
			local commandEnd = string.find(info, "<")
			local command = string.sub(info, 1, commandEnd - 1)
			local cqiEnd = string.find(info, ">")
			local cqiStr = string.sub(info, commandEnd + 1, cqiEnd - 1)
			local cqi = tonumber(cqiStr)
			local effectBundle = string.sub(info, cqiEnd + 1)
			-- "MixedLores|".."remove".."<"..tostring(charCqi)..">"..effectBundle
			--# assume cqi: CA_CQI
			if command == "remove" then cm:remove_effect_bundle_from_characters_force(effectBundle, cqi) end
			if command == "apply" then cm:apply_effect_bundle_to_characters_force(effectBundle, cqi, -1, false) end
		else
			local info = string.gsub(str, "MixedLores|", "")
			local charCqi = tonumber(info)
			--# assume charCqi: CA_CQI
			local char = cm:get_character_by_cqi(charCqi)
			local spellSlots = updateSaveTable(false, false, char)

			local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
			ml_tables = ml_force_require(char)
			if ml_tables then
				--mlLOG("CHAR: "..char:character_subtype_key())
				if savedOption == "Spells for free" and char:has_military_force() and not char:military_force():has_effect_bundle(ml_tables.enableAllBundle) then
					CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "MixedLores|".."apply".."<"..tostring(charCqi)..">"..ml_tables.enableAllBundle)
					cm:apply_effect_bundle_to_characters_force(ml_tables.enableAllBundle, charCqi, -1, false)
				elseif savedOption ~= "Spells for free" and char:has_military_force() and char:military_force():has_effect_bundle(ml_tables.enableAllBundle) then
					CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "MixedLores|".."remove".."<"..tostring(charCqi)..">"..ml_tables.enableAllBundle)
					cm:remove_effect_bundle_from_characters_force(ml_tables.enableAllBundle, charCqi)
				end
				for _, effectBundle in pairs(ml_tables.effectBundles) do
					if char:has_military_force() and not char:military_force():has_effect_bundle(effectBundle) then
						cm:apply_effect_bundle_to_characters_force(effectBundle, charCqi, -1, false)
					end
				end
				for _, spell in ipairs(spellSlots) do 
					if ml_tables.effectBundles[spell] and char:has_military_force() and char:military_force():has_effect_bundle(ml_tables.effectBundles[spell]) then
						cm:remove_effect_bundle_from_characters_force(ml_tables.effectBundles[spell], charCqi)
						--mlLOG("applySpellDisableEffect / effectBundle = "..ml_tables.effectBundles[spell].." / cqi = "..tostring(charCqi).." / command = ".."remove")
					end
				end
			end
		end
    end,
    true
)

--v function(tbl: map<number | integer, WHATEVER>) --> map<number | integer, WHATEVER>
local function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = cm:random_number(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end

--v function(char: CA_CHAR)
local function randomSpells(char)
	resetSaveTable(char)
	local spellSlots = updateSaveTable(false, false, char)
	local skillPool = {}
	ml_tables = ml_force_require(char)
	updateSkillTable(char)
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
	if savedOption == "Spells for free" then
		for skill, _ in pairs(ml_tables.has_skills) do
			table.insert(skillPool, skill)
		end
	else
		for skill, has_skill in pairs(ml_tables.has_skills) do
			if has_skill then
				table.insert(skillPool, skill)
			end
		end
	end
	if ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" then
		skillPool = {}
		local lores = {}
		for lore, _ in pairs(ml_tables.lores) do
			table.insert(lores, lore)
		end
		--# assume lores: map<number, string>
		lores = shuffle(lores)
		for skill, _ in pairs(ml_tables.lores[lores[1]]) do
			table.insert(skillPool, skill)
		end
		--# assume skillPool: map<number, string>
		skillPool = shuffle(skillPool)
	end
	local lorePool = {} 
	--# assume skillPool: map<number, string>
	if #skillPool > #spellSlots then
		skillPool = shuffle(skillPool)
	end
	if ml_tables.default_rule == "Modified TT 8th edition - Teclis" then
		local skillAllowed = {["Lore of High Magic"]= true, ["Lore of Beasts"] = true, ["Lore of Light"] = true, ["Lore of Life"] = true, ["Lore of Heavens"] = true, ["Lore of Fire"] = true,
							["Lore of Metal"] = true, ["Lore of Shadows"] = true, ["Lore of Death"] = true} --:map<string, bool>
		for i, skill in pairs(skillPool) do
			if skillAllowed[ml_tables.skillToLore[skill]] then
				skillAllowed[ml_tables.skillToLore[skill]] = false
				table.insert(lorePool, skill)	
			end
		end
		if #lorePool < #spellSlots then
			for i, skill in pairs(skillPool) do
				if ml_tables.skillToLore[skill] == "Lore of High Magic" and #lorePool < #spellSlots and not tableContains(lorePool, skill) then
					table.insert(lorePool, skill)	
				end
			end
		end
		skillPool = lorePool
	end
	for i, spellSlot in ipairs(spellSlots) do
		if ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" then
			if ml_tables.has_skills["wh2_sm0_skill_magic_spell_slot_"..i] then
				spellSlots = updateSaveTable(ml_tables.skillnames[skillPool[i]], "Spell Slot - "..i.." -", char)
			end
		else
			spellSlots[i] = ml_tables.skillnames[skillPool[i]]
			spellSlots = updateSaveTable(spellSlots[i], "Spell Slot - "..i.." -", char)
		end
	end
	applySpellDisableEffect(char, spellSlots)
end	

--v function(button: CA_UIC)
local function hideButtonSmoke(button)
	local smoke = find_uicomponent(button, "smoke_overlay") --smoke_clip_parent > smoke_overlay
	if is_uicomponent(smoke) then smoke:SetOpacity(0) end
end

--v function(char: CA_CHAR)
local function createReturnButton(char)
	returnButton = Button.new("returnButton", loreFrame, "CIRCULAR", homeIconPath) 
	local closeButton = find_uicomponent(core:get_ui_root(), "Lore of MagicCloseButton")
	local closeButtonX, closeButtonY = closeButton:Position()
	closeButton:MoveTo(closeButtonX + closeButton:Width()/2, closeButtonY)
	returnButton:PositionRelativeTo(closeButton, - closeButton:Width(), 0)
	returnButton:SetState("hover")
	returnButton.uic:SetTooltipText("Return to Spell Slot List")			
	returnButton:SetState("active")
	returnButton:RegisterForClick(
		function(context)
			if spellButtonContainer then spellButtonContainer:Clear() end
			if loreButtonContainer then loreButtonContainer:Clear() end
			if spellSlotButtonContainer then spellSlotButtonContainer:Clear() end
			createSpellSlotButtonContainer(char, updateSaveTable(false, false, char))
		end
	)
	frameButtonContainer:AddComponent(returnButton)
end	

--v function(lore: string, selectedSpellSlot: string, char: CA_CHAR)
local function createSpellButtonContainer(lore, selectedSpellSlot, char)
	if spellButtonContainer then spellButtonContainer:Clear() end
	local loreTable = ml_tables.lores[lore] --:map<string, string>
	updateSkillTable(char)
	local spellButtonList = ListView.new("SpellButtonList", loreFrame, "VERTICAL")
	spellButtonList:Resize(pX/2 - 18, pY - dummyButtonY/2)
	spellButtonContainer = Container.new(FlowLayout.VERTICAL)	
	local spellSlots = updateSaveTable(false, false, char)
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option")
	local loreStr
	if savedOption == "Multi-Colour" then
		if lore then
			loreStr = string.gsub(lore, "Lore of ", "")
			loreStr = string.gsub(loreStr, " Magic", "")
			loreStr = string.lower(loreStr)
		end
	end
	for skill, spell in pairs(loreTable) do
		local spellButton
		if savedOption == "Multi-Colour" then
			--#assume spellButton: COLOURED_TEXT_BUTTON
			spellButton = ColouredTextButton.new(spell, loreFrame, "ui/templates/square_large_text_button_"..loreStr, spell)
		else	
			--#assume spellButton: TEXT_BUTTON
			spellButton = TextButton.new(spell, loreFrame, "TEXT", spell)
		end
		--#assume spellButton: TEXT_BUTTON		
		hideButtonSmoke(spellButton.uic)
		spellButton:SetState("hover")
		local index = string.match(selectedSpellSlot, "%d")
		--# assume spellSlots: map<number, string>
		spellButton.uic:SetTooltipText("Select "..spell.." to replace "..spellSlots[tonumber(index)]..".")	
		spellButton:SetState("active")
		--# assume spellSlots: vector<string>
		for _, spellSlot in ipairs(spellSlots) do
			if spellSlot == spell then
				spellButton:SetDisabled(true)
				spellButton.uic:SetTooltipText("This spell has already been selected.")	
			end
		end
		local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
		if savedOption ~= "Spells for free" and not ml_tables.has_skills[skill] then
			spellButton:SetDisabled(true)
			local reqTooltip = "Required Skill: "..effect.get_localised_string("character_skills_localised_name_"..skill)
			spellButton.uic:SetTooltipText(reqTooltip)	
		end
		--if ml_tables.default_rule == "Modified TT 8th edition - Teclis" and not tableContains(loreTable, spellSlots[tonumber(string.match(spellSlotSelected, "%d"))]) and lore ~= "Lore of High Magic" then
		--	for _, spell in ipairs(spellSlots) do
		--		if tableContains(loreTable, spell) then
		--			spellButton:SetDisabled(true)
		--			spellButton.uic:SetTooltipText("You can only choose one spell from the "..lore..".")	
		--		end
		--	end
		--end
		spellButton:RegisterForClick(
			function(context)
				local spellSlots = updateSaveTable(spellButton.name, selectedSpellSlot, char)
				createSpellSlotButtonContainer(char, spellSlots)
				applySpellDisableEffect(char, spellSlots)
			end
		)
		spellButtonList:AddComponent(spellButton)
	end
	spellButtonContainer:AddComponent(spellButtonList)
	spellButtonContainer:PositionRelativeTo(loreFrame, pX/2 + 35, dummyButtonY/4)
	loreFrame:AddComponent(spellButtonContainer)
end


--v function(buttons: vector<TEXT_BUTTON>, selectedSpellSlot: string, char: CA_CHAR)
local function setupSingleSelectedButtonGroup(buttons, selectedSpellSlot, char)
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option")
	for _, button in ipairs(buttons) do
		button:SetState("active")
		button:RegisterForClick(
			function(context)
				for _, otherButton in ipairs(buttons) do
					if button.name == otherButton.name then
						otherButton:SetState("selected_hover")
						otherButton.uic:SetTooltipText("Select your prefered spell of the "..button.name..".")
					else
						otherButton:SetState("hover")
						otherButton.uic:SetTooltipText("Select the Lore of Magic you want to pick a spell from.")
						otherButton:SetState("active")
					end
				end
				createSpellButtonContainer(button.name, selectedSpellSlot, char)
			end
		)
	end
end

--v function(char: CA_CHAR, selectedSpellSlot: string)
local function createLoreButtonContainer(char, selectedSpellSlot)
	if not returnButton then createReturnButton(char) end
	if spellSlotButtonContainer then spellSlotButtonContainer:Clear() end
	loreButtonList = ListView.new("LoreButtonList", loreFrame, "VERTICAL")
	loreButtonList:Resize(pX/2 - 9, pY - dummyButtonY/2) -- width vslider 18
	loreButtonContainer = Container.new(FlowLayout.VERTICAL)
	local loreButtons = {} --: vector<TEXT_BUTTON>
	local loreEnable = {}
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option")
		for lore, _ in pairs(ml_tables.lores) do
			local loreStr = string.gsub(lore, "Lore of ", "")
			loreStr = string.gsub(loreStr, " Magic", "")
			loreStr = string.lower(loreStr)
			local loreButton 
			if savedOption == "Multi-Colour" then
				--#assume loreButton: COLOURED_TEXT_BUTTON
				loreButton = ColouredTextButton.new(lore, loreFrame, "ui/templates/square_large_text_button_toggle_"..loreStr, lore)
			else
				--#assume loreButton: TEXT_BUTTON
				loreButton = TextButton.new(lore, loreFrame, "TEXT_TOGGLE", lore)
			end
			--#assume loreButton: TEXT_BUTTON
			hideButtonSmoke(loreButton.uic)
			table.insert(loreButtons, loreButton)
			loreButtonList:AddComponent(loreButton)
			setupSingleSelectedButtonGroup(loreButtons, selectedSpellSlot, char)			
		end
	local spellSlots = updateSaveTable(false, false, char)
	for _, loreButton in ipairs(loreButtons) do
		local indexStr = string.match(selectedSpellSlot, "%d")
		--# assume spellSlots: map<number, string>
		if ml_tables.default_rule == "Modified TT 8th edition - Teclis" and not tableContains(ml_tables.lores[loreButton.name], spellSlots[tonumber(indexStr)]) and loreButton.name ~= "Lore of High Magic" then
			--# assume spellSlots: vector<string>
			for _, spell in ipairs(spellSlots) do
				if tableContains(ml_tables.lores[loreButton.name], spell) then
					loreButton:SetDisabled(true)
					loreButton.uic:SetTooltipText("You can only choose one spell from the "..loreButton.name..".")	
				end
			end
		elseif ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" then
			local occupiedSlotCount = 0
			--# assume spellSlots: vector<string>
			for _, spell in ipairs(spellSlots) do
				if not string.find(spell, "Spell Slot") then
					occupiedSlotCount = occupiedSlotCount + 1
				end
			end
			--# assume spellSlots: vector<string>
			for _, spell in ipairs(spellSlots) do
				--# assume spellSlots: map<number, string>
				if not string.find(spell, "Spell Slot") and not tableContains(ml_tables.lores[loreButton.name], spell) and (occupiedSlotCount > 1 or (occupiedSlotCount == 1 and string.find(spellSlots[tonumber(indexStr)], "Spell Slot"))) then
					loreButton:SetDisabled(true)
					loreButton.uic:SetTooltipText("You can only choose spells from one lore of magic.")	
				end
			end
		end
	end
	loreButtonContainer:AddComponent(loreButtonList)
	loreButtonContainer:PositionRelativeTo(loreFrame, 22, dummyButtonY/4)
	loreFrame:AddComponent(loreButtonContainer)
end

createSpellSlotButtonContainer = function(char, spellSlots)
	if returnButton then
		if frameButtonContainer then frameButtonContainer:Clear() end
		returnButton = nil
		local closeButton = find_uicomponent(core:get_ui_root(), "Lore of MagicCloseButton")
		local closeButtonX, closeButtonY = closeButton:Position()
		closeButton:MoveTo(closeButtonX - closeButton:Width()/2, closeButtonY)
	end
	if loreButtonContainer then loreButtonContainer:Clear() end
	if spellButtonContainer then spellButtonContainer:Clear() end
	local spellSlotButtonList = ListView.new("SpellSlotButtonList", loreFrame, "VERTICAL")
	local xOffset = 50 --default(wh1) button is too large
	spellSlotButtonList:Resize(dummyButtonX + xOffset, pY - dummyButtonY/2) --(pX/2 - 13, pY - 40)
	spellSlotButtonContainer = Container.new(FlowLayout.VERTICAL)
	updateSkillTable(char)
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option")	
	for i, spellSlot in ipairs(spellSlots) do
		local spellSlotButton
		if savedOption == "Multi-Colour" then
			--#assume spellSlotButton: COLOURED_TEXT_BUTTON
			if string.find(spellSlot, "Spell Slot") then
				spellSlotButton = ColouredTextButton.new("Spell Slot - "..i.." -", loreFrame, "ui/templates/square_large_text_button_grey", spellSlot)
			else
				local loreStr = ml_tables.spellToLore[spellSlot]
				if ml_tables.spellToLore[spellSlot] then
					loreStr = string.gsub(loreStr, "Lore of ", "")
					loreStr = string.gsub(loreStr, " Magic", "")
					loreStr = string.lower(loreStr)
					spellSlotButton = ColouredTextButton.new("Spell Slot - "..i.." -", loreFrame, "ui/templates/square_large_text_button_"..loreStr, spellSlot)
				end
			end
		else
			--#assume spellSlotButton: TEXT_BUTTON
			spellSlotButton = TextButton.new("Spell Slot - "..i.." -", loreFrame, "TEXT", spellSlot) 
		end	
		--#assume spellSlotButton: TEXT_BUTTON
		hideButtonSmoke(spellSlotButton.uic)
		spellSlotButton:RegisterForClick(
			function(context)
				createLoreButtonContainer(char, spellSlotButton.name)
			end
		)
		spellSlotButtonList:AddComponent(spellSlotButton)
		if ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" then
			if not ml_tables.has_skills["wh2_sm0_skill_magic_spell_slot_"..tostring(i)] then
				spellSlotButton:SetDisabled(true)
				local reqTooltip = "Required Skill: "..effect.get_localised_string("character_skills_localised_name_".."wh2_sm0_skill_magic_spell_slot_"..tostring(i))
				spellSlotButton.uic:SetTooltipText(reqTooltip)	
			end
		end
	end
	spellSlotButtonContainer:AddComponent(spellSlotButtonList)
	Util.centreComponentOnComponent(spellSlotButtonContainer, loreFrame)
	spellSlotButtonContainer:PositionRelativeTo(spellSlotButtonList.uic, xOffset/2, 0)
	loreFrame:AddComponent(spellSlotButtonContainer)
end

--v function()
local function editSpellBrowserUI()
	local spell_browser = find_uicomponent(core:get_ui_root(), "spell_browser")
	if loreFrame then
		loreFrame:PositionRelativeTo(spell_browser, spell_browser:Width(), spell_browser:Height() - loreFrame:Height() + 53)
	end
	local char = getmlChar()
	ml_tables = ml_force_require(char)
	if char then
		local spellSlots = updateSaveTable(false, false, char)
		for spellName, button in pairs(ml_tables.spells) do
			local compositeSpell = find_uicomponent(core:get_ui_root(), "spell_browser", "composite_lore_parent", "composite_spell_list", button)
			if not tableContains(spellSlots, spellName) and is_uicomponent(compositeSpell) then
				Util.delete(compositeSpell)
			end
		end
	end
end

--v function()
local function createSpellBrowserButton()
	spellBrowserButton = Util.createComponent("spellBrowserButton", loreFrame.uic, "ui/templates/round_small_button")
	spellBrowserButton:Resize(28, 28)
	local posFrameX, posFrameY = loreFrame:Position()
	local offsetX, offsetY = 10, 10
	spellBrowserButton:MoveTo(posFrameX + offsetX, posFrameY + offsetY)
	spellBrowserButton:SetImagePath(browserIconPath)
	spellBrowserButton:SetState("hover")
	spellBrowserButton:SetTooltipText("Spell Browser")
	spellBrowserButton:PropagatePriority(100)
	spellBrowserButton:SetState("active")
	local button_spell_browser = find_uicomponent(core:get_ui_root(), "button_spell_browser")
	if not button_spell_browser then
		spellBrowserButton:SetDisabled(true)
	else
		spellBrowserButton:SetDisabled(false)
	end
	Util.registerForClick(spellBrowserButton, "ml_spellBrowserButtonListener",
		function(context)
			button_spell_browser:SimulateLClick()
		end
	)
	loreFrame:AddComponent(spellBrowserButton)
end

--v function(buttons: vector<TEXT_BUTTON>)
local function setupSingleSelectionOptionButtons(buttons)
	for _, button in ipairs(buttons) do
		button:SetState("active")
		button:RegisterForClick(
			function(context)
				for _, otherButton in ipairs(buttons) do
					if button.name == otherButton.name then
						otherButton:SetState("selected")
					else
						otherButton:SetState("active")
					end
				end
			end
		)
	end
end

--v function(char: CA_CHAR)
local function createOptionsFrame(char)
	local closeButton = find_uicomponent(core:get_ui_root(), "Lore of MagicCloseButton")
	if closeButton then closeButton:SetVisible(false) end
	if returnButton then returnButton:SetVisible(false) end
	local optionFrame = find_uicomponent(core:get_ui_root(), "Options")
	--# assume optionFrame: FRAME
	if optionFrame then
		return
	end
	optionFrame = Frame.new("Options")
	optionFrame.uic:PropagatePriority(100)
	loreFrame.uic:Adopt(optionFrame.uic:Address())
	optionFrame:AddCloseButton(
		function()
			resetSaveTable(char)
			local slotTable = updateSaveTable(false, false, char)
			applySpellDisableEffect(char, slotTable)
			if spellButtonContainer then spellButtonContainer:Clear() end
			if loreButtonContainer then loreButtonContainer:Clear() end
			if spellSlotButtonContainer then spellSlotButtonContainer:Clear() end
			if frameButtonContainer then frameButtonContainer:Clear() end
			if loreFrame then createSpellSlotButtonContainer(char, slotTable) end
			if closeButton then closeButton:SetVisible(true) end
			if returnButton then returnButton:SetVisible(true) end
		end
	)
	local optionCloseButton = find_uicomponent(core:get_ui_root(), "OptionsCloseButton")
	if string.find(playerFaction:name(), "wh_") then
		optionCloseButton:SetImagePath("ui/skins/default/icon_check.png")
	end
	local optionContainerV = Container.new(FlowLayout.VERTICAL)
	local optionListV = ListView.new("optionListV", optionFrame, "VERTICAL")
	local skillOptionContainerH = Container.new(FlowLayout.HORIZONTAL)
	local colourOptionContainerH = Container.new(FlowLayout.HORIZONTAL)
	optionFrame:AddComponent(optionContainerV)
	local skillOptionButtons = {} --:vector<TEXT_BUTTON>
	local colourOptionButtons = {} --:vector<TEXT_BUTTON>

	local defaultSkillOptionButton = TextButton.new("Skill - based", optionFrame, "TEXT_TOGGLE", "Skill - based")
	hideButtonSmoke(defaultSkillOptionButton.uic)
	defaultSkillOptionButton:SetState("hover")
	defaultSkillOptionButton.uic:SetTooltipText("Spells are been made available by their respective skill.")
	defaultSkillOptionButton:SetState("active")
	defaultSkillOptionButton:SetState("selected_hover")
	defaultSkillOptionButton.uic:SetTooltipText("Spells are been made available by their respective skill.")
	defaultSkillOptionButton:SetState("active")
	table.insert(skillOptionButtons, defaultSkillOptionButton)
	skillOptionContainerH:AddComponent(defaultSkillOptionButton)
	local freeOptionButton = TextButton.new("Spells for free", optionFrame, "TEXT_TOGGLE", "Spells for free")
	hideButtonSmoke(freeOptionButton.uic)
	freeOptionButton:SetState("hover")
	freeOptionButton.uic:SetTooltipText("All spells are available from the start.")
	freeOptionButton:SetState("active")
	freeOptionButton:SetState("selected_hover")
	freeOptionButton.uic:SetTooltipText("All spells are available from the start.")
	freeOptionButton:SetState("active")
	table.insert(skillOptionButtons, freeOptionButton)
	skillOptionContainerH:AddComponent(freeOptionButton)
	local savedSkillOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
	local savedSkillButton = find_uicomponent(core:get_ui_root(), savedSkillOption)
	for _, button in ipairs(skillOptionButtons) do
		button:RegisterForClick(
			function(context)
				cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option", button.name)
			end
		)
	end
	setupSingleSelectionOptionButtons(skillOptionButtons)
	if ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" then
		defaultSkillOptionButton:SetDisabled(true)
		defaultSkillOptionButton.uic:SetTooltipText("Not Supported.")	
	end
	savedSkillButton:SetState("selected")
	optionListV:AddComponent(skillOptionContainerH)

	local divider = Image.new("option_divider", optionFrame, "ui/skins/default/separator_line.png")
	divider:Resize(2*dummyButtonX, 2)
	optionListV:AddComponent(divider)

	local multiColourOptionButton = TextButton.new("Multi-Colour", optionFrame, "TEXT_TOGGLE", "Multi-Colour")
	hideButtonSmoke(multiColourOptionButton.uic)
	multiColourOptionButton:SetState("hover")
	multiColourOptionButton.uic:SetTooltipText("Buttons are coloured in a way to represent their spell group affiliation.")
	multiColourOptionButton:SetState("active")
	multiColourOptionButton:SetState("selected_hover")
	multiColourOptionButton.uic:SetTooltipText("Buttons are coloured in a way to represent their spell group affiliation.")
	multiColourOptionButton:SetState("active")
	table.insert(colourOptionButtons, multiColourOptionButton)
	colourOptionContainerH:AddComponent(multiColourOptionButton)
	local singleColourOptionButton = TextButton.new("Single-Colour", optionFrame, "TEXT_TOGGLE", "Single-Colour")
	hideButtonSmoke(singleColourOptionButton.uic)
	singleColourOptionButton:SetState("hover")
	singleColourOptionButton.uic:SetTooltipText("All buttons are created using the default Warhammer button colour.")
	singleColourOptionButton:SetState("active")
	singleColourOptionButton:SetState("selected_hover")
	singleColourOptionButton.uic:SetTooltipText("All buttons are created using the default Warhammer button colour.")
	singleColourOptionButton:SetState("active")
	table.insert(colourOptionButtons, singleColourOptionButton)
	colourOptionContainerH:AddComponent(singleColourOptionButton)
	local savedColourOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option")
	local savedColourButton = find_uicomponent(core:get_ui_root(), savedColourOption)
	for _, button in ipairs(colourOptionButtons) do
		button:RegisterForClick(
			function(context)
				cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option", button.name)
			end
		)
	end
	setupSingleSelectionOptionButtons(colourOptionButtons)
	savedColourButton:SetState("selected")
	optionListV:AddComponent(colourOptionContainerH)
	local xOffset = 50 --default(wh1) button is too large

	optionContainerV:AddComponent(optionListV)
	optionListV:Resize(2*dummyButtonX + xOffset, pY - dummyButtonY/2)
	optionFrame:AddComponent(optionContainerV)
	Util.centreComponentOnComponent(optionContainerV, optionFrame)
	optionContainerV:PositionRelativeTo(optionListV.uic, xOffset/2, 0)
	Util.centreComponentOnScreen(optionFrame)
	local spell_browser = find_uicomponent(core:get_ui_root(), "spell_browser")
	if spell_browser then
		loreFrame:PositionRelativeTo(spell_browser, spell_browser:Width(), spell_browser:Height() - loreFrame:Height() + 53)
	end
	loreFrame.uic:RemoveTopMost()
	optionFrame.uic:RegisterTopMost()
end

--v function(char: CA_CHAR)
local function createOptionButton(char)
	optionButton = Util.createComponent("optionButton", loreFrame.uic, "ui/templates/round_small_button")
	optionButton:Resize(28, 28)
	local posFrameX, posFrameY = loreFrame:Position()
	local sizeFrameX, sizeFrameY = loreFrame:Bounds() 
	local offsetX, offsetY = 10, 10
	optionButton:MoveTo(posFrameX + sizeFrameX - (offsetX + optionButton:Width()), posFrameY + offsetY)
	optionButton:SetImagePath(optionsIconPath)
	optionButton:SetState("hover")
	optionButton:SetTooltipText("Options")
	optionButton:PropagatePriority(100)
	optionButton:SetState("active")
	Util.registerForClick(optionButton, "ml_optionButtonListener",
		function(context)
			createOptionsFrame(char)
		end
	)
	loreFrame:AddComponent(optionButton)
end

--v function(char: CA_CHAR)
local function createResetButton(char)
	resetButton = Util.createComponent("resetButton", loreFrame.uic, "ui/templates/round_small_button")
	resetButton:Resize(28, 28)
	local posFrameX, posFrameY = loreFrame:Position()
	local sizeFrameX, sizeFrameY = loreFrame:Bounds() 
	local offsetX, offsetY = 10, 10
	resetButton:MoveTo(posFrameX + sizeFrameX - (offsetX + 2*resetButton:Width()), posFrameY + offsetY)
	resetButton:SetImagePath(resetIconPath)
	resetButton:SetState("hover")
	resetButton:SetTooltipText("Reset")
	resetButton:PropagatePriority(100)
	resetButton:SetState("active")
	Util.registerForClick(resetButton, "ml_resetButtonListener",
		function(context)
			resetSaveTable(char)
			local slotTable = updateSaveTable(false, false, char)
			applySpellDisableEffect(char, slotTable)
			if spellButtonContainer then spellButtonContainer:Clear() end
			if loreButtonContainer then loreButtonContainer:Clear() end
			if spellSlotButtonContainer then spellSlotButtonContainer:Clear() end
			if frameButtonContainer then frameButtonContainer:Clear() end
			createSpellSlotButtonContainer(char, slotTable)
		end
	)
	loreFrame:AddComponent(resetButton)
end

--v function(char: CA_CHAR)
local function createShuffleButton(char)
	shuffleButton = Util.createComponent("shuffleButton", loreFrame.uic, "ui/templates/round_small_button")
	shuffleButton:Resize(28, 28)
	local posFrameX, posFrameY = loreFrame:Position()
	local sizeFrameX, sizeFrameY = loreFrame:Bounds() 
	local offsetX, offsetY = 10, 10
	shuffleButton:MoveTo(posFrameX + sizeFrameX - (offsetX + 3*shuffleButton:Width()), posFrameY + offsetY)
	shuffleButton:SetImagePath(shuffleIconPath)
	shuffleButton:SetState("hover")
	shuffleButton:SetTooltipText("Shuffle")
	shuffleButton:PropagatePriority(100)
	shuffleButton:SetState("active")
	Util.registerForClick(shuffleButton, "ml_shuffleButtonListener",
		function(context)
			randomSpells(char)
			local slotTable = updateSaveTable(false, false, char)
			if spellButtonContainer then spellButtonContainer:Clear() end
			if loreButtonContainer then loreButtonContainer:Clear() end
			if spellSlotButtonContainer then spellSlotButtonContainer:Clear() end
			if frameButtonContainer then frameButtonContainer:Clear() end
			createSpellSlotButtonContainer(char, slotTable)
		end
	)
	loreFrame:AddComponent(shuffleButton)
end

--v function()
local function createLoreUI()
	if loreFrame then
		return
	end
	loreFrame = Frame.new("Lore of Magic")

	local spell_browser = find_uicomponent(core:get_ui_root(), "spell_browser")
	loreFrame.uic:PropagatePriority(100)
	loreFrame:AddCloseButton(
		function()
			core:remove_listener("ml_optionButtonListener")
			core:remove_listener("ml_spellBrowserButtonListener")
			core:remove_listener("ml_resetButtonListener")
			core:remove_listener("ml_shuffleButtonListener")
			re_init()
		end, true
	)
	local closeButton = find_uicomponent(core:get_ui_root(), "Lore of MagicCloseButton")
	if string.find(playerFaction:name(), "wh_") then
		closeButton:SetImagePath("ui/skins/default/icon_cross.png")
	end
	closeButton:SetState("hover")
	closeButton:SetTooltipText("Close Lore of Magic")			
	closeButton:SetState("active")
	frameButtonContainer = Container.new(FlowLayout.HORIZONTAL)
	loreFrame:AddComponent(frameButtonContainer)
	local parchment = find_uicomponent(core:get_ui_root(), "Lore of Magic", "parchment")
	pX, pY = parchment:Bounds()
	Util.centreComponentOnScreen(loreFrame)
	if spell_browser then
		loreFrame:PositionRelativeTo(spell_browser, spell_browser:Width(), spell_browser:Height() - loreFrame:Height() + 53)
	end
	local char = getmlChar()
	ml_tables = ml_force_require(char)
	updateSkillTable(char)
	local spellSlots = updateSaveTable(false, false, char)
	createSpellBrowserButton()
	createOptionButton(char)
	createResetButton(char)
	createShuffleButton(char)
	createSpellSlotButtonContainer(char, spellSlots)
	--loreFrame.uic:SetMoveable(true)
	loreFrame.uic:RegisterTopMost()
end

--v function()
local function updateButtonVisibility_charPanel()
	local char = getmlChar()
	if char and not is_agentSelected(char) then
		loreButton_charPanel:SetVisible(true)
	else
		loreButton_charPanel:SetVisible(false)
	end
end

--v function()
local function createloreButton_charPanel()
	--cm:callback(
	--	function(context)
			if loreButton_charPanel == nil then
				loreButton_charPanel = Button.new("loreButton_charPanel", find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons"), "SQUARE", bookIconPath)
				local characterdetailspanel = find_uicomponent(core:get_ui_root(), "character_details_panel")
				local referenceButton = find_uicomponent(characterdetailspanel, "button_replace_general")
				loreButton_charPanel:Resize(referenceButton:Width(), referenceButton:Height())
				loreButton_charPanel:PositionRelativeTo(referenceButton, -loreButton_charPanel:Width() - 1, 0)
				loreButton_charPanel:SetState("hover")
				loreButton_charPanel.uic:SetTooltipText("Lore of Magic")			
				loreButton_charPanel:SetState("active")
				loreButton_charPanel:RegisterForClick(
					function(context)
						createLoreUI()
						spellBrowserButton:SetDisabled(true)
						spellBrowserButton:SetOpacity(50)
						--spellBrowserButton:SetTooltipText("Locked by c++")	
					end
				)
			end
			updateButtonVisibility_charPanel()			
	--	end, 0, "createloreButton_charPanel"
	--)
end

--v function(battle_type: BATTLE_TYPE)
local function createloreButton_preBattle(battle_type)
	local buttonParent = find_uicomponent(core:get_ui_root(), "popup_pre_battle", "mid", "battle_deployment", "regular_deployment", "list")
	loreButton_preBattle = Util.createComponent("loreButton_preBattle", buttonParent, "ui/templates/round_small_button")
	--cm:callback(
	--	function(context)
			local posFrameX, posFrameY = buttonParent:Position()
			local sizeFrameX, sizeFrameY = buttonParent:Bounds() 
			local referenceButton = find_uicomponent(buttonParent, "battle_information_panel", "button_holder", "button_info")
			local posReferenceButtonX, posReferenceButtonY = referenceButton:Position()
			local offsetX = (posFrameX + sizeFrameX) - (posReferenceButtonX + referenceButton:Width())
			loreButton_preBattle:MoveTo(posFrameX + offsetX, posReferenceButtonY)
			loreButton_preBattle:SetImagePath(bookIconPath)
			loreButton_preBattle:SetState("hover")
			loreButton_preBattle:SetTooltipText("Lore of Magic")
			loreButton_preBattle:PropagatePriority(100)
			loreButton_preBattle:SetState("active")
			if battle_type == "settlement_standard" or battle_type == "settlement_unfortified" then 
				referenceButton = find_uicomponent(buttonParent, "siege_information_panel", "button_holder", "button_info")
			elseif battle_type == "ambush" or battle_type == "land_ambush" then
				loreButton_preBattle:SetDisabled(true)
				loreButton_preBattle:SetTooltipText("This is not the time...")
				loreButton_preBattle:SetOpacity(50)
			end
	--		end, 0, "positionloreButton_preBattle"
	--)
	Util.registerForClick(loreButton_preBattle, "loreButton_preBattle_Listener",
		function(context)
			createLoreUI()
			spellBrowserButton:SetDisabled(true)
			spellBrowserButton:SetOpacity(50)
			--spellBrowserButton:SetTooltipText("Locked by c++")	
		end
	)
end

--v function()
local function createloreButton_unitsPanel()
	loreButton_unitsPanel = Button.new("loreButton_unitsPanel", find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_army"), "SQUARE", bookIconPath)
	--cm:callback(
	--	function(context)
			local unitsPanel = find_uicomponent(core:get_ui_root(), "button_group_army")
			local renownButton = find_uicomponent(unitsPanel, "button_renown") 
			local recruitButton = find_uicomponent(unitsPanel, "button_recruitment")
			loreButton_unitsPanel:Resize(renownButton:Width(), renownButton:Height())
			local blessedButton = find_uicomponent(unitsPanel, "button_blessed_spawn_pool") 
			local recruitButton = find_uicomponent(unitsPanel, "button_recruitment")
			if blessedButton and blessedButton:Visible() then
				loreButton_unitsPanel:PositionRelativeTo(blessedButton, loreButton_unitsPanel:Width() + 4, 0)
			elseif blessedButton and not blessedButton:Visible() and renownButton and renownButton:Visible() then
				loreButton_unitsPanel:PositionRelativeTo(renownButton, loreButton_unitsPanel:Width() + 4, 0)
			else
				loreButton_unitsPanel:PositionRelativeTo(recruitButton, loreButton_unitsPanel:Width() + 4, 0)
			end
			loreButton_unitsPanel:SetState("hover")
			loreButton_unitsPanel.uic:SetTooltipText("Lore of Magic")
			loreButton_unitsPanel:SetState("active")
	--	end, 0, "positionloreButton_unitsPanel"
	--)
	loreButton_unitsPanel:RegisterForClick(
		function(context)
			createLoreUI()
		end
	)
end

--v function()
local function deleteLoreFrame()
	if loreFrame then
		loreFrame:Delete()
		core:remove_listener("ml_optionButtonListener")
		core:remove_listener("ml_spellBrowserButtonListener")
		core:remove_listener("ml_resetButtonListener")
		core:remove_listener("ml_shuffleButtonListener")
	end
	re_init()
end

--v function(char: CA_CHAR)
local function setupInnateSpells(char)
	ml_tables = ml_force_require(char)
	--[[
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
	if savedOption ~= "Spells for free" then
		randomSpells(char)
		ml_tables = ml_force_require(char)
		local spellSlots = updateSaveTable(false, char)
		local innateSpells = {}
		updateSkillTable(char)
		for skill, has_skill in pairs(ml_tables.has_skills) do
			if has_skill then
				table.insert(innateSpells, ml_tables.skillnames[skill])
			end
		end
		for _, innateSpell in ipairs(innateSpells) do
			if not tableContains(spellSlots, innateSpell) then
				for i, spellSlot in ipairs(spellSlots) do
					if string.find(spellSlot, "Spell Slot") then
						spellSlots = updateSaveTable(innateSpell, char)
						applySpellDisableEffect(char, spellSlots)
						break
					end
				end
			end
		end
	end
	--]]
	if ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" and char:rank() == 1  then
		spellSlots = updateSaveTable(ml_tables.innateSpell, "Spell Slot - ".."1".." -", char)
		applySpellDisableEffect(char, spellSlots)
	else
		randomSpells(char)
	end
end

--v function(char: CA_CHAR)
local function setupSavedOptions(char)
	local savedRule = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."rule")
	if not savedRule then
		cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."rule", ml_tables.default_rule)
	end
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
	if not savedOption then
		cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option", ml_tables.default_option)
	end
	local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option")
	if not savedOption then
		cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."colour_option", "Multi-Colour")
	end
	local ownerFaction = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."ownerFaction")
	if not ownerFaction then
		cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."ownerFaction", char:faction():name())
	end
end

local buttonLocation_charPanel = true	
local buttonLocation_preBattle = true	
local buttonLocation_unitsPanel = true	

core:add_listener(
	"ml_resetLClickUp",
	"ComponentLClickUp",
	function(context)
		local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
		return context.string == "button_stats_reset" and is_uicomponent(panel)
	end,
	function(context)
		cm:callback(
			function(context)
				local char = getmlChar()
				if char and not is_agentSelected(char) then
					deleteLoreFrame()
					pulse_uicomponent(loreButton_charPanel.uic, false, 10, false, "active")	
					ml_tables = ml_force_require(char)
					if ml_tables and char:faction():is_human() then
						local savedOption = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."skill_option")
						updateSkillTable(char)
						local spellSlots = updateSaveTable(false, false, char)
						local newSpellSlots = {}
						if savedOption ~= "Spells for free" then
							for _, spell in ipairs(spellSlots) do
								for skillname, spellname in pairs(ml_tables.skillnames) do
									if spellname == spell and ml_tables.has_skills[skillname] then
										table.insert(newSpellSlots, spell)
										break
									end
								end
							end
							resetSaveTable(char)
							spellSlots = updateSaveTable(false, false, char)
							applySpellDisableEffect(char, newSpellSlots)
							for _, newSpell in ipairs(newSpellSlots) do
								for i, spellSlot in ipairs(spellSlots) do
									if string.find(spellSlot, "Spell Slot") then
										spellSlots = updateSaveTable(newSpell, "Spell Slot - "..i.." -", char)
										break	
									end
								end
							end
						elseif ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" then	
							for i, spell in ipairs(spellSlots) do
								if ml_tables.has_skills["wh2_sm0_skill_magic_spell_slot_"..i] then
									table.insert(newSpellSlots, spell)
								end
							end
							resetSaveTable(char)
							spellSlots = updateSaveTable(false, false, char)
							for _, newSpell in ipairs(newSpellSlots) do
								for i, spellSlot in ipairs(spellSlots) do
									if string.find(spellSlot, "Spell Slot") and ml_tables.has_skills["wh2_sm0_skill_magic_spell_slot_"..i] then
										spellSlots = updateSaveTable(newSpell, "Spell Slot - "..i.." -", char)
										break	
									end
								end
							end
							applySpellDisableEffect(char, newSpellSlots)
						end
					end
				end
			end, 0.1, "resetSkills"
		)
	end,
	true
)

core:add_listener(
	"llrRespec",
	"UITriggerScriptEvent",
	function(context)
		return context:trigger() == "LegendaryLordRespec"
	end,
	function(context)
		local cqi = context:faction_cqi() --: CA_CQI
		local char = cm:get_character_by_cqi(cqi)
		if is_mlChar(char) and not is_agentSelected(char) then
			deleteLoreFrame()
			resetSaveTable(char)
			applySpellDisableEffect(getmlChar(), updateSaveTable(false, false, char))
			setupInnateSpells(char)
		end
	end,
	true
)

--v function()
local function lorebuttonPulse()
	if loreButton_charPanel then
		pulse_uicomponent(loreButton_charPanel.uic, true, 10, false, "active")
	end
	core:add_listener(
		"ml_disablePulse",
		"ComponentLClickUp",
		function(context)
			return context.string == "loreButton_charPanel"
		end,
		function(context)
			pulse_uicomponent(loreButton_charPanel.uic, false, 10, false, "active")		
		end,
		false
	)
end

core:add_listener(
	"ml_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		return is_mlChar(context:character())
	end,
	function(context)
		ml_tables = ml_force_require(context:character())
		if ml_tables and context:character():faction():is_human() then
			local savedOption = cm:get_saved_value("ml_forename_"..context:character():get_forename().."_surname_"..context:character():get_surname().."_cqi_"..tostring(context:character():command_queue_index()).."_".."option")
			updateSkillTable(context:character())
			if ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" then
				if ml_tables.has_skills[context:skill_point_spent_on()] then
					lorebuttonPulse()
				end
			end
			if savedOption ~= "Spells for free" and ml_tables.skillnames[context:skill_point_spent_on()] then	
				local spellSlots = updateSaveTable(false, false, context:character())
				local banLore = false
				if ml_tables.default_rule == "Modified TT 8th edition - Teclis" and ml_tables.skillToLore[context:skill_point_spent_on()] ~= "Lore of High Magic" then
					local lore = ml_tables.skillToLore[context:skill_point_spent_on()]
					local loreTable = ml_tables.lores[lore]
					for i, spellSlot in ipairs(spellSlots) do
						if tableContains(loreTable, spellSlot) then
							banLore = true
							break
						end
					end
				end				
				if ml_tables.default_rule ~= "Modified TT 8th edition - Teclis" or not banLore then
					if not tableContains(spellSlots, ml_tables.skillnames[context:skill_point_spent_on()]) then
						local selectedSpellSlot = nil --:string
						for i, spellSlot in ipairs(spellSlots) do
							if string.find(spellSlot, "Spell Slot") then
								selectedSpellSlot = "Spell Slot - "..i.." -"
								break
							end
						end
						spellSlots = updateSaveTable(ml_tables.skillnames[context:skill_point_spent_on()], selectedSpellSlot, context:character())
						applySpellDisableEffect(context:character(), spellSlots)
						lorebuttonPulse()
					end
				end
			end
		else
			randomSpells(context:character())
		end
	end,
	true
)

core:add_listener(
	"ml_spellBrowserPanelOpened",
	"PanelOpenedCampaign",
	function(context)		
		return context.string == "spell_browser" 
	end,
	function(context)
		editSpellBrowserUI()
	end,
	true
)

core:add_listener(
	"ml_spellBrowserPanelclosed",
	"PanelClosedCampaign",
	function(context)		
		return context.string == "spell_browser" 
	end,
	function(context)
		if loreFrame then
			Util.centreComponentOnScreen(loreFrame)
			spellBrowserButton:SetState("active")
		end
		--deleteLoreFrame()
	end,
	true
)

--v function(char: CA_CHAR)
local function setupAICompletedBattleListener(char)
	core:add_listener(
		"ml_BattleCompleted"..tostring(char:command_queue_index()),
		"ScriptEventPlayerBattleCompleted",
		true,
		function(context)
			ml_tables = ml_force_require(char)
			if ml_tables.default_rule ~= "TT 6th edition - The Fay Enchantress" then
				local charCqi = char:command_queue_index()
				for _, effectBundle in pairs(ml_tables.effectBundles) do
					if char:military_force():has_effect_bundle(effectBundle) then
						CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "MixedLores|".."remove".."<"..tostring(charCqi)..">"..effectBundle)
						--cm:remove_effect_bundle_from_characters_force(effectBundle, charCqi)
					end
				end
			end
		end,
		false
	)
end

core:add_listener(
	"ml_aiPendingBattle",
	"PanelOpenedCampaign", 
	function(context) 
		return context.string == "popup_pre_battle"
	end,
	function(context)
		local pb = cm:model():pending_battle()
		local attackers = pb:secondary_attackers()
		local defenders = pb:secondary_defenders()
		if not pb:attacker():faction():is_human() and is_mlChar(pb:attacker()) then
			randomSpells(pb:attacker())
			setupAICompletedBattleListener(pb:attacker())
		elseif not pb:defender():faction():is_human() and is_mlChar(pb:defender()) then
			randomSpells(pb:defender())
			setupAICompletedBattleListener(pb:defender())
		elseif attackers:num_items() > 0 then
			for i = 0, attackers:num_items() - 1 do
				if not attackers:item_at(i):faction():is_human() and is_mlChar(attackers:item_at(i)) then
					randomSpells(attackers:item_at(i))
					setupAICompletedBattleListener(attackers:item_at(i))
				end
			end
		elseif defenders:num_items() > 0 then
			for i = 0, defenders:num_items() - 1 do
				if not defenders:item_at(i):faction():is_human() and is_mlChar(defenders:item_at(i)) then
					randomSpells(defenders:item_at(i))
					setupAICompletedBattleListener(defenders:item_at(i))
				end
			end
		end
	end,
	true
)


core:add_listener(
	"ml_ConfederationListener",
	"FactionJoinsConfederation", 
	true,
	function(context)
		local characterList = context:confederation():character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)
			if is_mlChar(currentChar) then
				ml_tables = ml_force_require(currentChar)
				setupSavedOptions(currentChar)
				local ownerFaction = cm:get_saved_value("ml_forename_"..currentChar:get_forename().."_surname_"..currentChar:get_surname().."_cqi_"..tostring(currentChar:command_queue_index()).."_".."ownerFaction")
				if (ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" or context:confederation():is_human()) and context:confederation():name() ~= ownerFaction then 
					cm:set_saved_value("ml_forename_"..currentChar:get_forename().."_surname_"..currentChar:get_surname().."_cqi_"..tostring(currentChar:command_queue_index()).."_".."ownerFaction", currentChar:faction():name())
					setupInnateSpells(currentChar) 
				end
			end
		end
	end,
	true
)

core:add_listener(
	"ml_agentCreatedListener",
	"CharacterCreated", 
	function(context)		
		return is_mlChar(context:character()) and not context:character():character_subtype("chs_archaon") 
	end,
	function(context)
		mlLOG("ml_agentCreatedListener: "..context:character():character_subtype_key())
		local char = context:character()
		ml_tables = ml_force_require(char)
		local ownerFaction = cm:get_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."ownerFaction")
		if (ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" or char:faction():is_human()) and char:faction():name() ~= ownerFaction then
			cm:set_saved_value("ml_forename_"..char:get_forename().."_surname_"..char:get_surname().."_cqi_"..tostring(char:command_queue_index()).."_".."ownerFaction", char:faction():name())
			setupSavedOptions(char)
			setupInnateSpells(char)
		else
			setupSavedOptions(char)
		end
	end,
	true
)


if buttonLocation_charPanel then
	core:add_listener(
		"ml_loreCharacterPanelOpened",
		"PanelOpenedCampaign",
		function(context)		
			return context.string == "character_details_panel" and not cm:model():pending_battle():is_active() 
		end,
		function(context)
			createloreButton_charPanel() 
			if loreFrame then
				spellBrowserButton:SetDisabled(true)
				spellBrowserButton:SetOpacity(50)	
			end			
		end,
		true
	)

	core:add_listener(
		"ml_loreCharacterPanelClosed",
		"PanelClosedCampaign",
		function(context) 
			return context.string == "character_details_panel" and not cm:model():pending_battle():is_active() 
		end,
		function(context)
			if loreButton_charPanel then
				loreButton_charPanel:Delete()
				loreButton_charPanel = nil
			end
			deleteLoreFrame()
		end,
		true
	)

	core:add_listener(
		"ml_cycleRightLClickUp",
		"ComponentLClickUp",
		function(context)
			local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
			return context.string == "button_cycle_right" and is_uicomponent(panel)
		end,
		function(context)
			cm:callback(
				function(context)
					updateButtonVisibility_charPanel()
					deleteLoreFrame()
				end, 0, "checkNamePanelText"
			)		
		end,
		true
	)
	
	core:add_listener(
		"ml_cycleLeftLClickUp",
		"ComponentLClickUp",
		function(context)
			local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
			return context.string == "button_cycle_left" and is_uicomponent(panel)
		end,
		function(context)
			cm:callback(
				function(context)
					updateButtonVisibility_charPanel()
					deleteLoreFrame()
				end, 0, "checkNamePanelText"
			)	
		end,
		true
	)
	
	core:add_listener(
		"ml_nextShortcutPressed",
		"ShortcutPressed",
		function(context)
			local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
			return context.string == "select_next" and is_uicomponent(panel)
		end,
		function(context)
			cm:callback(
				function(context)
					updateButtonVisibility_charPanel()
					deleteLoreFrame()
				end, 0, "checkNamePanelText"
			)	
		end,
		true
	)
	
	core:add_listener(
		"ml_prevShortcutPressed",
		"ShortcutPressed",
		function(context)
			local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
			return context.string == "select_prev" and is_uicomponent(panel)
		end,
		function(context)
			cm:callback(
				function(context)
					updateButtonVisibility_charPanel()
					deleteLoreFrame()
				end, 0, "checkNamePanelText"
			)	
		end,
		true
	)
end

if buttonLocation_preBattle then		
	core:add_listener(
		"ml_preBattlePanelOpened",
		"PanelOpenedCampaign", 
		function(context) 
			return context.string == "popup_pre_battle" and not loreButton_preBattle 
		end,
		function(context)
			local pb = cm:model():pending_battle()
			if not pb:is_null_interface() and getmlChar() then
				createloreButton_preBattle(pb:battle_type())
			end
		end,
		true
	)
	
	core:add_listener(
		"ml_preBattleCharacterPanelOpened",
		"PanelOpenedCampaign", 
		function(context) 
			local pb = cm:model():pending_battle()
			return context.string == "character_details_panel" and not pb:is_null_interface() and pb:is_active()
		end,
		function(context)
			deleteLoreFrame()
		end,
		true
	)
		
	core:add_listener(
		"ml_preBattlePanelClosed",
		"PanelClosedCampaign",
		function(context) 
			return context.string == "popup_pre_battle" 
		end,
		function(context)
			if loreButton_preBattle then
				Util.delete(loreButton_preBattle)
				core:remove_listener("loreButton_preBattle_Listener")
				loreButton_preBattle = nil
			end
			deleteLoreFrame()
		end,
		true
	)
end

if buttonLocation_unitsPanel then
	core:add_listener(
		"ml_unitPanelOpened",
		"PanelOpenedCampaign",
		function(context)		
			return context.string == "units_panel" and not loreButton_unitsPanel 
		end,
		function(context)
			if getmlChar() then
				createloreButton_unitsPanel()	
			end
		end,
		true
	)

	core:add_listener(
		"ml_unitPanelClosed",
		"PanelClosedCampaign",
		function(context) 
			return context.string == "units_panel" 
		end,
		function(context)
			if loreButton_unitsPanel then
				loreButton_unitsPanel:Delete()
				loreButton_unitsPanel = nil
			end
			deleteLoreFrame()
		end,
		true
	)

	core:add_listener(
		"ml_unitPanelCharacterSelected",
		"CharacterSelected", 
		function(context) 
			local panel = find_uicomponent(core:get_ui_root(), "units_panel")
			return is_uicomponent(panel)
		end,
		function(context)
			local char = context:character()
			--cm:callback(
			--	function(context)
					if not loreButton_unitsPanel and is_mlChar(char) then 
						createloreButton_unitsPanel()
					elseif not is_mlChar(char)  then 
						if loreButton_unitsPanel then
							loreButton_unitsPanel:Delete()
							loreButton_unitsPanel = nil
						end
						deleteLoreFrame()
					end
			--	end, 0, "waitforsmth"
			--)	
		end,
		true
	)
end

--v function()
local function ml_setup()
	local factionList = cm:model():world():faction_list()
	for i = 0, factionList:num_items() - 1 do 
		local currentFaction = factionList:item_at(i)	
		local characterList = currentFaction:character_list()
		for j = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(j)
			if is_mlChar(currentChar) then
				mlLOG("ml_setup: "..currentChar:character_subtype_key())
				ml_tables = ml_force_require(currentChar)
				setupSavedOptions(currentChar)
				if ml_tables.default_rule == "TT 6th edition - The Fay Enchantress" or currentFaction:is_human() then setupInnateSpells(currentChar) end
			end
		end
	end
end

if cm:is_new_game() then 
	mlLOG_reset()
	ml_setup() 
else
	local pb = cm:model():pending_battle()
	if find_uicomponent(core:get_ui_root(), "popup_pre_battle") and not pb:is_null_interface() and buttonLocation_preBattle and getmlChar() then
		createloreButton_preBattle(pb:battle_type())
	end
end