local loreButton_charPanel = nil --:BUTTON
local loreButton_preBattle = nil --:CA_UIC
local loreButton_unitsPanel = nil --:BUTTON
local spellBrowserButton = nil --:CA_UIC
local optionButton = nil --:CA_UIC
local loreFrame = nil --:FRAME
local spellButtonContainer = nil --:CONTAINER
local loreButtonContainer = nil --:CONTAINER
local spellSlotButtonContainer = nil --:CONTAINER
local spellSlotButtons = {} --:vector<TEXT_BUTTON>
local loreSpellText = nil --:TEXT
local loreAttributeText = nil --:TEXT
local pX --:number
local pY --:number
local dummyButton = TextButton.new("dummyButton", core:get_ui_root(), "TEXT", "dummy");
local dummyButtonX, dummyButtonY = dummyButton:Bounds();
dummyButton:Delete();
local spellSlotSelected = nil --:string
local bookIconPath = "ui/icon_lorebook2.png";
local browserIconPath = "ui/icon_spell_browser2.png";
local optionsIconPath = "ui/icon_options2.png";
local charSubMazdamundi = "wh2_main_lzd_lord_mazdamundi";
local loreTable = 	{	["Lore of High Magic"] = {"Apotheosis", "Arcane Unforging", "Fiery Convocation", "Hand of Glory", "Soul Quench", "Tempest"},
						["Lore of Light"] = {"Pha's Protection", "Shem's Burning Gaze", "Light of Battle", "Net of Amyntok", "Birona's Timewarp", "Banishment"},
 						["Lore of Life"] = {"Earth Blood", "Awakening of the Wood", "Flesh to Stone", "Shield of Thorns", "Regrowth", "The Dwellers Below"},
  						["Lore of Beasts"] = {"Wyssan's Wildform", "Flock of Doom", "The Amber Spear", "Pann's Impenetrable Pelt", "The Curse of Anraheir", "Transformation of Kadon"},
   						["Lore of Fire"] = {"Cascading Fire Cloak", "Fireball", "Flaming Sword of Rhuin", "The Burning Head", "Piercing Bolts of Burning", "Flame Storm"},
						["Lore of Heavens"] = {"Harmonic Convergence", "Wind Blast", "Urannon's Thunderbolt", "Curse of the Midnight Wind", "Comet of Casandora", "Chain Lightning"},
	 					["Lore of Metal"] = {"Plague of Rust", "Searing Doom", "Glittering Robe", "Gehenna's Golden Hounds", "Transmutation of Lead", "Final Transmutation"},
	  					["Lore of Death"] = {"Aspect of the Dreadknight", "Spirit Leech", "Doom and Darkness", "Soulblight", "The Purple Sun of Xereus", "The Fate of Bjuna"},
						["Lore of Shadows"] = {"Melkoth's Mystifying Miasma", "The Enfeebling Foe", "The Withering", "The Penumbral Pendulum", "Okkam's Mindrazor",	"Pit of Shades"}	
					} --: map<string, vector<string>>
local skillTable = {}
local enableTable = {}
local createSpellSlotButtonContainer --:function(char: CA_CHAR, spellSlots: vector<string>)

local tableString = cm:get_saved_value("sm0_mazdamundi");
if not tableString then
	local spellSlots = {"Spell Slot - 1 -", "Spell Slot - 2 -", "Spell Slot - 3 -", "Spell Slot - 4 -", "Spell Slot - 5 -", "Spell Slot - 6 -"} --:vector<string>
	local saveString = "return {"..cm:process_table_save(spellSlots).."}";
	cm:set_saved_value("sm0_mazdamundi", saveString);
end

--v function() --> CA_CHAR					
function getSelectedCharacter()
	local selectedCharacterCqi = cm:get_campaign_ui_manager():get_char_selected_cqi();
	return cm:get_character_by_cqi(selectedCharacterCqi);
end

--v function(charSubtype: string, faction: CA_FACTION) --> CA_CHAR					
function getCAChar(charSubtype, faction)
	local characterList = faction:character_list();
	local char = nil --:CA_CHAR
	for i = 0, characterList:num_items() - 1 do
		local currentChar = characterList:item_at(i)	
		if currentChar:character_subtype(charSubtype) then
			char = currentChar;
		end
	end
	return char;
end

--v function(buttonName: string, char: CA_CHAR)					
function replaceSpellEffect(buttonName, char) -- test
	local charCqi = char:cqi();
	local loreEffectBundles = {"wh2_sm0_effect_bundle_test"} --:vector<string>
	for _, loreEffectBundle in ipairs(loreEffectBundles) do 
		if char:military_force():has_effect_bundle(loreEffectBundle) then
			cm:remove_effect_bundle_from_characters_force(loreEffectBundle, charCqi);
			out("sm0/replaceLoreEffect/remove: "..loreEffectBundle);
		end
	end
	buttonName = "loreButtonTest"; --test
	buttonName = string.lower(buttonName);
	local effectBundle = string.gsub(buttonName, "lorebutton", "wh2_sm0_effect_bundle_");
	out("sm0/replaceLoreEffect/effectBundle: "..effectBundle);
	--test
	effectBundle = "wh2_sm0_effect_bundle_test";
	cm:apply_effect_bundle_to_characters_force(effectBundle, charCqi, -1, false);
	out("sm0/replaceLoreEffect/apply: end");
end

--v [NO_CHECK] function(spellName: any) --> vector<string>
function updateSaveTable(spellName)
	local spellSlots = loadstring(cm:get_saved_value("sm0_mazdamundi"))();
	if spellName then
		for i, spellSlot in ipairs(spellSlots) do
			if "Spell Slot - "..i.." -" == spellSlotSelected then
				spellSlots[i] = spellName;
				local saveString = "return {"..cm:process_table_save(spellSlots).."}";
				cm:set_saved_value("sm0_mazdamundi", saveString);
			end
		end
	end
	return spellSlots;
end

--v [NO_CHECK] function(lore: vector<string>, char: CA_CHAR)
function createSpellButtonContainer(lore, char)
	local spellButtonList = ListView.new("SpellButtonList", loreFrame, "VERTICAL");
	spellButtonList:Resize(pX/2 - 18, pY - dummyButtonY/2);
	spellButtonContainer = Container.new(FlowLayout.VERTICAL);	
	local spellButtons = {} --:vector<TEXT_BUTTON>
	local spellSlots = updateSaveTable(nil);
	for _, spell in ipairs(lore) do
		local spellButton = TextButton.new(spell, loreFrame, "TEXT", spell);
		spellButton:SetState("hover");
		spellButton.uic:SetTooltipText("Select "..spell.." to replace "..spellSlots[tonumber(string.match(spellSlotSelected, "%d"))]);	
		spellButton:SetState("active");
		for _, spellSlot in ipairs(spellSlots) do
			if spellSlot == spell then
				spellButton:SetDisabled(true);
				spellButton.uic:SetTooltipText("This spell is already selected");	
			end
		end
		table.insert(spellButtons, spellButton);
		spellButton:RegisterForClick(
			function(context)
				local spellSlots = updateSaveTable(spellButton.name);
				createSpellSlotButtonContainer(nil, spellSlots);
			end
		)
		spellButtonList:AddComponent(spellButton);
	end
	spellButtonContainer:AddComponent(spellButtonList);
	spellButtonContainer:PositionRelativeTo(loreFrame, pX/2 + 35, dummyButtonY/4);
end

--v function(buttons: vector<TEXT_BUTTON>, char: CA_CHAR)
function setupSingleSelectedButtonGroup(buttons, char)
	for _, button in ipairs(buttons) do
		button:SetState("active");
		button:RegisterForClick(
			function(context)
				for _, otherButton in ipairs(buttons) do
					if button.name == otherButton.name then
						otherButton:SetState("selected_hover");
						otherButton.uic:SetTooltipText("Select your prefered spell of the "..button.name);
					else
						otherButton:SetState("hover");
						otherButton.uic:SetTooltipText("Select the Lore of Magic you want to pick a spell from");
						otherButton:SetState("active");
					end
				end
				if spellButtonContainer then
					spellButtonContainer:Clear();
				end
				createSpellButtonContainer(loreTable[button.name], char);
			end
		);
	end
end

--v function(char: CA_CHAR)
function createLoreButtonContainer(char)
	spellSlotButtonContainer:Clear();
	local loreButtonList = ListView.new("LoreButtonList", loreFrame, "VERTICAL");
	loreButtonList:Resize(pX/2 - 9, pY - dummyButtonY/2); -- width vslider 18
	loreButtonContainer = Container.new(FlowLayout.VERTICAL);
	local loreButtons = {} --:vector<TEXT_BUTTON>
	local loreEnable = {};
	for lore, _ in pairs(loreTable) do
		local loreButton = TextButton.new(lore, loreFrame, "TEXT_TOGGLE", lore);
		table.insert(loreButtons, loreButton);
		loreButtonList:AddComponent(loreButton);
	end	
	setupSingleSelectedButtonGroup(loreButtons, char);
	loreButtonContainer:AddComponent(loreButtonList);
	loreButtonContainer:PositionRelativeTo(loreFrame, 22, dummyButtonY/4);
end

createSpellSlotButtonContainer = function(char, spellSlots)
	if loreButtonContainer then loreButtonContainer:Clear(); end
	if spellButtonContainer then spellButtonContainer:Clear(); end
	local spellSlotButtonList = ListView.new("SpellSlotButtonList", loreFrame, "VERTICAL");
	spellSlotButtonList:Resize(dummyButtonX, pY - dummyButtonY/2); --(pX/2 - 13, pY - 40);
	spellSlotButtonContainer = Container.new(FlowLayout.VERTICAL);
	for i, spellSlot in ipairs(spellSlots) do
		local spellSlotButton = TextButton.new("Spell Slot - "..i.." -", loreFrame, "TEXT", spellSlot);
		table.insert(spellSlotButtons, spellSlotButton);
		spellSlotButton:RegisterForClick(
			function(context)
				spellSlotSelected = spellSlotButton.name;
				createLoreButtonContainer(char);
			end
		)
		spellSlotButtonList:AddComponent(spellSlotButton);
	end
	spellSlotButtonContainer:AddComponent(spellSlotButtonList);
	Util.centreComponentOnComponent(spellSlotButtonContainer, loreFrame);
end

--v function() --> CA_CHAR
function getMazdaCharacter()
	local char = nil --:CA_CHAR
	if not cm:model():pending_battle():is_active() then
		char = getSelectedCharacter();
		if not char then
			local focusButton = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"); 
			local focusButtonText = focusButton:GetStateText();
			if string.find(focusButtonText,"Mazdamundi") then
				 char = getCAChar(charSubMazdamundi, cm:get_faction(cm:get_local_faction(true)));
			end
		end
	elseif cm:model():pending_battle():attacker():faction():is_human() then
		char = cm:model():pending_battle():attacker();
		if not char:character_subtype(charSubMazdamundi) and cm:model():pending_battle():secondary_attackers():num_items() >= 1 then
			local attackers = cm:model():pending_battle():secondary_attackers();
			for i = 0, attackers:num_items() - 1 do
				if attackers:item_at(i):character_subtype(charSubMazdamundi) then
					char = attackers:item_at(i);
				end
			end
		end
	elseif cm:model():pending_battle():defender():faction():is_human() then
		char = cm:model():pending_battle():defender();
		if not char:character_subtype(charSubMazdamundi) and cm:model():pending_battle():secondary_defenders():num_items() >= 1 then
			local defenders = cm:model():pending_battle():secondary_defenders();
			for i = 0, defenders:num_items() - 1 do
				if defenders:item_at(i):character_subtype(charSubMazdamundi) then
					char = defenders:item_at(i);
				end
			end
		end
	end
	return char;
end

--v function()
function closeUI()
	if loreButtonContainer then loreButtonContainer:Clear(); end
	if spellButtonContainer then spellButtonContainer:Clear(); end
	if spellSlotButtonContainer then spellSlotButtonContainer:Clear(); end
	loreButtonContainer = nil;
	spellButtonContainer = nil;
	spellSlotButtonContainer = nil;
	spellSlotSelected = nil;
	spellSlotButtons = {};
	loreFrame = nil;
end

--v function()
function createSpellBrowserButton()
	local parent = find_uicomponent(core:get_ui_root(), "Lore of Magic");
	spellBrowserButton = Util.createComponent("spellBrowserButton", parent, "ui/templates/round_small_button");
	Util.registerComponent("spellBrowserButton", spellBrowserButton);
	spellBrowserButton:Resize(28, 28);
	local posFrameX, posFrameY = loreFrame:Position();
	local offsetX, offsetY = 10, 10;
	spellBrowserButton:MoveTo(posFrameX + offsetX, posFrameY + offsetY);
	spellBrowserButton:SetImage(browserIconPath);
	spellBrowserButton:SetState("hover");
	spellBrowserButton:SetTooltipText("Spell Browser");
	spellBrowserButton:PropagatePriority(100);
	spellBrowserButton:SetState("active");
	Util.registerForClick(spellBrowserButton, "spellBrowserButtonListener",
		function(context)
			--
		end
	)
end

--v function()
function createOptionButton()
	local parent = find_uicomponent(core:get_ui_root(), "Lore of Magic");
	optionButton = Util.createComponent("optionButton", parent, "ui/templates/round_small_button");
	Util.registerComponent("optionButton", optionButton);
	optionButton:Resize(28, 28);
	local posFrameX, posFrameY = loreFrame:Position();
	local sizeFrameX, sizeFrameY = loreFrame:Bounds(); 
	local offsetX, offsetY = 10, 10;
	optionButton:MoveTo(posFrameX + sizeFrameX - (offsetX + optionButton:Width()), posFrameY + offsetY);
	optionButton:SetImage(optionsIconPath);
	optionButton:SetState("hover");
	optionButton:SetTooltipText("Options");
	optionButton:PropagatePriority(100);
	optionButton:SetState("active");
	Util.registerForClick(optionButton, "optionButtonListener",
		function(context)
			--
		end
	)
end

--v function()
function createLoreUI()
	if loreFrame then
		return;
	end
	loreFrame = Frame.new("Lore of Magic");
	loreFrame.uic:PropagatePriority(100);
	loreFrame:AddCloseButton(
		function()
			closeUI()
		end
	);
	local parchment = find_uicomponent(core:get_ui_root(), "Lore of Magic", "parchment");
	pX, pY = parchment:Bounds();
	Util.centreComponentOnScreen(loreFrame);
	createSpellBrowserButton();
	createOptionButton();
	loreFrame:AddComponent(spellBrowserButton);
	loreFrame:AddComponent(optionButton);
	local char = getMazdaCharacter();
	--local char = getCAChar(charSubMazdamundi, cm:get_faction(cm:get_local_faction(true)));
	local spellSlots = updateSaveTable(false);
	createSpellSlotButtonContainer(char, spellSlots);
	--root > menu_bar > buttongroup > button_spell_browser
	--local spellSlotButtonContainerX, spellSlotButtonContainerY = spellSlotButtonContainer:Position();
	--spellSlotButtonContainer:MoveTo(spellSlotButtonContainerX, spellSlotButtonContainerY - 75);
	--loreFrame:AddComponent(spellSlotButtonContainer);
	--local loreButtonContainer = createLoreButtonListView(char);
	--Util.centreComponentOnComponent(loreButtonContainer, loreFrame);
	--local loreButtonContainerX, loreButtonContainerY = loreButtonContainer:Position();
	--loreButtonContainer:MoveTo(loreButtonContainerX, loreButtonContainerY - 75);
	--loreFrame:AddComponent(loreButtonContainer);
	
	--loreFrame.uic:SetMoveable(true);
	--lastSelectedButton(char);
	loreFrame.uic:RegisterTopMost();
end

--v function()
function createloreButton_charPanel() -- character_panel
	cm:callback(
		function(context)
			if loreButton_charPanel == nil then
				loreButton_charPanel = Button.new("loreButton_charPanel", find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons"), "SQUARE", bookIconPath);
				local characterdetailspanel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				local referenceButton = find_uicomponent(characterdetailspanel, "button_replace_general");
				loreButton_charPanel:Resize(referenceButton:Width(), referenceButton:Height());
				loreButton_charPanel:PositionRelativeTo(referenceButton, -loreButton_charPanel:Width() - 1, 0);
				loreButton_charPanel:SetState("hover");
				loreButton_charPanel.uic:SetTooltipText("Lore of Magic");			
				loreButton_charPanel:SetState("active");
				loreButton_charPanel:RegisterForClick(
					function(context)
						createLoreUI();
					end
				)
			end
			local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
			local namePanelText = namePanel:GetStateText();
			if string.find(namePanelText, "Mazdamundi") then
				loreButton_charPanel:SetVisible(true);
			else
				loreButton_charPanel:SetVisible(false);
			end				
		end, 0, "createloreButton_charPanel"
	);
end

--v function(battle_type: BATTLE_TYPE)
function createloreButton_preBattle(battle_type) -- pre_battle
	local buttonParent = find_uicomponent(core:get_ui_root(), "popup_pre_battle", "mid", "battle_deployment", "regular_deployment", "list");
	loreButton_preBattle = Util.createComponent("loreButton_preBattle", buttonParent, "ui/templates/round_small_button");
	Util.registerComponent("loreButton_preBattle", loreButton_preBattle);
	cm:callback(
		function(context)
			local posFrameX, posFrameY = buttonParent:Position();
			local sizeFrameX, sizeFrameY = buttonParent:Bounds(); 
			local referenceButton = find_uicomponent(buttonParent, "battle_information_panel", "button_holder", "button_info");
			if battle_type == "settlement_standard" or battle_type == "settlement_unfortified"then 
				referenceButton = find_uicomponent(buttonParent, "siege_information_panel", "button_holder", "button_info"); 
			end
			local posReferenceButtonX, posReferenceButtonY = referenceButton:Position();
			local offsetX = (posFrameX + sizeFrameX) - (posReferenceButtonX + referenceButton:Width())
			loreButton_preBattle:MoveTo(posFrameX + offsetX, posReferenceButtonY);
			loreButton_preBattle:SetImage(bookIconPath);
			loreButton_preBattle:SetState("hover");
			loreButton_preBattle:SetTooltipText("Lore of Magic");
			loreButton_preBattle:PropagatePriority(100);
			loreButton_preBattle:SetState("active");
			end, 0, "positionloreButton_preBattle"
	);
	Util.registerForClick(loreButton_preBattle, "loreButton_preBattle_Listener",
		function(context)
			createLoreUI();
		end
	)
end

--v function()
function createloreButton_unitsPanel() -- main_units_panel
	loreButton_unitsPanel = Button.new("loreButton_unitsPanel", find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_army"), "SQUARE", bookIconPath);
	cm:callback(
		function(context)
			local unitsPanel = find_uicomponent(core:get_ui_root(), "button_group_army");
			local renownButton = find_uicomponent(unitsPanel, "button_renown"); 
			local recruitButton = find_uicomponent(unitsPanel, "button_recruitment");
			loreButton_unitsPanel:Resize(renownButton:Width(), renownButton:Height());
			if renownButton:Visible() then
				loreButton_unitsPanel:PositionRelativeTo(renownButton, loreButton_unitsPanel:Width() + 4, 0);
			else
				loreButton_unitsPanel:PositionRelativeTo(recruitButton, loreButton_unitsPanel:Width() + 4, 0);
			end
			loreButton_unitsPanel:SetState("hover");
			loreButton_unitsPanel.uic:SetTooltipText("Lore of Magic");
			loreButton_unitsPanel:SetState("active");
		end, 0, "positionloreButton_unitsPanel"
	);
	loreButton_unitsPanel:RegisterForClick(
		function(context)
			createLoreUI();
		end
	)
end

--v function()
function deleteLoreFrame()
	if loreFrame then
		loreFrame:Delete();
		loreFrame = nil;
	end
end

--v function()
function updateButtonVisibility()
	local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
	local namePanelText = namePanel:GetStateText();
	if string.find(namePanelText, "Mazdamundi") then
		loreButton_charPanel:SetVisible(true);
	else
		loreButton_charPanel:SetVisible(false);
	end
end

--v function()
function playerLoreListener()
	local buttonLocation_charPanel = true;	-- "character_details_panel" root > character_details_panel > background > skills_subpanel > listview
	local buttonLocation_preBattle = true;	-- "popup_pre_battle"
	local buttonLocation_unitsPanel = true;	-- "main_units_panel"

	if buttonLocation_charPanel then
		core:add_listener(
			"loreCharacterPanelOpened1",
			"PanelOpenedCampaign",
			function(context)		
				return context.string == "character_details_panel" and not cm:model():pending_battle():is_active(); 
			end,
			function(context)
				createloreButton_charPanel(); 						
			end,
			true
		);

		core:add_listener(
			"loreCharacterPanelClosed1",
			"PanelClosedCampaign",
			function(context) 
				return context.string == "character_details_panel"  and not cm:model():pending_battle():is_active(); 
			end,
			function(context)
				if loreButton_charPanel then
					loreButton_charPanel:Delete();
					loreButton_charPanel = nil;
				end
				deleteLoreFrame();
			end,
			true
		);
	
		core:add_listener(
			"loreCharacterPanelNextLClickUp1",
			"ComponentLClickUp",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "button_cycle_right" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);		
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelPreviousLClickUp1",
			"ComponentLClickUp",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "button_cycle_left" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);	
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelNextShortcutTriggered1",
			"ShortcutPressed",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "select_next" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);	
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelPreviousShortcutTriggered1",
			"ShortcutPressed",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "select_prev" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);	
			end,
			true
		);
		--[[
		core:add_listener(
			"loreSkillPoints",
			"ComponentLClickUp",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "button_stats_reset" and panel;
			end,
			function(context)
				cm:callback(
					function(context)
						local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
						local namePanelText = namePanel:GetStateText();
						if string.find(namePanelText, "Mazdamundi") then
							loreFrame:Delete();
							loreFrame = nil;
							local char = getMazdaCharacter();
							for _, loreTrait in ipairs(loreTraits) do 
								if char:has_trait(loreTrait) then
									local loreSkill = string.gsub(loreTrait, "wh2_sm0_trait_lore", "wh2_sm0_mazda_skill_lore");
									if string.find(loreSkill, "_plus_attribute") then
										loreSkill = string.gsub(loreTrait, "_plus_attribute","");
										if not char:has_skill("wh2_sm0_mazda_skill_lore_attributes") then
											replaceLoreTrait("dummy", char);
											return;
										end
									end
									if not char:has_skill(loreSkill) then
										replaceLoreTrait("dummy", char);
										return;
									end					
								end
							end
						end
					end, 0.1, "checkRequiredSkills"
				);
			end,
			true
		);
		]]--
	end
	
	if buttonLocation_preBattle then		
		core:add_listener(
			"lorePopupPreBattlePanelOpened3",
			"PanelOpenedCampaign", 
			function(context) 
				return context.string == "popup_pre_battle" and loreButton_preBattle == nil; 
			end,
			function(context)
				local selectedCharacter = getMazdaCharacter();
				local pb = cm:model():pending_battle();
				if pb:battle_type() ~= "ambush" and selectedCharacter:character_subtype(charSubMazdamundi) then
					createloreButton_preBattle(pb:battle_type());
				end
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelOpened3",
			"PanelOpenedCampaign", 
			function(context) 
				return context.string == "character_details_panel" and cm:model():pending_battle():is_active();
			end,
			function(context)
				deleteLoreFrame();
			end,
			true
		);
			
		core:add_listener(
			"lorePopupPreBattlePanelClosed3",
			"PanelClosedCampaign",
			function(context) 
				return context.string == "popup_pre_battle"; 
			end,
			function(context)
				if loreButton_preBattle then
					Util.delete(loreButton_preBattle);
					Util.unregisterComponent("loreButton_preBattle");
					core:remove_listener("specialButtonListener");
					loreButton_preBattle = nil;
				end
				deleteLoreFrame();
			end,
			true
		);
	end
	
	if buttonLocation_unitsPanel then
		core:add_listener(
			"loreUnitPanelOpened4",
			"PanelOpenedCampaign",
			function(context)		
				return context.string == "units_panel" and loreButton_unitsPanel == nil; 
			end,
			function(context)
				local selectedCharacter = getMazdaCharacter();
				if selectedCharacter:character_subtype(charSubMazdamundi) then
					createloreButton_unitsPanel();	
				end
			end,
			true
		);

		core:add_listener(
			"loreUnitPanelClosed4",
			"PanelClosedCampaign",
			function(context) 
				return context.string == "units_panel"; 
			end,
			function(context)
				if loreButton_unitsPanel then
					loreButton_unitsPanel:Delete();
					loreButton_unitsPanel = nil;
				end
				deleteLoreFrame();
			end,
			true
		);
	
		core:add_listener(
			"loreOtherCharacterSelected4",
			"CharacterSelected", 
			function(context) 
				local panel = find_uicomponent(core:get_ui_root(), "units_panel");
				return is_uicomponent(panel);
			end,
			function(context)
				if context:character():character_subtype(charSubMazdamundi) and loreButton_unitsPanel == nil then
					createloreButton_unitsPanel();
				elseif context:character():character_subtype(charSubMazdamundi) ~= true and loreButton_unitsPanel ~=nil then
					if loreButton_unitsPanel then
						loreButton_unitsPanel:Delete();
						loreButton_unitsPanel = nil;
					end
					deleteLoreFrame();
				end
			end,
			true
		);
	end
end
--v function(table: table) --> number
function tableLength(table)
	local count = 0;
	for _ in pairs(table) do
		count = count + 1;
	end
	return count;
end

--v function(table: map<WHATEVER, WHATEVER>, key: WHATEVER) --> string
function tableRemove(table, key)
    local item = table[key];
    table[key] = nil;
    return item;
end

--v function(table: table, value: WHATEVER) --> WHATEVER
function tableFind(table, value)
    for i, v in pairs(table) do
		if value == v then
			index = i;
        end
	end
	return index;
end

function aiLoreListener()
	core:add_listener(
		"aiLorePendingBattle",
		"PendingBattle",
		function(context)
			local pb = context:pending_battle();
			return pb:attacker():character_subtype(charSubMazdamundi) and not pb:attacker():faction():is_human() or pb:defender():character_subtype(charSubMazdamundi) and not pb:attacker():faction():is_human();
		end,
		function(context)
			local charMazda = nil --:CA_CHAR
			local enemyFaction = nil --:CA_FACTION
			if context:pending_battle():attacker():character_subtype(charSubMazdamundi) then
				charMazda = context:pending_battle():attacker();
				enemyFaction = context:pending_battle():defender():faction();
			else
				charMazda = context:pending_battle():defender();
				enemyFaction = context:pending_battle():attacker():faction();
			end
			
			local charList = charMazda:military_force():character_list();
			local availableLores = {};
			local revLores = {};
			availableLores = characterHasSkill(charMazda);			
			if availableLores["loreAttributeEnabled"] then
				tableRemove(availableLores, "loreAttributeEnabled");
			end		
			local tableSize = tableLength(availableLores);
			local j = 1;
			for i,v in pairs(availableLores) do
				revLores[j] = i;
				j = j+1;
			end		
			for i = 0, charList:num_items() - 1 do
				if charList:item_at(i):character_subtype("wh2_main_lzd_skink_priest_beasts") then
					if table.getn(revLores) >= 2 then
						local index = tableFind(revLores, "loreBeastsEnabled");
						table.remove(revLores, index);
					end
				elseif charList:item_at(i):character_subtype("wh2_main_lzd_skink_priest_heavens") then
					if table.getn(revLores) >= 2 then
						local index = tableFind(revLores, "loreHeavensEnabled");
						table.remove(revLores, index);
					end
				end
			end		
			local tableSize = nil;
			local roll = 0;
			local enableLoadedDice = false;
			if cm:random_number(1) == 1 and enableLoadedDice then
				if enemyFaction:culture() == "wh_dlc03_bst_beastmen" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_dlc05_wef_wood_elves" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_dlc08_nor_norsca" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_brt_bretonnia" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_chs_chaos" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_dwf_dwarfs" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_emp_empire" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_grn_greenskins" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_vmp_vampire_counts" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_dlc09_tmb_tomb_kings" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_def_dark_elves" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_hef_high_elves" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_lzd_lizardmen" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_skv_skaven" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				end
			else
				tableSize = table.getn(revLores);
				roll = cm:random_number(tableSize);
			end

			local loreString = string.gsub(revLores[roll], "lore", "");
			loreString = string.gsub(loreString, "Enabled", "");
			replaceLoreTrait(loreString, charMazda);		
		end,
		true
	);
end

if cm:is_new_game() then
	--[[
	local hexoatl = cm:model():world():faction_by_key("wh2_main_lzd_hexoatl");			
	local hexoatl_faction_leader = hexoatl:faction_leader():command_queue_index();	
	local char = cm:get_character_by_cqi(hexoatl_faction_leader);
	if not char:has_trait("wh2_sm0_trait_dummy") then
		cm:force_add_trait(cm:char_lookup_str(hexoatl_faction_leader), "wh2_sm0_trait_dummy", false);
	end
	]]--
else
	out("sm0 <<<init>>> savegame");
end

local playerFaction = cm:get_faction(cm:get_local_faction(true));
if playerFaction:culture() == "wh2_main_lzd_lizardmen" then
	playerLoreListener();
elseif playerFaction:name() ~= "wh2_main_lzd_hexoatl" then
	--aiLoreListener();
end