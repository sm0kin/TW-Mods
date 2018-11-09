cm:set_saved_value("sm0_confed", true);
local restrictTKconfed = true;
local playerFaction = cm:get_faction(cm:get_local_faction(true));
local OccupationOptionID = {["1913039130"] = "wh2_sm0_sc_brt_bretonnia_occupation_decision_confederate",
							["1913039131"] = "wh2_sm0_sc_lzd_lizardmen_occupation_decision_confederate",
							["1913039132"] = "wh2_sm0_sc_skv_skaven_occupation_decision_confederate",
							["1913039133"] = "wh2_sm0_sc_def_dark_elves_occupation_decision_confederate",
							["1913039134"] = "wh2_sm0_sc_dwf_dwarfs_occupation_decision_confederate",
							["1913039135"] = "wh2_sm0_sc_emp_empire_occupation_decision_confederate",
							["1913039136"] = "wh2_sm0_sc_grn_greenskins_occupation_decision_confederate",
							["1913039137"] = "wh2_sm0_sc_hef_high_elves_occupation_decision_confederate",
							["1913039138"] = "wh2_sm0_sc_wef_wood_elves_occupation_decision_confederate",
							["1913039139"] = "wh2_sm0_sc_vmp_vampire_counts_occupation_decision_confederate",
							["1913039140"] = "wh2_sm0_sc_tmb_tomb_kings_occupation_decision_confederate"} --: map<string, string>

--v function()
function addTkImmortalityTrait()
	local factionList = cm:model():world():faction_list();
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_traits", "");
	for i = 0, factionList:num_items() - 1 do
		local currentFaction = factionList:item_at(i);
		if currentFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" and not currentFaction:is_dead() then
			local leaderChar = currentFaction:faction_leader();
			if not leaderChar:has_trait("wh2_sm0_trait_immortality") and not leaderChar:is_wounded() then
				cm:force_add_trait("character_cqi:"..tostring(leaderChar:command_queue_index()), "wh2_sm0_trait_immortality", true);
			elseif not leaderChar:has_trait("wh2_sm0_trait_immortality") and leaderChar:is_wounded() then
				local leaderSubtype = leaderChar:character_subtype_key();
				local TraitListenerStr = "TraitListener_" ..leaderSubtype;

				core:add_listener(
					TraitListenerStr,
					"CharacterTurnStart",
					function(context)
						return context:character():character_subtype(leaderSubtype) and not context:character():is_wounded();
					end,
					function(context)
						cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_traits", "");
						cm:force_add_trait("character_cqi:"..tostring(leaderChar:command_queue_index()), "wh2_sm0_trait_immortality", true);
						core:remove_listener(TraitListenerStr);
						cm:callback(
							function(context)
								cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_traits", "");
							end, 1, "enableEventFeed"
						);
					end,
					false
				);
			end
		end
	end
	cm:callback(
		function(context)
			cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_traits", "");
		end, 1, "enableEventFeed"
	);
end

if playerFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
	cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false);
	addTkImmortalityTrait();

	core:add_listener(
		"TKconfederationExpired",
		"ScriptEventConfederationExpired",
		function(context)
			local factionName = context.string;
			local faction = cm:get_faction(factionName);			
			local subculture = faction:subculture();
			return subculture == "wh2_dlc09_sc_tmb_tomb_kings";
		end,
		function(context)
			local factionName = context.string;
			cm:callback(
				function(context)
					cm:force_diplomacy("faction:" .. factionName, "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false);
				end, 1, "changeDiplomacyOptions"
			);	
		end,
		true
	);

	core:add_listener(
		"TKgarrisonAttackedEvent",
		"GarrisonAttackedEvent",
		function(context)
			return cm:is_local_players_turn() and context:garrison_residence():faction():region_list():num_items() == 1;
		end,
		function(context)
			FACTION_GARRISON_ATTACKED = context:garrison_residence():faction():name();
			cm:set_saved_value("faction_garrison_attacked", FACTION_GARRISON_ATTACKED);
		end,
		true
	);
end

core:add_listener(
	"SettlementCapturedPanelOpened",
	"PanelOpenedCampaign",
	function(context)		
		return context.string == "settlement_captured"; 
	end,
	function(context)
		local icon = find_uicomponent(core:get_ui_root(), "settlement_captured", "icon_vassals");
		if icon ~= nil then 
			for currentID, _ in pairs(OccupationOptionID) do
				local frame = find_uicomponent(core:get_ui_root(), "settlement_captured", tostring(currentID));
				if frame then
					icon = find_uicomponent(core:get_ui_root(), "settlement_captured", "button_parent", tostring(currentID), "frame", "icon_parent", "icon_vassals");
					icon:SetImage("UI/skins/default/treaty_confederation.png");
					icon:SetTooltipText("Forces the enemy faction to accept Confederation. All their armies will be disbanded and their legendary lords will be forced to serve under your rule.", true);
					local button = find_uicomponent(core:get_ui_root(), "settlement_captured", tostring(currentID), "option_button");
					if FACTION_GARRISON_ATTACKED == nil then
						FACTION_GARRISON_ATTACKED = cm:get_saved_value("faction_garrison_attacked");
					end				
					if restrictTKconfed and playerFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
						if FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_khemri" then
							button:SetDisabled(true);
							button:SetOpacity(50);
							button:SetTooltipText("SETTRA DOES NOT SERVE!");
						else
							if playerFaction:name() == "wh2_dlc09_tmb_followers_of_nagash" and FACTION_GARRISON_ATTACKED ~= "wh2_dlc09_tmb_the_sentinels" or playerFaction:name() == "wh2_dlc09_tmb_the_sentinels" and FACTION_GARRISON_ATTACKED ~= "wh2_dlc09_tmb_followers_of_nagash" then
								button:SetDisabled(true);
								button:SetOpacity(50);
								button:SetTooltipText("They would rather desintegrate than follow Nagash!");
							elseif playerFaction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_the_sentinels" or playerFaction:name() ~= "wh2_dlc09_tmb_the_sentinels" and FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_followers_of_nagash" then
								button:SetDisabled(true);
								button:SetOpacity(50);
								button:SetTooltipText("Betraying Khemri must never be forgiven!");
							end
						end
					end
				end
			end
		end
	end,
	true
);

core:add_listener(
	"ForceConfedClick",
	"ComponentLClickUp",
	function(context)
		local occupationPanel = find_uicomponent(core:get_ui_root(), "settlement_captured");
		if occupationPanel then
			local optionButton = UIComponent(context.component);
			if optionButton:Id() == "root" then
				return false;
			else
				local optionParent = UIComponent(optionButton:Parent());
				local optionParentId = optionParent:Id();
				local OccupationKey = OccupationOptionID[optionParentId];
				return  OccupationKey ~= nil;
			end
		end
	end,
	function(context)
		cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "");
	end,
	true
);

--v function(faction: CA_FACTION)
function killAllUnits(faction)
	local mfList = faction:military_force_list();
	for i = 0, mfList:num_items() - 1 do
		local mf = mfList:item_at(i);	
		if mf:has_general() then
			cm:kill_character(mf:general_character():cqi(), true, true);
		end
	end
end

--v function(char: CA_CHAR, faction: CA_FACTION)
function forceConfed(char, faction)
	local winnerFactionName = char:faction():name();
	local loserFaction = faction;
	local loserFactionName = loserFaction:name();
	if playerFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
		addTkImmortalityTrait();
	end
	killAllUnits(loserFaction);
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "");
	cm:force_confederation(winnerFactionName, loserFactionName);
	cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "");
end

core:add_listener(
	"ForceConfedDecision",
	"CharacterPerformsSettlementOccupationDecision",
	function(context)
		local occupationDecision = context:occupation_decision();
		return OccupationOptionID[occupationDecision] ~= nil;
	end,
	function(context)
		local occupationDecision = context:occupation_decision();
		cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "");
		forceConfed(context:character(), context:garrison_residence():faction());
	end,
	true
);