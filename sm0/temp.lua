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

			--TEST
			--local cqi = currentChar:cqi();
			--cm:add_agent_experience(cm:char_lookup_str(cqi), 70000);
			--cm:spawn_character_to_pool(cm:get_local_faction(), "", "", "", "", 18, true, "general", "wh2_main_lzd_slann_mage_priest", false, "wh2_main_art_set_lzd_slann_mage_priest_01");
			--cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_main_lzd_cha_skink_priest_beasts_0");