cm:set_saved_value("sm0_save_cam", true);
--# assume table:TABLE
force_require("table_save");
local loadButton = nil --:BUTTON
local saveButton = nil --:BUTTON
local resetButton = nil --:BUTTON
local resetIconPath = "ui/icon_stats_reset_small.png";
local saveIconPath = "ui/icon_quick_save.png";
local loadIconPath = "ui/icon_load.png";
local playerFaction = cm:get_faction(cm:get_local_faction(true));
local playerFactionStr = playerFaction:name();
if string.find(playerFactionStr, "wh2_") then
    resetIconPath = "ui/icon_stats_reset_small2.png";
    saveIconPath = "ui/icon_quick_save2.png";
    loadIconPath = "ui/icon_load2.png";
end
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
function saveSettingsToTable()
    local lastCategory;
    for i, _ in pairs(camTable) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", i);
        if camCategory:CurrentState() == "selected" or camCategory:CurrentState() == "selected_hover" or camCategory:CurrentState() == "selected_down" then
            lastCategory = camCategory;
        end
    end  
    for j, _ in pairs(camTable) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", j);
        camCategory:SimulateLClick();
        local cameraStr = camCategory:Id();
        for i = 0, 5 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_camera", "option" .. i);
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_armies_camera"] = "option"..i;
            end
        end
        for i = 0, 2 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_speed", "option" .. i);
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_armies_speed"] = "option"..i;
            end
        end
        for i = 0, 5 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_camera", "option" .. i);
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_heroes_camera"] = "option"..i;
            end
        end
        for i = 0, 2 do
            local option = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_speed", "option" .. i);
            if option:CurrentState() == "selected_hover" or option:CurrentState() == "selected" or option:CurrentState() == "selected_down" then
                camTable[cameraStr]["dropdown_heroes_speed"] = "option"..i;
            end
        end
    end
    cm:callback(
        function()
            lastCategory:SimulateLClick();
        end, 0, "waitForUI"
    );
end

--v function(Table: map<string, map<string, string>>)
function applySettingsFromTable(Table)
    local lastCategory;
    for i, _ in pairs(Table) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", i);
        if camCategory:CurrentState() == "selected" or camCategory:CurrentState() == "selected_hover" or camCategory:CurrentState() == "selected_down" then
            lastCategory = camCategory;
        end
    end
    for j, optionTable in pairs(Table) do
        local camCategory = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", j);
        camCategory:SimulateLClick();
        armiesCameraOptionStr = optionTable["dropdown_armies_camera"];
        local armiesCameraOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_camera", armiesCameraOptionStr);
        armiesCameraOption:SimulateLClick();
        armiesSpeedOptionStr = optionTable["dropdown_armies_speed"];
        local armiesSpeedOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "armies", "dropdown_armies_speed", armiesSpeedOptionStr);
        armiesSpeedOption:SimulateLClick();
        heroesCameraOptionStr = optionTable["dropdown_heroes_camera"];
        local heroesCameraOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_camera", heroesCameraOptionStr);
        heroesCameraOption:SimulateLClick();
        heroesSpeedOptionStr = optionTable["dropdown_heroes_speed"];
        local heroesSpeedOption = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "dropdowns_list", "heroes", "dropdown_heroes_speed", heroesSpeedOptionStr);
        heroesSpeedOption:SimulateLClick();
    end
    cm:callback(
        function()
            if lastCategory then lastCategory:SimulateLClick(); end
        end, 0, "waitForUI"
    );
end

--v function()
function createUI()
    if not loadButton then
        loadButton = Button.new("loadButton", find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder"), "CIRCULAR", loadIconPath);
        local closeButton = find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder", "button_close");
        loadButton:Resize(closeButton:Width(), closeButton:Height());
        loadButton:PositionRelativeTo(closeButton, 0, closeButton:Height() + 25);
        loadButton:SetState("hover");
        loadButton.uic:SetTooltipText("Load user camera settings");
        loadButton:SetState("active");	
        loadButton:RegisterForClick(
            function(context)
                local camTable, err = table.load("cameraPreferences.txt");
                if not err then
                    applySettingsFromTable(camTable);
                else
                    applySettingsFromTable(camTableReset);
                end
            end 
        )	
    end
    if not saveButton then
        saveButton = Button.new("saveButton", find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder"), "CIRCULAR", saveIconPath);
        local closeButton = find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder", "button_close");
        saveButton:Resize(closeButton:Width(), closeButton:Height());
        saveButton:PositionRelativeTo(loadButton, - closeButton:Width() - 1, 0);
        saveButton:SetState("hover");
        saveButton.uic:SetTooltipText("Save user camera settings as default");
        saveButton:SetState("active");	
        saveButton:RegisterForClick(
            function(context)
                saveSettingsToTable();
                table.save(camTable, "cameraPreferences.txt");
            end 
        )	
    end
    if not resetButton then
        resetButton = Button.new("resetButton", find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder"), "CIRCULAR", resetIconPath);
        local closeButton = find_uicomponent(core:get_ui_root(), "camera_settings", "button_holder", "button_close");
        resetButton:Resize(closeButton:Width(), closeButton:Height());
        resetButton:PositionRelativeTo(saveButton, - closeButton:Width() - 1, 0);
        resetButton:SetState("hover");
        resetButton.uic:SetTooltipText("Reset camera settings to CA default");
        resetButton:SetState("active");	
        resetButton:RegisterForClick(
            function(context)
                applySettingsFromTable(camTableReset);
            end 
        )		
    end
end

--v function()
function deleteUI()
	if resetButton then
		resetButton:Delete();
        resetButton = nil;
    end
    if saveButton then
		saveButton:Delete();
		saveButton = nil;
    end
    if loadButton then
		loadButton:Delete();
		loadButton = nil;
    end
end

if cm:is_new_game() then
    local loadTable, err = table.load("cameraPreferences.txt");
    if not err then
        applySettingsFromTable(loadTable);
        deleteUI();
    end
end

core:add_listener(
    "applyLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "apply_current_faction" or context.string == "apply_player" or context.string == "apply_allies" or context.string == "apply_enemies" or context.string == "apply_neutrals";
    end,
    function(context)
        if context.string == "apply_current_faction" then
            deleteUI();
        else
            createUI();
        end
    end,
    true
)

core:add_listener(
    "SettingsLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "button_settings" or context.string == "button_pause";
    end,
    function(context)
        cm:callback(
            function()
                local apply_current_faction = find_uicomponent(core:get_ui_root(), "layout", "settings_panel", "camera_settings", "buttons_list", "apply_current_faction");
                if apply_current_faction:CurrentState() ~= "selected" and apply_current_faction:CurrentState() ~= "selected_hover" and apply_current_faction:CurrentState() ~= "selected_down" then
                    deleteUI();
                    createUI();
                else
                    deleteUI();
                end
            end, 0, "waitForUI"
        );
    end,
    true
)