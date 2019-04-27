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

--v function(table: table, element: any) --> bool
function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
        end
    end
    return false
end

local parchment = find_uicomponent(frame.uic, "parchment")
local fX, fY = frame.uic:Position()
local fW, fH = frame.uic:Bounds()
local pX, pY = parchment:Bounds()
local gapX, gapY = fW - pX, fH - pY
parchment:MoveTo(fX + gapX/2, fY + gapY/2)

--local button_spell_browser = find_uicomponent(core:get_ui_root(), "menu_bar", "buttongroup", "button_spell_browser");
--button_spell_browser:SetDisabled(false);
--button_spell_browser:SetInteractive(true);
--cm:get_intervention_manager():lock_ui(false, false);
--cm:get_campaign_ui_manager():unlock_ui();
--cm:get_campaign_ui_manager():override("spell_browser"):set_allowed(true);
--cm:get_campaign_ui_manager():override("spell_browser"):unlock(true, false);
--cm:get_intervention_manager():override("spell_browser"):set_allowed(true);
--cm:get_intervention_manager():override("spell_browser"):unlock();	

--v function(charSubtype: string, faction: CA_FACTION) --> CA_CHAR					
function getCharByFaction(charSubtype, faction)
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
--cm:force_confederation("wh2_main_lzd_xlanhuapec", "wh2_main_lzd_hexoatl");
			--TEST
			--local cqi = currentChar:cqi();
			--cm:add_agent_experience(cm:char_lookup_str(cqi), 70000);
			--cm:spawn_character_to_pool(cm:get_local_faction(), "", "", "", "", 18, true, "general", "wh2_main_lzd_slann_mage_priest", false, "wh2_main_art_set_lzd_slann_mage_priest_01");
			--cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_main_lzd_cha_skink_priest_beasts_0");
			
--Make a group in campaign_groups
--Create a member of that group in campaign_group_members
--Attach a number value to that member in campaign_group_member_criteria_values		
--Create new entry in event_feed_messageevents, in the event column use one of the events prefixed with "scripted", set the group to be the group you created in step one, set the image in this table too	
--When calling the function to trigger the event pass the number you added, set the bool you pass to true if the event you created in the last step has an event type that is persistent, false if transient (true makes it appear in faction log)
--# assume CM.show_message_event_located: method(
--#     faction_key: string,
--#     primary_detail: string,
--#     secondary_detail: string,
--#     flavour_text: string,
--#     location_x: number,
--#     location_y: number,
--#     show_immediately: boolean,
--#     event_picture_id: number
--#)
cm:show_message_event(
            human_factions[i],
            "event_feed_strings_text_wh_event_feed_string_scripted_event_karak_ekrund1_primary_detail",
            "",
            "event_feed_strings_text_wh_event_feed_string_scripted_event_karak_ekrund1_secondary_detail",
            true,
            592
        );

        --"[[col:" .. colour .. "]]" .. traitDescription .. traitEffectScopeDesc .. "[[/col]]";

       -- local divider = Image.new(name, parent, "ui/skins/default/separator_line.png")

       Example usage: vfs.exists("script/docgen.lua") 
        Returns true if that Lua file exists


        local playerFaction = cm:get_faction(cm:get_local_faction(true));
        cm:faction_set_food_factor_value(playerFaction:name(), "wh_dlc07_chivalry_events", 600);

        CA MitchToday at 00:45
You can use the FrontEnd script interface to do some stuff
In WH you have these functions:
[23:44.14]        frontend    table: 000000006FA23E50

[23:44.14]                continue_campaign    function: 000000006FA32770

[23:44.14]                campaign_saves_exist    function: 000000006FBB00E0

[23:44.14]                start_named_battle    function: 000000006FB6CA20

[23:44.14]                start_campaign    function: 000000000217FBE8

[23:44.14]                load_campaign    function: 000000006F96F998

[23:44.14]                campaign_saves_exist_mp    function: 000000006F9ACA40
excuse formatting
start campaign takes a key
FrontEnd.start_campaign("key");
Iv not used it, but might work..

sm0kin01/02/2019
There is no way use a mod to remove table entries another mod add to the game, right? e.g. special_ability_groups_to_unit_abilities_junctions
Cataph01/02/2019
no
you'd have to redirect the main unit to a new land unit that doesn't have that stuff, for example


bm:modify_battle_speed(1);	-- 2 == double, 0.5 == half the normal speed


core_object:svr_save_registry_bool(name, value)



cm:create_agent(
    "wh2_main_lzd_hexoatl",
    "wizard",
    "wh2_main_lzd_skink_priest_heavens",
    29,
    296,
    false,
    function(cqi)
        local char_str = cm:char_lookup_str(cqi);
        cm:replenish_action_points(char_str);
    end
);

DOCK_POINT_NONE    0
DOCK_POINT_TL    1
DOCK_POINT_TC    2
DOCK_POINT_TR    3
DOCK_POINT_CL    4
DOCK_POINT_C    5
DOCK_POINT_CR    6
DOCK_POINT_BL    7
DOCK_POINT_BC    8
DOCK_POINT_BR    9
uic:SetDockingPoint(number dock point)
Those refer to like, Top left, Top Center, Top Right, Center Left, Center, Center Right, Bottom Left, Bottom Center, Bottom Right



cm:add_custom_battlefield(
		"generic",											-- string identifier
		0,													-- x co-ord
		0,													-- y co-ord
		5000,												-- radius around position
		false,												-- will campaign be dumped
		"",													-- loading override
		"script/battle/campaign_battle/battle_start.lua",	-- script override
		"",													-- entire battle override
		0,													-- human alliance when battle override
		false,												-- launch battle immediately
		true,												-- is land battle (only for launch battle immediately)
		false												-- force application of autoresolver result
    );

--D:\Modding\scripts\vanilla\campaign\wh_campaign_mod_scripting.lua
--D:\Modding\VScode\TW-Mods\backup\battle\campaign_battle\battle_start.lua

the ethereal effect is handled via material files and an ethereal shader

 <shader>shaders/weighted2_ethereal_optimized.xml.shader</shader>


for wsmodels
check existing units like the vampire wraiths, vmp_cairn_wraith_body_01_weighted2_alpha_on.xml.material
it can be tricky to get working properly though


bm:set_volume(volume_type, 0..100) 

cm:add_first_tick_callback(function()
    Gotrek_and_Felix_add()
end)

Is there an easy, quick and painless way to change lord's/hero's name with scropts?

make a trait
apply the trait

Which kinda means no (at least for now, making dozens of traits is quite a bit)  for me, I was considering renaming every single lord / hero as you recruit him
I though it would be somehow possible to do with just two lua tables and single listener

    spawn char to pool has name args, but any existing characters need a tarit
and a trait



Taiyoumaru01/03/2019
is there any way I can get OBR or the other mod to reset a non-mod LLs quests as well?
considering when I confederated the LL he was wounded
DrunkFlamingo01/03/2019
Nope, quests are not reset able
Struggled with trying for a while with llr, its theoretically possible you would just have to redo the db for all of them
So I didnt
Taiyoumaru01/03/2019
sad to hear
not sure what redo the database means exatly but it sounds like a lot of work
but modders can theoretically do it without needing CA right?
DrunkFlamingo01/03/2019
Modders can theoretically do it without needing CA yes
it basically means:
There is a bunch of work that goes into setting up any kind of event, quest chains included
To make quests which are more pliable to resetting, you would need to redo all of those setups
and possibly change some of the objectives
so it would involve basically remaking a lot of the backend of the quests which is a lot of work, but yes 100% doable without CA


local playerFaction = cm:get_faction(cm:get_local_faction(true));
--
local faction_leader = playerFaction:faction_leader();
local x = faction_leader:logical_position_x()
local y = faction_leader:logical_position_y()
local region = faction_leader:faction():home_region():name()
local faction_leader_cqi = playerFaction:faction_leader():command_queue_index();	
cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), false);
cm:kill_character(faction_leader_cqi, true, true); 
core:add_listener(
	"sm0_test123",
	"CharacterCreated",
	function(context) return context:character():character_subtype_key() == "wh2_main_lzd_lord_mazdamundi" end,
	function(context) 
		cm:add_agent_experience(cm:char_lookup_str(context:character()), 70000);
		cm:set_character_immortality(cm:char_lookup_str(context:character()), true); 
	end,
	false
); 
	local unit_list = "wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_mon_bastiladon_0,wh2_main_lzd_mon_kroxigors,wh2_main_lzd_mon_bastiladon_blessed_2"
	local game_interface = cm:get_game_interface();--wh2_main_lzd_hexoatl
	game_interface:create_force_with_general("wh2_main_lzd_last_defenders", unit_list, region, x, y, "general", "wh2_main_lzd_lord_mazdamundi", "names_name_2147359221", "", "names_name_2147359230", "", "2140784856", true)
	local mazdamundi_quests = {
		{"mission", "wh2_main_anc_weapon_cobra_mace_of_mazdamundi", "wh2_main_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_1", 10},
		{"mission", "wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl", "wh2_main_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_1", 6}
	};
	--set_up_rank_up_listener(mazdamundi_quests, "wh2_main_lzd_lord_mazdamundi");
	
	cm:create_force_with_general(
		"wh2_main_lzd_hexoatl",
		"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_mon_bastiladon_0,wh2_main_lzd_mon_kroxigors,wh2_main_lzd_mon_bastiladon_blessed_2",
		region, --
		x, --47
		y, --299
		"general",
		"wh2_main_lzd_lord_mazdamundi",
		"names_name_2147359221",
		"",
		"names_name_2147359230",
		"",
		true,
		function(cqi)
			local mazdamundi_quests = {
				{"mission", "wh2_main_anc_weapon_cobra_mace_of_mazdamundi", "wh2_main_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_1", 10},
				{"mission", "wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl", "wh2_main_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_1", 6}
			};
			--set_up_rank_up_listener(mazdamundi_quests, "wh2_main_lzd_lord_mazdamundi");
			cm:add_agent_experience(cm:char_lookup_str(cqi), 70000);
			cm:set_character_immortality(cm:char_lookup_str(cqi), true);
		end
	);


---------------------------------------------		
Command: 	force_religion_factors	
Description: 	Forces regligion factors to a certain value, please note this will only work on turn 1 and at least 1 region key must be provided. Religions that are not represented by a pair of religion record key and value will be flattened down to 0.f. Numerical religion values added need to be between 0.0 and 1.0, the total of all value pairs must also be in that range.	
Usage: 		force_religion_factors("region_key", "religion_1_key", "religion_1_value", "religion_2_key", "religion_2_value", ...)
---------------------------------------------		
Command: 	stop_character_convalescing	
Description: 	Instantly stop a character from convalescing	
Usage: 		stop_character_convalescing(card32 character_cqi)
---------------------------------------------		
Command: 	heal_garrison	
Description: 	Heals the Garrison in a region back to full health	
Usage: 		heal_garrison(card32 region_cqi)
---------------------------------------------		
Command: 	set_scripted_mission_position	
Description: 	Set the position of a scripted mission objective	
Usage: 		set_scripted_mission_position(string mission_key, string script_key, card16 pos_x, card16 pos_y)
---------------------------------------------		
Command: 	find_valid_spawn_location_for_character_from_character	
Description: 	Utilise the pathfinder to locate a valid spawn point for a character, based around another character. Returns -1, -1 if invalid	
Usage: 		find_valid_spawn_location_for_character_from_character(String faction_key, String character_lookup)
---------------------------------------------		
Command: 	add_units_to_province_mercenary_pool_by_region	
Description: 	Add count of a specified unit to the province mercenary pool	
Usage: 		add_units_to_province_mercenary_pool_by_region(region_key, "awesome_unit", 2)
---------------------------------------------		
Command: 	add_foreign_slot_set_to_region_for_faction	
Description: 	Add the specified foreign slot set to the target region, for the target faction. Returns the foreign slot manager of the faction (may be null if parameters are invalid)	
Usage: 		add_foreign_slot_set_to_region_for_faction(faction_cqi, region_cqi, slot_set_key)
---------------------------------------------		
Command: 	remove_faction_foreign_slots_from_region	
Description: 	Add the specified foreign slot set to the target region, for the target faction.	
Usage: 		add_foreign_slot_set_to_region_for_faction(faction_cqi, region_cqi)


---------------------------------------------		
Command: 	foreign_slot_instantly_upgrade_building	
Description: 	Instantly upgrade the building in the specified foreign slot	
Usage: 		foreign_slot_instantly_upgrade_building(foreign_slot_cqi, upgrade_building_key)
---------------------------------------------		
Command: 	foreign_slot_instantly_dismantle_building	
Description: 	Instantly dismantle the building in the specified foreign slot	
Usage: 		foreign_slot_instantly_dismantle_building(foreign_slot_cqi)
---------------------------------------------		
Command: 	trigger_mission_with_targets	
Description: 	Trigger a mission with specified targets. Pass zero for CQI's if you don't want a target set.	
Usage: 		bool trigger_mission_with_targets(owning_faction_cqi, mission_key, faction_cqi, secondary_faction_cqi, character_cqi, military_force_cqi, region_cqi, settlement_cqi)
---------------------------------------------		
Command: 	trigger_incident_with_targets	
Description: 	Trigger an incident with specified targets. Pass zero for CQI's if you don't want a target set.	
Usage: 		bool trigger_incident_with_targets(owning_faction_cqi, incident_key, faction_cqi, secondary_faction_cqi, character_cqi, military_force_cqi, region_cqi, settlement_cqi)
---------------------------------------------		
Command: 	trigger_dilemma_with_targets	
Description: 	Trigger an dilemma with specified targets. Pass zero for CQI's if you don't want a target set.	
Usage: 		bool trigger_dilemma_with_targets(owning_faction_cqi, dilemma_key, faction_cqi, secondary_faction_cqi, character_cqi, military_force_cqi, region_cqi, settlement_cqi)
---------------------------------------------		
Command: 	trigger_intrigue	
Description: 	Triggers an intrigue incident which improves or worsens diplomatic relations between two factions. Fourth boolean argument improves relations if set to true, worsens them if set to false. Fifth argument exempts the issuing faction from the influence cost if true.	
Usage: 		trigger_intrigue(issuing faction key, first target faction key, second target faction key, should_improve, exempt_from_cost)
---------------------------------------------		
Command: 	apply_dilemma_diplomatic_bonus	
Description: 	Directly applies a diplomatic bonus or penalty between two factions, as if it had come from a dilemma. The bonus should be an integer between -6 and +6, each integer value of which corresponds to a change type (from PENALTY_XXXLARGE (-6) to BONUS_XXXLARGE (+6)) which carries a diplomatic attitude modifier that is actually applied.	
Usage: 		apply_dilemma_diplomatic_penalty(first_faction_key, second_faction_key, attitude_bonus)
---------------------------------------------	
Function: has_banner_ancillary
Description: Returns whether the unit has a banner equipped
Parameters: has_banner_ancillary()
Return: bool

Function: banner_ancillary
Description: Returns the ancillary key of the banner equipped by the unit, or an empty string if no banner is equipped
Parameters: banner_ancillary()
Return: String

--- @function svr_save_registry_bool
--- @desc Saves a boolean value to the registry. This will persist, even if the game is reloaded.
--- @p string value name
--- @p boolean value
function core_object:svr_save_registry_bool(name, value)
	if not is_string(name) then
		script_error("ERROR: svr_save_registry_bool() called but supplied name [" .. tostring(name) .. "] is not a string");
		return false;
	end;
	
	if not is_boolean(value) then
		script_error("ERROR: svr_save_registry_bool() called but supplied value [" .. tostring(value) .. "] is not boolean");
		return false;
	end;

	return self.svr:SaveRegistryBool(name, value);
end;


--- @function svr_load_registry_bool
--- @desc Loads a boolean value from the registry.
--- @p string value name
--- @return boolean value
function core_object:svr_load_registry_bool(name)
	return self.svr:LoadRegistryBool(name);
end;


Scripts run the exact same way but scripts run separately on both machines
This means they have to be determinate when they impact the game model, so you have to send triggers for non-determinant events (namely UI)
“Determinant when they impact the game model” means it would be bad if lets say, player A’s script decided to spawn chaos and player B’s script decided not to. That would be indeterminacy and cause a desync.
That generally only happens if you write code that uses UI events to cause things to happen (region trading mod, for example) since pressing buttons isn’t determinant across both machines.
There is a command to send an MP event to both players that is used to make UI mods MP safe. UI mods typically have to use that to be mp compatible.
