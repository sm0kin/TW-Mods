-- turns a horde faction must be dead for before it is allowed to re-emerge
local turns_before_faction_may_reemerge_after_death = 9;

-- turns before another (or the same) horde faction is allowed to re-emerge once one already has re-emerged
local faction_reemerge_cooldown_turns = 15;

-- percentage chance of a horde faction re-emerging if it is dead (meeting the above criteria)
local chance_of_horde_reemerging = 5;

local ram = random_army_manager;

ram:new_force("wh_main_sc_grn_savage_orcs_horde");

ram:add_unit("wh_main_sc_grn_savage_orcs_horde", "wh_main_grn_inf_savage_orcs",					3);
ram:add_unit("wh_main_sc_grn_savage_orcs_horde", "wh_main_grn_inf_savage_orc_arrer_boyz",		3);
ram:add_unit("wh_main_sc_grn_savage_orcs_horde", "wh_main_grn_cav_savage_orc_boar_boyz",		2);
ram:add_unit("wh_main_sc_grn_savage_orcs_horde", "wh_main_grn_inf_savage_orc_big_uns",			1);
ram:add_unit("wh_main_sc_grn_savage_orcs_horde", "wh_main_grn_cav_savage_orc_boar_boy_big_uns",	1);

ram:new_force("wh_dlc03_sc_bst_beastmen_horde");

ram:add_unit("wh_dlc03_sc_bst_beastmen_horde", "wh_dlc03_bst_inf_ungor_spearmen_0",				3);
ram:add_unit("wh_dlc03_sc_bst_beastmen_horde", "wh_dlc03_bst_inf_ungor_raiders_0",				3);
ram:add_unit("wh_dlc03_sc_bst_beastmen_horde", "wh_dlc03_bst_inf_minotaurs_0",					2);
ram:add_unit("wh_dlc03_sc_bst_beastmen_horde", "wh_dlc03_bst_inf_chaos_warhounds_0",			1);
ram:add_unit("wh_dlc03_sc_bst_beastmen_horde", "wh_dlc03_bst_inf_cygor_0",						1);

function add_horde_reemergence_listeners()
	-- force horde factions to re-emerge via random incident
	core:add_listener(
		"horde_reemerge",
		"FactionRoundStart",
		function(context)
			local allow_factions_to_reemerge = cm:get_saved_value("allow_factions_to_reemerge");
			
			local local_faction = cm:get_local_faction(true);
			
			if local_faction and cm:get_faction(local_faction) then
				local human_factions = cm:get_human_factions();
				return context:faction():name() == human_factions[1] and allow_factions_to_reemerge;
			else
				-- autorun - assume Empire is always going to be alive so can substitute for a player faction!
				return context:faction():name() == "wh_main_emp_empire" and allow_factions_to_reemerge;
			end;
		end,
		function()
			factions_dead = {};
			
			local factions_to_check = {
				"wh_main_grn_skull-takerz",
				"wh_main_grn_top_knotz",
				"wh_dlc03_bst_beastmen",
				"wh_dlc03_bst_redhorn",
				"wh_dlc03_bst_jagged_horn",
				"wh2_main_bst_blooded_axe",
				"wh2_main_bst_manblight",
				"wh2_main_bst_ripper_horn",
				"wh2_main_bst_shadowgor"
			};
			
			for i = 1, #factions_to_check do
				local current_faction_name = factions_to_check[i];
				local current_faction = cm:get_faction(current_faction_name);

				if current_faction and current_faction:is_dead() then
					local turns_dead = cm:get_saved_value(current_faction_name .. "_dead");
					
					if turns_dead == nil or turns_dead == 0 then
						-- the faction has died for the first time
						cm:set_saved_value(current_faction_name .. "_dead", 1);
					elseif turns_dead > turns_before_faction_may_reemerge_after_death then
						-- the faction has been dead for 10 turns, allow it to re-emerge
						table.insert(factions_dead, current_faction_name);
					else
						-- the faction has been dead, count the turn numbers
						cm:set_saved_value(current_faction_name .. "_dead", turns_dead + 1);
					end;
				end;
			end;
			
			if #factions_dead == 0 then
				return;
			end;
			
			local index = cm:random_number(#factions_dead);			
			local chosen_faction = factions_dead[index];
			
			local roll = cm:random_number(100);
			
			if roll <= chance_of_horde_reemerging then
				attempt_to_spawn_scripted_army(chosen_faction);
			end;
		end,
		true
	);

	-- only allow factions to re-emerge through script every X number of turns
	if cm:get_saved_value("allow_factions_to_reemerge") == nil then
		cm:set_saved_value("allow_factions_to_reemerge", true);
	end;

	core:add_listener(
		"faction_reemerge_cooldown_expired",
		"ScriptEventFactionReemergeCooldownExpired",
		true,
		function()
			cm:set_saved_value("allow_factions_to_reemerge", true);
		end,
		true
	);
end;

function attempt_to_spawn_scripted_army(faction_name)
	local possible_spawn_points = {
		{519, 516, "wh_main_middenland_middenheim"},
		{486, 438, "wh_main_reikland_altdorf"},
		{415, 318, "wh_main_carcassone_et_brionne_castle_carcassonne"},
		{416, 398, "wh_main_bastonne_et_montfort_castle_bastonne"},
		{630, 342, "wh_main_eastern_border_princes_akendorf"},
		{680, 287, "wh_main_death_pass_iron_rock"},
		{572, 190, "wh_main_southern_badlands_galbaraz"},
		{747, 328, "wh_main_the_silver_road_mount_squighorn"},
		{772, 223, "wh_main_desolation_of_nagash_spitepeak"},
		{728, 445, "wh_main_peak_pass_karak_kadrin"},
		{721, 503, "wh_main_northern_worlds_edge_mountains_karak_ungor"},
		{664, 535, "wh_main_southern_oblast_kislev"},
		{558, 408, "wh_main_averland_averheim"},
		{688, 342, "wh_main_blood_river_valley_varenka_hills"},
		{604, 604, "wh_main_troll_country_zoishenk"},
		{676, 454, "wh_main_eastern_sylvania_waldenhof"},
		{526, 327, "wh_main_the_vaults_karak_izor"},
		{370, 261, "wh_main_estalia_magritta"},
		{545, 164, "wh_main_southern_badlands_gor_gazan"},
		{691, 195, "wh_main_blightwater_karak_azgal"},
		{45, 704, "wh2_main_ironfrost_glacier_dagraks_end"},
		{180, 704, "wh2_main_the_road_of_skulls_kauark"},
		{395, 700, "wh2_main_aghol_wastelands_palace_of_princes"},
		{15, 565, "wh2_main_blackspine_mountains_red_desert"},
		{116, 546, "wh2_main_obsidian_peaks_circle_of_destruction"},
		{17, 498, "wh2_main_blackspine_mountains_plain_of_spiders"},
		{99, 462, "wh2_main_doom_glades_vauls_anvil"},
		{50, 361, "wh2_main_titan_peaks_ssildra_tor"},
		{39, 247, "wh2_main_northern_jungle_of_pahualaxa_shrine_of_sotek"},
		{76, 198, "wh2_main_southern_jungle_of_pahualaxa_floating_pyramid"},
		{95, 79, "wh2_main_southern_great_jungle_itza"},
		{200, 38, "wh2_main_headhunters_jungle_marks_of_the_old_ones"},
		{418, 87, "wh2_main_land_of_assassins_lashiek"},
		{507, 8, "wh2_main_great_desert_of_araby_el-kalabad"},
		{679, 120, "wh2_main_ash_river_quatar"},
		{872, 47, "wh2_main_southlands_jungle_golden_tower_of_the_gods"},
		{824, 156, "wh2_main_devils_backbone_lahmia"}
	};
	
	-- get the highest ranked general's position
	local current_turn_faction = cm:model():world():whose_turn_is_it();
	local highest_ranked_general = cm:get_highest_ranked_general_for_faction(current_turn_faction);

	if highest_ranked_general then
		char_x = highest_ranked_general:logical_position_x();
		char_y = highest_ranked_general:logical_position_y();
	else
		return;
	end;

	local min_distance = 50;
	local closest_distance = 500000;
	local chosen_spawn_point = nil;
	
	-- get the closest spawn point to the chosen general that isn't in a region owned by the player
	for i = 1, #possible_spawn_points do
		local current_distance = distance_squared(char_x, char_y, possible_spawn_points[i][1], possible_spawn_points[i][2]);
		local region = cm:get_region(possible_spawn_points[i][3]);
		
		if region:owning_faction() ~= current_turn_faction and current_distance < closest_distance and current_distance > min_distance then
			closest_distance = current_distance;
			chosen_spawn_point = possible_spawn_points[i];
		end;
	end;
	
	if not chosen_spawn_point then
		return;
	end;
	
	local x = chosen_spawn_point[1];
	local y = chosen_spawn_point[2];
	
	-- check if there is a character at that point, if so, return
	local faction_list = cm:model():world():faction_list();
	
	for i = 0, faction_list:num_items() - 1 do
		local current_faction = faction_list:item_at(i);
		local char_list = current_faction:character_list();
		
		for j = 0, char_list:num_items() - 1 do
			local current_char = char_list:item_at(j);
			if current_char:logical_position_x() == x and current_char:logical_position_y() == y then
				return;
			end;
		end;
	end;
	
	-- just using region for the id for now, but could uncover shroud
	local region_name = chosen_spawn_point[3];
	
	local faction = cm:get_faction(faction_name);
	local subculture = faction:subculture();
	local building = "wh_dlc03_horde_beastmen_gors_1";
	
	if subculture == "wh_main_sc_grn_savage_orcs" then
		building = "wh_main_horde_savage_military_1";
	end;
	
	local difficulty = cm:model():combined_difficulty_level();

	local army_size = 8;			-- easy

	if difficulty == 0 then
		army_size = 10;				-- normal
	elseif difficulty == -1 then
		army_size = 12;				-- hard
	elseif difficulty == -2 then
		army_size = 16;				-- very hard
	elseif difficulty == -3 then
		army_size = 16;				-- legendary
	end;
	
	cm:create_force(
		faction_name,
		ram:generate_force(subculture .. "_horde", army_size),
		region_name,
		x,
		y,
		false,
		function(cqi)
			show_spawned_army_event(subculture, x, y);
			
			-- add recruitment buildings to the spawned horde
			local character = cm:get_character_by_cqi(cqi);
			local mf_cqi = character:military_force():command_queue_index();
			cm:add_building_to_force(mf_cqi, building);
			
			local current_turn_faction_name = cm:model():world():whose_turn_is_it():name();
			cm:add_turn_countdown_event(current_turn_faction_name, faction_reemerge_cooldown_turns, "ScriptEventFactionReemergeCooldownExpired");
			
			cm:set_saved_value("allow_factions_to_reemerge", false);
			cm:set_saved_value(faction_name .. "_dead", 0);
		end
	);
end;

function show_spawned_army_event(subculture, x, y)
	local primary_detail = "";
	local secondary_detail = "";
	local id = 1;

	if subculture == "wh_main_sc_grn_savage_orcs" then
		primary_detail = "event_feed_strings_text_wh_event_feed_string_scripted_event_savage_orcs_primary_detail";
		secondary_detail = "event_feed_strings_text_wh_event_feed_string_scripted_event_savage_orcs_secondary_detail";
		id = 101;
	elseif subculture == "wh_dlc03_sc_bst_beastmen" then
		primary_detail = "event_feed_strings_text_wh_event_feed_string_scripted_event_beastmen_primary_detail";
		secondary_detail = "event_feed_strings_text_wh_event_feed_string_scripted_event_beastmen_secondary_detail";
		id = 102;
	end;
	
	local human_factions = cm:get_human_factions();
	
	for i = 1, #human_factions do
		local current_faction = cm:get_faction(human_factions[i]);
		local current_faction_culture = current_faction:culture();
		
		-- we don't show the Beastmen event for a Beastmen or Chaos player as the text doesn't fit
		if not ((current_faction_culture == "wh_dlc03_bst_beastmen" or current_faction_culture == "wh_main_chs_chaos") and subculture == "wh_dlc03_sc_bst_beastmen") then
			cm:show_message_event_located(
				human_factions[i],
				primary_detail,
				"",
				secondary_detail,
				x,
				y,
				true,
				id
			);
		end;
	end;
end;