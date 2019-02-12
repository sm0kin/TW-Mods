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

