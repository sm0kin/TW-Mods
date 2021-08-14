local disableSL = false
local speedBox = nil --:CA_UIC
local applyButton = nil --:CA_UIC
local saveButton = nil --:CA_UIC
local loadButton = nil --:CA_UIC
local bm = get_bm()
local bar_small_top_ref = find_uicomponent(core:get_ui_root(), "layout", "radar_holder", "bar_small_top")
local bar_small_top_ref_W, bar_small_top_ref_H = bar_small_top_ref:Bounds()
local savedEntry = tonumber(core:svr_load_string("svr_battleSpeed")) or 1 --:number
out("sm0/Battle_savedEntry: "..tostring(savedEntry))

--v function(uic: CA_UIC)
local function deleteUIC(uic)
    local root = core:get_ui_root()
    root:CreateComponent("Garbage", "UI/campaign ui/script_dummy")
    local component = root:Find("Garbage")
    local garbage = UIComponent(component)
    garbage:Adopt(uic:Address())
    garbage:DestroyChildren()
end

--v function()
local function deleteSpeedUI()
    if is_uicomponent(find_uicomponent(core:get_ui_root(), "speedBox")) then
        deleteUIC(speedBox)
        speedBox = nil
    end
    if is_uicomponent(find_uicomponent(core:get_ui_root(), "applyButton")) then
        deleteUIC(applyButton)
        core:remove_listener("sm0_applyButton")
        applyButton = nil
    end
    if is_uicomponent(find_uicomponent(core:get_ui_root(), "saveButton")) then
        deleteUIC(saveButton)
        core:remove_listener("sm0_saveButton")
        saveButton = nil
    end
    if is_uicomponent(find_uicomponent(core:get_ui_root(), "loadButton")) then
        deleteUIC(loadButton)
        core:remove_listener("sm0_loadButton")
        loadButton = nil
    end
    bar_small_top_ref:Resize(bar_small_top_ref_W, bar_small_top_ref_H)
end

--v function()
local function createSpeedUI()
    deleteSpeedUI()
    local speed_buttons = find_uicomponent(core:get_ui_root(), "layout", "radar_holder", "speed_controls", "speed_buttons")
    local referenceButton = find_uicomponent(speed_buttons, "pause")
    local referenceButtonW, referenceButtonH = referenceButton:Bounds()
    local referenceButtonX, referenceButtonY = referenceButton:Position()
    local bar_small_top = find_uicomponent(core:get_ui_root(), "layout", "radar_holder", "bar_small_top")
    local bar_small_top_W, bar_small_top_H = bar_small_top:Bounds()

    speed_buttons:CreateComponent("speedBox", "ui/common ui/text_box")
    speedBox = UIComponent(speed_buttons:Find("speedBox"))
    speed_buttons:Adopt(speedBox:Address())
    speedBox:PropagatePriority(referenceButton:Priority())
    speedBox:SetCanResizeHeight(true)
    speedBox:SetCanResizeWidth(true)
    speedBox:Resize(1.5*referenceButtonW, referenceButtonH)
    speedBox:SetCanResizeHeight(false)
    speedBox:SetCanResizeWidth(false)
    speedBox:MoveTo(referenceButtonX - 2.5*referenceButtonW, referenceButtonY)

    speed_buttons:CreateComponent("applyButton", "ui/templates/square_medium_button")
    applyButton = UIComponent(speed_buttons:Find("applyButton"))
    speed_buttons:Adopt(applyButton:Address())
    applyButton:PropagatePriority(referenceButton:Priority())
    --if (core:svr_load_bool("primary_defender_is_player") and string.find(core:svr_load_string("primary_defender_subculture"), "wh_")) or 
    --        (core:svr_load_bool("primary_attacker_is_player") and string.find(core:svr_load_string("primary_attacker_subculture"), "wh_")) then
    --    applyButton:SetImagePath("ui/skins/default/icon_check.png") 
    --else
    --    applyButton:SetImagePath("ui/skins/warhammer2/icon_check.png") 
    --end
    local reference_imagepath = referenceButton:GetImagePath()
    out("sm0/reference_imagepath: "..tostring(reference_imagepath))
    if string.find(reference_imagepath, "warhammer2") then 
        applyButton:SetImagePath("ui/skins/warhammer2/icon_check.png") 
    else
        applyButton:SetImagePath("ui/skins/default/icon_check.png")
    end
    applyButton:Resize(referenceButtonW, referenceButtonH)
    applyButton:MoveTo(referenceButtonX - referenceButtonW, referenceButtonY)
    applyButton:SetState("hover")
    applyButton:SetTooltipText("apply speed", "", false)
    applyButton:SetState("active")
    core:add_listener(
        "sm0_applyButton",
        "ComponentLClickUp",
        function(context)
            return context.string == "applyButton"
        end,
        function(context)
            local speedButton --: CA_UIC
            local stateText = speedBox:GetStateText()
            stateText = string.gsub(stateText, "%[%[col:green%]%]", "")
            stateText = string.gsub(stateText, "%[%[/col%]%]", "")
            stateText = string.gsub(stateText, ",", ".")
            local number = stateText
            if not tonumber(number) then
                speedButton = find_uicomponent(speed_buttons, "pause")
            elseif number == "0" then
                speedButton = find_uicomponent(speed_buttons, "pause")
                -- logical operations as string because tonumber isn't precise with float, e.g. tonumber("22.31") --> 22.310000000000002
                --#assume number: number
                if speedButton:CurrentState() == "selected" then number = savedEntry end
            else
                speedButton = find_uicomponent(speed_buttons, "play")
            end
            -- replay speed control doesn't recognise modify_battle_speed
            speedButton:SimulateLClick()
            if tonumber(number) then
                -- a battle speed of less than 100ms will cause problems since the game ticks every 100ms
                if tonumber(number) < 0.1 and number ~= "0" then number = "0.1" end
                --#assume number: number
                bm:modify_battle_speed(number)
                speedBox:SetStateText("[[col:green]]"..number.."[[/col]]")
                --bm:set_volume(VOLUME_TYPE_MUSIC, 100)
                --bm:set_volume(VOLUME_TYPE_SFX, 100)
                --bm:set_volume(VOLUME_TYPE_VO, 100)
                if number ~= "0" then savedEntry = number end
            else
                speedBox:SetStateText("[[col:red]]Invalid![[/col]]")
            end
        end,
        true
    )

    --local battle_type = core:svr_load_string("battle_type")
    --out("sm0/battle_type = "..battle_type) --only campaign uses the battle_type svr
    if not disableSL then
        speed_buttons:CreateComponent("saveButton", "ui/templates/square_medium_button")
        saveButton = UIComponent(speed_buttons:Find("saveButton"))
        speed_buttons:Adopt(saveButton:Address())
        saveButton:PropagatePriority(referenceButton:Priority())
        --if (core:svr_load_bool("primary_defender_is_player") and string.find(core:svr_load_string("primary_defender_subculture"), "wh_")) or 
        --(core:svr_load_bool("primary_attacker_is_player") and string.find(core:svr_load_string("primary_attacker_subculture"), "wh_")) then
        --    saveButton:SetImagePath("ui/icon_quick_save.png") 
        --else
        --    saveButton:SetImagePath("ui/icon_quick_save2.png") 
        --end
        if string.find(reference_imagepath, "warhammer2") then 
            saveButton:SetImagePath("ui/icon_quick_save2.png") 
        else
            saveButton:SetImagePath("ui/icon_quick_save.png")
        end
        saveButton:Resize(referenceButtonW, referenceButtonH)
        saveButton:MoveTo(referenceButtonX - 3.5*referenceButtonW, referenceButtonY)
        saveButton:SetState("hover")
        saveButton:SetTooltipText("save prefered speed", "", false)
        saveButton:SetState("active")
        
        core:add_listener(
            "sm0_saveButton",
            "ComponentLClickUp",
            function(context)
                return context.string == "saveButton"
            end,
            function(context)
                local speedButton --: CA_UIC
                local stateText = speedBox:GetStateText()
                stateText = string.gsub(stateText, "%[%[col:green%]%]", "")
                stateText = string.gsub(stateText, "%[%[/col%]%]", "")
                stateText = string.gsub(stateText, ",", ".")
                local number = stateText
                if not tonumber(number) then
                    speedBox:SetStateText("[[col:red]]Invalid![[/col]]")
                else
                    if tonumber(number) < 0.1 and number ~= "0" then number = "0.1" end
                    core:svr_save_string("svr_battleSpeed", tostring(number))
                    --loadButton:SetDisabled(false)
                    --loadButton:SetOpacity(255)
                    loadButton:SetState("hover")
                    loadButton:SetTooltipText("load prefered speed: "..tostring(number), "", false)
                    loadButton:SetState("active")
                end
            end,
            true
        )
        
        speed_buttons:CreateComponent("loadButton", "ui/templates/square_medium_button")
        loadButton = UIComponent(speed_buttons:Find("loadButton"))
        speed_buttons:Adopt(loadButton:Address())
        loadButton:PropagatePriority(referenceButton:Priority())
        --if (core:svr_load_bool("primary_defender_is_player") and string.find(core:svr_load_string("primary_defender_subculture"), "wh_")) or 
        --(core:svr_load_bool("primary_attacker_is_player") and string.find(core:svr_load_string("primary_attacker_subculture"), "wh_")) then
        --    loadButton:SetImagePath("ui/icon_load.png") 
        --else
        --    loadButton:SetImagePath("ui/icon_load2.png") 
        --end
        if string.find(reference_imagepath, "warhammer2") then 
            loadButton:SetImagePath("ui/icon_load2.png") 
        else
            loadButton:SetImagePath("ui/icon_load.png")
        end
        loadButton:Resize(referenceButtonW, referenceButtonH)
        loadButton:MoveTo(referenceButtonX - 4.5*referenceButtonW, referenceButtonY)
        loadButton:SetState("hover")
        loadButton:SetTooltipText("load prefered speed", "", false)
        loadButton:SetState("active")
        if tonumber(core:svr_load_string("svr_battleSpeed")) then 
            loadButton:SetState("hover")
            loadButton:SetTooltipText("load prefered speed: "..tostring(core:svr_load_string("svr_battleSpeed")), "", false)
            loadButton:SetState("active")
        else
            --loadButton:SetDisabled(true)
            loadButton:SetState("inactive")
            loadButton:SetTooltipText("no prefered speed found",  "", false)
            --loadButton:SetOpacity(50)
        end
        core:add_listener(
            "sm0_loadButton",
            "ComponentLClickUp",
            function(context)
                return context.string == "loadButton"
            end,
            function(context)
                speedBox:SetStateText(""..core:svr_load_string("svr_battleSpeed"))
            end,
            true
        )
        bar_small_top:Resize(bar_small_top_W + 4.5*referenceButtonW, bar_small_top_H)
    else
        bar_small_top:Resize(bar_small_top_W + 2.5*referenceButtonW, bar_small_top_H)
    end
end

core:add_listener(
    "sm0_battleStart_ComponentLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "pause" or context.string == "slow_mo" or context.string == "play" 
        or context.string == "fwd" or context.string == "ffwd" or (context.string == "button_battle_start" and not string.find(core:svr_load_string("battle_type"), "ambush"))
	end,
    function(context)
        createSpeedUI()
    end,
    true
)

core:add_listener(
    "sm0_speedButtons_ComponentLClickUp",
    "ComponentLClickUp",
    true,
    function(context)
        if context.string == "pause" then
            speedBox:SetStateText("0")
        elseif context.string == "slow_mo" then
            speedBox:SetStateText("0.5")
        elseif context.string == "play" then
            speedBox:SetStateText("1")
        elseif context.string == "fwd" then
            speedBox:SetStateText("2")
        elseif context.string == "ffwd" then
            speedBox:SetStateText("3")
        end
    end,
    true
)
core:add_listener(
    "sm0_tactical_map_ComponentLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "button_tactical_map"
	end,
    function(context)
        deleteSpeedUI()
    end,
    true
)

core:add_listener(
    "sm0_toggle_ui_ShortcutTriggered",
    "ShortcutTriggered",
    function(context)
        return context.string == "toggle_ui_with_borders" or context.string == "toggle_ui" or context.string == "show_tactical_map"
    end,
    function(context)
        deleteSpeedUI()
    end,
    true
)