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