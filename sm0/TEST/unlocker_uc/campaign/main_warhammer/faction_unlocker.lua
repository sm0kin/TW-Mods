cm:set_saved_value("Faction_Unlocker", true);
cm:set_saved_value("Faction_Unlocker_Vanilla", false);



function Faction_Unlocker()
	out("000 - Faction Unlocker");



	-- Warning about the upcoming version breaking Save Games
--	if not cm:get_saved_value("Unlocker_Version_Warning") then
--		cm:show_message_event(
--			player_1:name(),
--			"event_feed_strings_text_wh_event_feed_string_version_break_point_warning_title",
--			"event_feed_strings_text_wh_event_feed_string_version_break_point_warning_primary_detail",
--			"event_feed_strings_text_wh_event_feed_string_version_break_point_warning_secondary_detail",
--			true,
--			592
--		);
--		
--		cm:set_saved_value("Unlocker_Version_Warning", true);
--	end









The_Thirteenth_Scheme();




	Repositioned_Legendary_Lords();


	if cm:is_new_game() then
		if cm:get_faction("wh_main_chs_the_brass_legion"):is_human() then
			cm:show_message_event(
				"wh_main_chs_the_brass_legion",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_brass_legion_title",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_brass_legion_primary_detail",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_brass_legion_secondary_detail",
				true,
				595
			);
		end
		
		if cm:get_faction("wh2_main_dwf_karak_zorn"):is_human() then
			cm:show_message_event(
				"wh2_main_dwf_karak_zorn",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_lost_holds_title",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_lost_holds_primary_detail",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_lost_holds_karak_zorn_secondary_detail",
				true,
				592
			);
		end
		
		if cm:get_faction("wh2_main_dwf_spine_of_sotek_dwarfs"):is_human() then
			cm:show_message_event(
				"wh2_main_dwf_spine_of_sotek_dwarfs",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_lost_holds_title",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_lost_holds_primary_detail",
				"event_feed_strings_text_wh_event_feed_string_how_to_play_the_lost_holds_karak_zank_secondary_detail",
				true,
				592
			);
		end



		cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
		cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "");
		cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
		cm:disable_event_feed_events(true, "wh_event_category_faction", "", "");
		cm:disable_event_feed_events(true, "wh_event_category_provinces", "", "");




	






	-- Add Listeners


	-- Starting Units
--	Starting_Units();

	Remove_Units();
	Remove_Units_Ungrol_Stoneheart();
	Remove_Units_Thorek_Ironbrow();
	Remove_Units_Sigvald_the_Magnificent();

	Starting_Units_Wissenland();



	Restrict_Skeggi_Units();



	if not cm:get_saved_value("Necrarch_Brotherhood_Disable_Faction_Leader_Replacement") then		-- Set Variable to true to disable the lord replacement
		Necrarch_Brotherhood();
	end

	if not cm:get_saved_value("Strygos_Empire_Disable_Faction_Leader_Replacement") then			-- Set Variable to true to disable the lord replacement
		Strygos_Empire();
	end

	if not cm:get_saved_value("The_Silver_Host_Disable_Faction_Leader_Replacement") then		-- Set Variable to true to disable the lord replacement
		The_Silver_Host();
	end





	-- Buildings
	Starting_Buildings();


	-- Subfunctions
	if cm:is_multiplayer() then
		out("008 - Focus_Starting_Cameras - DISABLED");
		out("009 - Sudenburg - DISABLED");
	else
		cm:callback(	function()	Focus_Starting_Cameras();	end,	1	);
		
		Sudenburg();
	end

	Kill_Archaon_and_Sarthorael();

	Kill_The_Cabal();


	Southern_Realms_Start();




	-- The Brass Legion
	cm:instantly_upgrade_building("wh_main_hochland_brass_keep:1", "wh_main_emp_barracks_1");
	cm:transfer_region_to_faction("wh_main_hochland_brass_keep", "wh_main_chs_the_brass_legion");

	The_Brass_Legion();
	
	core:add_listener(
		"The_Brass_Legion_Dilemma",
		"FactionTurnStart",
		function(context) return context:faction():is_human() and context:faction():name() ~= "wh_main_chs_the_brass_legion" and cm:model():turn_number() >= 2 end,
		function(context) cm:trigger_dilemma(player_1:name(), "wh_main_dilemma_the_brass_legion", true) end,
		false
	);
	
	core:add_listener(
		"Chaos_Invasion_Dilemma_The_Brass_Legion",
		"FactionTurnStart",
		function(context) return context:faction():is_human() and context:faction():name() == "wh_main_chs_the_brass_legion" and cm:model():turn_number() >= 3 and cm:get_saved_value("chaos_invasion_dilemma") end,
		function(context) cm:trigger_dilemma(context:faction():name(), "wh_main_dilemma_chaos_invasion", true) end,
		false
	);




	local bohemond = cm:get_faction("wh_main_brt_bastonne"):faction_leader():cqi();
	
	cm:add_agent_experience(cm:char_lookup_str(bohemond), 1900);
	
	cm:force_add_skill(cm:char_lookup_str(bohemond), "wh_main_skill_brt_questing_vow");
	
	-- Delayed Skill Assignment so it can detect that the previous skill in the chain was already given
	cm:callback(
		function()
			cm:force_add_skill(cm:char_lookup_str(bohemond), "wh_main_skill_brt_grail_vow");
		end,
		1
	);













	-- Rogue Armies
	local jerrod = cm:get_faction("wh2_main_rogue_jerrods_errantry"):faction_leader():command_queue_index();
	
	cm:add_agent_experience(cm:char_lookup_str(jerrod), 4200);
	
	Rogue_Armies();




	Vanilla_Norsca();






	Starting_Units_Kraka_Drak();

	Starting_Units_New_World_Colonies();

	Starting_Units_Jagged_Horn();
	
	Starting_Units_Nordland();
	
	Starting_Units_Norsca();

	Starting_Units_Clan_Eshin();

	Starting_Units_Hochland();

	Starting_Units_The_Brass_Legion();

	Starting_Units_The_Cabal();

	Starting_Units_Konquata();

	if cm:get_faction("wh_main_emp_empire_separatists"):is_dead() then
		out("017 - Starting_Units_Reikland_Secessionists - DISABLED");
	else
		Starting_Units_Reikland_Secessionists();
	end


	local trade = "trade agreement,break trade";

	-- Greenskins can now trade
	cm:force_diplomacy("culture:wh_main_grn_greenskins", "all", trade, true, true, true);

	-- Norsca can now declare war on each other
	cm:force_diplomacy("subculture:wh_main_sc_nor_norsca", "subculture:wh_main_sc_nor_norsca", "war", true, true, true);





	-- Wood Elves and Beastmen are at war and cannot make peace
	cm:force_diplomacy("culture:wh_dlc05_wef_wood_elves", "culture:wh_dlc03_bst_beastmen", "all", false, false, true);
	cm:force_diplomacy("culture:wh_dlc05_wef_wood_elves", "culture:wh_dlc03_bst_beastmen", "war", true, true, true);









	cm:force_make_trade_agreement("wh_main_teb_border_princes", "wh_main_teb_estalia");
	cm:force_make_trade_agreement("wh_main_teb_border_princes", "wh_main_teb_tilea");
	cm:force_make_trade_agreement("wh_main_teb_estalia", "wh_main_teb_tilea");



	cm:force_make_trade_agreement("wh_main_teb_estalia", "wh2_main_emp_new_world_colonies");
	cm:force_make_trade_agreement("wh_main_teb_tilea", "wh2_main_emp_new_world_colonies");

	cm:make_diplomacy_available("wh_main_teb_estalia", "wh2_main_emp_new_world_colonies");
	cm:make_diplomacy_available("wh_main_teb_tilea", "wh2_main_emp_new_world_colonies");

	cm:force_make_trade_agreement("wh2_main_emp_new_world_colonies", "wh2_main_nor_skeggi");







	local cultures_trade_available = {
		"wh_main_brt_bretonnia",
		"wh_main_dwf_dwarfs",
		"wh_main_emp_empire",
		"wh_main_vmp_vampire_counts",
		"wh2_dlc09_tmb_tomb_kings",
		"wh2_main_hef_high_elves",
		"wh2_main_def_dark_elves",
		"wh2_main_lzd_lizardmen",
		"wh2_main_rogue"
	};
	
	-- Bowmen of Oreon can always trade
	for i = 1, #cultures_trade_available do
		cm:force_diplomacy("faction:wh2_main_wef_bowmen_of_oreon", "culture:" .. cultures_trade_available[i], "trade agreement", true, true, true);
	end;
	
	-- Always allow Confederation for Oreon
	cm:force_diplomacy("faction:wh2_main_wef_bowmen_of_oreon", "culture:wh_dlc05_wef_wood_elves", "form confederation", true, false, false);






	if not (cm:get_faction("wh_main_ksl_kislev"):is_human() or cm:get_faction("wh_main_ksl_erengrad"):is_human()) then
		cm:force_make_trade_agreement("wh_main_ksl_erengrad", "wh_main_ksl_kislev");
	end




	-- If Wissenland is human (but Reikland is not) then have them be at war with the Reikland Secessionists and unable to make peace
	if not cm:get_faction("wh_main_emp_empire_separatists"):is_human() then
		if not cm:get_faction("wh_main_emp_empire"):is_human() and cm:get_faction("wh_main_emp_wissenland"):is_human() then
			cm:force_make_peace("wh_main_emp_empire", "wh_main_emp_empire_separatists");
		else
			cm:force_make_peace("wh_main_emp_empire_separatists", "wh_main_emp_wissenland");
			cm:transfer_region_to_faction("wh_main_wissenland_wissenburg", "wh_main_emp_wissenland");
		end
	end




	if cm:get_faction("wh2_dlc09_tmb_the_sentinels"):is_human() then
		cm:force_diplomacy("faction:wh2_dlc09_tmb_the_sentinels", "all", "all", true, true, true);
	end









	-- Involve Naggaroth Beastmen in more wars from the start to lessen their devastation



	-- The Crooked Moon Mutinous Gits can never ask Crooked Moon for peace
	cm:force_diplomacy("faction:wh_main_grn_necksnappers", "faction:wh_main_grn_crooked_moon", "peace", false, false, true);




	-- If the More Vanilla mod is in use
	if cm:get_saved_value("Faction_Unlocker_Vanilla") then
		-- Revert Karak Azgaraz and Skarsnik to Vanilla
		cm:kill_character(cm:get_faction("wh2_main_skv_clan_fester"):faction_leader():cqi(), true, true);
		
		cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_azgaraz:0", "wh2_main_skv_settlement_minor_2");
		cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_azgaraz:1", "wh2_main_skv_clanrats_1");
		cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_azgaraz:2", "wh2_dlc09_tmb_resource_obsidian_1");
		
		cm:transfer_region_to_faction("wh_main_southern_grey_mountains_karak_azgaraz", "wh_main_grn_crooked_moon");
		cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_grn_necksnappers");

		cm:teleport_to("faction:wh_main_grn_crooked_moon,forename:2147358016", 471, 406, true);
		cm:teleport_to("faction:wh_main_grn_crooked_moon,forename:2147344448", 467, 405, true);
	end
	
	-- Give Clan Krizzor an early enemy army
	bloody_spearz_army = {
		["agent_subtype"] = "dlc06_grn_night_goblin_warboss",
		["forename"] = "names_name_2147344811",
		["family_name"] = "names_name_2147344839",
		["faction"] = "wh_main_grn_bloody_spearz",
		["faction_leader"] = false,
		["x_coordinate"] = 771,
		["y_coordinate"] = 438,
		["army_units"] = "wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz"
	}
	
	spawn_unique_character(bloody_spearz_army);
	
	out("018 - Bloody Spearz Extra Army");










	-- Kill Skeggi secondary army
	cm:kill_character(Get_Character("names_name_1060172250", "wh2_main_nor_skeggi"):cqi(), true, true);

	-- Hexoatl early enemy army
	clan_spittel_fallen_gates_army = {
		["id"] = "clan_spittel_fallen_gates_army",
		["agent_subtype"] = "wh2_main_skv_warlord",
		["forename"] = "names_name_2147360594",
		["family_name"] = "",
		["faction"] = "wh2_main_skv_clan_spittel",
		["faction_leader"] = false,
		["x_coordinate"] = 25,
		["y_coordinate"] = 308,
		["army_units"] = "wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_1,wh2_main_skv_inf_poison_wind_globadiers,wh2_main_skv_inf_skavenslave_slingers_0,wh2_main_skv_inf_skavenslaves_0"
	}
	
	spawn_unique_character(clan_spittel_fallen_gates_army);
	
	out("018 - Bloody Spearz Extra Army");



	clan_spittel_macu_peaks_army = {
		["id"] = "clan_spittel_macu_peaks_army",
		["agent_subtype"] = "wh2_main_skv_grey_seer_ruin",
		["forename"] = "names_name_1864128342",
		["family_name"] = "",
		["faction"] = "wh2_main_skv_clan_spittel",
		["faction_leader"] = false,
		["x_coordinate"] = 22,
		["y_coordinate"] = 272,
		["army_units"] = "wh2_main_skv_art_warp_lightning_cannon,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_gutter_runner_slingers_0"
	}
	
	spawn_unique_character(clan_spittel_macu_peaks_army);
	
	out("018 - Bloody Spearz Extra Army");














		-- Kill Clan Fester
		if cm:get_faction("wh_main_grn_crooked_moon"):is_human() or cm:get_faction("wh_main_grn_necksnappers"):is_human() then
			cm:kill_character(cm:get_faction("wh2_main_skv_clan_fester"):faction_leader():cqi(), true, true);
			
			cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_azgaraz:0", "wh2_main_skv_settlement_minor_2");
			cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_azgaraz:1", "wh2_main_skv_clanrats_1");
			cm:instantly_dismantle_building("wh_main_southern_grey_mountains_karak_azgaraz:2");
			
			cm:transfer_region_to_faction("wh_main_southern_grey_mountains_karak_azgaraz", "wh_main_grn_crooked_moon");
			cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_grn_necksnappers");
			
			cm:teleport_to("faction:wh_main_grn_crooked_moon,forename:2147358016", 471, 406, true);
			cm:teleport_to("faction:wh_main_grn_crooked_moon,forename:2147344448", 467, 405, true);
		else
		-- Move Skarsnik to Karak Eight Peaks
			cm:kill_character(cm:get_faction("wh_main_grn_necksnappers"):faction_leader():cqi(), true, true);
			
			cm:force_make_peace("wh_main_dwf_karak_norn", "wh_main_grn_crooked_moon");
		end
		
		
		
		clan_krizzor_army = {
			["id"] = "clan_krizzor_army",
			["agent_subtype"] = "wh2_main_skv_warlord",
			["forename"] = "names_name_1681752719",
			["family_name"] = "names_name_2147360732",
			["faction"] = "wh2_main_skv_clan_krizzor",
			["faction_leader"] = false,
			["x_coordinate"] = 769,
			["y_coordinate"] = 484,
			["army_units"] = "wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_skavenslave_slingers_0,wh2_main_skv_inf_skavenslave_spearmen_0,wh2_main_skv_inf_skavenslaves_0,wh2_main_skv_inf_skavenslaves_0"
		}
		
		spawn_unique_character(clan_krizzor_army);














	cm:remove_unit_from_character("faction:wh_main_grn_skull-takerz,forename:991056", "wh_main_grn_cav_savage_orc_boar_boyz");
	cm:remove_unit_from_character("faction:wh_main_grn_skull-takerz,forename:991056", "wh_main_grn_inf_savage_orcs");





	if not (cm:get_faction("wh_main_emp_empire"):is_human() or cm:get_faction("wh_main_emp_empire_separatists"):is_human()) then
		cm:instantly_upgrade_building("wh_main_reikland_eilhart:1", "wh_main_emp_farm_basic_1");
		
		cm:teleport_to("faction:wh_main_emp_empire_separatists,forename:2147344050", 509, 433, true);
	end


	cm:force_make_trade_agreement("wh2_main_dwf_greybeards_prospectors", "wh2_main_emp_sudenburg");





	-- As long as Hexoatl is owned by a Lizardman faction, apply this effect bundle
	-- Compensates for the loss of two +1 recruitment capacity that would have been possible in the Skeggi province
	core:add_listener(
		"Hexoatl_Recruitment_Compensation",
		"FactionTurnStart",
		true,
		function(context) Hexoatl_Recruitment_Compensation() end,
		true
	);





	-- Karak Izor Ghosts Immortality
	cm:set_character_immortality(cm:char_lookup_str(Get_Character("names_name_2147358979", "wh_main_dwf_karak_izor")), true);	-- King Lunn Ironhammer
	cm:set_character_immortality(cm:char_lookup_str(Get_Character("names_name_2147358988", "wh_main_dwf_karak_izor")), true);	-- Throni Ironbrow
	
	if cm:get_faction("wh_main_dwf_karak_izor"):is_human() then
		cm:set_character_immortality(cm:char_lookup_str(Get_Character("names_name_2147359003", "wh_main_dwf_karak_izor")), true);	-- Dramar Hammerfist
		cm:set_character_immortality(cm:char_lookup_str(Get_Character("names_name_2147358982", "wh_main_dwf_karak_izor")), true);	-- Halkenhaf Stonebeard
	end







	-- Lost Holds - Karak Zank & Karak Zorn Building / Unit Unlocking Mechanic
	cm:add_event_restricted_building_record_for_faction("wh_main_dwf_workshop_2", "wh2_main_dwf_spine_of_sotek_dwarfs");
	cm:add_event_restricted_building_record_for_faction("wh_main_dwf_workshop_3", "wh2_main_dwf_spine_of_sotek_dwarfs");
	cm:add_event_restricted_building_record_for_faction("wh_main_dwf_workshop_4", "wh2_main_dwf_spine_of_sotek_dwarfs");
	
	cm:add_event_restricted_unit_record_for_faction("wh_dlc06_dwf_inf_bugmans_rangers_0", "wh2_main_dwf_spine_of_sotek_dwarfs");
	cm:add_event_restricted_unit_record_for_faction("wh_main_dwf_inf_ironbreakers", "wh2_main_dwf_spine_of_sotek_dwarfs");
	cm:add_event_restricted_unit_record_for_faction("wh_main_dwf_inf_miners_1", "wh2_main_dwf_spine_of_sotek_dwarfs");
	
	
	cm:add_event_restricted_building_record_for_faction("wh_main_dwf_workshop_2", "wh2_main_dwf_karak_zorn");
	cm:add_event_restricted_building_record_for_faction("wh_main_dwf_workshop_3", "wh2_main_dwf_karak_zorn");
	cm:add_event_restricted_building_record_for_faction("wh_main_dwf_workshop_4", "wh2_main_dwf_karak_zorn");
	
	cm:add_event_restricted_unit_record_for_faction("wh_dlc06_dwf_inf_bugmans_rangers_0", "wh2_main_dwf_karak_zorn");
	cm:add_event_restricted_unit_record_for_faction("wh_main_dwf_inf_ironbreakers", "wh2_main_dwf_karak_zorn");
	cm:add_event_restricted_unit_record_for_faction("wh_main_dwf_inf_miners_1", "wh2_main_dwf_karak_zorn");
	
	
	

	
	end
	-- End of is_new_game

	cm:callback(
		function()
			cm:disable_event_feed_events(false, "wh_event_category_character", "", "");
			cm:disable_event_feed_events(false, "wh_event_category_conquest", "", "");
			cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
			cm:disable_event_feed_events(false, "wh_event_category_faction", "", "");
			cm:disable_event_feed_events(false, "wh_event_category_provinces", "", "");
		end,
		1
	);



	core:add_listener(
		"Lost_Holds",
		"IncidentOccuredEvent",
		function(context) return context:dilemma() == "wh2_main_incident_lost_hold_technology" end,
		function(context) Lost_Holds() end,
		true				-- Keep at true to make sure it continues to work for the other faction if one has achieved the trade route
	);



	core:add_listener(
		"The_Brass_Legion_Dilemma_Choice",
		"DilemmaChoiceMadeEvent",
		function(context) return context:dilemma() == "wh_main_dilemma_the_brass_legion" end,
		function(context)
			local choice = context:choice();
			
			if choice == 1 then
				Kill_All_Characters_of_Faction("wh_main_chs_the_brass_legion");
				cm:transfer_region_to_faction("wh_main_hochland_brass_keep", "wh_main_emp_hochland");
				cm:instantly_upgrade_building("wh_main_hochland_brass_keep:1", "wh_main_emp_resource_dyes_1");
			end
		end,
		false
	);
	
	core:add_listener(
		"Brass_Keep",
		"BuildingCompleted",
		true,
		function(context) The_Brass_Legion_Horde_Unlock() end,
		true
	);









	core:add_listener(
		"Sarthorael_Norsca_Awakening",
		"FactionLiberated",
		function(context) return cm:model():world():whose_turn_is_it():name() == cm:get_faction("wh_main_chs_chaos_separatists"):name() end,
		function(context) cm:force_make_vassal("wh_main_chs_chaos_separatists", context:faction():name()) end,
		true
	);
end;



--[[	Delay these commands by 0.5 seconds to not trigger the performance monitor breaking cutscenes and causing other strange behaviours
cm:callback(
	function()
	end,
0.5
);	End of the delayed scripts	--]]









function Lost_Holds()
	if cm:model():world():whose_turn_is_it():name() == cm:get_faction("wh2_main_dwf_spine_of_sotek_dwarfs"):name() then
		cm:apply_effect_bundle("wh2_main_bundle_faction_dwf_regiments_of_renown_+1", "wh2_main_dwf_spine_of_sotek_dwarfs", -1);
		
		cm:remove_event_restricted_building_record_for_faction("wh_main_dwf_workshop_2", "wh2_main_dwf_spine_of_sotek_dwarfs");
		cm:remove_event_restricted_building_record_for_faction("wh_main_dwf_workshop_3", "wh2_main_dwf_spine_of_sotek_dwarfs");
		cm:remove_event_restricted_building_record_for_faction("wh_main_dwf_workshop_4", "wh2_main_dwf_spine_of_sotek_dwarfs");
		
		cm:remove_event_restricted_unit_record_for_faction("wh_dlc06_dwf_inf_bugmans_rangers_0", "wh2_main_dwf_spine_of_sotek_dwarfs");
		cm:remove_event_restricted_unit_record_for_faction("wh_main_dwf_inf_ironbreakers", "wh2_main_dwf_spine_of_sotek_dwarfs");
		cm:remove_event_restricted_unit_record_for_faction("wh_main_dwf_inf_miners_1", "wh2_main_dwf_spine_of_sotek_dwarfs");
	elseif cm:model():world():whose_turn_is_it():name() == cm:get_faction("wh2_main_dwf_karak_zorn"):name() then
		cm:apply_effect_bundle("wh2_main_bundle_faction_dwf_regiments_of_renown_+1", "wh2_main_dwf_karak_zorn", -1);
		
		cm:remove_event_restricted_building_record_for_faction("wh_main_dwf_workshop_2", "wh2_main_dwf_karak_zorn");
		cm:remove_event_restricted_building_record_for_faction("wh_main_dwf_workshop_3", "wh2_main_dwf_karak_zorn");
		cm:remove_event_restricted_building_record_for_faction("wh_main_dwf_workshop_4", "wh2_main_dwf_karak_zorn");
		
		cm:remove_event_restricted_unit_record_for_faction("wh_dlc06_dwf_inf_bugmans_rangers_0", "wh2_main_dwf_karak_zorn");
		cm:remove_event_restricted_unit_record_for_faction("wh_main_dwf_inf_ironbreakers", "wh2_main_dwf_karak_zorn");
		cm:remove_event_restricted_unit_record_for_faction("wh_main_dwf_inf_miners_1", "wh2_main_dwf_karak_zorn");
	end
end










function The_Brass_Legion()
	cm:add_event_restricted_building_record_for_faction("_steel_altar_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_altar_2", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_chaos_warriors_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_chaos_warriors_2", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_chaos_warriors_3", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_forge_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_forge_2", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_forge_3", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_khorne_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_khorne_2", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_khorne_3", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_monsters_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_monsters_2", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_monsters_3", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_nurgle_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_nurgle_2", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_nurgle_3", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_rift_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_rift_2", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_slaanesh_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_slaanesh_2", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_tzeentch_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_tzeentch_2", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_tzeentch_3", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("_steel_weapons_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_weapons_2", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_1", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_2", "wh_main_chs_the_brass_legion");

	cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_4", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_5", "wh_main_chs_the_brass_legion");
	cm:add_event_restricted_building_record_for_faction("_steel_main_6", "wh_main_chs_the_brass_legion");
	
	if cm:get_faction("wh_main_chs_the_brass_legion"):is_human() then
		cm:instant_set_building_health_percent("wh_main_hochland_brass_keep", "wh_main_special_settlement_brass_keep", 30);	-- Damage the Brass Keep buildings
		cm:instant_set_building_health_percent("wh_main_hochland_brass_keep", "wh_main_special_brass_keep_barracks", 60);
	else
		local difficulty = cm:model():combined_difficulty_level();							-- Remove the AI Difficulty Growth Bonus
		
		if difficulty == 0 then
			cm:apply_effect_bundle("wh_main_bundle_the_brass_legion_ai_difficulty_growth_bonus_normalization_normal", "wh_main_chs_the_brass_legion", -1);
		elseif difficulty == -1 then
			cm:apply_effect_bundle("wh_main_bundle_the_brass_legion_ai_difficulty_growth_bonus_normalization_hard", "wh_main_chs_the_brass_legion", -1);
		elseif difficulty == -2 then
			cm:apply_effect_bundle("wh_main_bundle_the_brass_legion_ai_difficulty_growth_bonus_normalization_very_hard", "wh_main_chs_the_brass_legion", -1);
		elseif difficulty == -3 then
			cm:apply_effect_bundle("wh_main_bundle_the_brass_legion_ai_difficulty_growth_bonus_normalization_legendary", "wh_main_chs_the_brass_legion", -1);
		else
			cm:apply_effect_bundle("wh_main_bundle_the_brass_legion_ai_difficulty_growth_bonus_normalization_easy", "wh_main_chs_the_brass_legion", -1);
		end
	end
end



function The_Brass_Legion_Horde_Unlock()
	local brass_keep = cm:get_region("wh_main_hochland_brass_keep");
	
	if brass_keep:building_exists("wh_main_special_brass_keep_barracks_3") and brass_keep:building_exists("wh_main_special_brass_keep_monsters_3") and brass_keep:building_exists("wh_main_special_brass_keep_worship_3") then

		cm:remove_event_restricted_building_record_for_faction("_steel_altar_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_altar_2", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_chaos_warriors_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_chaos_warriors_2", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_chaos_warriors_3", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_forge_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_forge_2", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_forge_3", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_khorne_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_khorne_2", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_khorne_3", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_monsters_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_monsters_2", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_monsters_3", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_nurgle_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_nurgle_2", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_nurgle_3", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_rift_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_rift_2", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_slaanesh_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_slaanesh_2", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_tzeentch_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_tzeentch_2", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_tzeentch_3", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("_steel_weapons_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_weapons_2", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_1", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_2", "wh_main_chs_the_brass_legion");
	
		cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_4", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_5", "wh_main_chs_the_brass_legion");
		cm:remove_event_restricted_building_record_for_faction("_steel_main_6", "wh_main_chs_the_brass_legion");
		
		
		
		if player_1:name() == "wh_main_chs_the_brass_legion" then
			cm:show_message_event(
				player_1:name(),
				"event_feed_strings_text_wh_event_feed_string_the_brass_legion_title",
				"event_feed_strings_text_wh_event_feed_string_the_brass_legion_primary_detail",
				"event_feed_strings_text_wh_event_feed_string_the_brass_legion_secondary_detail",
				true,
				595
			);
		elseif player_2:name() == "wh_main_chs_the_brass_legion" then
			cm:show_message_event(
				player_2:name(),
				"event_feed_strings_text_wh_event_feed_string_the_brass_legion_title",
				"event_feed_strings_text_wh_event_feed_string_the_brass_legion_primary_detail",
				"event_feed_strings_text_wh_event_feed_string_the_brass_legion_secondary_detail",
				true,
				595
			);
		end
		
		core:remove_listener("Brass_Keep");
	end
end












function Necrarch_Brotherhood()
	local faction_leader = cm:get_faction("wh2_main_vmp_necrarch_brotherhood"):faction_leader():cqi();
	
	cm:set_character_immortality(cm:char_lookup_str(faction_leader), false);
	
	necrarch_brotherhood = {
		["agent_subtype"] = "wh2_dlc11_vmp_bloodline_necrarch",
		["forename"] = "names_name_2147359170",
		["family_name"] = "",
		["faction"] = "wh2_main_vmp_necrarch_brotherhood",
		["faction_leader"] = true,
		["x_coordinate"] = 706,
		["y_coordinate"] = 47,
		["army_units"] = "wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_mon_dire_wolves"
	}
	
	spawn_unique_character(necrarch_brotherhood);
	
	cm:kill_character(faction_leader, true, true);
	
	out("010 - Necrarch_Brotherhood");
end

function Strygos_Empire()
	local faction_leader = cm:get_faction("wh2_main_vmp_strygos_empire"):faction_leader():cqi();
	
	cm:set_character_immortality(cm:char_lookup_str(faction_leader), false);
	
	strygos_empire = {
		["agent_subtype"] = "wh2_dlc11_vmp_bloodline_strigoi",
		["forename"] = "names_name_2147359177",
		["family_name"] = "",
		["faction"] = "wh2_main_vmp_strygos_empire",
		["faction_leader"] = true,
		["x_coordinate"] = 507,
		["y_coordinate"] = 139,
		["army_units"] = "wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_mon_dire_wolves"
	}
	
	spawn_unique_character(strygos_empire);
	
	cm:kill_character(faction_leader, true, true);
	
	out("010 - Strygos_Empire");
end

function The_Silver_Host()
	local faction_leader = cm:get_faction("wh2_main_vmp_the_silver_host"):faction_leader():cqi();
	
	cm:set_character_immortality(cm:char_lookup_str(faction_leader), false);
	
	the_silver_host = {
		["agent_subtype"] = "wh2_dlc11_vmp_bloodline_lahmian",
		["forename"] = "names_name_1308257256",
		["family_name"] = "names_name_2147351279",
		["faction"] = "wh2_main_vmp_the_silver_host",
		["faction_leader"] = true,
		["x_coordinate"] = 839,
		["y_coordinate"] = 170,
		["army_units"] = "wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_fell_bats"
	}
	
	spawn_unique_character(the_silver_host);
	
	cm:kill_character(faction_leader, true, true);
	
	out("010 - The_Silver_Host");
end
















































function Hexoatl_Recruitment_Compensation()
	hexoatl = cm:get_region("wh2_main_isthmus_of_lustria_hexoatl");
	
	if hexoatl:building_exists("wh2_main_lzd_energy_3") then
		cm:apply_effect_bundle_to_region("wh2_main_bundle_hexoatl_recruitment_compensation_+1", "wh2_main_isthmus_of_lustria_hexoatl", -1);
		cm:set_saved_value("Hexoatl_Recruitment_Compensation_+1", true);
	elseif hexoatl:building_exists("wh2_main_lzd_energy_4") then
		cm:apply_effect_bundle_to_region("wh2_main_bundle_hexoatl_recruitment_compensation_+1", "wh2_main_isthmus_of_lustria_hexoatl", -1);
		cm:set_saved_value("Hexoatl_Recruitment_Compensation_+1", true);
	elseif hexoatl:building_exists("wh2_main_lzd_energy_5") then
		cm:apply_effect_bundle_to_region("wh2_main_bundle_hexoatl_recruitment_compensation_+2", "wh2_main_isthmus_of_lustria_hexoatl", -1);
		cm:set_saved_value("Hexoatl_Recruitment_Compensation_+2", true);
	else
		if cm:get_saved_value("Hexoatl_Recruitment_Compensation_+1") then
			remove_effect_bundle_from_region("wh2_main_bundle_hexoatl_recruitment_compensation_+1", "wh2_main_isthmus_of_lustria_hexoatl");
		elseif cm:get_saved_value("Hexoatl_Recruitment_Compensation_+2") then
			remove_effect_bundle_from_region("wh2_main_bundle_hexoatl_recruitment_compensation_+2", "wh2_main_isthmus_of_lustria_hexoatl");		
		end
	end
end





function Restrict_Skeggi_Units()
	local units = {
		"wh_dlc08_nor_cha_fimir_balefiend_fire_0",
		"wh_dlc08_nor_cha_fimir_balefiend_shadow_0",
		"wh_main_nor_cha_marauder_chieftan_3",
		"wh_dlc08_nor_feral_manticore",
		"wh_dlc08_nor_mon_fimir_0",
		"wh_dlc08_nor_mon_fimir_1",
		"wh_dlc08_nor_mon_frost_wyrm_0",
		"wh_dlc08_nor_mon_frost_wyrm_ror_0",
		"wh_dlc08_nor_mon_norscan_ice_trolls_0",
		"wh_dlc08_nor_mon_war_mammoth_0",
		"wh_dlc08_nor_mon_war_mammoth_1",
		"wh_dlc08_nor_mon_war_mammoth_2",
		"wh_dlc08_nor_mon_war_mammoth_ror_1",
		"wh_dlc08_nor_mon_warwolves_0",
		"wh_dlc08_nor_veh_marauder_warwolves_chariot_0"
	}
	
	for i = 1, #units do
		local unit = units[i];
		
		cm:add_event_restricted_unit_record_for_faction(unit, "wh2_main_nor_skeggi");
	end
	
	
	
	cm:add_event_restricted_building_record_for_faction("wh_main_nor_chaos_1", "wh2_main_nor_skeggi");
	
	cm:add_event_restricted_building_record_for_faction("wh_main_nor_creatures_1", "wh2_main_nor_skeggi");
	cm:add_event_restricted_building_record_for_faction("wh_main_nor_creatures_2", "wh2_main_nor_skeggi");
	cm:add_event_restricted_building_record_for_faction("wh_main_nor_creatures_3", "wh2_main_nor_skeggi");
end









function Focus_Starting_Cameras()
	-- Scroll Camera to Capital
	local factions = {
		"wh_main_brt_artois",
		"wh_main_brt_bastonne",
		"wh_main_brt_lyonesse",
		"wh_main_brt_parravon",
		"wh_dlc03_bst_jagged_horn",
		"wh_dlc03_bst_redhorn",
		"wh_main_chs_chaos_separatists",
		"wh_main_chs_the_brass_legion",
		"wh_main_dwf_barak_varr",
		"wh_main_dwf_karak_azul",
		"wh_main_dwf_karak_hirn",
		"wh_main_dwf_karak_norn",
		"wh_main_dwf_karak_ziflin",
		"wh_main_dwf_kraka_drak",
		"wh_main_dwf_zhufbar",
		"wh_main_emp_averland",
		"wh_main_emp_empire_separatists",
		"wh_main_emp_hochland",
		"wh_main_emp_marienburg",
		"wh_main_emp_middenland",
		"wh_main_emp_nordland",
		"wh_main_emp_ostermark",
		"wh_main_emp_ostland",
		"wh_main_emp_stirland",
		"wh_main_emp_talabecland",
		"wh_main_emp_wissenland",
		"wh_main_grn_black_venom",
		"wh_main_grn_bloody_spearz",
		"wh_main_grn_broken_nose",
		"wh_main_grn_necksnappers",
		"wh_main_grn_red_eye",
		"wh_main_grn_red_fangs",
		"wh_main_grn_scabby_eye",
		"wh_main_grn_skullsmasherz",
		"wh_main_grn_skull-takerz",
		"wh_main_grn_teef_snatchaz",
		"wh_main_grn_top_knotz",
		"wh_main_ksl_erengrad",
		"wh_main_ksl_kislev",
		"wh_main_nor_aesling",
		"wh_main_nor_baersonling",
		"wh_main_nor_bjornling",
		"wh_main_nor_graeling",
		"wh_main_nor_skaeling",
		"wh_main_nor_varg",
		"wh_main_teb_bilbali",
		"wh_main_teb_lichtenburg_confederacy",
		"wh_main_teb_luccini",
		"wh_main_teb_tilea",
		"wh_main_teb_tobaro",
		"wh_main_vmp_mousillon",
		"wh_main_vmp_rival_sylvanian_vamps",
		"wh_dlc05_wef_torgovann",
		"wh_dlc05_wef_wydrioth",
		"wh2_main_brt_bregonne",
		"wh2_main_brt_knights_of_origo",
		"wh2_main_brt_knights_of_the_flame",
		"wh2_main_brt_thegans_crusaders",
		"wh2_main_bst_blooded_axe",
		"wh2_main_bst_manblight",
		"wh2_main_bst_ripper_horn",
		"wh2_main_bst_shadowgor",
		"wh2_main_chs_the_cabal",
		"wh2_dlc11_cst_vampire_coast_rebels",
		"wh2_main_def_bleak_holds",
		"wh2_main_def_blood_hall_coven",
		"wh2_main_def_clar_karond",
		"wh2_main_def_cult_of_excess",
		"wh2_main_def_deadwood_sentinels",
		"wh2_main_def_ghrond",
		"wh2_main_def_hag_graef",
		"wh2_main_def_karond_kar",
		"wh2_main_def_scourge_of_khaine",
		"wh2_main_def_ssildra_tor",
		"wh2_main_def_the_forgebound",
		"wh2_main_dwf_greybeards_prospectors",
		"wh2_main_dwf_karak_zorn",
		"wh2_main_dwf_spine_of_sotek_dwarfs",
		"wh2_main_emp_new_world_colonies",
		"wh2_main_emp_sudenburg",
		"wh2_main_grn_arachnos",
		"wh2_main_grn_blue_vipers",
		"wh2_main_hef_caledor",
		"wh2_main_hef_chrace",
		"wh2_main_hef_cothique",
		"wh2_main_hef_ellyrion",
		"wh2_main_hef_saphery",
		"wh2_main_hef_tiranoc",
		"wh2_main_hef_yvresse",
		"wh2_main_lzd_itza",
		"wh2_main_lzd_konquata",
		"wh2_main_lzd_sentinels_of_xeti",
		"wh2_main_lzd_teotiqua",
		"wh2_main_lzd_tlaxtlan",
		"wh2_main_lzd_xlanhuapec",
		"wh2_main_nor_aghol",
		"wh2_main_nor_mung",
		"wh2_main_nor_skeggi",
		"wh2_main_skv_clan_eshin",
		"wh2_main_skv_clan_ferrik",
		"wh2_main_skv_clan_fester",
		"wh2_main_skv_clan_gnaw",
		"wh2_main_skv_clan_krizzor",
		"wh2_main_skv_clan_mordkin",
		"wh2_main_skv_clan_moulder",
		"wh2_main_skv_clan_septik",
		"wh2_main_skv_clan_skyre",
		"wh2_main_skv_clan_spittel",
		"wh2_main_skv_clan_volkn",
		"wh2_dlc09_tmb_dune_kingdoms",
		"wh2_dlc09_tmb_numas",
		"wh2_dlc09_tmb_rakaph_dynasty",
		"wh2_dlc09_tmb_the_sentinels",
		"wh2_main_vmp_necrarch_brotherhood",
		"wh2_main_vmp_strygos_empire",
		"wh2_main_vmp_the_silver_host",
		"wh2_main_wef_bowmen_of_oreon"
	}
	
	for i = 1, #factions do
		local faction = cm:get_faction(factions[i]);
		
		if faction:is_human() then
			local faction_leader_cqi = player_1:faction_leader():command_queue_index();
			
			cm:scroll_camera_with_cutscene_to_character(6, nil, faction_leader_cqi);
			
			out("008 - Focus_Starting_Cameras");
		end
	end
end








-- Adding to Chaos script causes a crash upon save game loading

function Kill_Archaon_and_Sarthorael()
	local chaos = cm:get_faction("wh_main_chs_chaos");
	local archaon = chaos:faction_leader():command_queue_index();
	local chaos_separatists = cm:get_faction("wh_main_chs_chaos_separatists");
	local sarthorael = chaos_separatists:faction_leader():command_queue_index();
	
	if not chaos:is_human() and not chaos_separatists:is_human() then
		cm:kill_character(archaon, true, true);
		
		out("010 - Kill_Archaon_and_Sarthorael - 01");
	end
	
	if not chaos_separatists:is_human() then
		cm:add_agent_experience(cm:char_lookup_str(sarthorael), 66700);
		cm:kill_character(sarthorael, true, true);
		
		out("010 - Kill_Archaon_and_Sarthorael - 02");
	end
end





function Kill_The_Cabal()
	local faction = cm:get_faction("wh2_main_chs_the_cabal");
	local faction_leader = faction:faction_leader():command_queue_index();
	
	if not faction:is_human() then
		cm:kill_character(faction_leader, true, true);
		
		out("010 - Kill_The_Cabal");
	end
end







function Rogue_Armies()
	local factions = {
		"wh2_main_rogue_abominations",
		"wh2_main_rogue_beastcatchas",
		"wh2_main_rogue_bernhoffs_brigands",
		"wh2_main_rogue_black_spider_tribe",
		"wh2_main_rogue_boneclubbers_tribe",
		"wh2_main_rogue_celestial_storm",
		"wh2_main_rogue_college_of_pyrotechnics",
		"wh2_main_rogue_def_chs_vashnaar",
		"wh2_main_rogue_def_mengils_manflayers",
		"wh2_main_rogue_doomseekers",
		"wh2_main_rogue_gerhardts_mercenaries",
		"wh2_main_rogue_hef_tor_elithis",
		"wh2_main_rogue_hung_warband",
		"wh2_main_rogue_jerrods_errantry",
		"wh2_main_rogue_mangy_houndz",
		"wh2_main_rogue_morrsliebs_howlers",
		"wh2_main_rogue_pirates_of_the_far_sea",
		"wh2_main_rogue_pirates_of_the_southern_ocean",
		"wh2_main_rogue_pirates_of_trantio",
		"wh2_main_rogue_scions_of_tesseninck",
		"wh2_main_rogue_scourge_of_aquitaine",
		"wh2_main_rogue_stuff_snatchers",
		"wh2_main_rogue_teef_snatchaz",
		"wh2_main_rogue_the_wandering_dead",
		"wh2_main_rogue_troll_skullz",
		"wh2_main_rogue_vauls_expedition",
		"wh2_main_rogue_vmp_heirs_of_mourkain",
		"wh2_main_rogue_wef_hunters_of_kurnous",
		"wh2_main_rogue_worldroot_rangers",
		"wh2_main_rogue_wrath_of_nature"
	}
	
	for i = 1, #factions do
		local faction = cm:get_faction(factions[i]);
		local faction_leader_cqi = faction:faction_leader():command_queue_index();
		
		cm:force_diplomacy(factions[i], "all", "vassal", true, true, false);
		
		if faction:is_human() then
			if not cm:is_multiplayer() then
				cm:scroll_camera_with_cutscene_to_character(6, nil, faction_leader_cqi);
			end
			
			out("012 - Rogue_Armies");
		else
			cm:kill_character(faction_leader_cqi, true, true);
			
			out("012 - Rogue_Armies - KILLED");
		end
	end
end

function Vanilla_Norsca()
	local factions = {
		"wh_dlc08_nor_goromadny_tribe",
		"wh_dlc08_nor_helspire_tribe",
		"wh_dlc08_nor_naglfarlings",
		"wh_dlc08_nor_vanaheimlings"
	}
	
	for i = 1, #factions do
		local faction = cm:get_faction(factions[i]);
		local faction_leader_cqi = faction:faction_leader():command_queue_index();
		
		cm:kill_character(faction_leader_cqi, true, true);
			
		out("013 - Vanilla Norsca - KILLED");
	end
end













function Starting_Buildings()
	cm:instantly_upgrade_building("wh_main_the_wasteland_marienburg:0", "wh_main_emp_settlement_major_2_coast");
	
	cm:instantly_upgrade_building("wh_main_eastern_border_princes_matorca:2", "wh_main_emp_resource_salt_1");
	
	cm:instantly_upgrade_building("wh_main_northern_grey_mountains_karak_ziflin:0", "wh_main_dwf_settlement_minor_2");
	
	out("007 - Starting_Buildings");
end










function Southern_Realms_Start()
	local border_princes = cm:get_faction("wh_main_teb_border_princes");
	local estalia = cm:get_faction("wh_main_teb_estalia");
	local tilea = cm:get_faction("wh_main_teb_tilea");
	local new_world_colonies = cm:get_faction("wh2_main_emp_new_world_colonies");
	
	if border_princes:is_human() then
		if cm:general_with_forename_exists_in_faction_with_force("wh_main_teb_border_princes", "names_name_997012") then
			-- Gashnag the Black Prince
			local gashnag = Get_Character("names_name_997012", "wh_main_teb_border_princes"):command_queue_index();
			
			cm:scroll_camera_with_cutscene_to_character(6, end_callback, gashnag);
			
			out("011 - Southern_Realms_Start - Border Princes - Gashnag - 01");
		else
			cm:teleport_to("faction:wh_main_teb_border_princes,forename:991068", 546, 251, true);
			
			cm:scroll_camera_with_cutscene_to_settlement(6, end_callback, "wh_main_western_border_princes_myrmidens");
			
			out("011 - Southern_Realms_Start - Border Princes - Valmir");
		end
--	else
--		cm:teleport_to("faction:wh_main_teb_border_princes,forename:991068", 546, 251, true);					-- Breaks Campaign Start Zoom
	end
	
	
	
	if estalia:is_human() then
		cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
		
		if cm:general_with_forename_exists_in_faction_with_force("wh_main_teb_estalia", "names_name_997014") then
			-- Lucrezzia Belladonna
			local tobaro_faction_leader_cqi = cm:get_faction("wh_main_teb_tobaro"):faction_leader():command_queue_index();
			
			cm:kill_character(tobaro_faction_leader_cqi, true, true);
			
			
			cm:teleport_to("faction:wh_main_teb_estalia,forename:997014", 434, 255, true);
			
			cm:transfer_region_to_faction("wh_main_estalia_tobaro", "wh_main_teb_estalia");
			cm:transfer_region_to_faction("wh_main_estalia_magritta", "wh_main_teb_magritta");
			
			cm:scroll_camera_with_cutscene_to_settlement(6, end_callback, "wh_main_estalia_tobaro");
			
			
			cm:force_declare_war("wh_main_teb_estalia", "wh_main_grn_broken_nose", true, true);
			
			
			local character = Get_Character("names_name_997014", "wh_main_teb_estalia");
			
			cm:remove_unit_from_character(cm:char_lookup_str(character), "wh_main_teb_cha_captain_0");
			
			out("011 - Southern_Realms_Start - Estalia - Lucrezzia");
		else
			cm:scroll_camera_with_cutscene_to_settlement(6, end_callback, "wh_main_estalia_magritta");
			
			out("011 - Southern_Realms_Start - Estalia - Lupio");
		end
		
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "") end, 1);
	end
	
	
	
	-- Borgio the Besieger
	if tilea:is_human() and cm:general_with_forename_exists_in_faction_with_force("wh_main_teb_tilea", "names_name_997016") then
		local character = Get_Character("names_name_997016", "wh_main_teb_tilea");
		
		cm:remove_unit_from_character(cm:char_lookup_str(character), "wh_main_teb_cha_captain_0");
	end
	
	
	
	if cm:get_saved_value("Cataph_TEB") then
		-- AI Legendary Lord Unlocks
		Unlock_TEB_Lords();
		
		if cm:general_with_forename_exists_in_faction_with_force("wh2_main_emp_new_world_colonies", "names_name_992002") then
			-- Marco Colombo
			local character = Get_Character("names_name_992002", "wh2_main_emp_new_world_colonies");
			
			cm:remove_unit_from_character(cm:char_lookup_str(character), "wh_main_emp_inf_crossbowmen");
			cm:remove_unit_from_character(cm:char_lookup_str(character), "wh_main_emp_inf_spearmen_0");
			cm:remove_unit_from_character(cm:char_lookup_str(character), "wh_main_emp_inf_swordsmen");
		else
			-- El Cadavo
			local character = Get_Character("names_name_992004", "wh2_main_emp_new_world_colonies");
			
			cm:remove_unit_from_character(cm:char_lookup_str(character), "wh_main_emp_inf_crossbowmen");
			cm:remove_unit_from_character(cm:char_lookup_str(character), "wh_main_emp_inf_swordsmen");
		end
	end
	
	
	
	-- Kill Magritta? Kill Lucrezzia's Captain?
	if not cm:general_with_forename_exists_in_faction_with_force("wh_main_teb_estalia", "names_name_997014") then
		cm:kill_character(cm:get_faction("wh_main_teb_magritta"):faction_leader():cqi(), true, false);
		
		cm:kill_character(Get_Character("names_name_999002", "wh_main_teb_estalia"):cqi(), true, false);
		
		out("011 - Southern_Realms_Start - 01");
	end
	
	
	
	-- If Gashnag is the starting general, spawn Broken Nose Raiders
	if cm:general_with_forename_exists_in_faction_with_force("wh_main_teb_border_princes", "names_name_997012") and cm:get_faction("wh_main_grn_broken_nose"):is_human() == false then
		broken_nose_raiders = {
			["agent_subtype"] = "grn_goblin_great_shaman",
			["forename"] = "names_name_2147344531",
			["family_name"] = "",
			["faction"] = "wh_main_grn_broken_nose",
			["faction_leader"] = false,
			["x_coordinate"] = 525,
			["y_coordinate"] = 275,
			["army_units"] = "wh_main_grn_cav_goblin_wolf_chariot,wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_goblin_spearmen,wh_main_grn_inf_night_goblin_archers,wh_main_grn_inf_night_goblins"
		}
		
		spawn_unique_character(broken_nose_raiders);
		
		cm:force_declare_war("wh_main_teb_border_princes", "wh_main_grn_broken_nose", true, true);
		
		out("011 - Southern_Realms_Start - Border Princes - Gashnag - 02");
	end
	
	out("011 - Southern_Realms_Start - End");
end








function Sudenburg()
	local sudenburg = cm:get_faction("wh2_main_emp_sudenburg");
	local sudenburg_faction_leader_cqi = sudenburg:faction_leader():command_queue_index();
	
	-- If Sudenburg is not human, kill off and replace Balthasar Gelt with an Arch Lector
	if not sudenburg:is_human() then
		cm:set_character_immortality(cm:char_lookup_str(sudenburg_faction_leader_cqi), false);
		
		cm:kill_character(sudenburg_faction_leader_cqi, true, true);
		
		
		
		sudenburg_faction_leader = {					-- Copy this into the "spawn_unique_character(<-HERE->);"
			["agent_subtype"] = "dlc04_emp_arch_lector",
			["forename"] = "names_name_2147355161",
			["family_name"] = "names_name_2147354625",
			["faction"] = "wh2_main_emp_sudenburg",
			["faction_leader"] = true,				-- true or false	Overwrites default Faction Leader, if this gets changed to a custom agent_subtype, remember to use the porthole fix and modify the tables to add custom voicing on the diplomacy screen
			["experience"] = 0,					-- Optional, custom starting experience as per character_experience_skill_tiers
			["x_coordinate"] = 479,
			["y_coordinate"] = 20,
			["army_units"] = "wh_main_emp_art_mortar,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_1,wh_main_emp_inf_swordsmen,wh_main_emp_inf_swordsmen"			-- Spacing cannot be added
		}
		
		spawn_unique_character(sudenburg_faction_leader);
		
		out("009 - Sudenburg");
	end
	
	out("009 - Sudenburg - DISABLED");
end




function Wissenland()
	cm:kill_character(Get_Character("names_name_991024", "wh_main_emp_empire_separatists"):cqi(), true, false);
	cm:kill_character(Get_Character("names_name_2147344050", "wh_main_emp_empire_separatists"):cqi(), true, false);
	
	cm:transfer_region_to_faction("wh_main_reikland_eilhart", "wh_main_emp_empire");
	
	cm:force_diplomacy("faction:wh_main_emp_wissenland", "faction:wh_main_emp_empire_separatists", "peace", false, false, true);
	cm:force_diplomacy("faction:wh_main_emp_empire_separatists", "faction:wh_main_emp_wissenland", "peace", false, false, true);
	
	out("Wissenland");
end
















































function Remove_Units()
	FACTIONS = {
		"wh_main_brt_artois",
		"wh_main_brt_bastonne",
		"wh_main_brt_lyonesse",
		"wh_main_brt_parravon",
		"wh_main_dwf_barak_varr",
		"wh_main_dwf_karak_azul",
		"wh_main_dwf_karak_hirn",
		"wh_main_dwf_karak_norn",
		"wh_main_dwf_karak_ziflin",
		"wh_main_dwf_kraka_drak",
		"wh_main_dwf_zhufbar",
		"wh_main_emp_hochland",
		"wh_main_emp_wissenland",
		"wh_main_grn_broken_nose",
		"wh_main_grn_top_knotz",
		"wh_main_teb_tilea",
		"wh2_main_dwf_karak_zorn",
		"wh2_main_dwf_spine_of_sotek_dwarfs",
		"wh2_main_emp_sudenburg",
		"wh2_main_skv_clan_eshin",
		"wh2_main_skv_clan_ferrik",
		"wh2_main_skv_clan_fester",
		"wh2_main_skv_clan_moulder",
		"wh2_main_skv_clan_skyre",
	}
	
	UNITS = {}
	
	for i = 1, #FACTIONS do
		local faction = FACTIONS[i];
		local faction_leader_cqi = cm:get_faction(FACTIONS[i]):faction_leader():command_queue_index();
		
		if faction == "wh_main_brt_artois" then
			UNITS = {
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_peasant_bowmen",
				"wh_main_brt_inf_peasant_bowmen"
			}
		
		out("003 - Remove_Units - 01");
		elseif faction == "wh_main_brt_bastonne" then
			UNITS = {
				"wh_main_brt_art_field_trebuchet",
				"wh_dlc07_brt_cha_damsel_life_0",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms"
			}
		
		out("003 - Remove_Units - 02");
		elseif faction == "wh_main_brt_lyonesse" then
			UNITS = {
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_peasant_bowmen"
			}
		
		out("003 - Remove_Units - 03");
		elseif faction == "wh_main_brt_parravon" then
			UNITS = {
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_men_at_arms",
				"wh_main_brt_inf_peasant_bowmen",
				"wh_main_brt_inf_peasant_bowmen"
			}
		
		out("003 - Remove_Units - 04");
		elseif faction == "wh_main_dwf_barak_varr" then
			UNITS = {
				"wh_main_dwf_art_grudge_thrower",
				"wh_main_dwf_inf_thunderers_0",
				"wh_main_dwf_inf_thunderers_0"
			}
		
		out("003 - Remove_Units - 05");
		elseif faction == "wh_main_dwf_karak_azul" then
			UNITS = {
				"wh_main_dwf_cha_rune_smith_0",
				"wh_main_dwf_inf_dwarf_warrior_1",
				"wh_main_dwf_inf_quarrellers_0",
				"wh_main_dwf_inf_thunderers_0"
			}
		
		out("003 - Remove_Units - 06");
		elseif faction == "wh_main_dwf_karak_hirn" then
			UNITS = {
				"wh_main_dwf_art_grudge_thrower",
				"wh_main_dwf_cha_thane",
				"wh_main_dwf_inf_quarrellers_0",
				"wh_main_dwf_inf_quarrellers_0"
			}
		
		out("003 - Remove_Units - 07");
		elseif faction == "wh_main_dwf_karak_norn" then
			UNITS = {
				"wh_main_dwf_art_grudge_thrower",
				"wh_main_dwf_inf_quarrellers_0",
				"wh_main_dwf_inf_quarrellers_0"
			}
		
		out("003 - Remove_Units - 08");
		elseif faction == "wh_main_dwf_karak_ziflin" then
			UNITS = {
				"wh_main_dwf_cha_thane",
				"wh_main_dwf_inf_quarrellers_0",
				"wh_main_dwf_inf_quarrellers_0",
				"wh_main_dwf_inf_thunderers_0"
			}
		
		out("003 - Remove_Units - 09");
		elseif faction == "wh_main_dwf_kraka_drak" then
			UNITS = {
				"wh_main_dwf_art_grudge_thrower",
				"wh_main_dwf_cha_rune_smith_0",
				"wh_main_dwf_inf_dwarf_warrior_0",
				"wh_main_dwf_inf_dwarf_warrior_0",
				"wh_main_dwf_inf_dwarf_warrior_1",
				"wh_main_dwf_inf_thunderers_0",
				"wh_main_dwf_inf_thunderers_0"
			}
		
		out("003 - Remove_Units - 10");
		elseif faction == "wh_main_dwf_zhufbar" then
			UNITS = {
				"wh_main_dwf_cha_master_engineer_0",
				"wh_main_dwf_inf_dwarf_warrior_1",
				"wh_main_dwf_inf_thunderers_0"
			}
		
		out("003 - Remove_Units - 11");
		elseif faction == "wh_main_emp_hochland" then
			UNITS = {
				"wh_main_emp_art_mortar",
				"wh_main_emp_inf_crossbowmen",
				"wh_main_emp_inf_crossbowmen",
				"wh_main_emp_inf_spearmen_0",
				"wh_main_emp_inf_spearmen_0"
			}
		
		out("003 - Remove_Units - 12");
		elseif faction == "wh_main_emp_wissenland" then
			UNITS = {
				"wh_dlc05_emp_cha_wizard_shadows_0"
			}
		
		out("003 - Remove_Units - 12");
		elseif faction == "wh_main_grn_broken_nose" then
			UNITS = {
				"wh_main_grn_inf_orc_boyz",
				"wh_main_grn_inf_orc_boyz",
				"wh_main_grn_inf_orc_boyz"
			}
		
		out("003 - Remove_Units - 13");
		elseif faction == "wh_main_grn_top_knotz" then
			UNITS = {
				"wh_main_grn_inf_goblin_spearmen"
			}
		
		out("003 - Remove_Units - 12");
		elseif faction == "wh_main_teb_tilea" then
			UNITS = {
				"wh_main_teb_cha_captain_0"
			}
		
		out("003 - Remove_Units - 13");
		elseif faction == "wh2_main_dwf_karak_zorn" then
			UNITS = {
				"wh_main_dwf_cha_rune_smith_0",
				"wh_main_dwf_inf_dwarf_warrior_1",
				"wh_main_dwf_inf_dwarf_warrior_1",
				"wh_main_dwf_inf_quarrellers_0",
				"wh_main_dwf_inf_thunderers_0"
			}
		
		out("003 - Remove_Units - 13");
		elseif faction == "wh2_main_dwf_spine_of_sotek_dwarfs" then
			UNITS = {
				"wh_main_dwf_cha_thane"
			}
		
		out("003 - Remove_Units - 13");
		elseif faction == "wh2_main_emp_sudenburg" then
			UNITS = {
				"wh_dlc05_emp_cha_wizard_life_0"
			}
		
		out("003 - Remove_Units - 14");
		elseif faction == "wh2_main_skv_clan_eshin" then
			UNITS = {
				"wh2_main_skv_inf_clanrats_0",
				"wh2_main_skv_inf_skavenslave_slingers_0",
				"wh2_main_skv_inf_skavenslave_slingers_0",
				"wh2_main_skv_inf_skavenslave_spearmen_0",
				"wh2_main_skv_inf_skavenslaves_0",
				"wh2_main_skv_inf_skavenslaves_0",
				"wh2_main_skv_inf_skavenslaves_0",
				"wh2_main_skv_inf_skavenslaves_0",
				"wh2_main_skv_cha_assassin"
			}
		
		out("003 - Remove_Units - 16");
		elseif faction == "wh2_main_skv_clan_ferrik" then
			UNITS = {
				"wh2_main_skv_cha_warlock_engineer"
			}
		
		out("003 - Remove_Units - 15");
		elseif faction == "wh2_main_skv_clan_fester" then
			UNITS = {
				"wh2_main_skv_cha_plague_priest_0"
			}
		
		out("003 - Remove_Units - 16");
		elseif faction == "wh2_main_skv_clan_moulder" then
			UNITS = {
				"wh2_main_skv_inf_clanrats_0",
				"wh2_main_skv_inf_skavenslaves_0",
				"wh2_main_skv_inf_night_runners_1"
			}
		
		out("003 - Remove_Units - 16");
		elseif faction == "wh2_main_skv_clan_skyre" then
			UNITS = {
				"wh2_main_skv_inf_night_runners_1",
				"wh2_main_skv_inf_skavenslave_slingers_0",
				"wh2_main_skv_inf_skavenslaves_0",
				"wh2_main_skv_inf_skavenslaves_0",
				"wh2_main_skv_cha_warlock_engineer"
			}
		
		out("003 - Remove_Units - 16");
		end
		
		for x = 1, #UNITS do
			cm:remove_unit_from_character(cm:char_lookup_str(faction_leader_cqi), UNITS[x]);
		end
	end
end

function Remove_Units_Ungrol_Stoneheart()
	UNITS = {
		"wh_dlc03_bst_inf_ungor_herd_1",
		"wh_dlc03_bst_inf_ungor_raiders_0",
		"wh_dlc03_bst_inf_ungor_spearmen_0",
		"wh_dlc03_bst_inf_ungor_spearmen_0"
	}
	
	local character = Get_Character("names_name_2147357958", "wh_dlc03_bst_redhorn");
	
	for i = 1, #UNITS do
		cm:remove_unit_from_character(cm:char_lookup_str(character), UNITS[i]);
		
		out("004 - Remove_Units_Ungrol_Stoneheart");
	end
end

function Remove_Units_Thorek_Ironbrow()
	UNITS = {
		"wh_main_dwf_cha_rune_smith_0",
		"wh_main_dwf_inf_dwarf_warrior_1",
		"wh_main_dwf_inf_quarrellers_0",
		"wh_main_dwf_inf_thunderers_0"
	}
	
	local character = Get_Character("names_name_997000", "wh_main_dwf_karak_azul");
	
	if cm:general_with_forename_exists_in_faction_with_force("wh_main_dwf_karak_azul", "names_name_997000") then
		for i = 1, #UNITS do
			cm:remove_unit_from_character(cm:char_lookup_str(character), UNITS[i]);
			
			out("005 - Remove_Units_Thorek_Ironbrow");
		end
	end
end

function Remove_Units_Sigvald_the_Magnificent()								-- Only Sigvald because other Chaos Lords have Chaos Warriors removed via startpos
	if cm:general_with_forename_exists_in_faction_with_force("wh_main_chs_chaos", "names_name_2147345922") then
		cm:remove_unit_from_character(cm:char_lookup_str(Get_Character("names_name_2147345922", "wh_main_chs_chaos")), "wh_main_chs_inf_chaos_warriors_0");
		
		out("005 - Remove_Units_Sigvald_the_Magnificent");
	end
end


























function Starting_Units_Kraka_Drak()
	local faction = cm:get_faction("wh_main_dwf_kraka_drak");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	if cm:get_saved_value("Cataph_Kraka_Drak") == true then
		Starting_Units_Thorgard_Cromson(faction_leader_cqi);
		
		out("013 - Starting_Units_Kraka_Drak - Cataph");
	else
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), "wh_main_dwf_inf_dwarf_warrior_0");
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), "wh_main_dwf_inf_longbeards");
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), "wh_main_dwf_inf_longbeards_1");
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), "wh_main_dwf_inf_quarrellers_0");
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), "wh_main_dwf_inf_quarrellers_1");
		
		out("013 - Starting_Units_Kraka_Drak - Vanilla");
	end
end

function Starting_Units_New_World_Colonies()
	local el_cadavo = Get_Character("names_name_992004", "wh2_main_emp_new_world_colonies");
	local marco_colombo = Get_Character("names_name_992002", "wh2_main_emp_new_world_colonies");
	
	if cm:get_saved_value("Cataph_TEB") then
		if cm:general_with_forename_exists_in_faction_with_force("wh2_main_emp_new_world_colonies", "names_name_992002") then
			Starting_Units_Marco_Colombo(marco_colombo);
			
			out("014 - Starting_Units_New_World_Colonies - Cataph - Colombo");
		else
			Starting_Units_El_Cadavo(el_cadavo);
			
			out("014 - Starting_Units_New_World_Colonies - Cataph - El Cadavo");
		end
	else
		cm:remove_unit_from_character(cm:char_lookup_str(el_cadavo), "wh_main_emp_inf_crossbowmen");
		cm:remove_unit_from_character(cm:char_lookup_str(el_cadavo), "wh_main_emp_inf_spearmen_1");
		cm:remove_unit_from_character(cm:char_lookup_str(el_cadavo), "wh_main_emp_inf_swordsmen");
		
		cm:grant_unit_to_character(cm:char_lookup_str(el_cadavo), "wh_main_emp_inf_halberdiers");
		cm:grant_unit_to_character(cm:char_lookup_str(el_cadavo), "wh_main_emp_inf_handgunners");
		cm:grant_unit_to_character(cm:char_lookup_str(el_cadavo), "wh_main_emp_art_mortar");
	end
end

function Starting_Units_Jagged_Horn()
	local jagged_horn = Get_Character("names_name_2147358392", "wh_dlc03_bst_jagged_horn");
	local jagged_horn_cqi = jagged_horn:command_queue_index();
	
	cm:grant_unit_to_character(cm:char_lookup_str(jagged_horn_cqi), "wh_dlc03_bst_inf_ungor_herd_1");
	cm:grant_unit_to_character(cm:char_lookup_str(jagged_horn_cqi), "wh_dlc03_bst_inf_ungor_herd_1");
	cm:grant_unit_to_character(cm:char_lookup_str(jagged_horn_cqi), "wh_dlc03_bst_inf_ungor_raiders_0");
	cm:grant_unit_to_character(cm:char_lookup_str(jagged_horn_cqi), "wh_dlc03_bst_inf_ungor_raiders_0");
	
	out("016 - Starting_Units_Jagged_Horn");
end

function Starting_Units_Nordland()
	local nordland = cm:get_faction("wh_main_emp_nordland");
	local nordland_cqi = nordland:faction_leader():command_queue_index();
	
	cm:remove_unit_from_character(cm:char_lookup_str(nordland_cqi), "wh_main_emp_inf_spearmen_0");
	cm:remove_unit_from_character(cm:char_lookup_str(nordland_cqi), "wh_main_emp_inf_spearmen_0");
	
	cm:grant_unit_to_character(cm:char_lookup_str(nordland_cqi), "wh_dlc04_emp_inf_free_company_militia_0");
	cm:grant_unit_to_character(cm:char_lookup_str(nordland_cqi), "wh_dlc04_emp_inf_free_company_militia_0");
	cm:grant_unit_to_character(cm:char_lookup_str(nordland_cqi), "wh_main_emp_inf_spearmen_1");
	cm:grant_unit_to_character(cm:char_lookup_str(nordland_cqi), "wh_main_emp_inf_spearmen_1");
	cm:grant_unit_to_character(cm:char_lookup_str(nordland_cqi), "wh_main_emp_inf_swordsmen");
	cm:grant_unit_to_character(cm:char_lookup_str(nordland_cqi), "wh_main_emp_inf_swordsmen");
	
	out("016 - Starting_Units_Nordland");
end

function Starting_Units_Reikland_Secessionists()
	local reikland_secessionists = cm:get_faction("wh_main_emp_empire_separatists");
	local reikland_secessionists_cqi = reikland_secessionists:faction_leader():command_queue_index();
	
	cm:grant_unit_to_character(cm:char_lookup_str(reikland_secessionists_cqi), "wh_main_emp_inf_crossbowmen");
	cm:grant_unit_to_character(cm:char_lookup_str(reikland_secessionists_cqi), "wh_main_emp_inf_halberdiers");
	cm:grant_unit_to_character(cm:char_lookup_str(reikland_secessionists_cqi), "wh_main_emp_inf_swordsmen");
	cm:grant_unit_to_character(cm:char_lookup_str(reikland_secessionists_cqi), "wh_main_emp_inf_swordsmen");
	
	out("017 - Starting_Units_Reikland_Secessionists");
end

function Starting_Units_Wissenland()
	UNITS = {
		"wh_main_emp_inf_handgunners",
		"wh_main_emp_inf_handgunners",
		"wh_main_emp_inf_spearmen_0",
		"wh_main_emp_inf_swordsmen",
		"wh_main_emp_inf_swordsmen"
	}
	
	local faction = cm:get_faction("wh_main_emp_wissenland");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	if not faction:is_human() then
		for i = 1, #UNITS do
			cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), UNITS[i]);
			
			out("006 - Starting_Units_Wissenland");
		end
	end
end

function Starting_Units_Norsca()
	UNITS = {
		"wh_dlc08_nor_inf_marauder_berserkers_0",
		"wh_dlc08_nor_inf_marauder_champions_1",
		"wh_dlc08_nor_mon_warwolves_0"
	}
	
	local faction = cm:get_faction("wh_main_nor_skaeling");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	for i = 1, #UNITS do
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), UNITS[i]);
			
		out("006 - Starting_Units_Norsca");
	end
end

function Starting_Units_Clan_Eshin()
	UNITS = {
		"wh2_main_skv_inf_night_runners_0",
		"wh2_main_skv_inf_night_runners_0"
	}
	
	local faction = cm:get_faction("wh2_main_skv_clan_eshin");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	for i = 1, #UNITS do
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), UNITS[i]);
			
		out("006 - Starting_Units_Clan_Eshin");
	end
end

function Starting_Units_Hochland()
	UNITS = {
		"wh_main_emp_inf_spearmen_1",
		"wh_main_emp_inf_swordsmen"
	}
	
	local faction = cm:get_faction("wh_main_emp_hochland");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	for i = 1, #UNITS do
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), UNITS[i]);
			
		out("006 - Starting_Units_Hochland");
	end
end

function Starting_Units_The_Brass_Legion()
	UNITS = {
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_main_chs_inf_chaos_marauders_1"
	}
	
	local faction = cm:get_faction("wh_main_chs_the_brass_legion");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	for i = 1, #UNITS do
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), UNITS[i]);
			
		out("006 - Starting_Units_The_Brass_Legion");
	end
end

function Starting_Units_The_Cabal()
	UNITS = {
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_dlc06_chs_inf_aspiring_champions_0",
		"wh_main_chs_inf_chaos_marauders_0",
		"wh_main_chs_inf_chaos_marauders_1",
		"wh_main_chs_inf_chaos_warriors_0",
		"wh_main_chs_inf_chaos_warriors_1",
		"wh_dlc01_chs_inf_chaos_warriors_2",
		"wh_main_chs_mon_chaos_spawn",
		"wh_main_chs_mon_chaos_warhounds_0"
	}
	
	local faction = cm:get_faction("wh2_main_chs_the_cabal");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	for i = 1, #UNITS do
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), UNITS[i]);
			
		out("006 - Starting_Units_The_Cabal");
	end
end

function Starting_Units_Konquata()
	UNITS = {
		"wh2_main_lzd_cav_cold_ones_feral_0",
		"wh2_main_lzd_inf_saurus_spearmen_1",
		"wh2_main_lzd_inf_saurus_warriors_1",
		"wh2_main_lzd_inf_skink_skirmishers_0"
	}
	
	local faction = cm:get_faction("wh2_main_lzd_konquata");
	local faction_leader_cqi = faction:faction_leader():command_queue_index();
	
	for i = 1, #UNITS do
		cm:grant_unit_to_character(cm:char_lookup_str(faction_leader_cqi), UNITS[i]);
			
		out("006 - Starting_Units_Konquata");
	end
end


















function Unlock_TEB_Lords()
	local lords = {		
		{["id"] = "990015",	["forename"] = "names_name_997012",		["faction"] = "wh_main_teb_border_princes"},		-- Gashnag the Black Prince
		{["id"] = "990017",	["forename"] = "names_name_997014",		["faction"] = "wh_main_teb_estalia"},			-- Lucrezzia Belladonna
		{["id"] = "990021",	["forename"] = "names_name_997016",		["faction"] = "wh_main_teb_tilea"},			-- Borgio the Besieger
		{["id"] = "990026",	["forename"] = "names_name_992002",		["faction"] = "wh2_main_emp_new_world_colonies"}	-- Marco Colombo
	};
	
	for i = 1, #lords do
		local faction = cm:get_faction(lords[i].faction);
		
		if not faction:is_human() then
			cm:unlock_starting_general_recruitment(lords[i].id, lords[i].faction);
		end
	end
end








-------WRITTEN BY: Vandy for Crynsos
--last update March 30, 2018

function The_Thirteenth_Scheme()
	out("CFU:: FIXING THE THIRTEENTH SCHEME")

	local rite_templates = {
		--------------------------
		-- thirteen (eshin) --
		--------------------------
		{
			["culture"] = "wh2_main_skv_skaven",
			["rite_name"] = "wh2_main_ritual_skv_thirteen_eshin",
			["event_name"] = "CharacterRankUp",
			["condition"] =
				function(context, faction_name)					
					local character = context:character();
					
					return character:faction():name() == faction_name and character:is_faction_leader() and character:rank() >= 7;
				end,
			["faction_name"] = "wh2_main_skv_clan_eshin"
		},
		{
			["culture"] = "wh2_main_skv_skaven",
			["rite_name"] = "wh2_main_ritual_skv_thirteen_eshin",
			["event_name"] = "CharacterTurnStart",
			["condition"] =
				function(context, faction_name)					
					local character = context:character();
					
					return character:faction():name() == faction_name and character:is_faction_leader() and character:rank() >= 7;
				end,
			["faction_name"] = "wh2_main_skv_clan_eshin"
		},
		
		--------------------------
		-- thirteen (moulder) --
		--------------------------
		{
			["culture"] = "wh2_main_skv_skaven",
			["rite_name"] = "wh2_main_ritual_skv_thirteen_moulder",
			["event_name"] = "CharacterRankUp",
			["condition"] =
				function(context, faction_name)					
					local character = context:character();
					
					return character:faction():name() == faction_name and character:is_faction_leader() and character:rank() >= 7;
				end,
			["faction_name"] = "wh2_main_skv_clan_moulder"
		},
		{
			["culture"] = "wh2_main_skv_skaven",
			["rite_name"] = "wh2_main_ritual_skv_thirteen_moulder",
			["event_name"] = "CharacterTurnStart",
			["condition"] =
				function(context, faction_name)					
					local character = context:character();
					
					return character:faction():name() == faction_name and character:is_faction_leader() and character:rank() >= 7;
				end,
			["faction_name"] = "wh2_main_skv_clan_moulder"
		},		
		
		--------------------------
		-- thirteen (skryre) --
		--------------------------
		{
			["culture"] = "wh2_main_skv_skaven",
			["rite_name"] = "wh2_main_ritual_skv_thirteen_skyre",
			["event_name"] = "CharacterRankUp",
			["condition"] =
				function(context, faction_name)					
					local character = context:character();
					
					return character:faction():name() == faction_name and character:is_faction_leader() and character:rank() >= 7;
				end,
			["faction_name"] = "wh2_main_skv_clan_skyre"
		},
		{
			["culture"] = "wh2_main_skv_skaven",
			["rite_name"] = "wh2_main_ritual_skv_thirteen_skyre",
			["event_name"] = "CharacterTurnStart",
			["condition"] =
				function(context, faction_name)					
					local character = context:character();
					
					return character:faction():name() == faction_name and character:is_faction_leader() and character:rank() >= 7;
				end,
			["faction_name"] = "wh2_main_skv_clan_skyre"
		}				
	};
	
	local human_factions = cm:get_human_factions();
	
	for i = 1, #human_factions do
		for j = 1, #rite_templates do
			local current_rite_template = rite_templates[j];
			if cm:get_faction(human_factions[i]):culture() == current_rite_template.culture then
				local rite = rite_unlock:new(
					current_rite_template.rite_name,
					current_rite_template.event_name,
					current_rite_template.condition,
					current_rite_template.faction_name
				)
				
				rite:start(human_factions[i]);
			end;
		end;
	end;
end









function Kill_All_Characters_of_Faction(faction_key)
	local faction = cm:get_faction(faction_key);
	
	local faction_character_list = faction:character_list();
	
	cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
	
	for i = 0, faction_character_list:num_items() - 1 do
		local character = faction_character_list:item_at(i);
		
		if character:is_null_interface() == false then
			cm:kill_character(character:cqi(), true, true);
		end
	end
	
	cm:callback(
		function()
			cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
		end,
		1
	);
end

