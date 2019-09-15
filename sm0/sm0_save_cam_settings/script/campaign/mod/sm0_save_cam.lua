--# assume table:TABLE
force_require("script/table_save")
local loadButton = nil --:CA_UIC
local saveButton = nil --:CA_UIC
local resetButton = nil --:CA_UIC
local resetIconPath = "ui/icon_stats_reset_small.png"
local saveIconPath = "ui/icon_quick_save.png"
local loadIconPath = "ui/icon_load.png"

local camTableReset = {
    ["apply_player"] = {    
        ["dropdown_armies_camera"] = "option0",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option0",
        ["dropdown_heroes_speed"] = "option0"
    },
    ["apply_allies"] = {    
        ["dropdown_armies_camera"] = "option3",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option3",
        ["dropdown_heroes_speed"] = "option0"
    },
    ["apply_enemies"] = {   
        ["dropdown_armies_camera"] = "option3",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option3",
        ["dropdown_heroes_speed"] = "option0"
    },
    ["apply_neutrals"] = {  
        ["dropdown_armies_camera"] = "option3",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option3",
        ["dropdown_heroes_speed"] = "option0"
    }   
} --: map<string, map<string, string>>

local camTable = {      
    ["apply_player"] = {    
        ["dropdown_armies_camera"] = "option0",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option0",
        ["dropdown_heroes_speed"] = "option0"
    },
    ["apply_allies"] = {    
        ["dropdown_armies_camera"] = "option3",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option3",
        ["dropdown_heroes_speed"] = "option0"
    },
    ["apply_enemies"] = {   
        ["dropdown_armies_camera"] = "option3",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option3",
        ["dropdown_heroes_speed"] = "option0"
    },
    ["apply_neutrals"] = {  
        ["dropdown_armies_camera"] = "option3",
        ["dropdown_armies_speed"] = "option0",
        ["dropdown_heroes_camera"] = "option3",
        ["dropdown_heroes_speed"] = "option0"
    }  
} --: map<string, map<string, string>>

--v function()
local function saveSettingsToTable()
    local lastCategory
    for i, _ in pairs(camTable) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", i)
        if camCategory:CurrentState() == "selected" or camCategory:CurrentState() == "selected_hover" or camCategory:CurrentState() == "selected_down" then
            lastCategory = camCategory
        end
    end  
    for j, _ in pairs(camTable) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", j)
        camCategory:SimulateLClick()
        local cameraStr = camCategory:Id()
        for i = 0, 5 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_camera", "option" .. i)
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_armies_camera"] = "option"..i
            end
        end
        for i = 0, 2 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_speed", "option" .. i)
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_armies_speed"] = "option"..i
            end
        end
        for i = 0, 5 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_camera", "option" .. i)
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_heroes_camera"] = "option"..i
            end
        end
        for i = 0, 2 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_speed", "option" .. i)
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_heroes_speed"] = "option"..i
            end
        end
    end
    cm:callback(
        function()
            lastCategory:SimulateLClick()
        end, 0, "waitForUI"
    )
end

--v function(Table: map<string, map<string, string>>)
local function applySettingsFromTable(Table)
    local lastCategory
    for i, _ in pairs(Table) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", i)
        if camCategory:CurrentState() == "selected" or camCategory:CurrentState() == "selected_hover" or camCategory:CurrentState() == "selected_down" then
            lastCategory = camCategory
        end
    end
    for j, optionTable in pairs(Table) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", j)
        camCategory:SimulateLClick()
        armiesCameraOptionStr = optionTable["dropdown_armies_camera"]
        local armiesCameraOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_camera", armiesCameraOptionStr)
        armiesCameraOption:SimulateLClick()
        armiesSpeedOptionStr = optionTable["dropdown_armies_speed"]
        local armiesSpeedOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_speed", armiesSpeedOptionStr)
        armiesSpeedOption:SimulateLClick()
        heroesCameraOptionStr = optionTable["dropdown_heroes_camera"]
        local heroesCameraOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_camera", heroesCameraOptionStr)
        heroesCameraOption:SimulateLClick()
        heroesSpeedOptionStr = optionTable["dropdown_heroes_speed"]
        local heroesSpeedOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_speed", heroesSpeedOptionStr)
        heroesSpeedOption:SimulateLClick()
    end
    cm:callback(
        function()
            if lastCategory then lastCategory:SimulateLClick() end
        end, 0, "waitForUI"
    )
end

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
local function deleteUI()
	if resetButton then
        deleteUIC(resetButton)
        core:remove_listener("sm0_resetButton")
        resetButton = nil
    end
    if saveButton then
        deleteUIC(saveButton)
        core:remove_listener("sm0_saveButton")
        saveButton = nil
    end
    if loadButton then
        deleteUIC(loadButton)
        core:remove_listener("sm0_loadButton")
        loadButton = nil
    end
end

--v function()
local function createUI()
    deleteUI()
    local camera_buttons = find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder")
    local referenceButton = find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder", "button_close")
    local referenceButtonW, referenceButtonH = referenceButton:Bounds()
    local referenceButtonX, referenceButtonY = referenceButton:Position()

    camera_buttons:CreateComponent("loadButton", "ui/templates/round_small_button")
    loadButton = UIComponent(camera_buttons:Find("loadButton"))
    camera_buttons:Adopt(loadButton:Address())
    loadButton:PropagatePriority(referenceButton:Priority())
    loadButton:SetImagePath(loadIconPath) 
    loadButton:Resize(referenceButtonW, referenceButtonH)
    loadButton:MoveTo(referenceButtonX, referenceButtonY + referenceButtonH + 25)
    loadButton:SetState("hover")
    loadButton:SetTooltipText("Load user camera settings")
    loadButton:SetState("active")
    core:add_listener(
        "sm0_loadButton",
        "ComponentLClickUp",
        function(context)
            return context.string == "loadButton"
        end,
        function(context)
            local camTable, err = table.load("cameraPreferences.txt")
            if not err then
                applySettingsFromTable(camTable)
            else
                applySettingsFromTable(camTableReset)
            end
        end,
        true
    )

    camera_buttons:CreateComponent("saveButton", "ui/templates/round_small_button")
    saveButton = UIComponent(camera_buttons:Find("saveButton"))
    camera_buttons:Adopt(saveButton:Address())
    saveButton:PropagatePriority(referenceButton:Priority())
    saveButton:SetImagePath(saveIconPath) 
    saveButton:Resize(referenceButtonW, referenceButtonH)
    saveButton:MoveTo(referenceButtonX - referenceButtonW - 1, referenceButtonY + referenceButtonH + 25)
    saveButton:SetState("hover")
    saveButton:SetTooltipText("Save user camera settings as default")
    saveButton:SetState("active")
    core:add_listener(
        "sm0_saveButton",
        "ComponentLClickUp",
        function(context)
            return context.string == "saveButton"
        end,
        function(context)
            saveSettingsToTable()
            table.save(camTable, "cameraPreferences.txt")
        end,
        true
    )
    
    camera_buttons:CreateComponent("resetButton", "ui/templates/round_small_button")
    resetButton = UIComponent(camera_buttons:Find("resetButton"))
    camera_buttons:Adopt(resetButton:Address())
    resetButton:PropagatePriority(referenceButton:Priority())
    resetButton:SetImagePath(resetIconPath) 
    resetButton:Resize(referenceButtonW, referenceButtonH)
    resetButton:MoveTo(referenceButtonX - 2*referenceButtonW - 2, referenceButtonY + referenceButtonH + 25)
    resetButton:SetState("hover")
    resetButton:SetTooltipText("Reset camera settings to CA default")
    resetButton:SetState("active")
    core:add_listener(
        "sm0_resetButton",
        "ComponentLClickUp",
        function(context)
            return context.string == "resetButton"
        end,
        function(context)
            applySettingsFromTable(camTableReset)
        end,
        true
    )
end

core:add_listener(
    "applyLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "apply_current_faction" or context.string == "apply_player" or context.string == "apply_allies" or context.string == "apply_enemies" or context.string == "apply_neutrals"
    end,
    function(context)
        if context.string == "apply_current_faction" then
            deleteUI()
        else
            createUI()
        end
    end,
    true
)

core:add_listener(
    "SettingsLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "button_settings" or context.string == "button_pause"
    end,
    function(context)
        cm:callback(
            function()
                local apply_current_faction = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", "apply_current_faction")
                if apply_current_faction:CurrentState() ~= "selected" and apply_current_faction:CurrentState() ~= "selected_hover" and apply_current_faction:CurrentState() ~= "selected_down" then
                    createUI()
                else
                    deleteUI()
                end
            end, 0, "waitForUI"
        )
    end,
    true
)

--v function()
function sm0_save_cam()
    local playerFaction = cm:get_faction(cm:get_local_faction(true))
    local playerFactionStr = playerFaction:name()
    if string.find(playerFactionStr, "wh2_") then
        resetIconPath = "ui/icon_stats_reset_small2.png"
        saveIconPath = "ui/icon_quick_save2.png"
        loadIconPath = "ui/icon_load2.png"
    end
    if cm:is_new_game() then
        local loadTable, err = table.load("cameraPreferences.txt")
        if not err then
            applySettingsFromTable(loadTable)
            deleteUI()
        end
    end
end