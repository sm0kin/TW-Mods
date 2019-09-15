--Drunk Flamingo's log script
--All credits to Drunk Flamingo
--v function(text: string | number | boolean | CA_CQI)
local function sm0_LOG(text)
	if not __write_output_to_logfile then
		return
	end

	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","a")
	--# assume logTimeStamp: string
	popLog :write("sm0:  [".. logTimeStamp .. "]:  [Turn: ".. tostring(cm:turn_number()) .. "]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

-- vanilla function overrides:
-- wh_chaos_invasion.lua
function ci_get_difficulty()
	sm0_LOG("DIFFICULTY / ci_get_difficulty") -- works
	local is_multiplayer = cm:is_multiplayer()
	local difficulty = cm:model():combined_difficulty_level()
	
	if cm:get_local_faction(true) then
		if difficulty == 0 then
			difficulty = 2				-- normal
		elseif difficulty == -1 then
			difficulty = 3				-- hard
		elseif difficulty == -2 then
			difficulty = 5				-- very hard
		elseif difficulty == -3 then
			difficulty = 5				-- legendary
		else
			difficulty = 1				-- easy
		end
	else
	-- autorun
		if difficulty == 0 then
			difficulty = 2				-- normal
		elseif difficulty == 1 then
			difficulty = 3				-- hard
		elseif difficulty == 2 then
			difficulty = 5				-- very hard
		elseif difficulty == 3 then
			difficulty = 5				-- legendary
		else
			difficulty = 1				-- easy
		end
	end
	
	return difficulty
end

-- wh_dlc08_norsca_chaos_invasion
function NCI_Add_Army_XP(cqi, force_xp)
	sm0_LOG("DIFFICULTY / NCI_Add_Army_XP")
	local xp = force_xp;
	
	if xp == nil then
		local difficulty = cm:model():difficulty_level();
		
		if difficulty == -1 then
			-- Hard
			xp = 2;
		elseif difficulty == -2 then
			-- Very Hard
			xp = 7;
		elseif difficulty == -3 then
			-- Legendary
			xp = 7;
		else
			xp = 0;
		end
	end
	
	cm:award_experience_level(cm:char_lookup_str(cqi), xp);
end

-- wh_dlc08_norscan_gods
function Spawn_Challenger(faction_key, god_key, is_mp)
	sm0_LOG("DIFFICULTY / Spawn_Challenger")
	local invasion_key = "invasion_"..faction_key.."_"..god_key;
	local random_spawn_num = cm:random_number(#NORSCA_SPAWN_LOCATIONS);
	local random_spawn = NORSCA_SPAWN_LOCATIONS[random_spawn_num];
	local mission_spawn = nil;
	table.remove(NORSCA_SPAWN_LOCATIONS, random_spawn_num);
	
	local ram = random_army_manager;
	local unit_list = ram:generate_force("challenger_"..god_key, 19);
	
	local target_faction = cm:model():world():faction_by_key(faction_key);
	local challenger_invasion = invasion_manager:new_invasion(invasion_key, NORSCAN_CHALLENGER_FACTION_PREFIX..god_key, unit_list, random_spawn);
	
	if cm:is_multiplayer() == false then
		if target_faction:is_null_interface() == false and target_faction:has_faction_leader() == true then
			local faction_leader = target_faction:faction_leader();
			if faction_leader:is_null_interface() == false and faction_leader:has_military_force() == true then
				local faction_leader_cqi = faction_leader:command_queue_index();
				challenger_invasion:set_target("CHARACTER", faction_leader_cqi, faction_key);
			else
				challenger_invasion:set_target("NONE", nil, faction_key);
			end
		end
	end
	
	if cm:is_multiplayer() == false then
		-- Add army XP based on difficulty in SP
		local difficulty = cm:model():difficulty_level();
		
		if difficulty == -1 then
			-- Hard
			challenger_invasion:add_unit_experience(1);
		elseif difficulty == -2 then
			-- Very Hard
			challenger_invasion:add_unit_experience(3);
		elseif difficulty == -3 then
			-- Legendary
			challenger_invasion:add_unit_experience(3);
		end
	end
	
	-- Set up the General
	challenger_invasion:create_general(GOD_KEY_TO_CHALLENGER_DETAILS[god_key].make_faction_leader, GOD_KEY_TO_CHALLENGER_DETAILS[god_key].agent_subtype, GOD_KEY_TO_CHALLENGER_DETAILS[god_key].forename, GOD_KEY_TO_CHALLENGER_DETAILS[god_key].clan_name, GOD_KEY_TO_CHALLENGER_DETAILS[god_key].family_name, GOD_KEY_TO_CHALLENGER_DETAILS[god_key].other_name);
	
	challenger_invasion:add_character_experience(30, true); -- Level 30
	
	challenger_invasion:apply_effect(GOD_KEY_TO_CHALLENGER_DETAILS[god_key].effect_bundle, -1);
	
	challenger_invasion:start_invasion(
	function(self)
		local force = self:get_force();
		local force_cqi = force:command_queue_index();
		local force_leader_cqi = force:general_character():command_queue_index();
	
		NORSCAN_GODS[faction_key][god_key].challenger_cqi = force_cqi;
		NORSCAN_GODS[faction_key][god_key].challenger_force_cqi = force_leader_cqi;
		NORSCAN_GODS[faction_key][god_key].mission_record = "wh_dlc08_kill_challenger_"..god_key;
		
		if cm:is_multiplayer() == false then
			out("(SP) Preventing "..NORSCAN_CHALLENGER_FACTION_PREFIX..god_key.." diplomacy [all] with [all]");
			cm:force_diplomacy("faction:"..NORSCAN_CHALLENGER_FACTION_PREFIX..god_key, "all", "all", false, false, true);
		else
			out("(MP) Preventing "..NORSCAN_CHALLENGER_FACTION_PREFIX..god_key.." diplomacy [all] with [all]");
			cm:force_diplomacy("faction:"..NORSCAN_CHALLENGER_FACTION_PREFIX..god_key, "all", "all", false, false, true);
		end
	end,
	not is_mp
	);
	return random_spawn, "wh_dlc08_kill_challenger_"..god_key;
end

-- wh_horde_reemergence
function attempt_to_spawn_scripted_army(faction_name)
	sm0_LOG("DIFFICULTY / attempt_to_spawn_scripted_army") --works
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

-- wh2_dlc10_hellebron
function death_night_blood_voyage()
	sm0_LOG("DIFFICULTY / death_night_blood_voyage")
	out.design("DEATH NIGHT: death_night_blood_voyage");
	local turn_number = cm:model():turn_number();
	local unit_list = random_army_manager:generate_force("death_night_army_2", 19);
	local spawn_pos = {x = 156, y = 625};
	
	if cm:model():campaign_name("wh2_main_great_vortex") then
		spawn_pos = {x = 286, y = 637};
	end
	
	local blood_voyage_inv = nil;
	local ulthuan_target, ulthuan_target_faction, human_high_elves = death_night_generate_ulthuan_target();
	local player_blood_voyage = false;
	local force_player_blood_voyage = false; -- Debug
	local har_ganeth = cm:model():world():faction_by_key(death_night_faction);
	
	if har_ganeth:is_human() == true then
		if cm:is_multiplayer() == false then
			if ulthuan_target ~= nil and force_player_blood_voyage == false then
				-- AI CONTROLLED BLOOD VOYAGE (SP) (Player Hellebron)
				blood_voyage_inv = invasion_manager:new_invasion("blood_voyage_inv_"..turn_number, blood_voyage_faction, unit_list, spawn_pos);
				blood_voyage_inv:set_target("REGION", ulthuan_target, ulthuan_target_faction);
				blood_voyage.target = ulthuan_target_faction;
				blood_voyage.human = false;
			else
				-- PLAYER CONTROLLED BLOOD VOYAGE (SP)
				player_blood_voyage = true;
				unit_list = random_army_manager:generate_force("death_night_army_player", 19);
				blood_voyage_inv = invasion_manager:new_invasion("blood_voyage_inv_"..turn_number, death_night_faction, unit_list, spawn_pos);
				blood_voyage.target = "";
				blood_voyage.human = true;
			end
		else
			-- PLAYER CONTROLLED BLOOD VOYAGE (MP) (Player Hellebron)
			player_blood_voyage = true;
			unit_list = random_army_manager:generate_force("death_night_army_player", 19);
			blood_voyage_inv = invasion_manager:new_invasion("blood_voyage_inv_"..turn_number, death_night_faction, unit_list, spawn_pos);
			blood_voyage.target = "";
			blood_voyage.human = true;
		end
	elseif ulthuan_target ~= nil then
		if turn_number <= 30 then
			unit_list = random_army_manager:generate_force("death_night_army_1", 19);
		end
		
		-- AI CONTROLLED BLOOD VOYAGE (SP & MP) (AI Hellebron)
		blood_voyage_inv = invasion_manager:new_invasion("blood_voyage_inv_"..turn_number, blood_voyage_faction, unit_list, spawn_pos);
		blood_voyage_inv:set_target("REGION", ulthuan_target, ulthuan_target_faction);
		blood_voyage.target = ulthuan_target_faction;
		blood_voyage.human = false;
		
		local difficulty = cm:get_difficulty(true);
		
		if difficulty == "very hard" then
			blood_voyage_inv:add_unit_experience(3);
		elseif difficulty == "legendary" then
			blood_voyage_inv:add_unit_experience(3);
		end
	else
		out.design("\tDidn't spawn Blood Voyage!");
		return;
	end
	
	local hellebron = har_ganeth:faction_leader();
	
	if hellebron and hellebron:is_null_interface() == false and hellebron:has_skill("wh2_dlc10_skill_def_crone_unique_blood_queen") == true then
		blood_voyage_inv:add_unit_experience(3);
	end
	
	if player_blood_voyage == true then
		blood_voyage_inv:apply_effect("wh2_dlc10_bundle_blood_voyage_player", 15);
	else
		blood_voyage_inv:apply_effect("wh2_dlc10_bundle_blood_voyage", 0);
	end
	
	blood_voyage_inv:abort_on_target_owner_change(true);
	blood_voyage_inv:start_invasion(
	function(self)
		local force_leader = self:get_general();
		local local_faction = cm:get_local_faction(true);
	
		if local_faction == death_night_faction then
			cm:scroll_camera_from_current(false, 3, {force_leader:display_position_x(), force_leader:display_position_y(), 14.768, 0.0, 12.0});
		end
		
		blood_voyage.active = true;
		blood_voyage.loot = 300 + cm:random_number(600);
		
		cm:force_alliance(death_night_faction, blood_voyage_faction, true);
		cm:add_character_vfx(force_leader:command_queue_index(), death_night_vfx, false);
		
		out.design("DEATH NIGHT: Blood Voyage Invasion Started");
		out.design("\tblood_voyage.active: "..tostring(blood_voyage.active));
		out.design("\tblood_voyage.loot: "..tostring(blood_voyage.loot));
		out.design("\tblood_voyage.target: "..tostring(blood_voyage.target));
		out.design("\tblood_voyage.human: "..tostring(blood_voyage.human));
		out.design("\tblood_voyage.cooldown: "..tostring(blood_voyage.cooldown));
	end,
	true, false, false
	);
	core:trigger_event("ScriptEventDeathBloodVoyage");
	cm:force_diplomacy("all", "faction:"..blood_voyage_faction, "all", false, false, true);
	cm:force_diplomacy("faction:"..death_night_faction, "faction:"..blood_voyage_faction, "join war", true, true, false);
	cm:force_diplomacy("all", "faction:"..blood_voyage_faction, "war", true, true, false);
	cm:force_diplomacy("faction:"..death_night_faction, "faction:"..blood_voyage_faction, "war", false, false, true);
	
	if cm:model():has_faction_command_queue_index(death_night.faction_cqi) then
		local faction = cm:model():faction_for_command_queue_index(death_night.faction_cqi);
		local owner = "_";
		
		if player_blood_voyage == true then
			owner = "_owner_";
		end
		
		cm:show_message_event_located(
			faction:name(),
			"event_feed_strings_text_wh_dlc10_event_feed_string_scripted_event_blood_voyage"..owner.."title",
			"event_feed_strings_text_wh_dlc10_event_feed_string_scripted_event_blood_voyage"..owner.."primary_detail",
			"event_feed_strings_text_wh_dlc10_event_feed_string_scripted_event_blood_voyage"..owner.."secondary_detail",
			spawn_pos.x,
			spawn_pos.y,
			true,
			1011
		);
	end
	
	for elf, value in pairs(human_high_elves) do
		if value then
			blood_voyage_warning_event(elf);
		end
	end
	
	cm:apply_effect_bundle("wh2_dlc10_bundle_blood_voyage_active", "wh2_main_hef_avelorn", 0);
	
	local har_ganeth = nil;
	
	if cm:model():campaign_name("wh2_main_great_vortex") then
		har_ganeth = cm:model():world():region_manager():region_by_key("wh2_main_vor_the_road_of_skulls_har_ganeth");
	else
		har_ganeth = cm:model():world():region_manager():region_by_key("wh2_main_the_road_of_skulls_har_ganeth");
	end
	
	local garrison_residence = har_ganeth:garrison_residence();
	local garrison_residence_cqi = garrison_residence:command_queue_index();
	cm:remove_garrison_residence_vfx(garrison_residence_cqi, death_night_vfx);
end

-- wh2_vortex_rituals
function vortex_get_difficulty()
	sm0_LOG("DIFFICULTY / vortex_get_difficulty") -- works
	local difficulty = cm:model():combined_difficulty_level();
	
	local local_faction = cm:get_local_faction(true);
	
	if local_faction and cm:get_faction(local_faction) then
		if difficulty == 0 then
			difficulty = "normal";
		elseif difficulty == -1 then
			difficulty = "hard";
		elseif difficulty == -2 then
			difficulty = "legendary";
		elseif difficulty == -3 then
			difficulty = "legendary";
		else
			difficulty = "easy";
		end;
	else
	-- autorun
		if difficulty == 0 then
			difficulty = "normal";
		elseif difficulty == 1 then
			difficulty = "hard";
		elseif difficulty == 2 then
			difficulty = "legendary";
		elseif difficulty == 3 then
			difficulty = "legendary";
		else
			difficulty = "easy";
		end;
	end;
	
	return difficulty;
end;