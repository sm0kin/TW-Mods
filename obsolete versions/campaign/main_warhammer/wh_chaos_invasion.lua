-- x5 invasion strength



-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--	CHAOS INVASION
--	This script delivers the Chaos Invasion system to the main campaign
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-- set this to true to test the chaos invasion events
local test_chaos_invasion_events = false;

-- the string used in the factions table
local ci_chaos_faction_string = "wh_main_chs_chaos";
local ci_beastmen_faction_string = "wh_dlc03_bst_beastmen_chaos";

-- the string used in the regions table
local ci_chaos_wastes_string = "wh_main_chaos_wastes";

-- we have to use a neighbouring region as the horde home region as the Chaos Wastes region does not have a settlement!
local ci_chaos_home_region = "wh_main_goromandy_mountains_baersonlings_camp";

-- the imperium values that trigger the mid and late game events
local ci_mid_game_imperium = 99999; --7
local ci_late_game_imperium = 99999; --10

-- turn number to force the Chaos Invasion to trigger if the player has not hit the required imperium level. Also works for autoruns where there is no player
-- values here that are non-numeric now disable the relevant timeout
local ci_mid_game_turn_timeout = 99999; --150
local ci_late_game_turn_timeout = 99999; --200

if test_chaos_invasion_events then
	ci_mid_game_turn_timeout = 3;
	ci_late_game_turn_timeout = 5;
end;

-- turn number to display early game event message
local ci_early_game_event_turn = 20;

-- the number of hordes we want the Chaos faction to have when spawning a new wave
-- mid game | late game
-- easy, normal, hard, very hard, legendary
local ci_max_num_hordes = {{20, 20, 25, 30, 35}, {30, 30, 35, 40, 45}}; --{{3, 3, 4, 5, 6}, {5, 5, 6, 7, 8}};

-- the area in which it is valid to spawn hordes (currently a rectangle in the Chaos Wastes region) and the faction that should spawn there
-- min x, max x, min y, max y
local ci_spawn_areas = {
	{766, 780, 612, 625, "default"}, -- main
	{216, 237, 495, 507, "wh2_main_chs_chaos_incursion_def"}, -- north west
	{282, 307, 15, 24, "wh2_main_chs_chaos_incursion_hef"} -- south west
};

local ci_norsca_spawn_area = {474, 518, 160, 186};

-- range of units to spawn a new horde with (min, max)
-- mid game | late game
local ci_horde_size = {{15, 17}, {19,19}};

-- amount of free XP to give agents and armies when spawning
-- agents | mid game | late game
-- rank 2, 3, 4 | rank 7, 8, 9 | rank 20, 21, 22
local ci_character_xp = {{900, 1900, 3000}, {6890, 8370, 9940}, {32360, 34800, 37300}};

-- turn number to shuffle the AI personalities if the Chaos faction is under player control
local ci_player_chaos_personality_shuffle_turn = 30;

-- number of times to spawn additional waves before cancelling during late game event
-- easy, normal, hard, very hard, legendary
local ci_num_spawn_waves_late_game = {0, 1, 2, 3, 4};

-- Lord of Change details
local ci_loc_details = {
	["id"] = "lord_of_change",
	["agent_subtype"] = "Exalt_Lord_of_Change",
	["forename"] = "names_name_2147357518",
	["family_name"] = "names_name_2147357523",
	["faction_leader"] = false
};

local ci_archaon_forename = "names_name_2147343903";

-------------------------------------------------------------------------------------
local chaos_general_subtype = "Lord_Khorne";  --STRINGS MUST BE DEFINED WITH ; INSTEAD OF ,
-----------------------------------------------------------------------------------
---------------------------NAMES--------------
local forename_string_array_chaos = {"names_name_2147345937", "names_name_2147345943", "names_name_2147345949", "names_name_2147345958", "names_name_2147345975", "names_name_2147345978", "names_name_2147345981", "names_name_2147346009", "names_name_2147346014", "names_name_2147346030", "names_name_2147346055", "names_name_2147346063", "names_name_2147346073", "names_name_2147346075", "names_name_214734608", "names_name_2147346094", "names_name_2147346097", "names_name_2147346102", "names_name_2147346104", "names_name_2147346107", "names_name_2147346115", "names_name_2147346119", "names_name_2147346121", "names_name_2147346126", "names_name_2147346127", "names_name_2147346132", "names_name_2147346133", "names_name_2147346139", "names_name_2147346140", "names_name_2147346149"}; --names group 98 is chaos

local familyname_string_array_chaos = {"names_name_2147353266", "names_name_2147353271", "names_name_2147353276", "names_name_2147353280", "names_name_2147353290", "names_name_2147353296", "names_name_2147353297", "names_name_2147353302", "names_name_2147353310", "names_name_2147353316", "names_name_2147353325", "names_name_2147353329", "names_name_2147353332", "names_name_2147353333", "names_name_2147353343", "names_name_2147353351", "names_name_2147353352", "names_name_2147353354", "names_name_2147353363", "names_name_2147353369", "names_name_2147353375", "names_name_2147353383", "names_name_2147353390", "names_name_2147353400", "names_name_2147353403", "names_name_2147353408", "names_name_2147353414", "names_name_2147353423", "names_name_2147353427", "names_name_2147353428", "names_name_2147353435", "names_name_2147353445", "names_name_2147353448", "names_name_2147353456", "names_name_2147353461", "names_name_2147353465", "names_name_2147353466", "names_name_2147353472", "names_name_2147353473", "names_name_2147353474", "names_name_2147353480", "names_name_2147353485", "names_name_2147353488", "names_name_2147353490", "names_name_2147353499", "names_name_2147353509", "names_name_2147353514", "names_name_2147353518", "names_name_2147353524", "names_name_2147353527", "names_name_2147353537", "names_name_2147353544", "names_name_2147353551", "names_name_2147353554", "names_name_2147353558", "names_name_2147353566", "names_name_2147353571", "names_name_2147353581", "names_name_2147353584", "names_name_2147353587", "names_name_2147353590", "names_name_2147353597", "names_name_2147353598", "names_name_2147353599", "names_name_2147353606", "names_name_2147353616", "names_name_2147353626", "names_name_2147353631", "names_name_2147353636", "names_name_2147353646", "names_name_2147353652", "names_name_2147353658"}; --remember order 1 is family name


local forename_string_array_beastmen = {"names_name_2147357473", "names_name_2147357484", "names_name_2147357907", "names_name_2147357916", "names_name_2147357923", "names_name_2147357926", "names_name_2147357930", "names_name_2147357932", "names_name_2147357937", "names_name_2147357943", "names_name_2147357945", "names_name_2147357946", "names_name_2147357951", "names_name_2147357958", "names_name_2147358341", "names_name_2147358346", "names_name_2147358352", "names_name_2147358359", "names_name_2147358360", "names_name_2147358364", "names_name_2147358374", "names_name_2147358380", "names_name_2147358389", "names_name_2147358392", "names_name_2147358396", "names_name_2147358402", "names_name_2147358411", "names_name_2147358419", "names_name_2147358421", "names_name_2147358423", "names_name_2147358424", "names_name_2147358430", "names_name_2147358433", "names_name_2147358442", "names_name_2147358445", "names_name_2147358450", "names_name_2147358456", "names_name_2147358461", "names_name_2147358468", "names_name_2147358471", "names_name_2147358480", "names_name_2147358488", "names_name_2147358498", "names_name_2147358503", "names_name_2147358506", "names_name_2147358512", "names_name_2147358513", "names_name_2147358517", "names_name_2147358526", "names_name_2147358534", "names_name_2147358537", "names_name_2147358541", "names_name_2147358551", "names_name_2147358554", "names_name_2147358564", "names_name_2147358571", "names_name_2147358578", "names_name_2147358585", "names_name_2147358594", "names_name_2147358597", "names_name_2147358603", "names_name_2147358611", "names_name_2147358617"}; --names group 98 is chaos

local familyname_string_array_beastmen = {"names_name_2147346075", "names_name_2147346084", "names_name_2147357518", "names_name_2147346094", "names_name_2147346097", "names_name_2147346097", "names_name_2147346097", "names_name_2147357472", "names_name_2147357483", "names_name_2147357961", "names_name_2147357971", "names_name_2147357976", "names_name_2147357983", "names_name_2147357986", "names_name_2147357996", "names_name_2147358002", "names_name_2147358009", "names_name_2147358622", "names_name_2147358631", "names_name_2147358633", "names_name_2147358635", "names_name_2147358637", "names_name_2147358640", "names_name_2147358648", "names_name_2147358654", "names_name_2147358664", "names_name_2147358668", "names_name_2147358674", "names_name_2147358680", "names_name_2147358686", "names_name_2147358691", "names_name_2147358693", "names_name_2147358697", "names_name_2147358704", "names_name_2147358706", "names_name_2147358712", "names_name_2147358720", "names_name_2147358730", "names_name_2147358734", "names_name_2147358736", "names_name_2147358745", "names_name_2147358748", "names_name_2147358757", "names_name_2147358760", "names_name_2147358764", "names_name_2147358768", "names_name_2147358777", "names_name_2147358784", "names_name_2147358793", "names_name_2147358799", "names_name_2147358801", "names_name_2147358802", "names_name_2147358808", "names_name_2147358811", "names_name_2147358821", "names_name_2147358827", "names_name_2147358835", "names_name_2147358845", "names_name_2147358846", "names_name_2147358852", "names_name_2147358859", "names_name_2147358867", "names_name_2147358868", "names_name_2147358878", "names_name_2147358883", "names_name_2147358886", "names_name_2147358895", "names_name_2147358901", "names_name_2147358903", "names_name_2147358905", "names_name_2147358907", "names_name_2147358912"}; --remember order 1 is family name

local lord_forename = "names_name_2147357518"; 
local lord_familyname = "names_name_2147357523";

--local ci_chaos_horde_buildings = {
	--"wh_main_horde_chaos_settlement_3",
	--"wh_main_horde_chaos_warriors_2",
	--"wh_main_horde_chaos_forge_1"
--};


-------------------------------------------------------------------------------------
-- BUILDINGS VARS --do we need to ste mains here? the beastmen don't?
-----------------------------------------------------------------------------------

--I think these are already arrays? with 4 different values? so ci_blah_blah[1] refers to the _steel_main etc.
local ci_chaos_horde_buildings_khorne = {
	"_steel_main_4",
	"_steel_khorne_1",
	"_steel_monsters_1",
	"_steel_cult_3"
};

local ci_chaos_horde_buildings_tzeentch = {
	"_steel_main_4",
	"_steel_tzeentch_1",
	"_steel_monsters_1",
	"_steel_cult_3"
};

local ci_chaos_horde_buildings_slaanesh= {
	"_steel_main_4",
	"_steel_slaanesh_1",
	"_steel_monsters_1",
	"_steel_cult_3"
};

local ci_chaos_horde_buildings_nurgle = {
	"_steel_main_4",
	"_steel_nurgle_1",
	"_steel_monsters_1",
	"_steel_cult_3"
};

local ci_chaos_horde_buildings = {
	"_steel_main_4",
	"_steel_chaos_warriors_2",
	"_steel_monsters_1",
	"_steel_cult_3"
};

-- SET BUILDING VARS FOR STAGE 2
local ci_chaos_horde_buildings_khorne2 = {
	"_steel_main_6",
	"_steel_khorne_2",
	"_steel_monsters_2",
	"_steel_rift_2",
	"_steel_forge_2"
};

local ci_chaos_horde_buildings_tzeentch2 = {
	"_steel_main_6",
	"_steel_tzeentch_2",
	"_steel_monsters_2",
		"_steel_rift_2",
	"_steel_forge_2"
};

local ci_chaos_horde_buildings_slaanesh2 = {
	"_steel_main_6",
	"_steel_slaanesh_2",
	"_steel_monsters_2",
		"_steel_rift_2",
	"_steel_forge_2"
};

local ci_chaos_horde_buildings_nurgle2 = {
	"_steel_main_6",
	"_steel_nurgle_2",
	"_steel_monsters_2",
	"_steel_rift_2",
	"_steel_forge_2"
};

local ci_chaos_horde_buildings2 = {
	"_steel_main_6",
	"_steel_chaos_warriors_2",
	"_steel_monsters_2",
	"_steel_rift_2",
	"_steel_forge_2"
};

-------------------------------------------------------------------------------------
-- END CODE
-----------------------------------------------------------------------------------

local ci_beastmen_horde_buildings = {
	"wh_dlc03_horde_beastmen_herd_3",
	"wh_dlc03_horde_beastmen_gors_3",
	"wh_dlc03_horde_beastmen_minotaurs_1"
};





function chaos_wave_check()
	if cm:get_saved_value("chaos_first_wave_spawned") == false then
		if is_number(cm:get_saved_value("chaos_first_wave_turn")) and cm:model():turn_number() >= cm:get_saved_value("chaos_first_wave_turn") then
			ci_mid_game_cutscene();								-- Spawn the First Wave at the specified turn
			cm:set_saved_value("chaos_first_wave_spawned", true);
		elseif cm:get_saved_value("check_imperium_level") then
			if player_1:imperium_level() >= 7 or (player_2 and player_2:imperium_level() >= 7) or cm:model():turn_number() >= 150 then
				ci_mid_game_cutscene();							-- Spawn the First Wave once the required Imperium Level is reached
				cm:set_saved_value("chaos_first_wave_spawned", true);
				cm:set_saved_value("chaos_second_wave_turn", cm:model():turn_number() + 50);	-- Prepare the Second Wave to spawn 50 turns after the first one
			end
		end
	end
	
	if cm:get_saved_value("chaos_second_wave_spawned") == false then
		if is_number(cm:get_saved_value("chaos_second_wave_turn")) then
			if cm:model():turn_number() == cm:get_saved_value("chaos_second_wave_turn") - 1 then
				ci_pre_late_game_start("Turn Number Reached");					-- Prepare Archaon 1 turn before the Second Wave
			elseif cm:model():turn_number() == cm:get_saved_value("chaos_second_wave_turn") then
				ci_late_game_cutscene();							-- Start the Archaon Cutscene
				cm:set_saved_value("chaos_second_wave_spawned", true);
			end
		end
	end
end





function ci_setup()
	if cm:is_new_game() then					-- Initialize Values
		cm:set_saved_value("chaos_first_wave_turn", false);
		cm:set_saved_value("chaos_second_wave_turn", false);
		cm:set_saved_value("chaos_first_wave_spawned", false);
		cm:set_saved_value("chaos_second_wave_spawned", false);
		cm:set_saved_value("chaos_invasion_dilemma", true);			-- Set to false before Turn 3 to disable the Dilemma from appearing
		cm:set_saved_value("check_imperium_level", true);
	end
	
	-- Trigger the Chaos Invasion Dilemma, check for whether a faction exists that is human, not Chaos and if so, wait until turn 3 to trigger the Chaos Invasion Dilemma
	core:add_listener(
		"Chaos_Invasion_Dilemma",
		"FactionTurnStart",
		function(context) return context:faction():is_human() and context:faction():culture() ~= "wh_main_chs_chaos" and cm:model():turn_number() >= 3 and cm:get_saved_value("chaos_invasion_dilemma") end,
		function(context) cm:trigger_dilemma(player_1:name(), "wh_main_dilemma_chaos_invasion", true) end,
		false
	);
	
	-- Listen to the Chaos Invasion Dilemma Choice result and define the Chaos Invasion trigger conditions
	core:add_listener(
		"Chaos_Invasion_Dilemma_Choice",
		"DilemmaChoiceMadeEvent",
		function(context) return context:dilemma() == "wh_main_dilemma_chaos_invasion" end,
		function(context)
			local choice = context:choice();
			
			if choice == 0 then
				cm:set_saved_value("chaos_first_wave_turn", 150);
				cm:set_saved_value("chaos_second_wave_turn", 200);
			elseif choice == 1 then
				cm:set_saved_value("chaos_first_wave_spawned", true);
				cm:set_saved_value("chaos_second_wave_spawned", true);
			elseif choice == 2 then
				cm:set_saved_value("chaos_first_wave_turn", 100);
				cm:set_saved_value("chaos_second_wave_turn", 150);
				cm:set_saved_value("check_imperium_level", false);
			else
				cm:set_saved_value("chaos_first_wave_turn", 150);
				cm:set_saved_value("chaos_second_wave_turn", 200);
				cm:set_saved_value("check_imperium_level", false);
			end
		end,
		false
	);
	
	-- Trigger the Chaos Invasion under the correct conditions
	core:add_listener(
		"Chaos_Trigger_Turn_Check",
		"FactionRoundStart",
		true,
		function() chaos_wave_check() end,
		true
	);
	
	
	
	
	
	if core:is_tweaker_set("DISABLE_PRELUDE_CAMPAIGN_SCRIPTS") then
		out.chaos("Tweaker DISABLE_PRELUDE_CAMPAIGN_SCRIPTS is set so not running any Chaos Invasion scripts");
		return;
	end;
	
	if cm:is_multiplayer() == false then
		local norscan_1 = cm:get_faction("wh_dlc08_nor_norsca");
		local norscan_2 = cm:get_faction("wh_dlc08_nor_wintertooth");
		local human_norscan = false;
		
		if norscan_1 and norscan_1:is_human() == true then
			human_norscan = true;
		end
		if norscan_2 and norscan_2:is_human() == true then
			human_norscan = true;
		end
		
		if human_norscan == true then
			out.chaos("\tAborting Chaos invasion script, a player is Norsca!");
			out.chaos("****************************************************");
			Setup_Norsca_Chaos_Invasion();
			return;
		end
	end
	
	--[[
	local human_factions = cm:get_human_factions();
	
	for i = 1, #human_factions do
		if wh_faction_is_horde(cm:get_faction(human_factions[i])) and not test_chaos_invasion_events then
			ci_mid_game_turn_timeout = 150;
			ci_late_game_turn_timeout = 200;
			break;
		end;
	end;
	
	-- autorun, no imperium tracking
	if not cm:get_local_faction(true) and not test_chaos_invasion_events then
		ci_mid_game_turn_timeout = 150;
		ci_late_game_turn_timeout = 200;
	end;
	--]]

	out.chaos("****************************************************");
	out.chaos("Initialising the Chaos Invasion script");
	
	ci_setup_armies();
	
	local difficulty = ci_get_difficulty();
	local difficulty_string = "easy";
	if difficulty == 2 then
		difficulty_string = "normal";
	elseif difficulty == 3 then
		difficulty_string = "hard";
	elseif difficulty == 4 then
		difficulty_string = "very hard";
	elseif difficulty == 5 then
		difficulty_string = "legendary";
	end;
	
	out.chaos("\tDifficulty is " .. tostring(difficulty) .. " (model difficulty is " .. tostring(cm:model():difficulty_level()) .. ") which equates to " .. difficulty_string);
	
	if not cm:is_new_game() then
		out.chaos("\tci_stage is " .. tostring(cm:get_saved_value("ci_stage")));
		out.chaos("\tci_timeout_roll is " .. tostring(cm:get_saved_value("ci_timeout_roll")));
		out.chaos("\tci_early_event_shown is " .. tostring(cm:get_saved_value("ci_early_event_shown")));
		out.chaos("\tci_player_chaos_personality_change is " .. tostring(cm:get_saved_value("ci_player_chaos_personality_change")));
		out.chaos("\tci_trigger_mid_game_event_on_turn_start is " .. tostring(cm:get_saved_value("ci_trigger_mid_game_event_on_turn_start")));
		out.chaos("\tci_archaon_not_spawned is " .. tostring(cm:get_saved_value("ci_archaon_not_spawned")));
		if cm:is_multiplayer() then
			out.chaos("\tci_start_pre_late_game_to_late_game_listener_mp is " .. tostring(cm:get_saved_value("ci_start_pre_late_game_to_late_game_listener_mp")));
		else
			out.chaos("\tci_start_pre_late_game_to_late_game_listener is " .. tostring(cm:get_saved_value("ci_start_pre_late_game_to_late_game_listener")));
		end;
		out.chaos("\tci_trigger_late_game_event_on_turn_start is " .. tostring(cm:get_saved_value("ci_trigger_late_game_event_on_turn_start")));
		out.chaos("\tci_num_waves is " .. tostring(cm:get_saved_value("ci_num_waves")));
		out.chaos("\tkholek_sigvald_experience is " .. tostring(cm:get_saved_value("kholek_sigvald_experience")));
		
		local chaos_faction = cm:get_faction(ci_chaos_faction_string);
		local beastmen_faction = cm:get_faction(ci_beastmen_faction_string);
		
		if chaos_faction:is_dead() then
			out.chaos("\tChaos faction is dead");
		else
			out.chaos("\tChaos faction is alive and has " .. ci_get_num_hordes(ci_chaos_faction_string) .. " hordes");
		end;
		
		if beastmen_faction:is_dead() then
			out.chaos("\tBeastmen faction is dead");
		else
			out.chaos("\tBeastmen faction is alive and has " .. ci_get_num_hordes(ci_beastmen_faction_string) .. " hordes");
		end;
	end;
	
	out.chaos("****************************************************");
	
	ci_skip_chaos_turn_listener();
	
	local stage = cm:get_saved_value("ci_stage");
	
	if stage == 1 then
		out.chaos("Loading from a save file - the player has already reached the Chaos Invasion mid game event");
		ci_mid_game_setup_listeners();
		return;
	elseif stage == 2 then
		out.chaos("Loading from a save file - the player has already reached the Chaos Invasion late game event");
		ci_late_game_setup_listeners();
		return;
	elseif stage == 3 then
		out.chaos("Loading from a save file - the player has already defeated the Chaos Invasion - not running any script");
		return;
	end;
	
	cm:set_saved_value("ci_stage", 0);
	
	local faction = cm:get_faction(ci_chaos_faction_string);
	
	if faction:is_human() then
		ci_player_chaos();
		return;
	end;
	
--[[
	local faction = cm:get_faction(ci_chaos_faction_string);
	
	if faction:is_human() then
		ci_player_chaos();
		return;
	end;
	
	if cm:is_new_game() then
		if not cm:is_multiplayer() then
			in_ci_mid_game_event:start();
			in_ci_late_game_event:start();
		end;
		
		cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
		
		-- kill Archaon!
		local archaon = ci_get_archaon();
		cm:kill_character(archaon:command_queue_index(), true, true);
		
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "") end, 1);
	end;
--]]
	
	---------------------------------------------------------
	-- mid game start events
	---------------------------------------------------------
	
	if is_number(ci_mid_game_turn_timeout) then
		core:add_listener(
			"turn_number_check_mid",
			"FactionRoundStart",
			function() return cm:model():turn_number() >= ci_mid_game_turn_timeout end,
			function() ci_timeout(function() ci_mid_game_start("turn number timeout") end, "FactionTurnEnd") end,
			false
		);
	end;
	
	core:add_listener(
		"imperium_level_check_mid",
		"FactionRoundStart",
		function(context) return context:faction():is_human() and context:faction():imperium_level() >= ci_mid_game_imperium end,
		function(context) ci_mid_game_start("human faction [" .. context:faction():name() .. "] has reached required or exceeded imperium level") end,
		true
	);
	
	-- add mp-only listener for mid-game chaos event flag
	if cm:is_multiplayer() then
		core:add_listener(
			"mp_only_mid_game_event_turn_start_listener",
			"FactionRoundStart",
			function(context) return context:faction():is_human() and cm:get_saved_value("ci_trigger_mid_game_event_on_turn_start") end,
			function()
				out.chaos("FactionRoundStart listener has found ci_trigger_mid_game_event_on_turn_start to be true");
				ci_mid_game_event_mpc();
				ci_mid_game_start_setup();
			end,
			false
		);
	end;
	
	
	---------------------------------------------------------
	-- early game event
	---------------------------------------------------------
	if cm:get_local_faction(true) and cm:model():turn_number() < 50 and not cm:get_saved_value("ci_early_event_shown") then
		core:add_listener(
			"early_game_event_message",
			"FactionTurnStart",
			function(context) return context:faction():is_human() and cm:model():turn_number() >= ci_early_game_event_turn end,
			function() ci_timeout(function() ci_early_game_show_event() end, "FactionTurnStart") end,
			false
		);
	end;
end;

function ci_early_game_show_event()
	core:remove_listener("early_game_event_message");
	core:remove_listener("ci_roll");
	
	if cm:get_saved_value("ci_stage") > 0 then
		out.chaos("Tried to show the early game message event, but the player has already reached the mid game event, how can this happen?");
		return;
	end;
	
	local human_factions = cm:get_human_factions();
	
	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_early_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_early_secondary_detail",
			true,
			29
		);
	end;
	
	cm:set_saved_value("ci_early_event_shown", true);
end;

function ci_player_chaos()
	if not cm:get_saved_value("ci_player_chaos_personality_change") then
		core:add_listener(
			"turn_number_check",
			"FactionTurnStart",
			function()
				return cm:model():turn_number() >= ci_player_chaos_personality_shuffle_turn;
			end,
			function()
				out.chaos("ci_player_chaos_personality_shuffle_turn number reached, going to shuffle AI personalities now");
				ci_force_personality_change_in_all_factions();
			end,
			false
		);
	end;
end;

function ci_get_archaon()
	local faction = cm:get_faction(ci_chaos_faction_string);
	local char_list = faction:character_list();
	
	for i = 0, char_list:num_items() - 1 do
		local current_char = char_list:item_at(i);
		
		if current_char:get_forename() == ci_archaon_forename then
			return current_char;
		end;
	end;
end;

function ci_force_personality_change_in_all_factions(stage)
	out.chaos("Forcing personality change in all AI factions");
	
	cm:set_saved_value("ci_player_chaos_personality_change", true);
	
	local round_override = 0;
	
	if stage == 2 then
		round_override = 30;
	elseif stage == 3 then
		round_override = 100;
	elseif stage == 4 then
		round_override = 150;
	end;
	
	local faction_list = cm:model():world():faction_list();
	
	-- force personality change in all AI factions with an optional round override (in case events trigger early)
	-- don't change Norsca faction personalities if Beastmen is human in SPC
	local skip_norsca = false;	
	
	if player_1:culture("wh_dlc03_bst_beastmen") then
		skip_norsca = true;
	elseif player_2:culture("wh_dlc03_bst_beastmen") then
		skip_norsca = true;
	end
	
	for i = 0, faction_list:num_items() - 1 do
		local faction = faction_list:item_at(i);
		
		if not faction:is_human() then
			if skip_norsca and faction:subculture() == "wh_main_sc_nor_norsca" then
				break;
			end;
			
			local faction_name = faction:name();
			
			if stage then
				cm:cai_force_personality_change_with_override_round_number(faction_name, round_override);
			else
				cm:cai_force_personality_change(faction_name);
			end;
		end;
	end;
	
	-- for Chaos Invasion event (around turn 100), force personalties that contain the "Shield of Civilisation" trait
	if stage == 3 then
		local difficulty = ci_get_difficulty();
		local use_hard_personalities = false;
		
		-- if the campaign is Very Hard or Legendary then use the hard personalities
		if (difficulty == 4 or difficulty == 5) and not cm:is_multiplayer() then
			use_hard_personalities = true;
		end;
		
		local empire_personalities = {
			"wh_empire_default_allied",
			"wh_empire_subordinate_allied",
			"wh_empire_variant1_allied"
		};
		
		local empire_personalities_hard = {
			"wh_empire_default_hard_allied",
			"wh_empire_subordinate_hard_allied",
			"wh_empire_variant1_hard_allied"
		};
		
		local dwarfs_personalities = {
			"wh_dwarfs_default_allied",
			"wh_dwarfs_subordinate_allied",
			"wh_dwarfs_variant1_allied"
		};
		
		local dwarfs_personalities_hard = {
			"wh_dwarfs_default_hard_allied",
			"wh_dwarfs_subordinate_hard_allied",
			"wh_dwarfs_variant1_hard_allied"
		};
		
		local high_elves_personalities = {
			"wh2_highelf_allied",
			"wh2_highelf_defensive_allied",
			"wh2_highelf_internally_hostile_defensive_allied"
		};
		
		local high_elves_personalities_hard = {
			"wh2_highelf_hard_allied",
			"wh2_highelf_defensive_hard_allied",
			"wh2_highelf_internally_hostile_defensive_less_diplomatic_hard_allied"
		};
		
		local lizardmen_personalities = {
			"wh2_lizardmen_allied",
			"wh2_passive_straightforward_allied"
		};
		
		local lizardmen_personalities_hard = {
			"wh2_lizardmen_hard_allied",
			"wh2_passive_straightforward_hard_allied"
		};
		
		local faction_list = cm:model():world():faction_list();
		
		for i = 0, faction_list:num_items() - 1 do
			local faction = faction_list:item_at(i);
			local faction_name = faction:name();
			local faction_culture = faction:culture();
			
			if not faction:is_human() then
				if faction_culture == "wh_main_emp_empire" or faction_culture == "wh_main_brt_bretonnia" then
					if faction_name == "wh_main_emp_empire" or faction_name == "wh_main_brt_bretonnia" then
						if use_hard_personalities then
							cm:force_change_cai_faction_personality(faction_name, "wh_empire_subjugator_hard_allied");
						else
							cm:force_change_cai_faction_personality(faction_name, "wh_empire_subjugator_allied");
						end;
					elseif faction:subculture() == "wh_main_sc_teb_teb" or faction:subculture() == "wh_main_sc_ksl_kislev" then
						if use_hard_personalities then
							cm:force_change_cai_faction_personality(faction_name, "wh_teb_default_allied");
						else
							cm:force_change_cai_faction_personality(faction_name, "wh_teb_default_hard_allied");
						end;
					elseif use_hard_personalities then
						cm:force_change_cai_faction_personality(faction_name, empire_personalities_hard[cm:random_number(#empire_personalities_hard)]);
					else
						cm:force_change_cai_faction_personality(faction_name, empire_personalities[cm:random_number(#empire_personalities)]);
					end;
				elseif faction_culture == "wh_main_dwf_dwarfs" then
					if faction_name == "wh_main_dwf_dwarfs" then
						if use_hard_personalities then
							cm:force_change_cai_faction_personality(faction_name, "wh_dwarfs_subjugator_hard_allied");
						else
							cm:force_change_cai_faction_personality(faction_name, "wh_dwarfs_subjugator_allied");
						end;
					elseif use_hard_personalities then
						cm:force_change_cai_faction_personality(faction_name, dwarfs_personalities_hard[cm:random_number(#dwarfs_personalities_hard)]);
					else
						cm:force_change_cai_faction_personality(faction_name, dwarfs_personalities[cm:random_number(#dwarfs_personalities)]);
					end;
				elseif faction_culture == "wh2_main_hef_high_elves" then
					if faction_name == "wh2_main_hef_eataine" or faction_name == "wh2_main_hef_order_of_loremasters" then
						if use_hard_personalities then
							cm:force_change_cai_faction_personality(faction_name, "wh2_highelf_major_hard_allied");
						else
							cm:force_change_cai_faction_personality(faction_name, "wh2_highelf_major_allied");
						end;
					elseif use_hard_personalities then
						cm:force_change_cai_faction_personality(faction_name, high_elves_personalities_hard[cm:random_number(#high_elves_personalities_hard)]);
					else
						cm:force_change_cai_faction_personality(faction_name, high_elves_personalities[cm:random_number(#high_elves_personalities)]);
					end;
				elseif faction_culture == "wh2_main_lzd_lizardmen" then
					if faction_name == "wh2_main_lzd_hexoatl" or faction_name == "wh2_main_lzd_last_defenders" then
						if use_hard_personalities then
							cm:force_change_cai_faction_personality(faction_name, "wh2_lizardmen_major_hard_allied");
						else
							cm:force_change_cai_faction_personality(faction_name, "wh2_lizardmen_major_allied");
						end;
					elseif use_hard_personalities then
						cm:force_change_cai_faction_personality(faction_name, lizardmen_personalities_hard[cm:random_number(#lizardmen_personalities_hard)]);
					else
						cm:force_change_cai_faction_personality(faction_name, lizardmen_personalities[cm:random_number(#lizardmen_personalities)]);
					end;
				end;
			end;
		end;
	end;
end;

function ci_mid_game_start(reason)
	out.chaos("Beginning the mid game Chaos Invasion! Reason is: " .. tostring(reason));
	
	core:remove_listener("turn_number_check_mid");
	core:remove_listener("imperium_level_check_mid");
	core:remove_listener("ci_roll");
	
	if cm:get_local_faction(true) then
		-- set a saved value so that the chaos invasion event happens the next time the player starts the turn
		out.chaos("marking ci_trigger_mid_game_event_on_turn_start as true");
		cm:set_saved_value("ci_trigger_mid_game_event_on_turn_start", true);
	else
		out.chaos("*** AUTORUN RUNNING *** Spawning mid game first wave");	
		ci_spawn_horde(1, function() ci_mid_game_transition() end);
		ci_mid_game_start_setup();
	end;
end;

function ci_mid_game_start_setup()
	if cm:get_local_faction(true) and not cm:is_multiplayer() then
		out.chaos("Disabling saving game");
		cm:disable_saving_game(true);
	end;
	
	if not cm:get_saved_value("ci_player_chaos_personality_change") then
		ci_force_personality_change_in_all_factions();
	end
	
	-- apply a dummy effect bundle to all human factions - this is just for the sake of player visibility
	local faction_list = cm:model():world():faction_list();
	
	for i = 0, faction_list:num_items() - 1 do
		local current_faction = faction_list:item_at(i);
		
		if current_faction:is_human() then
			local effect_bundle = "wh_main_bundle_faction_chaos_rises";
			
			if current_faction:culture() == "wh_dlc03_bst_beastmen" then
				effect_bundle = "wh_main_bundle_faction_chaos_rises_good";
			end;
			
			cm:apply_effect_bundle(effect_bundle, current_faction:name(), 0)
		end;
	end;
	
	-- apply effect bundles to all province capitals that actually give the Chaos corruption effect
	-- if this is done faction wide then provinces can get multiple corruption effects
	local region_list = cm:model():world():region_manager():region_list();
	
	for i = 0, region_list:num_items() - 1 do
		local current_region = region_list:item_at(i);
		
		if current_region:is_province_capital() then
			cm:apply_effect_bundle_to_region("wh_main_bundle_region_chaos_rises", current_region:name(), 0);
		end;
	end;
	
	-- spawn Chaos agents
	ci_spawn_agent(2);
	
	-- start listeners for transition to the late game
	-- pass through an exemption turn, as otherwise the listener will trigger on the FactionTurnStart event that happens immediately after this
	-- (we are currently processing the FactionRoundStart event)
	ci_mid_game_setup_listeners(cm:model():turn_number())
end;

--[[
in_ci_mid_game_event = intervention:new(
	"ci_mid_game_event",														-- string name
	0,																			-- cost
	function() ci_mid_game_cutscene() end,										-- trigger callback
	BOOL_INTERVENTIONS_DEBUG	 												-- show debug output
);

in_ci_mid_game_event:add_trigger_condition(
	"ScriptEventPlayerFactionTurnStart",
	function(context) return cm:get_saved_value("ci_trigger_mid_game_event_on_turn_start") end
);

in_ci_mid_game_event:set_suppress_pause_before_triggering(true);
in_ci_mid_game_event:set_wait_for_event_dismissed(false);
--]]

function ci_mid_game_cutscene()
	--cm:set_use_cinematic_borders_for_automated_cutscenes(true);
	
	ci_mid_game_start_setup();
	
	local cached_x, cached_y, cached_d, cached_b, cached_h = cm:get_camera_position();
	
	local failsafe_final_pos = {517.6, 476.2, 16.7, 0, 14.0};
	
	local override_final_pos = {332.9, 354.3, 14, 0.0, 14};
	local override_region_to_unshroud = "wh_main_chaos_wastes";
	
	chaos_rises_start_pos = {517.6, 476.2, 16.7, 0, 14.0};
	chaos_rises_scene = "";
	
--[[
	if not chaos_rises_scene then
		override_final_pos, override_region_to_unshroud = ci_initialise_cutscene();
	end;
--]]
	
	local event_callback = function()
		cm:fade_scene(0, 0.5);
		
		cm:callback(
			function()
				cm:set_camera_position(cached_x, cached_y, cached_d, cached_b, cached_h);
				cm:fade_scene(1, 0.5);
				cm:restore_shroud_from_snapshot();
--				in_ci_mid_game_event:complete();
			end,
			0.5
		);
	end;
	
	local hordes_spawned = false;
	
	-- function to spawn the chaos hordes towards/at the end of the cutscene
	-- this function completes the intervention, restores the shroud and repositions the camera back at the start position when the event panel is dismissed
	local spawn_hordes_func = function()
		-- only let it work once
		if hordes_spawned then
			return;
		end;
		
		hordes_spawned = true;
		
		ci_spawn_horde(
			1, 
			function()
				cm:modify_advice(true, false);
				
				-- show event
				ci_mid_game_show_event(event_callback);
				
				-- officially transfer to the mid-game period
				ci_mid_game_transition();
			end
		);
	end;
	
--	if is_table(chaos_rises_start_pos) and is_string(chaos_rises_scene) then
		local cindy_scene_started = false;
		local last_advice_given = false;
		
		--
		--	singleplayer cutscene with cindy scene - declaration
		--
		
		local cutscene = campaign_cutscene:new(
			"chaos_rises",
			23.5
		);
		
		cutscene:set_disable_settlement_labels(false);
		cutscene:set_restore_shroud(false);
		
		--
		--	skip callback
		--
		
--		cutscene:set_skippable(
--			true,
--			function()
				-- if we've yet to start the cindy scene/fading to black at the moment the cutscene is skipped, wait half a second
				-- before repositioning the camera and fading back again, to give the fade time to complete
				
				cm:fade_scene(0, 0);
				
				if not cindy_scene_started then
					cm:callback(
						function()
							cm:set_camera_position(517.6, 476.2, 16.7, 0, 14.0);
							cm:fade_scene(1, 0.5);
							
--							cm:show_advice("war.camp.advice.chaos_rising.003", true);
						end,
						0.5
					);
				elseif not last_advice_given then
					cm:show_advice("war.camp.advice.chaos_rising.003", true);
					cm:callback(function() cm:fade_scene(1, 0.5) end, 0.5);
				end;
				
				cm:restore_shroud_from_snapshot();
				
				cm:take_shroud_snapshot();
				
				cm:make_region_visible_in_shroud(cm:get_local_faction(true), ci_chaos_wastes_string);
				
				spawn_hordes_func();
--			end
--		);
		
		--
		--	actions
		--
		
		-- fade to black, reposition camera at start position, start the cindy scene and then fade from black again
		cutscene:action(
			function()
				cm:take_shroud_snapshot();
				cm:fade_scene(0, 0.5);
			end,
			0
		);
		
		cutscene:action(function() cm:set_camera_position(517.6, 476.2, 16.7, 0, 14.0) end, 0.5);	-- the game dislikes receiving variables for coordinates
		
		cutscene:action(
			function()
				cindy_scene_started = true;
				
				cm:show_shroud(false);
				
				cutscene:cindy_playback(chaos_rises_scene, true, true);
			end, 
			0.6
		);
		
		cutscene:action(function() cm:fade_scene(1, 0.5) end, 0.7);
		
		cutscene:action(function() cm:show_advice("war.camp.advice.chaos_rising.002"); end, 1.5);
		
		cm:scroll_camera_with_cutscene(10, end_callback, 517.6, 476.2, 16.7, 0, 14.0);
		
		cutscene:action(
			function()
				cutscene:wait_for_advisor();
			end,
			16
		);
		
		cutscene:action(
			function()
				last_advice_given = true;
				cm:show_advice("war.camp.advice.chaos_rising.003");
			end, 
			16.5
		);
		
		cutscene:action(
			function()
				spawn_hordes_func();
				
				cm:restore_shroud_from_snapshot();
				
				cm:take_shroud_snapshot();
				
				cm:make_region_visible_in_shroud(cm:get_local_faction(true), ci_chaos_wastes_string);
			end,
			21		-- needs to be close enough to the end of the cutscene that the event message will trigger after the cutscene ends
		);
		
		cutscene:start();
		
		ci_mid_game_start_setup();
--[[
	elseif override_final_pos then
		local cutscene = campaign_cutscene:new(
			"chaos_rises",
			14
		);
		
		cutscene:set_disable_settlement_labels(false);
		cutscene:set_restore_shroud(false);
		
		cutscene:set_skippable(
			true,
			function()
				cm:fade_scene(0, 0);
				
				cm:callback(
					function()
						cm:make_region_visible_in_shroud(cm:get_local_faction(true), override_region_to_unshroud);
						cm:set_camera_position(unpack(override_final_pos));
						cm:fade_scene(1, 0.5);
					end,
					0.5
				);
				
				spawn_hordes_func();
			end
		);
		
		-- fade to black, reposition camera at start position, start the cindy scene and then fade from black again
		cutscene:action(
			function()
				cm:take_shroud_snapshot();
				cm:fade_scene(0, 0.5);
			end,
			0
		);
		
		cutscene:action(
			function()
				cm:set_camera_position(unpack(chaos_rises_start_pos));
			end,
			0.5
		);
		
		cutscene:action(
			function()
				cm:fade_scene(1, 0.5);
			end,
			0.7
		);
		
		cutscene:action(
			function()
				cm:show_advice("war.camp.advice.chaos_rising.002");
				
				cm:scroll_camera_from_current(false, 8, override_final_pos);
			end,
			1.2
		);
		
		cutscene:action(
			function()
				cm:make_region_visible_in_shroud(cm:get_local_faction(true), override_region_to_unshroud);
				
				spawn_hordes_func();
			end,
			9.5
		);
		
		cutscene:start();
	end;
--]]
end;

function ci_mid_game_event_mpc()
	out.chaos("ci_mid_game_event_mpc() called");
	
	ci_spawn_horde(
		1,
		function()
			-- show event
			ci_mid_game_show_event();
			
			-- officially transfer to the mid-game period
			ci_mid_game_transition();
		end
	);
end;


function ci_mid_game_show_event(callback, delay)
	out.chaos("ci_mid_game_show_event() called");
	
	if cm:get_local_faction(true) and cm:get_saved_value("ci_stage") == 0 then
		cm:whitelist_event_feed_event_type("scripted_persistent_located_eventevent_feed_target_faction");
		
		local human_factions = cm:get_human_factions();
		
		for i = 1, #human_factions do
			cm:show_message_event_located(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_mid_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_mid_secondary_detail",
				770,
				617,
				true,
				30,
				callback,
				delay
			);
		end;
	end;
end;


-- officially transition to the mid-game period
function ci_mid_game_transition()
	out.chaos("ci_mid_game_transition() called");

	cm:set_saved_value("ci_stage", 1);
	
	-- prevent the mid-game transition from repeating
	cm:set_saved_value("ci_trigger_mid_game_event_on_turn_start", false);
	
	-- lock the legendary lords (in MPC, we do this in diplomacy setup)
	if not cm:is_multiplayer() then
		out.chaos("\t[SPC] Locking Archaon, Sigvald and Kholek!");
		cm:lock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
		cm:lock_starting_general_recruitment("2140783662", ci_chaos_faction_string);
		cm:lock_starting_general_recruitment("2140783672", ci_chaos_faction_string);
	end;
	
	if not cm:get_saved_value("intercontinental_diplomacy_available") then
		make_intercontinental_diplomacy_available(true, 80000);
	end
	
	ci_chaos_diplomacy_startup();
	
	ci_autosave_and_enable_saving();
end;

-- reapply the corruption effect bundle if a region is occupied or razed as this removes it
function ci_setup_region_change_listeners(stage, effect_bundle)
	core:add_listener(
		"settlement_occupied_" .. stage,
		"GarrisonOccupiedEvent",
		true,
		function(context)
			local region = context:garrison_residence():region();
			
			if region:is_province_capital() then
				local region_name = region:name();
				
				cm:remove_effect_bundle_from_region(effect_bundle, region_name);
				cm:apply_effect_bundle_to_region(effect_bundle, region_name, 0);
			end;
		end,
		true
	);
	
	core:add_listener(
		"settlement_razed_" .. stage,
		"CharacterRazedSettlement",
		true,
		function(context)
			local region = context:character():region();
			
			if region:is_province_capital() then
				local region_name = region:name();
				
				cm:remove_effect_bundle_from_region(effect_bundle, region_name);
				cm:apply_effect_bundle_to_region(effect_bundle, region_name, 0);
			end;
		end,
		true
	);
	
	core:add_listener(
		"settlement_confederated_" .. stage,
		"FactionJoinsConfederation",
		true,
		function(context)
			local faction = context:confederation();
			local region_list = faction:region_list();
			
			for i = 0, region_list:num_items() - 1 do
				local region = region_list:item_at(i);
				
				if region:is_province_capital() then
					local region_name = region:name();
					
					cm:remove_effect_bundle_from_region(effect_bundle, region_name);
					cm:apply_effect_bundle_to_region(effect_bundle, region_name, 0);
				end;
			end;
		end,
		true
	);
end;

-- start listeners for the transition to late game
function ci_mid_game_setup_listeners(exemption_turn)
	out.chaos("Setting up listeners to transition from the mid game event to the late game event");
	
	if is_number(exemption_turn) then
		out.chaos("\twe were passed an exemption turn [" .. exemption_turn .. "] - the Chaos army count listener will disregard any hits it receives on this turn");
	end;
	
	-- keep the number of Chaos forces topped-up
	if cm:get_local_faction(true) then
		-- not-autorun
		core:add_listener(
			"chaos_army_count_check_mid",
			"FactionTurnStart",
			-- don't do the doom tide if we're about to start the late game event
			function(context) return context:faction():is_human() and (not exemption_turn or cm:model():turn_number() ~= exemption_turn) end,
			function()
				local num_hordes = ci_get_num_hordes();
				
				if num_hordes > 0 and cm:get_saved_value("ci_start_pre_late_game_to_late_game_listener") then
					out.chaos("Tried to do a Doom Tide event, but we've reached the late game event and Chaos have at least one army");
					return;
				end;
				
				if num_hordes < 2 then
					out.chaos("Chaos has dropped to one or fewer armies, spawning another wave");
					
					ci_spawn_horde(
						1,
						function()
							ci_chaos_diplomacy_startup();
							
							if not cm:get_saved_value("ci_archaon_not_spawned") then
								out.chaos("\tBringing back the Chaos faction, re-locking Archaon, Sigvald and Kholek!");
								
								local archaon = ci_get_archaon();
								
								if archaon:has_military_force() then
									out.chaos("Archaon is leading an army during the mid game event, how can this happen?");
								else
									cm:lock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
								end;
								
								cm:lock_starting_general_recruitment("2140783662", ci_chaos_faction_string);
								cm:lock_starting_general_recruitment("2140783672", ci_chaos_faction_string);
							end;
						end
					);
					
					local human_factions = cm:get_human_factions();
					
					for i = 1, #human_factions do
						cm:show_message_event_located(
							human_factions[i],
							"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_wave_primary_detail",
							"",
							"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_wave_secondary_detail",
							775,
							605,
							true,
							32
						);
					end;
				end;
			end,
			true
		);
	else
		-- autorun only	
		core:add_listener(
			"chaos_army_count_check_mid",
			"FactionTurnStart",
			function(context) return context:faction():name() == ci_chaos_faction_string end,
			function()
				local num_hordes = ci_get_num_hordes();
				
				if num_hordes < 2 then
					out.chaos("*** AUTORUN RUNNING *** Chaos has dropped to one army, spawning another wave");
					
					ci_spawn_horde(
						1,
						function()
							ci_chaos_diplomacy_startup();
							
							out.chaos("\t[AUTORUN] Locking Archaon, Sigvald and Kholek!");
							cm:lock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
							cm:lock_starting_general_recruitment("2140783662", ci_chaos_faction_string);
							cm:lock_starting_general_recruitment("2140783672", ci_chaos_faction_string);
						end
					);
				end;
			end,
			true
		);
	end;
	
	ci_setup_region_change_listeners("mid_game", "wh_main_bundle_region_chaos_rises");
	
	--
	-- listen for transition to late-game
	--
	
	if not cm:get_saved_value("ci_start_pre_late_game_to_late_game_listener_mp") then
		core:add_listener(
			"imperium_level_check_late",
			"FactionTurnStart",
			function(context) return context:faction():is_human() and context:faction():imperium_level() >= ci_late_game_imperium and (not cm:is_multiplayer() or ci_get_num_hordes(ci_chaos_faction_string) > 0) end,
			function(context) ci_pre_late_game_start("player faction [" .. context:faction():name() .. "] has reached or exceeded required imperium level") end,
			false
		);
		
		if is_number(ci_late_game_turn_timeout) then
			if cm:get_local_faction(true) then
				core:add_listener(
					"turn_number_check_late",
					"FactionTurnStart",
					function(context) return context:faction():is_human() and cm:model():turn_number() >= ci_late_game_turn_timeout and (not cm:is_multiplayer() or ci_get_num_hordes(ci_chaos_faction_string) > 0) end,
					function() ci_timeout(function() ci_pre_late_game_start("Turn timeout has been reached or exceeded") end, "FactionRoundStart") end,
					false
				);
			else
				core:add_listener(
					"turn_number_check_late_autorun",
					"FactionTurnStart",
					function(context) return cm:model():turn_number() >= ci_late_game_turn_timeout and (not cm:is_multiplayer() or ci_get_num_hordes(ci_chaos_faction_string) > 0) end,
					function() ci_timeout(function() ci_pre_late_game_start("Turn timeout has been reached or exceeded") end, "FactionRoundStart") end,
					false
				);
			end;
		end;
	end;
	
	if cm:is_multiplayer() then
		core:add_listener(
			"turn_number_check_late",
			"FactionTurnStart",
			function(context) 
				local turn_number = cm:get_saved_value("ci_start_pre_late_game_to_late_game_listener_mp");
				
				return context:faction():is_human() and turn_number and turn_number < cm:model():turn_number();
			end,
			function()
				ci_late_game_start();
			end,
			false
		);
	else
		ci_late_game_start();
	end;
end;


function ci_pre_late_game_start(reason)
	out.chaos("Beginning the pre late game Chaos Invasion! Reason: " .. tostring(reason));
	
	out.chaos("\tUnlocking Archaon!");
	cm:unlock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
	cm:set_saved_value("ci_archaon_not_spawned", true);
	
	core:remove_listener("turn_number_check_late");
	core:remove_listener("turn_number_check_late_autorun");
	core:remove_listener("imperium_level_check_late");
	
	ci_skip_chaos_turn_listener();
	
	if cm:is_multiplayer() then
		cm:set_saved_value("ci_start_pre_late_game_to_late_game_listener_mp", cm:model():turn_number());
	else
		cm:set_saved_value("ci_start_pre_late_game_to_late_game_listener", true);
	end;
	
	ci_late_game_start();
end;


-- called when the conditions are correct to transition to late game
function ci_late_game_start()
	if cm:is_multiplayer() then
		local turn_number = cm:get_saved_value("ci_start_pre_late_game_to_late_game_listener_mp");
		if not turn_number or turn_number >= cm:model():turn_number() then
			return;
		end;
	elseif not cm:get_saved_value("ci_start_pre_late_game_to_late_game_listener") then
		return;
	end;
	
	-- remove listeners
	ci_late_game_remove_listeners();
	
	if cm:is_multiplayer() then
		-- multiplayer
		-- play movie, spawn some stuff, then transition immediately to late game (see bottom of this function)
		ci_late_game_play_chaos_rises_movie();
		
		out.chaos("\tUnlocking Archaon, Sigvald and Kholek!");
		cm:unlock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
		cm:unlock_starting_general_recruitment("2140783662", ci_chaos_faction_string);
		cm:unlock_starting_general_recruitment("2140783672", ci_chaos_faction_string);
		
		ci_spawn_archaon();
		
		-- spawn the Lord of Change
		ci_spawn_special_character(ci_loc_details);
		
		ci_spawn_horde(2, function() ci_late_game_show_event_and_advice() end);
	elseif cm:get_local_faction(true) then
		-- singleplayer
		-- set value for intervention to listen for and return
		cm:set_saved_value("ci_trigger_late_game_event_on_turn_start", true);
		return;
	else
		core:remove_listener("chaos_army_count_check_mid");
		
		out.chaos("\tUnlocking Archaon, Sigvald and Kholek!");
		cm:unlock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
		cm:unlock_starting_general_recruitment("2140783662", ci_chaos_faction_string);
		cm:unlock_starting_general_recruitment("2140783672", ci_chaos_faction_string);
		
		out.chaos("*** AUTORUN RUNNING *** Spawning Archaon");
		ci_spawn_archaon();
		
		out.chaos("*** AUTORUN RUNNING *** Spawning Lord of Change");
		ci_spawn_special_character(ci_loc_details);
		
		-- we offset this to make sure the spawn horde check picks up the two previous characters in autoruns
		-- not needed in SP as we spawn an army each second, but autoruns spawns them all together
		out.chaos("*** AUTORUN RUNNING *** Spawning late game first wave");
		cm:callback(function() ci_spawn_horde(2) end, 0.2);
	end;
	
	-- officially transition into late-game
	ci_late_game_transition();
end;


-- remove the listeners that facilitate moving from the mid-game period to the late-game period
-- this is called when one of those listeners is fired, and also when the transition actually happens 
-- (it's called twice to handle the one-turn window that opens in sp before the intervention fires)
function ci_late_game_remove_listeners()
	core:remove_listener("turn_number_check_late");
	core:remove_listener("turn_number_check_late_autorun");
	core:remove_listener("imperium_level_check_late");
	core:remove_listener("settlement_occupied_mid_game");
	core:remove_listener("settlement_razed_mid_game");
	core:remove_listener("settlement_confederated_mid_game");
	core:remove_listener("ci_roll");
end;



-- officially transition to the late-game period (this only gets called once)
function ci_late_game_transition()
	out.chaos("ci_late_game_transition() called");
	
	cm:set_camera_position(517.6, 476.2, 16.7, 0, 14.0);
	
	if cm:get_local_faction(true) and not cm:is_multiplayer() then
		out.chaos("Disabling saving game");
		cm:disable_saving_game(true);
	end;
	
	cm:set_saved_value("ci_stage", 2);
	
	-- prevent the late-game transition from repeating
	cm:set_saved_value("ci_trigger_late_game_event_on_turn_start", false);
	
	-- start listeners for late-game event
	ci_late_game_setup_listeners();
	
	ci_chaos_diplomacy_startup();
	
	make_intercontinental_diplomacy_available();
	
	-- spawn Norsca armies in singleplayer
	if not cm:is_multiplayer() then
		ci_spawn_norsca();
	end;
	
	local faction_list = cm:model():world():faction_list();
	local human_factions = cm:get_human_factions();
	
	-- declare war on human factions first
	local mpc_declared_war_on_player_1 = true;
	
	for i = 1, #human_factions do
		local current_faction_name = human_factions[i];
		local current_faction = cm:get_faction(current_faction_name);
		
		-- apply a dummy effect bundle to all human factions - this is just for the sake of player visibility and remove the mid-game bundle
		local effect_bundle = "wh_main_bundle_faction_chaos_invasion";
		
		if current_faction:culture() == "wh_dlc03_bst_beastmen" then
			effect_bundle = "wh_main_bundle_faction_chaos_invasion_good";
		end;
		
		cm:apply_effect_bundle(effect_bundle, current_faction_name, 0);
		
		cm:remove_effect_bundle("wh_main_bundle_faction_chaos_rises", current_faction_name);
		cm:remove_effect_bundle("wh_main_bundle_faction_chaos_rises_good", current_faction_name);
		
		-- don't declare war on human Beastmen or Norsca in SPC
		if not cm:is_multiplayer() and (current_faction:subculture() == "wh_dlc03_sc_bst_beastmen" or current_faction:subculture() == "wh_main_sc_nor_norsca") then
			out.chaos("A) NOT declaring war on [" .. current_faction_name .. "] because it is a SPC and their subculture is Beastmen or Norsca");
		else
			out.chaos("A) Declaring war on [" .. current_faction_name .. "]");
			cm:force_declare_war(ci_chaos_faction_string, current_faction_name, false, false); -- don't invite the players' allies, we do this later
			cm:force_diplomacy("faction:" .. ci_chaos_faction_string, "faction:" .. current_faction_name, "peace", false, false, true);
		end;
	end;
	
	-- apply effect bundles to all province capitals that actually give the Chaos corruption effect
	-- if this is done faction wide then provinces can get multiple corruption effects
	local region_list = cm:model():world():region_manager():region_list();
	
	for i = 0, region_list:num_items() - 1 do
		local current_region = region_list:item_at(i);
		
		if current_region:is_province_capital() then
			local current_region_name = current_region:name();
			
			cm:remove_effect_bundle_from_region("wh_main_bundle_region_chaos_rises", current_region_name);
			cm:apply_effect_bundle_to_region("wh_main_bundle_region_chaos_invasion", current_region_name, 0);
		end;
	end;
	
	-- check if player is Beastmen in SPC and allied with Chaos
	local playable_beastmen_faction = cm:get_faction("wh_dlc03_bst_beastmen");
	local chaos_faction = cm:get_faction(ci_chaos_faction_string);
	--[[
	local player_allied_with_chaos = false;
	
	if not cm:is_multiplayer() and playable_beastmen_faction:allied_with(chaos_faction) then
		player_allied_with_chaos = true;
	end;
	
	local human_factions = cm:get_human_factions();
	local player_1 = cm:get_faction(human_factions[1]);
	local player_2 = nil;
	-- only get player 2 if one exists
	if cm:is_multiplayer() then
		player_2 = cm:get_faction(human_factions[2]);
	end;
	--]]

	-- loop through all non-Chaos and Beastmen culture factions that are alive and not vassals
	for i = 0, faction_list:num_items() - 1 do
		local current_faction = faction_list:item_at(i);
		local current_faction_name = current_faction:name();
		local current_faction_culture = current_faction:culture();
		
		if (current_faction_culture ~= "wh_main_chs_chaos" and current_faction_culture ~= "wh_dlc03_bst_beastmen" and current_faction_culture ~= "wh2_main_rogue") and not current_faction:is_dead() and not current_faction:is_human() then
			-- declare war on AI factions next (picking up any allies from the above)
			-- force war between this faction and Beastmen if player is Beastmen and allied with Chaos in SPC
			if not cm:is_multiplayer() and playable_beastmen_faction:allied_with(chaos_faction) then
				out.chaos("B) Declaring player-Beastmen war on [" .. current_faction_name .. "]");
				cm:force_declare_war("wh_dlc03_bst_beastmen", current_faction_name, false, false);
			end;
			
			out.chaos("C) Declaring war on [" .. current_faction_name .. "]");
			cm:force_declare_war(ci_chaos_faction_string, current_faction_name, false, false);
			cm:force_diplomacy("faction:" .. ci_chaos_faction_string, "faction:" .. current_faction_name, "peace", false, false, true);
		end;
	end;
	
	cm:callback(function() ci_make_chaos_vassals() end, 0.2);

	ci_force_personality_change_in_all_factions(3);
	
	-- remove the listener previously keeping the army alive
	core:remove_listener("chaos_army_count_check_mid");
	ci_late_game_remove_listeners();		-- this needs to be called here as well as in ci_late_game_start
end;


-- plays the chaos rises movie
function ci_late_game_play_chaos_rises_movie()
	cm:register_instant_movie("Warhammer/chs_rises");
end;






--
--	single-player intervention late-game event: spawn things, then show the event messages and advice
--

in_ci_late_game_event = intervention:new(
	"ci_late_game_event",														-- string name
	0,																			-- cost
	function() ci_late_game_cutscene() end,										-- trigger callback
	BOOL_INTERVENTIONS_DEBUG	 												-- show debug output
);

in_ci_late_game_event:add_trigger_condition(
	"ScriptEventPlayerFactionTurnStart",
	function(context)
		-- only go to the late game event if Chaos have armies on the map, otherwise Archaon may not spawn correctly (if there aren't any armies, it will just do another Doom Tide event)
		local num_hordes = ci_get_num_hordes(ci_chaos_faction_string);
		
		return cm:get_saved_value("ci_trigger_late_game_event_on_turn_start") and num_hordes > 0;
	end
);

in_ci_late_game_event:set_suppress_pause_before_triggering(true);
in_ci_late_game_event:set_wait_for_event_dismissed(false);

function ci_late_game_cutscene()	
	--cm:set_use_cinematic_borders_for_automated_cutscenes(true);
	
	local cached_x, cached_y, cached_d, cached_b, cached_h = cm:get_camera_position();
	
	cm:set_saved_value("ci_trigger_late_game_event_on_turn_start", false);
	
	-- play movie
	ci_late_game_play_chaos_rises_movie();
	
	cm:fade_scene(0, 0.5);
	
	cm:scroll_camera_with_cutscene(
		1,
		function()
			cm:fade_scene(1, 0.5);
			
			cm:take_shroud_snapshot();
			
			cm:make_region_visible_in_shroud(cm:get_local_faction(true), ci_chaos_wastes_string);
			
			out.chaos("\tUnlocking Archaon, Sigvald and Kholek!");
			cm:unlock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
			cm:unlock_starting_general_recruitment("2140783662", ci_chaos_faction_string);
			cm:unlock_starting_general_recruitment("2140783672", ci_chaos_faction_string);
			
			cm:callback(
				function()
					cm:show_advice("war.camp.advice.chaos_rising.001");
					
					ci_spawn_archaon();
					
					cm:callback(
						function()
							-- spawn the Lord of Change
							ci_spawn_special_character(ci_loc_details);
						end,
						1
					);
					
					cm:callback(
						function()
							ci_spawn_horde(
								2,
								function()
									-- whitelist event type we're about to show
									cm:whitelist_event_feed_event_type("scripted_persistent_located_eventevent_feed_target_faction");
									
									cm:modify_advice(true, false);
									
									-- show event message
									ci_late_game_show_event(
										function()
											cm:fade_scene(0, 0.5);
											
											cm:callback(
												function()
													cm:set_camera_position(cached_x, cached_y, cached_d, cached_b, cached_h);
													cm:restore_shroud_from_snapshot();
													cm:fade_scene(1, 0.5);
													in_ci_late_game_event:complete();
													
													-- start archaon monitor interventions
													if in_archaon_encountered then
														in_archaon_encountered:start();
													else
														script_error("WARNING: could not find archaon encountered intervention to start");
													end;
													
													if in_archaon_defeated then
														in_archaon_defeated:start();
													else
														script_error("WARNING: could not find archaon defeated intervention to start");
													end;
													
													ci_autosave_and_enable_saving();
												end,
												0.5
											);
										end
									);
									
									-- officially transition into late-game
									ci_late_game_transition();
								end
							)
						end,
						2
					);
				end,
				1
			);
		end,
		{517.6, 476.2, 16.7, 0, 14.0}
	);
end;

-- show chaos invasion event and advice
function ci_late_game_show_event(callback, delay)
	if cm:get_local_faction(true) then
		local human_factions = cm:get_human_factions();
		
		for i = 1, #human_factions do
			cm:show_message_event_located(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_end_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_end_secondary_detail",
				775,
				605,
				true,
				31,
				callback,
				delay
			);
		end;
	end;
end;



-- set up listeners for the late-game event
function ci_late_game_setup_listeners()
	out.chaos("Setting up listeners for the late game event");
	
	if cm:get_local_faction(true) then
		core:add_listener(
			"chaos_army_count_check_late",
			"FactionTurnStart",
			function(context) return context:faction():is_human() end,
			function()
				if ci_get_num_hordes() < 4 then
					-- get the number of waves we have already spawned
					local num_waves = cm:get_saved_value("ci_num_waves") or 0;
					
					local difficulty = ci_get_difficulty();
					
					-- if Beastmen is human in SPC and difficulty is hard or higher, use normal difficulty instead (otherwise Chaos are overpowered!)
					local playable_beastmen_faction = cm:get_faction("wh_dlc03_bst_beastmen");
					
					if player_1:culture("wh_dlc03_bst_beastmen") then
						difficulty = 2;
					elseif player_2:culture("wh_dlc03_bst_beastmen") then
						difficulty = 2;
					end
					
					-- if we have already spawned enough waves, cancel the monitor
					local desired_waves = ci_num_spawn_waves_late_game[difficulty];
					
					if num_waves >= desired_waves then
						out.chaos("DOOMTIDE: We have already spawned the desired number of additional waves - [" .. desired_waves .. "] - stopping monitor");
						core:remove_listener("chaos_army_count_check_late");
						return;
					end;
					
					cm:set_saved_value("ci_num_waves", num_waves + 1);
					
					out.chaos("DOOMTIDE: Chaos has dropped to fewer than four armies, spawning wave number [" .. num_waves .. "] of [" .. desired_waves .. "]");
					ci_spawn_horde(
						2,
						function()
							-- do the diplomacy setup again in case Chaos is alive but Beastmen is dead (they will need to be made vassal)
							ci_chaos_diplomacy_startup();
						end,
						true	-- spawn these armies in instantly
					);
					
					local human_factions = cm:get_human_factions();
					
					for i = 1, #human_factions do
						cm:show_message_event_located(
							human_factions[i],
							"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_wave_primary_detail",
							"",
							"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_wave_late_secondary_detail",
							775,
							605,
							true,
							32
						);
					end;
				end;
			end,
			true
		);
	else
		core:add_listener(
			"chaos_army_count_check_late",
			"FactionTurnStart",
			function(context) return context:faction():name() == ci_chaos_faction_string end,
			function()
				-- get the number of waves we have already spawned
				local num_waves = cm:get_saved_value("ci_num_waves") or 0;
				
				local desired_waves = ci_num_spawn_waves_late_game[ci_get_difficulty()];
				
				if num_waves >= desired_waves then
					out.chaos("DOOMTIDE: We have already spawned the desired number of additional waves - [" .. desired_waves .. "] - stopping monitor");
					core:remove_listener("chaos_army_count_check_late");
					return;
				end;
				
				if ci_get_num_hordes() < 4 then
					out.chaos("*** AUTORUN RUNNING *** Chaos has dropped to fewer than four armies, spawning another wave");
					ci_spawn_horde(2, function() ci_chaos_diplomacy_startup() end);
				end;
				
				cm:set_saved_value("ci_num_waves", num_waves + 1);
			end,
			true
		);
	end;
	
	ci_setup_region_change_listeners("late_game", "wh_main_bundle_region_chaos_invasion");
	
	core:add_listener(
		"archaon_wounded_monitor",
		"FactionTurnStart",
		true,
		function()
			local archaon = ci_get_archaon();
			
			if archaon == nil or not archaon:has_military_force() then
				out.chaos("Archaon has been wounded - stopping monitor");
				core:remove_listener("archaon_wounded_monitor");
				core:remove_listener("chaos_army_count_check_late");
			end;
		end,
		true
	);
	
	core:add_listener(
		"chaos_defeated_monitor",
		"FactionTurnStart",
		function(context) return context:faction():is_human() end,
		function()
			local num_hordes = ci_get_num_hordes(); --TODO: which factions do we check here? all of them?
			
			if num_hordes < 1 then
				ci_chaos_defeated();
			end;
		end,
		true
	);
	
	-- listen for Kholek and Sigvald being selected by the AI then apply XP to them
	core:add_listener(
		"kholek_sigvald_experience",
		"FactionTurnEnd",
		function(context) return context:faction():name() == ci_chaos_faction_string and not cm:get_saved_value("kholek_sigvald_experience") end,
		function(context)
			local char_list = context:faction():character_list();
			
			for i = 0, char_list:num_items() - 1 do
				local current_char = char_list:item_at(i);
				local current_char_forename = current_char:get_forename();
				
				if (current_char_forename == "names_name_2147345922" or current_char_forename == "names_name_2147345931") and current_char:rank() < 5 then
					cm:add_agent_experience(cm:char_lookup_str(current_char:cqi()), ci_character_xp[3][cm:random_number(3)]);
					cm:set_saved_value("kholek_sigvald_experience", true);
				end;
			end;
		end,
		false
	);
end;

-- show chaos invasion event and advice (currently just used in MPC)
function ci_late_game_show_event_and_advice()
	if cm:get_local_faction(true) then		
		local human_factions = cm:get_human_factions();
		
		for i = 1, #human_factions do
			cm:show_message_event_located(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_end_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_end_secondary_detail",
				775,
				605,
				true,
				31
			);
		end;
		
		cm:show_advice("war.camp.advice.chaos_rising.001", true);
	end;
end;

function ci_chaos_defeated()
	out.chaos("Chaos invasion has happened and Chaos have no military presence - assuming they have been defeated");
	
	cm:set_saved_value("ci_stage", 3);
	
	core:remove_listener("archaon_wounded_monitor");
	core:remove_listener("settlement_occupied_late_game");
	core:remove_listener("settlement_razed_late_game");
	core:remove_listener("settlement_confederated_late_game");
	core:remove_listener("chaos_army_count_check_late");
	core:remove_listener("chaos_defeated_monitor");
	core:remove_listener("kholek_sigvald_experience");
	
	ci_force_personality_change_in_all_factions(4);
	
	-- remove all Chaos related effect bundles
	local faction_list = cm:model():world():faction_list();
	
	for i = 0, faction_list:num_items() - 1 do
		local current_faction = faction_list:item_at(i);
		local current_faction_name = current_faction:name();
		
		if current_faction:is_human() then
			cm:remove_effect_bundle("wh_main_bundle_faction_chaos_invasion", current_faction_name);
			cm:remove_effect_bundle("wh_main_bundle_faction_chaos_invasion_good", current_faction_name);
		end;
	end;
	
	local region_list = cm:model():world():region_manager():region_list();
	
	for i = 0, region_list:num_items() - 1 do
		local current_region = region_list:item_at(i);
		local current_region_name = current_region:name();
			
		cm:remove_effect_bundle_from_region("wh_main_bundle_region_chaos_rises", current_region_name);
		cm:remove_effect_bundle_from_region("wh_main_bundle_region_chaos_invasion", current_region_name);
	end;
	
	if cm:get_local_faction(true) then		
		local human_factions = cm:get_human_factions();
		
		for i = 1, #human_factions do
			local secondary_detail = "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_defeated_secondary_detail";
			local current_faction = cm:get_faction(human_factions[i]);
			
			if current_faction:culture() == "wh_main_vmp_vampire_counts" then
				secondary_detail = "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_defeated_secondary_detail_vmp";
			end;
			
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_defeated_primary_detail",
				"",
				secondary_detail,
				true,
				35
			);
		end;
	end;
end;

function ci_timeout(callback, event_name)
	out.chaos("Player has still not reached required imperium threshold, going to force a CI event soon");
	
	-- if not an autorun...
	if cm:get_local_faction(true) then
		-- this will happen for each human faction, so it will trigger more quickly in multiplayer (AS DESIGNED)
		core:add_listener(
			"ci_roll",
			event_name,
			function(context) return context:faction():is_human() end,
			function()
				ci_timeout_roll(callback);
			end,
			true
		);
		
		-- do the roll as soon as the player turn starts as the listener will need to be established, meaning save/load could avoid the listener entirely
		ci_timeout_roll(callback);
	else
		-- do the callback straight away in autoruns
		callback();
	end;
end;

function ci_timeout_roll(callback)
	local chance = cm:get_saved_value("ci_timeout_roll");
	if chance == nil then chance = 0 end;
	
	chance = chance + 2;
	
	local rnd = 100;
	if test_chaos_invasion_events then
		rnd = 1;
	end;
	
	local roll = cm:random_number(rnd);
	out.chaos("Rolled a " .. roll .. " with a chance of " .. chance .. " to go to the next event");
	cm:set_saved_value("ci_timeout_roll", chance)
	if roll <= chance then
		callback();
		-- reset the saved roll for the next time we do one
		cm:set_saved_value("ci_timeout_roll", 0);
	end;
end;

function ci_spawn_horde(stage, callback, instant)
	local difficulty = ci_get_difficulty();
	local is_multiplayer = cm:is_multiplayer();
	
	-- if Beastmen is human in SPC and difficulty is hard or higher, use normal difficulty instead (otherwise Chaos are overpowered!)
	if player_1:culture("wh_dlc03_bst_beastmen") then
		difficulty = 2;
	elseif player_2:culture("wh_dlc03_bst_beastmen") then
		difficulty = 2;
	end
	
	out.chaos("ci_spawn_horde() called, difficulty level: " .. tostring(difficulty) .. ", is_multiplayer: " .. tostring(is_multiplayer));
	
	local max_num_hordes = ci_max_num_hordes[stage][difficulty];
	
	if is_multiplayer or not cm:get_local_faction(true) then
		out.chaos("\t\tArmies will be spawned with no grace delay as it's a multiplayer or autorun game");
	else
		out.chaos("\t\tIt's a singleplayer game, so armies will be spawned with a grace delay between them");
	end;
	
	local cutscene_length = 0;
	
	for i = 1, #ci_spawn_areas do
		local faction_name = ci_spawn_areas[i][5];
		
		local current_num_hordes = ci_get_num_hordes(faction_name);
		
		out.chaos("\tFaction [" .. faction_name .. "] currently have " .. current_num_hordes .. " armies total, the desired number at this stage is " .. max_num_hordes);
		
		if current_num_hordes >= max_num_hordes then
			out.chaos("\t\tThere are more armies than necessary, not spawning any further armies");
		else
			local desired_hordes = max_num_hordes - current_num_hordes;
			
			if i == 1 then
				cutscene_length = desired_hordes + 1;
			end;
			
			out.chaos("\tThere are fewer armies than necessary, going to attempt to spawn " .. desired_hordes .. " additional armies");
			


			for j = 1, desired_hordes do
				local valid = false;
				local x = 0;
				local y = 0;
				local army_string = false;
				local buildings = ci_chaos_horde_buildings;

		
				--local buildings = ci_chaos_horde_buildings;
			
				-- ==========================STEEL INSERT CODE=========================================================	TO FIND BUILDING VAR
				out.chaos("********************************************************");	
				out.chaos("ATTEMPTING TO CREATE ARMY." ..tostring(j));		


				out.chaos("now executing custom chaos buildings code.");
				out.chaos("STAGE =: " ..tostring(stage));

				local army_to_select = cm:random_number(5);
				--	local army_to_select = cm:random_number(4);
				out.chaos("army to select = "..tostring(army_to_select));

				if stage == 1 then
					out.chaos("setting stage 1 building vars.");					
					if army_to_select == 1 then --KHORNE
						out.chaos("army to select = Khorne Army-Spawn Buildings");							
						buildings = ci_chaos_horde_buildings_khorne;	
						--local building_set_to_use = ci_chaos_horde_buildings_khorne;	
						out.chaos("attempting to set building variable to Khorne. local buildings var = "..tostring(buildings));	

					elseif army_to_select == 2 then --TZEENTCH
						out.chaos("army to select = Tzeentch Army-Spawn Buildings");
						buildings = ci_chaos_horde_buildings_tzeentch;	
						out.chaos("attempting to set building variable to tzeentch. local buildings var = "..tostring(buildings));

					elseif army_to_select == 3 then --NURGLE
						out.chaos("army to select = Nurgle Army-Spawn Buildings");
						buildings = ci_chaos_horde_buildings_nurgle;	
						out.chaos("attempting to set building variable to nurgle. local buildings var = "..tostring(buildings));	

					elseif army_to_select == 4 then --SLAANESH
						out.chaos("army to select = Slaanesh Army-Spawn Buildings");
						buildings = ci_chaos_horde_buildings_slaanesh;	
						out.chaos("attempting to set building variable to slaanesh. local buildings var = "..tostring(buildings));
					else
						out.chaos("army to select = UNDIVIDED-Spawn Buildings");
						buildings = ci_chaos_horde_buildings;
						out.chaos("attempting to set building variable to undivided. local buildings var = "..tostring(buildings));	
					
					end;									
					-- ====================================================	
					out.chaos("After check. local buildings var = "..tostring(buildings));	
				else
					out.chaos("setting stage 2 building vars.");							
					if army_to_select == 1 then --KHORNE
						out.chaos("army to select = Khorne Army-Spawn Buildings2");							
						buildings = ci_chaos_horde_buildings_khorne2;	
						--local building_set_to_use = ci_chaos_horde_buildings_khorne;	
						out.chaos("attempting to set building variable to Khorne. local buildings var = "..tostring(buildings));	

					elseif army_to_select == 2 then --TZEENTCH
						out.chaos("army to select = Tzeentch Army-Spawn Buildings2");
						buildings = ci_chaos_horde_buildings_tzeentch2;	
						out.chaos("attempting to set building variable to tzeentch. local buildings var = "..tostring(buildings));

					elseif army_to_select == 3 then --NURGLE
						out.chaos("army to select = Nurgle Army-Spawn Buildings2");
						buildings = ci_chaos_horde_buildings_nurgle2;	
						out.chaos("attempting to set building variable to nurgle. local buildings var = "..tostring(buildings));	

					elseif army_to_select == 4 then --SLAANESH
						out.chaos("army to select = Slaanesh Army-Spawn Buildings2");
						buildings = ci_chaos_horde_buildings_slaanesh2;	
						out.chaos("attempting to set building variable to slaanesh. local buildings var = "..tostring(buildings));
					
					else
						out.chaos("army to select = UNDIVIDED-Spawn Buildings2");
						buildings = ci_chaos_horde_buildings2;
						out.chaos("attempting to set building variable to undivided. local buildings var = "..tostring(buildings));
					end;									
					-- ====================================================	
					out.chaos("After check. local buildings var = "..tostring(buildings));	
				end;


				local faction_name_to_spawn = faction_name;
				
				if faction_name == "default" then
					--local faction_roll = cm:random_number(2);
					local faction_roll = cm:random_number(3);
					--local faction_roll = 3; --FORCE BEASTMEN
					local general_roll = cm:random_number(3);
										out.chaos("faction roll is: " ..tostring(faction_roll));
										out.chaos("general roll is: " ..tostring(general_roll));
										out.chaos("army_to_select is: " ..tostring(army_to_select));
					
					-- make sure we start by spawning a Chaos army if no Chaos armies exist					
					if j == 1 and ci_get_num_hordes(ci_chaos_faction_string) == 0 then
						faction_roll = 1;
					end;
					
					--	if faction_roll == 2 then
					if faction_roll == 3 then
						out.chaos("ARMY IS ACTUALLY BEASTMEN, OVERRIDING VARS ARMY: ." ..tostring(j));
						faction_name_to_spawn = ci_beastmen_faction_string;
						army_string = ci_get_army_string("beastmen", stage);
						buildings = ci_beastmen_horde_buildings;
						
					else
						faction_name_to_spawn = ci_chaos_faction_string;
						-- ==========================STEEL INSERT CODE=========================================================
						if army_to_select == 1 then --KHORNE
							army_string = ci_get_army_string("khorne", stage);	
							elseif army_to_select == 2 then --TZEENTCH
							army_string = ci_get_army_string("tzeentch", stage);	
							elseif army_to_select == 3 then --NURGLE
							army_string = ci_get_army_string("nurgle", stage);	
							elseif army_to_select == 4 then --SLAANESH
							army_string = ci_get_army_string("slaanesh", stage);	
							else  --UNDIVIDED
							army_string = ci_get_army_string("chaos", stage);	
						end;
						-- ==========================END INSERT CODE=========================================================	
					end;
				end;
				--out.chaos("ARMY STRING var = " .. tostring(army_string) ");
				
				if not army_string then
					army_string = ci_get_army_string("chaos", stage);
				end;
				
				
				local spawn_function = function()
				out.chaos("**************************ATTEMPT TO ACTIVATE SPAWN FUNCTION**********************************************");
					while not valid do
						x = cm:random_number(ci_spawn_areas[i][2], ci_spawn_areas[i][1]);
						y = cm:random_number(ci_spawn_areas[i][4], ci_spawn_areas[i][3]);
						
						if is_valid_spawn_point(x, y) then
												out.chaos("valid spawn point!");
												
												--===============================MUST SET GENERAL SUBTYPE HERE BECAUSE ELSE DOSNT WORK PROPERLY...(2-4 ARMIES HAVE SAME LORD)
				--============================================GENERAL SUBTYPES===================================
					if army_to_select == 1 then --KHORNE

					if general_roll == 3 then	
					chaos_general_subtype = "Exalt_Bloodthirster";	
					else
					chaos_general_subtype = "Lord_Khorne";
					end;
									out.chaos("chaos general subtype set for army: " ..tostring(j));	
									out.chaos("chaos general subtype set for army: " ..tostring(chaos_general_subtype));	
								elseif army_to_select == 2 then --TZEENTCH
	
					if general_roll == 3 then	
					chaos_general_subtype = "Exalt_Lord_of_Change";	
					elseif general_roll == 2 then
					chaos_general_subtype = "Lord_Tzeentch";
					else
					chaos_general_subtype = "Tzeentch_Sorceror_Lord";
					end;	
									out.chaos("chaos general subtype set for army: " ..tostring(j));	
									out.chaos("chaos general subtype set for army: " ..tostring(chaos_general_subtype));	
								elseif army_to_select == 3 then --NURGLE

						if general_roll == 3 then	
					chaos_general_subtype = "Nurgle_Sorceror_Lord";	
					else
					chaos_general_subtype = "Lord_Nurgle";
					end;	
									out.chaos("chaos general subtype set for army: " ..tostring(j));	
									out.chaos("chaos general subtype set for army: " ..tostring(chaos_general_subtype));	
								elseif army_to_select == 4 then --SLAANESH
	
					if general_roll == 3 then	
					chaos_general_subtype = "Slaanesh_Sorceror_Lord";	
					else
					chaos_general_subtype = "Lord_Slaanesh";
					end;		
									out.chaos("chaos general subtype set for army: " ..tostring(j));	
									out.chaos("chaos general subtype set for army: " ..tostring(chaos_general_subtype));	
								else  --UNDIVIDED
					if general_roll == 3 then	
					chaos_general_subtype = "Undivided_Sorceror_Lord";	
					else
					chaos_general_subtype = "chs_lord";
					end;		

									out.chaos("chaos general subtype set for army: " ..tostring(j));	
									out.chaos("chaos general subtype set for army: " ..tostring(chaos_general_subtype));	
					end;
					
					--****************************CHAOS NAMES************************
					--lord_forename = "names_name_2147357906"; --must be a name associated with the beastmen\chaos\correct faction or it dosnt work.
					lord_forename = forename_string_array_chaos[cm:random_number(30)];
					lord_familyname = familyname_string_array_chaos[cm:random_number(72)];--name_group is 131 for Beastmen 98 for chaos, in db order of 0 is first anme, 1 is last name
					--****************************END NAMES************************
					
					if faction_name_to_spawn == "wh_dlc03_bst_beastmen_chaos" then
					--out.chaos("******************BEASTMEN**************");
					out.chaos("***BEASTMEN LORD OVERRIDE*******");	
					chaos_general_subtype = "dlc03_bst_beastlord";	
					out.chaos("chaos general subtype set for army: " ..tostring(j));	
					out.chaos("chaos general subtype set for army: " ..tostring(chaos_general_subtype));
					--**************************** BEASTMEN NAMES************************
					lord_forename = forename_string_array_beastmen[cm:random_number(63)]; --must be a name associated with the beastmen\chaos\correct faction or it dosnt work.
					lord_familyname = familyname_string_array_beastmen[cm:random_number(72)];--name_group is 131 for Beastmen 98 for chaos, in db order of 0 is first anme, 1 is last name
					
					--lord_forename = forename_string_array_chaos[cm:random_number(5)];
					
					--****************************END NAMES************************
					end;
												--============================================END GENERAL SUBTYPES===================================
								
								--=========================================================================				THIS IS EXECUTED 4 TIMES IN A ROW FOR STAGE 1..			
								cm:create_force_with_general(
								faction_name_to_spawn,
								army_string,
								ci_chaos_home_region,
								x,
								y,
								"general",
								chaos_general_subtype,
								lord_forename,   --forename 			
								"",   --faction
								lord_familyname,   --family name
								"",   --other
						--		"id",			-- no longer needed?
								false, --is_faction_leader //buildings arnt being added because something to do with command queue?
						--		true, --added command quee -cant add an extra true here because: ERROR: create_force_with_general() called but supplied success callback [true] is not a function or nil
			
								--=========================================================================
								function(cqi)
									out.chaos("create_force() has created a [" .. faction_name_to_spawn .. "] force, commander's cqi is " .. cqi);
									cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true);
									cm:add_agent_experience(cm:char_lookup_str(cqi), ci_character_xp[stage + 1][cm:random_number(3)]);
									
									local char = cm:get_character_by_cqi(cqi);
									local mf_cqi = char:military_force():command_queue_index();
									------------------THIS LINE CAUSES AN ERROR-------------ERROR: add_building_to_force() called but supplied building_level [nil] is not a string or table-----------
									--out.chaos("local buildings var = " .. tostring(buildings) ");
									cm:add_building_to_force(mf_cqi, buildings);
								end
							);
							
							valid = true;
						end;
					end;
				end;
				
				-- in autoruns/when requested we spawn the armies instantly, otherwise offset each one
				if j == 1 or not cm:get_local_faction(true) or instant then
					spawn_function();
				else
					local timer = j - 1;
					
					if is_multiplayer then
						timer = timer / 5;
					end;
					
					cm:callback(
						function()
							spawn_function();
						end,
						timer
					);
				end;
			end;
		end;
	end;
	
	-- do the callback with the above rules
	if is_function(callback) then
		if is_multiplayer or not cm:get_local_faction(true) or instant then
			callback();
		else
			cm:callback(function() callback() end, cutscene_length);
		end;
	end;
end;

function ci_setup_armies()
	local ram = random_army_manager;
	
		-------------------------------------------------------------------------------------
-- STEEL CHANGES
-----------------------------------------------------------------------------------
-- CHAOS ARMY MAKEUP.
-- 60% Infantry
-- 20% Calvary
-- 10% War Engines
-- 10% Monsters

-------------------------------------------------------------------------------------
-- UNDIVDED ARMY
-----------------------------------------------------------------------------------
-- CHAOS ARMY MAKEUP.
-- 60% Infantry
-- 20% Calvary
-- 10% War Engines
-- 10% Monsters
	
	ram:new_force("chaos_1");
	
	ram:add_mandatory_unit("chaos_1", "Hellcannon_cult_wh2",		1);
	
	ram:add_unit("chaos_1", "wh_main_chs_inf_chaos_marauders_0",		2);
	ram:add_unit("chaos_1", "wh_main_chs_inf_chaos_warriors_0",			5);
	ram:add_unit("chaos_1", "wh_main_chs_inf_chaos_warriors_1",			3);
	ram:add_unit("chaos_1", "harad_chaos_cultists",						3);
	ram:add_unit("chaos_1", "Cult_Pole",								5);
	ram:add_unit("chaos_1", "Cult_Swords",								4);
	ram:add_unit("chaos_1", "Cult_Riders",								5);
	ram:add_unit("chaos_1", "Cult_Swords",								6);
	ram:add_unit("chaos_1", "wh_main_chs_cav_chaos_chariot",			2);
	ram:add_unit("chaos_1", "wh_main_nor_cav_marauder_horsemen_0",		2);
	ram:add_unit("chaos_1", "Fallen",									4);
	ram:add_unit("chaos_1", "wh_main_chs_mon_chaos_warhounds_0",		1);
	ram:add_unit("chaos_1", "wh_main_chs_mon_chaos_spawn",				2);
	ram:add_unit("chaos_1", "wh_main_chs_mon_trolls",					2);
	ram:add_unit("chaos_1", "chs_bolt_thrower",							2);

	--STAGE 2
	ram:new_force("chaos_2");
	
	ram:add_mandatory_unit("chaos_2", "chs_grand_battery_Hellcannon_cult",		1);
	
	ram:add_unit("chaos_2", "wh_main_chs_inf_chaos_warriors_0",			20);
	ram:add_unit("chaos_2", "wh_main_chs_inf_chaos_warriors_1",			10);
	ram:add_unit("chaos_2", "Chaos_Chosen_2",							8);
	ram:add_unit("chaos_2", "Chaos_Chosen_Great_Weapons_2",				5);
	ram:add_unit("chaos_2", "chs_prime_staff",							6);
	ram:add_unit("chaos_2", "chs_swordmaster",							8);
	ram:add_unit("chaos_2", "wh_main_chs_cav_chaos_knights_0",			12);
	ram:add_unit("chaos_2", "wh_main_chs_cav_chaos_chariot",			6);
	ram:add_unit("chaos_2", "wh_main_chs_mon_chaos_spawn",				8);
	ram:add_unit("chaos_2", "wh_main_chs_mon_trolls",					10);
	ram:add_unit("chaos_2", "wh_main_chs_mon_giant",					8);
	ram:add_unit("chaos_2", "Hellcannon_cult_wh2",						10);
	ram:add_unit("chaos_2", "Galrauch", 								1);
	
	
-------------------------------------------------------------------------------------
-- TZEENTCH ARMY
-----------------------------------------------------------------------------------	
-- CHAOS ARMY MAKEUP.
-- 60% Infantry
-- 20% Calvary
-- 10% War Engines
-- 10% Monsters
	
	ram:new_force("tzeentch_1");
	
	ram:add_mandatory_unit("tzeentch_1", "Hellcannon_cult_wh2",		1);
	
	ram:add_unit("tzeentch_1", "harad_chaos_cultists",						3);
	ram:add_unit("tzeentch_1", "Tzeentch_warriors",							6);
	ram:add_unit("tzeentch_1", "wh_main_chs_inf_chaos_warriors_1",			3);
	ram:add_unit("tzeentch_1", "wh_main_chs_cav_chaos_chariot",				2);
	ram:add_unit("tzeentch_1", "wh_main_nor_cav_marauder_horsemen_0",		2);
	ram:add_unit("tzeentch_1", "Tzeentch_knights",							4);
	ram:add_unit("tzeentch_1", "wh_main_chs_mon_chaos_warhounds_0",			1);
	ram:add_unit("tzeentch_1", "wh_main_chs_mon_chaos_spawn",				2);
	ram:add_unit("tzeentch_1", "Pink_Horrors",								2);
	
	--STAGE 2
	ram:new_force("tzeentch_2");
	
	ram:add_mandatory_unit("tzeentch_2", "chs_grand_battery_Hellcannon_cult", 1);
	ram:add_unit("tzeentch_2", "Hellcannon_cult_wh2",						 1);
	ram:add_unit("tzeentch_2", "Tzeentch_knights", 							 4);
	ram:add_unit("tzeentch_2", "Tzeentch_warriors", 						 10);
	ram:add_unit("tzeentch_2", "Chaos_Chosen_2", 							 2);
	ram:add_unit("tzeentch_2", "chs_prime_staff",							 1);
	ram:add_unit("tzeentch_2", "Changers", 									 6);
	ram:add_unit("tzeentch_2", "Pink_Horrors", 								 2);
	ram:add_unit("tzeentch_2", "wh_main_chs_mon_chaos_spawn", 				 4);
	ram:add_unit("tzeentch_2", "Lord_of_Change", 							 1);
	ram:add_unit("tzeentch_2", "wh_main_chs_mon_giant", 					 1);	
	
-------------------------------------------------------------------------------------
-- KHORNE ARMY
-----------------------------------------------------------------------------------	
-- CHAOS ARMY MAKEUP.
-- 60% Infantry
-- 20% Calvary
-- 10% War Engines
-- 10% Monsters	

	ram:new_force("khorne_1");
	
	ram:add_mandatory_unit("khorne_1", "Hellcannon_cult_wh2", 				1);
	ram:add_unit("khorne_1", "harad_chaos_cultists", 						3);
	ram:add_unit("khorne_1", "Cult_Swords",									2);
	ram:add_unit("khorne_1", "Norse_Huskarls", 								3);
	ram:add_unit("khorne_1", "Khorne_knights", 								2);
	ram:add_unit("khorne_1", "wh_main_chs_cav_marauder_horsemen_0", 		1);
	ram:add_unit("khorne_1", "Bloodletters",							    2);
	ram:add_unit("khorne_1", "wh_main_chs_inf_chaos_marauders_1", 			2);
	ram:add_unit("khorne_1", "Khorne_warriors", 							6);
	ram:add_unit("khorne_1", "Khorne_Skulltakers", 							3);
	ram:add_unit("khorne_1", "wh_main_chs_mon_chaos_warhounds_0", 			1);
	ram:add_unit("khorne_1", "Fleshhounds", 								2);
	
		--STAGE 2
		ram:new_force("khorne_2");

	ram:add_mandatory_unit("khorne_2", "chs_grand_battery_Hellcannon_cult", 1);
	ram:add_unit("khorne_2", "Hellcannon_cult_wh2", 						1);
	ram:add_unit("khorne_2", "Norse_Huskarls", 								1);
	ram:add_unit("khorne_2", "Khorne_knights", 								2);
	ram:add_unit("khorne_2", "wh_main_chs_cav_marauder_horsemen_0", 		1);
	ram:add_unit("khorne_2", "Bloodletters", 								1);
	ram:add_unit("khorne_2", "wh_main_chs_inf_chaos_marauders_1",			2);
	ram:add_unit("khorne_2", "Khorne_warriors", 							5);
	ram:add_unit("khorne_2", "Khorne_Skulltakers",							3);
	ram:add_unit("khorne_2", "chs_forsaken_giant", 							1);
	ram:add_unit("khorne_2", "wh_main_chs_mon_chaos_warhounds_0", 			1);
	ram:add_unit("khorne_2", "Fleshhounds", 								2);
	ram:add_unit("khorne_2", "Bloodthirster", 								1);
-------------------------------------------------------------------------------------
-- NURGLE ARMY
-----------------------------------------------------------------------------------
-- CHAOS ARMY MAKEUP.
-- 60% Infantry
-- 20% Calvary
-- 5% War Engines
-- 15% Monsters
	ram:new_force("nurgle_1");
	
	ram:add_mandatory_unit("nurgle_1", "Plague_Cannon", 						1);
	ram:add_unit("nurgle_1", "Nurgle_knights", 									4);
	ram:add_unit("nurgle_1", "wh_main_chs_cav_marauder_horsemen_0",			    2);
	ram:add_unit("nurgle_1", "wh_main_chs_cav_marauder_horsemen_1", 			2);
	ram:add_unit("nurgle_1", "Nurgle_warriors", 								4);
	ram:add_unit("nurgle_1", "Nurgle_PlagueReapers", 							3);
	ram:add_unit("nurgle_1", "Afflicted",									    6);
	ram:add_unit("nurgle_1", "wh_main_chs_mon_chaos_warhounds_1", 				2);
	ram:add_unit("nurgle_1", "wh_main_chs_mon_giant", 							1);
	ram:add_unit("nurgle_1", "Plaguebearers", 									1);
	
		--STAGE 2
		ram:new_force("nurgle_2");
	
	ram:add_mandatory_unit("nurgle_2", "chs_grand_battery_Plague_Cannon", 1);
	ram:add_unit("nurgle_2", "Plague_Cannon", 									1);
	ram:add_unit("nurgle_2", "Nurgle_knights", 									4);
	ram:add_unit("nurgle_2", "wh_main_chs_cav_marauder_horsemen_0", 			1);
	ram:add_unit("nurgle_2", "wh_main_chs_cav_marauder_horsemen_1", 			1);
	ram:add_unit("nurgle_2", "Nurgle_warriors", 								5);
	ram:add_unit("nurgle_2", "Nurgle_PlagueReapers", 							5);
	ram:add_unit("nurgle_2", "Afflicted", 										3);
	ram:add_unit("nurgle_2", "wh_main_chs_mon_chaos_warhounds_1",			    2);
	ram:add_unit("nurgle_2", "wh_main_chs_mon_giant", 							1);
	ram:add_unit("nurgle_2", "Plaguebearers", 									3);
	ram:add_unit("nurgle_2", "Great_Unclean_One", 								1);

-------------------------------------------------------------------------------------
-- SLAANESH ARMY
-----------------------------------------------------------------------------------
-- CHAOS ARMY MAKEUP.
-- 60% Infantry
-- 20% Calvary
-- 5% War Engines
-- 15% Monsters
	
		ram:new_force("slaanesh_1");
	
	ram:add_mandatory_unit("slaanesh_1", "Slaanesh_Pleasure_Cannon", 1);
	ram:add_unit("slaanesh_1", "Slaanesh_Riders", 										1);
	ram:add_unit("slaanesh_1", "wh_main_chs_cav_marauder_horsemen_0",					    2);
	ram:add_unit("slaanesh_1", "Slaanesh_Chariot", 										1);
	ram:add_unit("slaanesh_1", "harad_chaos_cultists",								    5);
	ram:add_unit("slaanesh_1", "Daemonettes", 											1);
	ram:add_unit("slaanesh_1", "Slaanesh_lancers", 										2);
	ram:add_unit("slaanesh_1", "Slaanesh_warriors", 									3);
	ram:add_unit("slaanesh_1", "wh_main_chs_mon_chaos_spawn", 							3);
	ram:add_unit("slaanesh_1", "wh_main_chs_mon_chaos_warhounds_0", 					2);
	ram:add_unit("slaanesh_1", "Daemonettes_Mounted", 									1);
	
			--STAGE 2
		ram:new_force("slaanesh_2");
	
	ram:add_mandatory_unit("slaanesh_2", "chs_grand_battery_Slaanesh_Pleasure_Cannon", 1);
	ram:add_unit("slaanesh_2", "Slaanesh_Riders", 								2);
	ram:add_unit("slaanesh_2", "Slaanesh_Chariot",								1);
	ram:add_unit("slaanesh_2", "harad_chaos_cultists", 							2);
	ram:add_unit("slaanesh_2", "Daemonettes", 									2);
	ram:add_unit("slaanesh_2", "Slaanesh_lancers", 								4);
	ram:add_unit("slaanesh_2", "Blessed", 										2);
	ram:add_unit("slaanesh_2", "Slaanesh_warriors", 							5);
	ram:add_unit("slaanesh_2", "wh_main_chs_mon_chaos_spawn",			     	3);
	ram:add_unit("slaanesh_2", "wh_main_chs_mon_chaos_warhounds_0", 			1);
	ram:add_unit("slaanesh_2", "Daemonettes_Mounted",						    2);
	
	-------------------------------------------------------------------------------------
-- END ARMY CODE
-----------------------------------------------------------------------------------
		--STAGE 1
	ram:new_force("beastmen_1");
	
	ram:add_unit("beastmen_1", "wh_dlc03_bst_inf_ungor_herd_1",			26);
	ram:add_unit("beastmen_1", "wh_dlc03_bst_inf_ungor_raiders_0",		18);
	ram:add_unit("beastmen_1", "wh_dlc03_bst_inf_ungor_spearmen_0",		18);
	ram:add_unit("beastmen_1", "wh_dlc03_bst_inf_chaos_warhounds_0",	13);
	ram:add_unit("beastmen_1", "wh_dlc03_bst_inf_gor_herd_0",			10);
	ram:add_unit("beastmen_1", "wh_dlc03_bst_inf_gor_herd_1",			10);
	ram:add_unit("beastmen_1", "wh_dlc03_bst_inf_centigors_0",			5);
	
	--STAGE 2	
	ram:new_force("beastmen_2");
	
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_gor_herd_0",			17);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_gor_herd_1",			17);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_ungor_spearmen_1",		12);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_ungor_raiders_0",		12);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_bestigor_herd_0",		10);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_minotaurs_0",			8);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_minotaurs_1",			8);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_inf_cygor_0",				7);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_mon_giant_0",				5);
	ram:add_unit("beastmen_2", "wh_dlc03_bst_cav_razorgor_chariot_0",	4);
end;

function ci_get_army_string(race, stage)
	return random_army_manager:generate_force(race .. "_" .. stage, cm:random_number(ci_horde_size[stage][2], ci_horde_size[stage][1]));
end;

function is_valid_spawn_point(x, y)
	local faction_list = cm:model():world():faction_list();
	
	for i = 0, faction_list:num_items() - 1 do
		local current_faction = faction_list:item_at(i);
		local char_list = current_faction:character_list();
		
		for i = 0, char_list:num_items() - 1 do
			local current_char = char_list:item_at(i);
			if current_char:logical_position_x() == x and current_char:logical_position_y() == y then
				out.chaos("Tried to spawn a Chaos character, but there was already a character on that location!");
				return false;
			end;
		end;
	end;
	
	return true;
end;

function ci_spawn_agent(num_agents)
	local agent_positions_empire = {
		{487, 438},
		{516, 428},
		{503, 483}
	};
	
	local agent_positions_dwarfs = {
		{681, 352},
		{751, 358},
		{687, 334}
	};
	
	local agent_positions_greenskins = {
		{738, 311},
		{704, 283},
		{755, 278}
	};
	
	local agent_positions_vampire_counts = {
		{671, 411},
		{673, 446},
		{647, 394}
	};
	
	local agent_positions = {
		{496, 520},
		{680, 532},
		{542, 372},
		{412, 399},
		{652, 257}
	};
	
	if cm:get_local_faction(true) and not cm:is_multiplayer() then
		local player_faction = cm:get_faction(cm:get_local_faction(true));
		
		if player_faction == cm:get_region("wh_main_reikland_altdorf"):owning_faction() then
			for i = 1, #agent_positions_empire do table.insert(agent_positions, agent_positions_empire[i]) end;
		end;
		
		if player_faction == cm:get_region("wh_main_the_silver_road_karaz_a_karak"):owning_faction() then
			for i = 1, #agent_positions_dwarfs do table.insert(agent_positions, agent_positions_dwarfs[i]) end;
		end;
		
		if player_faction == cm:get_region("wh_main_death_pass_karak_drazh"):owning_faction() then
			for i = 1, #agent_positions_greenskins do table.insert(agent_positions, agent_positions_greenskins[i]) end;
		end;
		
		if player_faction == cm:get_region("wh_main_eastern_sylvania_castle_drakenhof"):owning_faction() then
			for i = 1, #agent_positions_vampire_counts do table.insert(agent_positions, agent_positions_vampire_counts[i]) end;
		end;
	else
		for i = 1, #agent_positions_empire do table.insert(agent_positions, agent_positions_empire[i]) end;
		for i = 1, #agent_positions_dwarfs do table.insert(agent_positions, agent_positions_dwarfs[i]) end;
		for i = 1, #agent_positions_greenskins do table.insert(agent_positions, agent_positions_greenskins[i]) end;
		for i = 1, #agent_positions_vampire_counts do table.insert(agent_positions, agent_positions_vampire_counts[i]) end;
	end;
	
	for i = 1, num_agents do
		local chosen_agent = "";
		local chosen_subtype = "";
		local agent_roll = cm:random_number(2);
		
		if agent_roll == 1 then
			chosen_agent = "wizard";
			
		-- ==================================INSERT CODE			
			local subtype_roll = cm:random_number(5);
			if subtype_roll == 1 then
				chosen_subtype = "Nurgle_Sorceror";
			elseif subtype_roll == 2 then
				chosen_subtype = "Slaanesh_Sorceror";
			elseif subtype_roll == 3 then
				chosen_subtype = "Tzeentch_Sorceror";
			elseif subtype_roll == 4 then
				chosen_subtype = "Undivided_Sorceror";
			else
				chosen_subtype = "Cult_Master";
			end;
		else
			chosen_agent = "champion";
			chosen_subtype = "chs_exalted_hero";
		end;
		-- ==================================END INSERT CODE
		local valid = false;
		local count = 0;
		
		while not valid and count < 10 do
			local random_position = cm:random_number(#agent_positions);
			local chosen_coord = agent_positions[random_position];
			
			if is_valid_spawn_point(chosen_coord[1], chosen_coord[2]) then
				cm:create_agent(
					ci_chaos_faction_string,
					chosen_agent,
					chosen_subtype,
					chosen_coord[1],
					chosen_coord[2],
					true,
					function(cqi)
						cm:add_agent_experience(cm:char_lookup_str(cqi), ci_character_xp[1][cm:random_number(3)]);
					end
				);
				-- remove the chosen position from the table to ensure another agent is not spawned there
				table.remove(agent_positions, random_position);
				
				valid = true;
			end;
			
			count = count + 1;
		end;
	end;
end;

function ci_spawn_norsca()
	local difficulty = ci_get_difficulty();
	local norsca_faction_name = "wh_main_nor_bjornling";
	local is_multiplayer = cm:is_multiplayer();
	
	out.chaos("ci_spawn_norsca() called, difficulty level: " .. tostring(difficulty) .. ", is_multiplayer: " .. tostring(is_multiplayer));
	
	local num_armies_to_spawn = ci_max_num_hordes[1][difficulty];
	
	local turn_number = tostring(cm:model():turn_number());
	
	local army_string = {
		"wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_1,wh_main_nor_inf_chaos_marauders_1,wh_main_nor_mon_chaos_warhounds_0,wh_main_nor_mon_chaos_warhounds_0,wh_main_nor_mon_chaos_trolls,wh_main_nor_mon_chaos_trolls,wh_main_nor_cav_chaos_chariot,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_1,wh_main_nor_cav_marauder_horsemen_1",
		"wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_1,wh_main_nor_inf_chaos_marauders_1,wh_main_nor_cav_chaos_chariot,wh_main_nor_cav_chaos_chariot,wh_main_nor_mon_chaos_trolls,wh_main_nor_mon_chaos_trolls,wh_main_nor_mon_chaos_warhounds_0,wh_main_nor_mon_chaos_warhounds_0,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_1,wh_main_nor_cav_marauder_horsemen_1,wh_main_nor_cav_marauder_horsemen_1",
		"wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_0,wh_main_nor_inf_chaos_marauders_1,wh_main_nor_inf_chaos_marauders_1,wh_main_nor_cav_chaos_chariot,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_0,wh_main_nor_cav_marauder_horsemen_1,wh_main_nor_cav_marauder_horsemen_1,wh_main_nor_mon_chaos_warhounds_0,wh_main_nor_mon_chaos_warhounds_0,wh_main_nor_mon_chaos_warhounds_0,wh_main_nor_mon_chaos_trolls,wh_main_nor_mon_chaos_trolls"
	};
	
	for i = 1, num_armies_to_spawn do
		local valid = false;
		local x = 0;
		local y = 0;
		
		while not valid do
			x = cm:random_number(ci_norsca_spawn_area[2], ci_norsca_spawn_area[1]);
			y = cm:random_number(ci_norsca_spawn_area[4], ci_norsca_spawn_area[3]);
			
			if is_valid_spawn_point(x, y) then
				cm:create_force(
					norsca_faction_name,
					army_string[cm:random_number(3)],
					ci_chaos_home_region,
					x,
					y,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true);
						cm:add_agent_experience(cm:char_lookup_str(cqi), ci_character_xp[2][cm:random_number(3)]);
					end
				);
				
				valid = true;
			end;
		end;
	end;
	
	cm:callback(
		function()
			cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
			
			local factions_at_war_with = {
				"wh_main_grn_greenskins",
				"wh_main_dwf_dwarfs"
			};
			
			for i = 1, #factions_at_war_with do
				local current_faction_name = factions_at_war_with[i];
				local current_faction = cm:get_faction(current_faction_name);
				
				if not current_faction:is_dead() then
					-- declare war on the player if they are allied with one of the factions
					if cm:get_local_faction(true) then
						if cm:get_faction(cm:get_local_faction(true)):is_ally_vassal_or_client_state_of(current_faction) then
							cm:force_declare_war(cm:get_local_faction(true), norsca_faction_name, true, true);
							cm:force_diplomacy("faction:" .. cm:get_local_faction(true), "faction:" .. norsca_faction_name, "peace", false, false, true);
						end;
					end;
					
					cm:force_declare_war(current_faction_name, norsca_faction_name, true, true);
					cm:force_diplomacy("faction:" .. current_faction_name, "faction:" .. norsca_faction_name, "peace", false, false, true);
				end;
			end;
			
			cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "") end, 1);
		end,
		0.5
	);
end;

-- disables any further advice - call this at the point at which the advisor dies
function ci_disable_further_advice()
	out.chaos("*** ci_disable_further_advice() called - disabling advice from this point forward ***");
	cm:set_saved_value("advice_is_disabled", true);
	cm:set_advice_enabled(false);
end;

function ci_spawn_special_character(char_details)
	--=============================STEEL EDIT=======================
	--	local unit_str = ci_get_army_string("chaos", 2);
	local unit_str = ci_get_army_string("tzeentch", 2);	
	--=============================END STEEL EDIT=======================	
	local valid = false;
	local x = 0;
	local y = 0;
	
	while not valid do
		x = cm:random_number(ci_spawn_areas[1][2], ci_spawn_areas[1][1]);
		y = cm:random_number(ci_spawn_areas[1][4], ci_spawn_areas[1][3]);
		
		if is_valid_spawn_point(x, y) then
			cm:create_force_with_general(
				ci_chaos_faction_string,
				unit_str,
				ci_chaos_home_region,
				x,
				y,
				"general",
				char_details["agent_subtype"],
				char_details["forename"],
				"",
				char_details["family_name"],
				"",
				-- char_details["id"],			-- no longer needed
				char_details["faction_leader"],
				function(cqi)
					local char_str = cm:char_lookup_str(cqi);
					
					if char_details["agent_subtype"] == "chs_lord_of_change" then cm:force_add_trait(char_str, "wh_main_trait_name_dummy_the_ever-watcher", true) end;
					cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true);
					cm:set_character_immortality(char_str, true);
					cm:set_character_unique(char_str, true);
					cm:add_agent_experience(char_str, ci_character_xp[3][cm:random_number(3)]);
					
					local char = cm:get_character_by_cqi(cqi);
					local mf_cqi = char:military_force():command_queue_index();
					cm:add_building_to_force(mf_cqi, ci_chaos_horde_buildings);
				end
			);
			
			valid = true;
		end;
	end;
end;

function ci_spawn_archaon()
	local archaon = ci_get_archaon();
	
	if not archaon then
		script_error("WARNING: Could not find Archaon to spawn him - how could this happen?");
	elseif archaon:has_military_force() then
		script_error("WARNING: Tried to spawn Archaon for the Chaos Invasion late game event, but he is already on the map - how could this happen?");
	else
		local unit_str = ci_get_army_string("chaos", 2);
		local valid = false;
		local x = 0;
		local y = 0;
		
		while not valid do
			x = cm:random_number(ci_spawn_areas[1][2], ci_spawn_areas[1][1]);
			y = cm:random_number(ci_spawn_areas[1][4], ci_spawn_areas[1][3]);
			
			if is_valid_spawn_point(x, y) then
				cm:create_force_with_existing_general(
					cm:char_lookup_str(archaon),
					ci_chaos_faction_string,
					unit_str,
					ci_chaos_home_region,
					x,
					y,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force_unbreakable", cqi, 0, true);
						cm:add_agent_experience(cm:char_lookup_str(cqi), ci_character_xp[3][cm:random_number(3)]);
					
						local char = cm:get_character_by_cqi(cqi);
						local mf_cqi = char:military_force():command_queue_index();
						cm:add_building_to_force(mf_cqi, ci_chaos_horde_buildings);
						
						cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_spawned", true);
						cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_spawned", true);
					end
				);
				
				valid = true;
			end;
		end;
	end;
	
	cm:set_saved_value("ci_archaon_not_spawned", false);
	core:remove_listener("end_chaos_turn");
end;

function ci_chaos_diplomacy_startup()
	out.chaos("ci_chaos_diplomacy_startup() called");
	
	-- offset the whole check by half a second just to ensure there is some Chaos presence on the map
	cm:callback(
		function()
			local chaos_faction = cm:get_faction(ci_chaos_faction_string);
			local beastmen_faction = cm:get_faction(ci_beastmen_faction_string);
			
			if chaos_faction and not chaos_faction:at_war() then
				out.chaos("Bringing back the Chaos faction, re-establishing diplomatic relations");
				
				-- do this here in MPC as any earlier and there may be no Chaos presence on the map
				if cm:is_multiplayer() then
					out.chaos("\t[MPC] Locking Archaon, Sigvald and Kholek!");
					cm:lock_starting_general_recruitment("2140782858", ci_chaos_faction_string);
					cm:lock_starting_general_recruitment("2140783662", ci_chaos_faction_string);
					cm:lock_starting_general_recruitment("2140783672", ci_chaos_faction_string);
				end;
				
				cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
				
				-- ensure Chaos and Beastmen can never make peace
				-- UNLESS it's a SPC and player is Beastmen
				local faction_list = cm:model():world():faction_list();
				
				for i = 0, faction_list:num_items() - 1 do
					local current_faction = faction_list:item_at(i);
					local current_faction_name = current_faction:name();
					
					if cm:is_multiplayer() or current_faction:name() ~= "wh_dlc03_bst_beastmen" then
						cm:force_diplomacy("faction:" .. ci_chaos_faction_string, "faction:" .. current_faction_name, "peace", false, false, true);
						cm:force_diplomacy("faction:" .. ci_beastmen_faction_string, "faction:" .. current_faction_name, "peace", false, false, true);
					end;
				end;
				
				local factions_at_war_with = {
					"wh_main_emp_empire",
					"wh_main_dwf_dwarfs",
					"wh_main_dwf_karak_izor",
					"wh_main_brt_bretonnia",
					"wh_main_brt_bordeleaux",
					"wh_main_brt_carcassonne",
					"wh_main_ksl_kislev",
					"wh_main_emp_middenland",
					"wh_main_emp_ostermark",
					"wh_main_emp_ostland",
					"wh_main_dwf_kraka_drak",
					"wh_main_emp_nordland",
					"wh2_main_hef_eataine",
					"wh2_main_hef_order_of_loremasters",
					"wh2_main_lzd_hexoatl",
					"wh2_main_lzd_last_defenders"
				};
				
				local human_factions = cm:get_human_factions();
				local mpc_declared_war_on_player_1 = false;
				
				for i = 1, #factions_at_war_with do
					local faction_name = factions_at_war_with[i];
					local faction = cm:get_faction(faction_name);
					
					if not faction:is_dead() then
						local faction_has_human_ally = false;
					
						-- declare war on the player first if they are allied with one of the factions in the list
						if cm:get_local_faction(true) then
							for j = 1, #human_factions do
								local current_faction_name = human_factions[j];
								local current_faction = cm:get_faction(current_faction_name);
								
								if current_faction:is_ally_vassal_or_client_state_of(faction) then
									-- this faction is allied with a player, no need to declare war on it
									faction_has_human_ally = true;
									
									if not mpc_declared_war_on_player_1 then
										out.chaos("1) Declaring war on [" .. current_faction_name .. "]");
										cm:force_declare_war(ci_chaos_faction_string, current_faction_name, true, true);
										
										-- we've declared war on player 1, no need to declare war on player 2
										mpc_declared_war_on_player_1 = true;
									end;
								end;
							end;
						end;
						
						-- the player wasn't allied with the faction in the list, declare war on that faction
						if not faction_has_human_ally then
							out.chaos("2) Declaring war on [" .. faction_name .. "]");
							cm:force_declare_war(ci_chaos_faction_string, faction_name, true, true);
							cm:force_diplomacy("faction:" .. ci_chaos_faction_string, "faction:" .. faction_name, "peace", false, false, true);
						end;
					end;
				end;
				
				-- force war between Chaos and any of Varg/Skaeling/Beastmen enemies so vassal/master rules are preserved
				local vassal_enemies = {};
				
				table.insert(vassal_enemies, cm:get_faction(ci_beastmen_faction_string):factions_at_war_with());
				
				-- only make Norsca factions Chaos's vassals if Beastmen and Norsca are not human controlled
				if not player_1:culture("wh_dlc03_bst_beastmen") and not player_2:culture("wh_dlc03_bst_beastmen") then
					if not player_1:subculture("wh_main_sc_nor_norsca") and not player_2:subculture("wh_main_sc_nor_norsca") then
						local aesling_faction = cm:get_faction("wh_main_nor_aesling");
						local baersonling_faction = cm:get_faction("wh_main_nor_baersonling");
						local bjornling_faction = cm:get_faction("wh_main_nor_bjornling");
						local graeling_faction = cm:get_faction("wh_main_nor_graeling");
						
						local varg_faction = cm:get_faction("wh_main_nor_varg");
						local skaeling_faction = cm:get_faction("wh_main_nor_skaeling");
						
						
						table.insert(vassal_enemies, aesling_faction:factions_at_war_with());
						table.insert(vassal_enemies, baersonling_faction:factions_at_war_with());
						table.insert(vassal_enemies, bjornling_faction:factions_at_war_with());
						table.insert(vassal_enemies, graeling_faction:factions_at_war_with());
						
						table.insert(vassal_enemies, varg_faction:factions_at_war_with());
						table.insert(vassal_enemies, skaeling_faction:factions_at_war_with());
					end
				end;
				
				local player_1 = cm:get_faction(human_factions[1]);
				local player_2 = nil;
				-- only get player 2 if one exists
				if cm:is_multiplayer() then
					player_2 = cm:get_faction(human_factions[2]);
				end;
				
				-- declare war on all enemies of Chaos's vassals unless they are allied with a human faction (they should be dealt with earlier)
				for i = 1, #vassal_enemies do
					if vassal_enemies[i] and not vassal_enemies[i]:is_empty() then
						for j = 0, vassal_enemies[i]:num_items() - 1 do
							local current_faction = vassal_enemies[i]:item_at(j);
							local current_faction_name = current_faction:name();
							
							if not current_faction:is_ally_vassal_or_client_state_of(player_1) and not (player_2 and current_faction:is_ally_vassal_or_client_state_of(player_2)) then
								-- go through all chaos factions as one vassal might not have the same enemies as another - all 4 factions should be at war with the same set after this
								local chaos_factions = {
									ci_beastmen_faction_string,
									"wh_main_nor_aesling",
									"wh_main_nor_baersonling",
									"wh_main_nor_bjornling",
									"wh_main_nor_graeling",
									"wh_main_nor_varg",
									"wh_main_nor_skaeling",
									ci_chaos_faction_string
								};
								
								for k = 1, #chaos_factions do
									local current_chaos_faction = chaos_factions[k];
									
									if not cm:get_faction(current_chaos_faction):is_dead() then
										out.chaos("3) Forcing war between [" .. current_chaos_faction .. "] and [" .. current_faction_name .. "]");
										cm:force_declare_war(current_chaos_faction, current_faction_name, false, false);
									end;
								end;
							end;
						end;
					end;
				end;
				
				ci_make_chaos_vassals();
				
				cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "") end, 1);
			-- if Chaos is already alive but we're bringing back Beastmen, make them a vassal
			elseif not beastmen_faction:at_war() then
				out.chaos("Bringing back Beastmen, making Beastmen vassal");
				cm:force_make_vassal(ci_chaos_faction_string, ci_beastmen_faction_string);
				cm:force_diplomacy("faction:" .. ci_chaos_faction_string, "faction:" .. ci_beastmen_faction_string, "war,break vassal,break alliance,break vassal,break client state", false, false, true);
			end;
			
			ci_wh2_chaos_diplomacy_startup();
		end,
		0.5
	);
end;

function ci_wh2_chaos_diplomacy_startup()
	-- additional chaos factions for the expanded map
	local additional_chaos_factions = {
		"wh2_main_chs_chaos_incursion_def",
		"wh2_main_chs_chaos_incursion_hef",
		"wh2_main_chs_chaos_incursion_lzd"
	};
	
	-- have each of these additional chaos factions declare war on all factions that are alive, not chaos in culture, and where a state of war is not already present
	local faction_list = cm:model():world():faction_list();
	
	for i = 1, #additional_chaos_factions do
		local current_chaos_faction_name = additional_chaos_factions[i];
		local current_chaos_faction = cm:get_faction(current_chaos_faction_name);
		
		for j = 0, faction_list:num_items() - 1 do
			local current_target_faction = faction_list:item_at(j);
			local current_target_faction_culture = current_target_faction:culture();
			
			if not current_target_faction:is_dead() and current_target_faction_culture ~= "wh_dlc03_bst_beastmen" and (current_target_faction_culture ~= "wh_main_chs_chaos" or current_target_faction:is_human()) and not current_chaos_faction:at_war_with(current_target_faction) then
				local current_target_faction_name = current_target_faction:name();
				out.chaos("4) Forcing war between [" .. current_chaos_faction_name .. "] and [" .. current_target_faction_name .. "]");
				cm:force_declare_war(current_chaos_faction_name, current_target_faction_name, false, false);
				cm:force_diplomacy("faction:" .. current_chaos_faction_name, "faction:" .. current_target_faction_name, "peace", false, false, true);
			end;
		end;
	end;
end;

function ci_make_chaos_vassals()
	out.chaos("ci_make_chaos_vassals() called");
	
	local vassal_factions = {
		ci_beastmen_faction_string,
		"wh_main_nor_varg",
		"wh_main_nor_skaeling"
	};
	
	local make_norsca_vassals = false;
	
	if cm:is_multiplayer() or not cm:get_faction("wh_dlc03_bst_beastmen"):is_human() then
		make_norsca_vassals = true;
	end;
	
	for i = 1, #vassal_factions do
		local current_faction = vassal_factions[i];
		
		if make_norsca_vassals or current_faction == ci_beastmen_faction_string then
			out.chaos("force_make_vassal between " .. ci_chaos_faction_string .. " and " .. current_faction);
			cm:force_make_vassal(ci_chaos_faction_string, current_faction);
			cm:force_diplomacy("faction:" .. ci_chaos_faction_string, "faction:" .. current_faction, "war,break vassal,break alliance,break client state", false, false, true);
		end;
	end;
end;

-- in order to prevent save/load issues, we autosave in legendary difficulty and re-enable saving once the events have finished
function ci_autosave_and_enable_saving()
	if not cm:is_multiplayer() then
		out.chaos("Enabling saving game");
		cm:disable_saving_game(false);
		
		if cm:model():difficulty_level() == -3 then
			-- delay this by a second in case any diplomacy settings are still being processed
			cm:callback(
				function()
					out.chaos("Legendary difficulty - autosaving...");
					cm:autosave_at_next_opportunity();
				end,
				1
			);
		end;
	end;
end;

-- if Archaon has been unlocked but has not been spawned yet then end Chaos's turn immediately until he has been spawned
-- otherwise the AI will replace an existing general with him and break the script!
function ci_skip_chaos_turn_listener()
	if cm:get_saved_value("ci_archaon_not_spawned") then
		core:add_listener(
			"end_chaos_turn",
			"FactionTurnStart",
			function(context) return context:faction():name() == ci_chaos_faction_string end,
			function()
				out.chaos("Archaon has been unlocked but has not been spawned - ending Chaos turn! This should only happen once or twice.");
				cm:end_turn(true);
			end,
			true
		);
	end;
end;

function ci_get_num_hordes(faction_name)
	if faction_name == "default" or not faction_name then
		-- old method of getting the total number of chaos and beastmen armies
		return cm:get_faction(ci_chaos_faction_string):military_force_list():num_items() + cm:get_faction(ci_beastmen_faction_string):military_force_list():num_items();
	else
		return cm:get_faction(faction_name):military_force_list():num_items();
	end;
end;

-- check if the player faction is a horde
-- in that case, start the camera at the highest ranked general and then move into the closest cindy scene to that position
function ci_initialise_cutscene()	
	local player_faction = cm:get_faction(cm:get_local_faction(true));
	local is_horde = wh_faction_is_horde(player_faction);
	
	-- if there is no chaos_rises_scene specified in a faction's prelude file, use this method
	local x = 493;
	local y = 455;
		
	local chaos_rises_scene_positions = {
		{472.5, 277.6},		-- dwarfs
		{332.9, 354.3},		-- empire
		{483.97, 226.93},	-- greenskins
		{459.2, 326.1},		-- vampire counts
		
		{150, 386, "wh2_main_sea_the_forbidding_coast"},				-- north west spawn area
		{197, 15, "wh_main_sea_southern_straits_of_the_great_ocean"}	-- south west spawn area
	};
	
	local chaos_rises_scene_files = {
		"script/campaign/main_warhammer/chaos_rises/scenes/dwarf_chaos_rises.CindyScene",
		"script/campaign/main_warhammer/chaos_rises/scenes/empire_chaos_rises.CindyScene",
		"script/campaign/main_warhammer/chaos_rises/scenes/greenskins_chaos_rises.CindyScene",
		"script/campaign/main_warhammer/chaos_rises/scenes/vampire_counts_chaos_rises.CindyScene"
	};
	
	if is_horde then
		-- get the highest ranked general's position
		local highest_ranked_general = cm:get_highest_ranked_general_for_faction(player_faction);
		
		if highest_ranked_general then
			x = highest_ranked_general:display_position_x();
			y = highest_ranked_general:display_position_y();
		end;
	else
		-- get the location of the capitals
		local capital = player_faction:home_region():settlement();
		
		x = capital:display_position_x();
		y = capital:display_position_y();
	end;
	
	local closest_distance = 500000;
	
	local coordinates = false;
	local region = false;
	
	-- get the closest chaos rises scene start pos to the found pos
	for i = 1, #chaos_rises_scene_positions do
		local current_distance = distance_squared(x, y, chaos_rises_scene_positions[i][1], chaos_rises_scene_positions[i][2]);
		if current_distance < closest_distance then
			closest_distance = current_distance;
			chaos_rises_scene = chaos_rises_scene_files[i];
			coordinates = {chaos_rises_scene_positions[i][1], chaos_rises_scene_positions[i][2], 16.7, 0, 14.0};
			region = chaos_rises_scene_positions[i][3];
		end;
	end;
	
	chaos_rises_start_pos = {x, y, 14, 0.0, 14};
	
	return coordinates, region;
end;

function ci_get_difficulty()
	local is_multiplayer = cm:is_multiplayer();
	local difficulty = cm:model():combined_difficulty_level();
	
	if cm:get_local_faction(true) then
		if difficulty == 0 then
			difficulty = 2;				-- normal
		elseif difficulty == -1 then
			difficulty = 3;				-- hard
		elseif difficulty == -2 then
			difficulty = 4;				-- very hard
		elseif difficulty == -3 then
			difficulty = 5;				-- legendary
		else
			difficulty = 1;				-- easy
		end;
	else
	-- autorun
		if difficulty == 0 then
			difficulty = 2;				-- normal
		elseif difficulty == 1 then
			difficulty = 3;				-- hard
		elseif difficulty == 2 then
			difficulty = 4;				-- very hard
		elseif difficulty == 3 then
			difficulty = 5;				-- legendary
		else
			difficulty = 1;				-- easy
		end;
	end;
	
	return difficulty;
end;