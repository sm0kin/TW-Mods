cm:set_saved_value("sm0_mazdamundi", true);

local loreBookButton1 = nil;
local loreBookButton2 = nil;
local loreBookButton3 = nil;
local loreBookButton4 = nil;
local loreFrame = nil;
local loreSpellText = nil;
local loreAttributeText = nil;

local charSubMazdamundi = "wh2_main_lzd_lord_mazdamundi";

--v function() --> CA_CHAR					
function getSelectedCharacter()
	local selectedCharacter = cm:get_campaign_ui_manager():get_char_selected();
	if selectedCharacter == '' then
		return nil;
	else
		local selectedCharacterCqi = string.sub(selectedCharacter, 15);
		return cm:get_character_by_cqi(selectedCharacterCqi);
	end
end

--v function() --> CA_CHAR					
function getMazdaCharacterByFaction()
	local localFaction = cm:get_faction(cm:get_local_faction(true));
	if localFaction then
		local characterList = localFaction:character_list();
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype(charSubMazdamundi) then
				return currentChar;
			end
		end
	end
end

--v function(buttonName: string, char: CA_CHAR)					
function replaceSpellEffect(buttonName, char) -- test
	local charCqi = char:cqi();
	local loreEffectBundles = {"wh2_sm0_effect_bundle_test"};
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
--v function(char: CA_CHAR) --> CONTAINER
function createSpellSlotButtonContainer(char)
	local spellSlotButtonContainer = Container.new(FlowLayout.HORIZONTAL);
	
	

	local spellSlotButtons = {} --:vector<TEXT_BUTTON>
	--local loreEnable = {};
	--loreEnable = characterHasSkill(char);
	for i = 0, 5 do
		local spellSlotButton = TextButton.new("spellSlotButton_"..i, loreFrame, "TEXT_TOGGLE", "Spell Slot -"..i.."-");
		table.insert(spellSlotButtons, spellSlotButton);
		spellSlotButtonContainer:AddComponent(spellSlotButton);
		spellSlotButtonContainer:AddGap(spellSlotButton:Width() + 2);
		--if loreEnable["loreLightEnabled"] then
		--	loreButtonLight:SetState("hover");
		--	loreButtonLight.uic:SetTooltipText("Lore of Light");	
		--else
		--	loreButtonLight:SetDisabled(true);
		--	loreButtonLight.uic:SetTooltipText("Required Skill: Lore of Light");
		--end
	end

		
	setupSingleSelectedButtonGroup(spellSlotButtons, char);
	
	
	for _, spellSlotButton in ipairs(spellSlotButtons) do
		spellSlotButtonContainer:AddComponent(spellSlotButton);
		spellSlotButtonContainer:AddGap(4);
	end
	
    return spellSlotButtonContainer;
end

function createLoreButtonContainer(char)
    local loreButtonContainer = Container.new(FlowLayout.VERTICAL);
	local loreButtons = {};
	local loreEnable = {};
	--loreEnable = characterHasSkill(char);
	
	local loreButtonLight = TextButton.new("loreButtonLight", loreFrame, "TEXT_TOGGLE", "Lore of Light");
	table.insert(loreButtons, loreButtonLight);
	--if loreEnable["loreLightEnabled"] then
		loreButtonLight:SetState("hover");
		loreButtonLight.uic:SetTooltipText("Lore of Light");	
	--else
		--loreButtonLight:SetDisabled(true);
		--loreButtonLight.uic:SetTooltipText("Required Skill: Lore of Light");
	--end	
	
	local loreButtonLife = TextButton.new("loreButtonLife", loreFrame, "TEXT_TOGGLE", "Lore of Life");
	table.insert(loreButtons, loreButtonLife);
	--if loreEnable["loreLifeEnabled"] then
		loreButtonLife:SetState("hover");	
		loreButtonLife.uic:SetTooltipText("Lore of Life");	
	--else
		--loreButtonLife:SetDisabled(true);
		--loreButtonLife.uic:SetTooltipText("Required Skill: Lore of Life");
	--end		
	
	local loreButtonBeasts = TextButton.new("loreButtonBeasts", loreFrame, "TEXT_TOGGLE", "Lore of Beasts");
	table.insert(loreButtons, loreButtonBeasts);
	--if loreEnable["loreBeastsEnabled"] then
		loreButtonBeasts:SetState("hover");
		loreButtonBeasts.uic:SetTooltipText("Lore of Beasts");	
	--else
	--	loreButtonBeasts:SetDisabled(true);
	--	loreButtonBeasts.uic:SetTooltipText("Required Skill: Lore of Beasts");
	--end		
		
	local loreButtonFire = TextButton.new("loreButtonFire", loreFrame, "TEXT_TOGGLE", "Lore of Fire");
	table.insert(loreButtons, loreButtonFire);
	--if loreEnable["loreFireEnabled"] then
		loreButtonFire:SetState("hover");
		loreButtonFire.uic:SetTooltipText("Lore of Fire");	
	--else
	--	loreButtonFire:SetDisabled(true);
	--	loreButtonFire.uic:SetTooltipText("Required Skill: Lore of Fire");
	--end		
		
	local loreButtonHeavens = TextButton.new("loreButtonHeavens", loreFrame, "TEXT_TOGGLE", "Lore of Heavens");
	table.insert(loreButtons, loreButtonHeavens);
	--if loreEnable["loreHeavensEnabled"] then
		loreButtonHeavens:SetState("hover");
		loreButtonHeavens.uic:SetTooltipText("Lore of Heavens");	
	--else
	--	loreButtonHeavens:SetDisabled(true);
	--	loreButtonHeavens.uic:SetTooltipText("Required Skill: Lore of Heavens");
	--end		
		
	local loreButtonMetal = TextButton.new("loreButtonMetal", loreFrame, "TEXT_TOGGLE", "Lore of Metal");
	table.insert(loreButtons, loreButtonMetal);
	--if loreEnable["loreMetalEnabled"] then
		loreButtonMetal:SetState("hover");
		loreButtonMetal.uic:SetTooltipText("Lore of Metal");	
	--else
	--	loreButtonMetal:SetDisabled(true);
	--	loreButtonMetal.uic:SetTooltipText("Required Skill: Lore of Metal");
	--end	
		
	local loreButtonDeath = TextButton.new("loreButtonDeath", loreFrame, "TEXT_TOGGLE", "Lore of Death");
	table.insert(loreButtons, loreButtonDeath);
	--if loreEnable["loreDeathEnabled"] then
		loreButtonDeath:SetState("hover");
		loreButtonDeath.uic:SetTooltipText("Lore of Death");
	--else
	--	loreButtonDeath:SetDisabled(true);
	--	loreButtonDeath.uic:SetTooltipText("Required Skill: Lore of Death");
	--end	
		
	local loreButtonShadows = TextButton.new("loreButtonShadows", loreFrame, "TEXT_TOGGLE", "Lore of Shadows");
	table.insert(loreButtons, loreButtonShadows);
	--if loreEnable["loreShadowsEnabled"] then
		loreButtonShadows:SetState("hover");
		loreButtonShadows.uic:SetTooltipText("Lore of Shadows");
	--else
	--	loreButtonShadows:SetDisabled(true);
	--	loreButtonShadows.uic:SetTooltipText("Required Skill: Lore of Shadows");
	--end		
		
	setupSingleSelectedButtonGroup(loreButtons, char);
	
	--local buttonSize = loreButtonLight:Width(); --56
	
	for _, lorebutton in ipairs(loreButtons) do
		loreButtonContainer:AddComponent(lorebutton);
		--loreButtonContainer:AddGap(buttonSize / 8);
	end
	
    return loreButtonContainer;
end

--v function() --> CA_CHAR
function getMazdaCharacter()
	local char = nil;
	if not cm:model():pending_battle():is_active() then
		char = getSelectedCharacter();
		if char == nil then
			local focusButton = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"); 
			local focusButtonText = focusButton:GetStateText();
			if string.find(focusButtonText,"Mazdamundi") then
				 char = getMazdaCharacterByFaction();
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

	Util.centreComponentOnScreen(loreFrame);
	local char = getMazdaCharacter();
	local spellSlotButtonContainer = createSpellSlotButtonContainer(char);
	--local loreButtonContainer = createLoreButtonContainer(char);
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
				loreBookButton1 = Button.new("loreBookButton1", find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons"), "SQUARE", "ui/icon_lorebook.png");
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
	loreBookButton2 = Button.new("loreBookButton2", find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "button_group_unit"), "SQUARE", "ui/icon_lorebook.png"); 
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
			loreBookButton3:SetImage("ui/icon_lorebook.png");
			loreBookButton3:SetState("hover");
			loreBookButton3:SetTooltipText("Choose Lore of Magic");
			loreBookButton3.uic:PropagatePriority(100);
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
	loreBookButton4 = Button.new("loreBookButton4", find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_army"), "SQUARE", "ui/icon_lorebook.png");
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
	loreBookButton1 = Util.getComponentWithName("loreBookButton1");
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
	loreBookButton2 = Util.getComponentWithName("loreBookButton2");
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
	loreBookButton3 = Util.getComponentWithName("loreBookButton3");
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
	loreBookButton4 = Util.getComponentWithName("loreBookButton4");
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
				return context.string == "button_cycle_right" and panel;
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
				return context.string == "button_cycle_left" and panel;
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
				return context.string == "select_next" and panel;
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
				return context.string == "select_prev" and panel;
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
				return panel;
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

function tableRemove(table, key)
    local item = table[key];
    table[key] = nil;
    return item;
end

function tableFind(table, val)
    for index, value in pairs(table) do
        if value == val then
            return index
        end
    end
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
			local charMazda = nil;
			local enemyFaction = nil;
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
			if cm:random_number() == 1 and enableLoadedDice then
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
