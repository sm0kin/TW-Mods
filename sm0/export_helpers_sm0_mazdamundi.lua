local loreBookButton1 = nil --:BUTTON
local loreBookButton2 = nil --:BUTTON
local loreBookButton3 = nil --:CA_UIC
local loreBookButton4 = nil --:BUTTON
local loreFrame = nil --:FRAME
local spellButtonContainer = nil --:CONTAINER
local loreButtonContainer = nil --:CONTAINER
local spellSlotButtonContainer = nil --:CONTAINER
local spellSlotSelected = nil --:string
local spellSlotButtons = {} --:vector<TEXT_BUTTON>
local loreSpellText = nil --:TEXT
local loreAttributeText = nil --:TEXT
local iconPath = "ui/icon_lorebook2.png";
local pX --:number
local pY --:number
local dummyButton = TextButton.new("dummyButton", core:get_ui_root(), "TEXT", "dummy");
local dummyButtonX, dummyButtonY = dummyButton:Bounds();
dummyButton:Delete();
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
local charSubMazdamundi = "wh2_main_lzd_lord_mazdamundi";

local tableString = cm:get_saved_value("sm0_mazdamundi");
if not tableString then
	local spellSlots = {"Spell Slot - 1 -", "Spell Slot - 2 -", "Spell Slot - 3 -", "Spell Slot - 4 -", "Spell Slot - 5 -", "Spell Slot - 6 -"} --:vector<string>
	local saveString = "return {"..cm:process_table_save(spellSlots).."}";
	cm:set_saved_value("sm0_mazdamundi", saveString);
end

local createSpellSlotButtonContainer --:function(char: CA_CHAR, spellSlots: vector<string>)

--v function() --> CA_CHAR					
function getSelectedCharacter()
	local selectedCharacterCqi = cm:get_campaign_ui_manager():get_char_selected_cqi();
	if selectedCharacterCqi == '' then
		return nil;
	else
		return cm:get_character_by_cqi(selectedCharacterCqi);
	end
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

--v function(buttons: vector<TEXT_BUTTON>, char: CA_CHAR)
function setupSingleSelectedButtonGroup(buttons, char)
    for _, button in ipairs(buttons) do
		button:SetState("active");
        button:RegisterForClick(
            function(context)
                for _, otherButton in ipairs(buttons) do
                    if button.name == otherButton.name then
                        otherButton:SetState("selected_hover");
						--local buttonTooltip = string.gsub(otherButton.name, "loreButton", "Selected: Lore of ");
						otherButton.uic:SetTooltipText("Select your prefered spell for Spell Slot -1-.");
						--replaceLoreTrait(otherButton.name, char);
						--createSpellText(otherButton.name, char);
                    else
                        otherButton:SetState("active");
                    end
                end
            end
        );
    end
end

--v function(spellName: string) --> vector<string>
function updateSaveTable(spellName)
	local spellSlots = loadstring(cm:get_saved_value("sm0_mazdamundi"))();
	for i, spellSlot in ipairs(spellSlots) do
		if spellSlot == spellSlotSelected then
			spellSlots[i] = spellName;
			local saveString = "return {"..cm:process_table_save(spellSlots).."}";
			cm:set_saved_value("sm0_mazdamundi", saveString);
		end
	end
	return spellSlots;
end

----v function(spellName: string)
--function updateSpellSlotContainer(spellName)
--	for _, spellSlotButton in ipairs(spellSlotButtons) do
--		if spellSlotButton.name == spellSlotSelected then
--			updateSaveTable(spellName);
--			--spellSlotButton:SetButtonText(spellName);
--		end
--	end
--end

--v function(lore: vector<string>, char: CA_CHAR)
function createSpellButtonContainer(lore, char)
	--if spellButtonContainer then
	--	spellButtonContainer:SetVisible(true);
	--	return;
	--end
	local spellButtonList = ListView.new("SpellButtonList", loreFrame, "VERTICAL");
	spellButtonList:Resize(pX/2 - 18, pY - dummyButtonY/2); --(pX/2 - 13, pY - 40);

	spellButtonContainer = Container.new(FlowLayout.VERTICAL);	
	local spellButtons = {} --:vector<TEXT_BUTTON>
	--local loreEnable = {};
	--loreEnable = characterHasSkill(char);
	local spellSlots = loadstring(cm:get_saved_value("sm0_mazdamundi"))();
	for _, spell in ipairs(lore) do
		local spellButton = TextButton.new(spell, loreFrame, "TEXT", spell);
		--for _, spellSlot in ipairs(spellSlots) do
		--	if spellSlot == spell then
		--		spellButton:SetDisabled(true);
		--	--else
		--	--	spellButton:SetDisabled(false);
		--	end
		--end
		table.insert(spellButtons, spellButton);
		spellButton:RegisterForClick(
			function(context)
				local spellSlots = updateSaveTable(spellButton.name);
				loreButtonContainer:Clear();
				spellButtonContainer:Clear();
				createSpellSlotButtonContainer(nil, spellSlots);
			end
		)
		spellButtonList:AddComponent(spellButton);
		--spellSlotButtonContainer:AddGap(2); --spellSlotButton:Height() + 
		--if loreEnable["loreLightEnabled"] then
		--	loreButtonLight:SetState("hover");
		--	loreButtonLight.uic:SetTooltipText("Lore of Light");	
		--else
		--	loreButtonLight:SetDisabled(true);
		--	loreButtonLight.uic:SetTooltipText("Required Skill: Lore of Light");
		--end
	end
	spellButtonContainer:AddComponent(spellButtonList);
		
	--setupSingleSelectedButtonGroup(spellSlotButtons, char);
	--for _, spellSlotButton in ipairs(spellSlotButtons) do
	--	spellSlotButtonContainer:AddComponent(spellSlotButton);
	--	spellSlotButtonContainer:AddGap(4);
	--end
	spellButtonContainer:PositionRelativeTo(loreFrame, pX/2 + 35, dummyButtonY/4);
end

--v function(char: CA_CHAR)
function createLoreButtonContainer(char)
	--if loreButtonContainer then
	--	loreButtonContainer:SetVisible(true);
	--	return;
	--end
	local loreButtonList = ListView.new("LoreButtonList", loreFrame, "VERTICAL");
	loreButtonList:Resize(pX/2 - 9, pY - dummyButtonY/2); -- width vslider 18
	--for i, lore in ipairs(loreList) do
	--    local regionButton = createRegionButton(region);
	--    regionList:AddComponent(regionButton);
	--    table.insert(regionButtons, regionButton);
	--end
	--setUpSingleButtonSelectedGroup(regionButtons);

	loreButtonContainer = Container.new(FlowLayout.VERTICAL);
	local loreButtons = {} --:vector<TEXT_BUTTON>
	local loreEnable = {};
	--loreEnable = characterHasSkill(char);
	for lore, _ in pairs(loreTable) do
		local loreButton = TextButton.new(lore, loreFrame, "TEXT_TOGGLE", lore);
		table.insert(loreButtons, loreButton);
		--if loreEnable["loreLightEnabled"] then
			loreButton:SetState("hover");
			loreButton.uic:SetTooltipText(lore);	
		--else
			--loreButtonLight:SetDisabled(true);
			--loreButtonLight.uic:SetTooltipText("Required Skill: Lore of Light");
		--end
	end	
	
	setupSingleSelectedButtonGroup(loreButtons, char);
	
	--local buttonSize = loreButtonLight:Width(); --56
	
	for _, loreButton in ipairs(loreButtons) do
		loreButtonList:AddComponent(loreButton);
		--loreButtonList:AddGap(2);
		--loreButtonContainer:AddGap(buttonSize / 8);
		loreButton:RegisterForClick(
			function(context)
				if spellButtonContainer then
					spellButtonContainer:Clear();
				end
				createSpellButtonContainer(loreTable[loreButton.name], char);
			end
		)
	end


	loreButtonContainer:AddComponent(loreButtonList);
	--loreButtonContainer:Reposition();
	--Util.centreComponentOnComponent(loreButtonContainer, loreFrame);
	loreButtonContainer:PositionRelativeTo(loreFrame, 22, dummyButtonY/4);
	--loreButtonContainer:Reposition();
end

createSpellSlotButtonContainer = function(char, spellSlots)
	local spellSlotButtonList = ListView.new("SpellSlotButtonList", loreFrame, "VERTICAL");
	spellSlotButtonList:Resize(dummyButtonX, pY - dummyButtonY/2); --(pX/2 - 13, pY - 40);


	spellSlotButtonContainer = Container.new(FlowLayout.VERTICAL);
	
	

	--local loreEnable = {};
	--loreEnable = characterHasSkill(char);
	for i, spellSlot in ipairs(spellSlots) do
		local spellSlotButton = TextButton.new("Spell Slot - "..i.." -", loreFrame, "TEXT", spellSlot);
		table.insert(spellSlotButtons, spellSlotButton);
		spellSlotButton:RegisterForClick(
			function(context)
				spellSlotSelected = spellSlotButton.name;
				spellSlotButtonContainer:Clear();
				createLoreButtonContainer(char);
			end
		)

		spellSlotButtonList:AddComponent(spellSlotButton);
		--spellSlotButtonContainer:AddGap(2); --spellSlotButton:Height() + 
		--if loreEnable["loreLightEnabled"] then
		--	loreButtonLight:SetState("hover");
		--	loreButtonLight.uic:SetTooltipText("Lore of Light");	
		--else
		--	loreButtonLight:SetDisabled(true);
		--	loreButtonLight.uic:SetTooltipText("Required Skill: Lore of Light");
		--end
	end
	spellSlotButtonContainer:AddComponent(spellSlotButtonList);

	Util.centreComponentOnComponent(spellSlotButtonContainer, loreFrame);
	
	--setupSingleSelectedButtonGroup(spellSlotButtons, char);
	
	
	--for _, spellSlotButton in ipairs(spellSlotButtons) do
	--	spellSlotButtonContainer:AddComponent(spellSlotButton);
	--	spellSlotButtonContainer:AddGap(4);
	--end
end

--v function() --> CA_CHAR
function getMazdaCharacter()
	local char = nil --:CA_CHAR
	if not cm:model():pending_battle():is_active() then
		char = getSelectedCharacter();
		if char == nil then
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
function createLoreUI()
	if loreFrame then
		return;
	end
	loreFrame = Frame.new("Lore of Magic");
	loreFrame.uic:PropagatePriority(100);
	loreFrame:AddCloseButton(
		function()
			loreFrame = nil;
		end
	);
	local parchment = find_uicomponent(core:get_ui_root(), "Lore of Magic", "parchment");
	pX, pY = parchment:Bounds();
	Util.centreComponentOnScreen(loreFrame);
	--local char = getMazdaCharacter();
	local char = getCAChar(charSubMazdamundi, cm:get_faction(cm:get_local_faction(true)));
	local spellSlots = loadstring(cm:get_saved_value("sm0_mazdamundi"))();
	createSpellSlotButtonContainer(char, spellSlots);
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

function createLoreButton1() -- character_panel
	cm:callback(
		function(context)
			if loreBookButton1 == nil then
				loreBookButton1 = Button.new("loreBookButton1", find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons"), "SQUARE", iconPath);
				local characterdetailspanel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				local referenceButton = find_uicomponent(characterdetailspanel, "button_replace_general");
				loreBookButton1:Resize(referenceButton:Width(), referenceButton:Height());
				loreBookButton1:PositionRelativeTo(referenceButton, -loreBookButton1:Width() - 1, 0);
				loreBookButton1:SetState("hover");
				loreBookButton1.uic:SetTooltipText("Choose Lore of Magic");			
				loreBookButton1:SetState("active");
				loreBookButton1:RegisterForClick(
					function(context)
						createLoreUI();
					end
				)
			end
			local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
			local namePanelText = namePanel:GetStateText();
			if string.find(namePanelText, "Mazdamundi") then
				loreBookButton1:SetVisible(true);
			else
				loreBookButton1:SetVisible(false);
			end				
		end, 0, "createLoreBookButton1"
	);
end

function createLoreButton2() --
	loreBookButton2 = Button.new("loreBookButton2", find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "button_group_unit"), "SQUARE", iconPath); 
	cm:callback(
		function(context)
			local buttonGroupUnit = find_uicomponent(core:get_ui_root(), "button_group_unit");
			local referenceButton = find_uicomponent(buttonGroupUnit, "button_replace_general");
			loreBookButton2:Resize(referenceButton:Width(), referenceButton:Height());
			loreBookButton2:PositionRelativeTo(referenceButton, 0, 0);
			loreBookButton2:SetState("hover");
			loreBookButton2.uic:SetTooltipText("Choose Lore of Magic");			
			loreBookButton2:SetState("active");
		end, 0, "positionLoreBookButton2"
	);
	loreBookButton2:RegisterForClick(
		function(context)
			createLoreUI();
		end
	)
end

function createLoreButton3() -- pre_battle
	local buttonParent = find_uicomponent(core:get_ui_root(), "popup_pre_battle", "mid", "battle_deployment", "regular_deployment", "list");
	loreBookButton3 = Util.createComponent("loreBookButton3", buttonParent, "ui/templates/round_small_button");
	Util.registerComponent("loreBookButton3", loreBookButton3);
	cm:callback(
		function(context)
			local preBattlePanel = find_uicomponent(core:get_ui_root(), "popup_pre_battle", "mid", "battle_deployment", "regular_deployment", "list", "battle_information_panel", "button_holder");
			local referenceButton = find_uicomponent(preBattlePanel, "button_info");
			local posReferenceButtonX, posReferenceButtonY = referenceButton:Position();
			loreBookButton3:MoveTo(posReferenceButtonX - 500, posReferenceButtonY);
			loreBookButton3:SetImage(iconPath);
			loreBookButton3:SetState("hover");
			loreBookButton3:SetTooltipText("Choose Lore of Magic");
			--loreBookButton3.uic:PropagatePriority(100);
			loreBookButton3:PropagatePriority(100);
			loreBookButton3:SetState("active");
			end, 0, "positionLoreBookButton3"
	);
	Util.registerForClick(loreBookButton3, "specialButtonListener",
		function(context)
			createLoreUI();
		end
	)
end

function createLoreButton4() -- main_units_panel
	loreBookButton4 = Button.new("loreBookButton4", find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_army"), "SQUARE", iconPath);
	cm:callback(
		function(context)
			local unitsPanel = find_uicomponent(core:get_ui_root(), "button_group_army");
			local referenceButton = find_uicomponent(unitsPanel, "button_renown");
			loreBookButton4:Resize(referenceButton:Width(), referenceButton:Height());
			loreBookButton4:PositionRelativeTo(referenceButton, loreBookButton4:Width() + 4, 0);
			loreBookButton4:SetState("hover");
			loreBookButton4.uic:SetTooltipText("Choose Lore of Magic");
			loreBookButton4:SetState("active");
		end, 0, "positionLoreBookButton4"
	);
	loreBookButton4:RegisterForClick(
		function(context)
			createLoreUI();
		end
	)
end

function closeLoreUI1() -- character_panel
	--loreBookButton1 = Util.getComponentWithName("loreBookButton1");
	if loreBookButton1 then
		loreBookButton1:Delete();
		loreBookButton1 = nil;
	end
	if loreFrame then
		loreFrame:Delete();
		loreFrame = nil;
	end
end

function closeLoreUI2() -- 
	--loreBookButton2 = Util.getComponentWithName("loreBookButton2");
	if loreBookButton2 then
		loreBookButton2:Delete();
		loreBookButton2 = nil;
	end
	if loreFrame then
		loreFrame:Delete();
		loreFrame = nil;
	end
end

function closeLoreUI3() -- pre_battle
	--loreBookButton3 = Util.getComponentWithName("loreBookButton3");
	if loreBookButton3 then
		Util.delete(loreBookButton3);
		Util.unregisterComponent("loreBookButton3");
		core:remove_listener("specialButtonListener");
		loreBookButton3 = nil;
	end
	if loreFrame then
		loreFrame:Delete();
		loreFrame = nil;
	end
end

function closeLoreUI4() -- main_units_panel
	--loreBookButton4 = Util.getComponentWithName("loreBookButton4");
	if loreBookButton4 then
		loreBookButton4:Delete();
		loreBookButton4 = nil;
	end
	if loreFrame then
		loreFrame:Delete();
		loreFrame = nil;
	end
end

function playerLoreListener()
	local buttonLocation1 = true;	-- "character_details_panel" root > character_details_panel > background > skills_subpanel > listview
	local buttonLocation2 = false;	-- "units_panel", "main_units_panel", "button_group_unit"
	local buttonLocation3 = true;	-- "popup_pre_battle"
	local buttonLocation4 = true;	-- "main_units_panel"

	if buttonLocation1 then
		core:add_listener(
			"loreCharacterPanelOpened1",
			"PanelOpenedCampaign",
			function(context)		
				return context.string == "character_details_panel" and not cm:model():pending_battle():is_active(); 
			end,
			function(context)
				createLoreButton1(); 						
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
				closeLoreUI1();
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
						local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
						local namePanelText = namePanel:GetStateText();
						if string.find(namePanelText, "Mazdamundi") then
							loreBookButton1:SetVisible(true);
						else
							loreBookButton1:SetVisible(false);
						end
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
						local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
						local namePanelText = namePanel:GetStateText();
						if string.find(namePanelText, "Mazdamundi") then
							loreBookButton1:SetVisible(true);
						else
							loreBookButton1:SetVisible(false);
						end
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
						local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
						local namePanelText = namePanel:GetStateText();
						if string.find(namePanelText, "Mazdamundi") then
							loreBookButton1:SetVisible(true);
						else
							loreBookButton1:SetVisible(false);
						end
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
						local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
						local namePanelText = namePanel:GetStateText();
						if string.find(namePanelText, "Mazdamundi") then
							loreBookButton1:SetVisible(true);
						else
							loreBookButton1:SetVisible(false);
						end
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
	
	if buttonLocation2 then
		core:add_listener(
			"loreLandUnitComponentLClickUp2",
			"ComponentLClickUp",
			function(context)		
				return context.string == "LandUnit 0" and loreBookButton2 == nil; 
			end,
			function(context)
				local selectedCharacter = getSelectedCharacter();
				--local lordUnitPanel = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units", "LandUnit 0");
				if selectedCharacter:character_subtype(charSubMazdamundi) then --and lordUnitPanel:CurrentState() == "selected_hover"
					createLoreButton2();	
				end			
			end,
			true
		);

		core:add_listener(
			"loreButtonGroupUnitClosed2",
			"PanelClosedCampaign",
			function(context) 
				return context.string == "button_group_unit"; 
			end,
			function(context)
				closeLoreUI2();
			end,
			true
		);
	end
	
	if buttonLocation3 then		
		core:add_listener(
			"lorePopupPreBattlePanelOpened3",
			"PanelOpenedCampaign", 
			function(context) 
				return context.string == "popup_pre_battle" and loreBookButton3 == nil; 
			end,
			function(context)
				local selectedCharacter = getMazdaCharacter();
				local pb = cm:model():pending_battle();
				if pb:battle_type() ~= "ambush" and selectedCharacter:character_subtype(charSubMazdamundi) then
					createLoreButton3();
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
				loreFrame:Delete();
				loreFrame = nil;
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
				closeLoreUI3();
			end,
			true
		);
	end
	
	if buttonLocation4 then
		core:add_listener(
			"loreUnitPanelOpened4",
			"PanelOpenedCampaign",
			function(context)		
				return context.string == "units_panel" and loreBookButton4 == nil; 
			end,
			function(context)
				local selectedCharacter = getMazdaCharacter();
				if selectedCharacter:character_subtype(charSubMazdamundi) then
					createLoreButton4();	
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
				closeLoreUI4();
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
				if context:character():character_subtype(charSubMazdamundi) and loreBookButton4 == nil then
					createLoreButton4();
				elseif context:character():character_subtype(charSubMazdamundi) ~= true and loreBookButton4 ~=nil then
					closeLoreUI4();
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

--v function(table: map<WHATEVER,WHATEVER>, key: WHATEVER) --> string
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