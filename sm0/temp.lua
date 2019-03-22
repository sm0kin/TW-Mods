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
--cm:force_confederation("wh2_main_hef_avelorn", "wh2_main_hef_order_of_loremasters");
			--TEST
			--local cqi = currentChar:cqi();
			--cm:add_agent_experience(cm:char_lookup_str(cqi), 70000);
			--cm:spawn_character_to_pool(cm:get_local_faction(), "", "", "", "", 18, true, "general", "wh2_main_lzd_slann_mage_priest", false, "wh2_main_art_set_lzd_slann_mage_priest_01");
            --cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_main_lzd_cha_skink_priest_beasts_0");
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



LL 2:  ERROR    : [27, 02 2019 23:36:22]
LL 2:  [string "/script/campaign/mod/sr_chaos.lua"]:83: attempt to call method 'command_queue_index' (a nil value)    : [27, 02 2019 23:36:22]
LL 2:  stack traceback:
	[string "/script/campaign/mod/mixu_darkhand.lua"]:60: in function 'safeCall'
	[string "/script/campaign/mod/mixu_darkhand.lua"]:78: in function <[string "/script/campaign/mod/mixu_darkhand.lua"]:73>
	(tail call): ?
	[C]: in function 'pcall'
	[string "/script/campaign/mod/mixu_darkhand.lua"]:56: in function 'safeCall'
	[string "/script/campaign/mod/mixu_darkhand.lua"]:78: in function <[string "/script/campaign/mod/mixu_darkhand.lua"]:73>
	(tail call): ?
	[C]: in function 'pcall'
	[string "/script/campaign/mod/mixu_darkhand.lua"]:56: in function 'safeCall'
	[string "/script/campaign/mod/mixu_darkhand.lua"]:78: in function '?'
	[string "data/script/_lib/lib_core.lua"]:954: in function 'event_callback'
	[string "data/script/_lib/lib_core.lua"]:907: in function 'callback'
    [string "data/script/_lib/lib_core.lua"]:915: in function <[string "data/script/_lib/lib_core.lua"]:915>    : [27, 02 2019 23:36:22]
LL 2:  ERROR    : [27, 02 2019 23:40:22]
LL 2:  [string "/script/campaign/mod/sr_halfling.lua"]:33: attempt to call method 'command_queue_index' (a nil value)    : [27, 02 2019 23:40:22]
LL 2:  stack traceback:
    [string "/script/campaign/mod/mixu_darkhand.lua"]:60: in function 'safeCall'
    [string "/script/campaign/mod/mixu_darkhand.lua"]:78: in function <[string "/script/campaign/mod/mixu_darkhand.lua"]:73>
    (tail call): ?
    [C]: in function 'pcall'
    [string "/script/campaign/mod/mixu_darkhand.lua"]:56: in function 'safeCall'
    [string "/script/campaign/mod/mixu_darkhand.lua"]:78: in function <[string "/script/campaign/mod/mixu_darkhand.lua"]:73>
    (tail call): ?
    [C]: in function 'pcall'
    [string "/script/campaign/mod/mixu_darkhand.lua"]:56: in function 'safeCall'
    [string "/script/campaign/mod/mixu_darkhand.lua"]:78: in function '?'
    [string "data/script/_lib/lib_core.lua"]:954: in function 'event_callback'
    [string "data/script/_lib/lib_core.lua"]:907: in function 'callback'
    [string "data/script/_lib/lib_core.lua"]:915: in function <[string "data/script/_lib/lib_core.lua"]:915>    : [27, 02 2019 23:40:22]
    

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