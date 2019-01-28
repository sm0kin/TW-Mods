local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local ColouredTextButton = {} --# assume ColouredTextButton: COLOURED_TEXT_BUTTON

local States = {
    "active", "hover", "down", 
    "selected", "selected_hover", "selected_down",
    "drop_down"
} --: vector<BUTTON_STATE>

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, path: string, buttonText: string) --> COLOURED_TEXT_BUTTON
function ColouredTextButton.new(name, parent, path, buttonText)
    local parentComponent = Components.getUiContentComponent(parent);    
    local colouredTextButton = nil --: CA_UIC
    local textButtonText = nil --: CA_UIC
    if string.find(path,"square_large_text_button") then
        colouredTextButton = Util.createComponent(name, parentComponent, path);
        textButtonText = UIComponent(colouredTextButton:Find("button_txt"));
    else
        Log.write("Invalid text button template:" .. path);
    end

    textButtonText:SetStateText(buttonText);

    local self = {};
    setmetatable(self, {__index = ColouredTextButton});
    --# assume self: COLOURED_TEXT_BUTTON
    self.uic = colouredTextButton --: const
    self.name = name --: const
    self.path = path --: const
    self.textButtonText = textButtonText --: const
    self.listeners = {} --: vector<string>
    self.disabled = false;
    Util.registerComponent(name, self); 
    return self;
end

-- Component functions

--v function(self: COLOURED_TEXT_BUTTON, xPos: number, yPos: number)
function ColouredTextButton.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: COLOURED_TEXT_BUTTON, xMove: number, yMove: number)
function ColouredTextButton.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: COLOURED_TEXT_BUTTON, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function ColouredTextButton.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: COLOURED_TEXT_BUTTON, factor: number)
function ColouredTextButton.Scale(self, factor)
    local width, height = self.uic:Bounds();
    self.uic:ResizeTextResizingComponentToInitialSize(width * factor, height * factor); 
end

--v function(self: COLOURED_TEXT_BUTTON, width: number, height: number)
function ColouredTextButton.Resize(self, width, height)
    self.uic:ResizeTextResizingComponentToInitialSize(width, height); 
end

--v function(self: COLOURED_TEXT_BUTTON) --> (number, number)
function ColouredTextButton.Position(self)
    return self.uic:Position();
end

--v function(self: COLOURED_TEXT_BUTTON) --> (number, number)
function ColouredTextButton.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: COLOURED_TEXT_BUTTON) --> number
function ColouredTextButton.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: COLOURED_TEXT_BUTTON) --> number
function ColouredTextButton.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: COLOURED_TEXT_BUTTON) --> number
function ColouredTextButton.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: COLOURED_TEXT_BUTTON) --> number
function ColouredTextButton.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: COLOURED_TEXT_BUTTON, visible: boolean)
function ColouredTextButton.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: COLOURED_TEXT_BUTTON) --> boolean
function ColouredTextButton.Visible(self)
    return self.uic:Visible();
end

--v function(self: COLOURED_TEXT_BUTTON) --> CA_UIC
function ColouredTextButton.GetContentComponent(self)
    return self.uic;
end

--v function(self: COLOURED_TEXT_BUTTON) --> CA_UIC
function ColouredTextButton.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: COLOURED_TEXT_BUTTON)
function ColouredTextButton.Delete(self) 
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
    for i, listener in ipairs(self.listeners) do
        core:remove_listener(listener);
    end
end

-- Custom functions

--v function(self: COLOURED_TEXT_BUTTON)
function ColouredTextButton.ClearSound(self)
    self.uic:ClearSound();
end

--v function(self: COLOURED_TEXT_BUTTON, state: BUTTON_STATE)
function ColouredTextButton.SetState(self, state) 
    self.uic:SetState(state);
end

--v function(self: COLOURED_TEXT_BUTTON) --> BUTTON_STATE
function ColouredTextButton.CurrentState(self)
    return self.uic:CurrentState();
end

--v function(self: COLOURED_TEXT_BUTTON) --> boolean
function ColouredTextButton.IsSelected(self)
    local state = self.uic:CurrentState();
    if state == "active" or state == "hover" or state == "down" then
        return false;
    else
        return true;
    end
end

--v function(button: COLOURED_TEXT_BUTTON) --> string
local function calculateButtonListenerName(button)
    return button.name .. "ClickListener" .. #button.listeners;
end

--v function(self: COLOURED_TEXT_BUTTON, callback: function(context: CA_UIContext), listenerName: string?)
function ColouredTextButton.RegisterForClick(self, callback, listenerName)
    local registerListenerName = nil --: string
    if not listenerName then
        registerListenerName = calculateButtonListenerName(self);
    else
        registerListenerName = listenerName;
    end
    Util.registerForClick(self.uic, registerListenerName, callback);
    table.insert(self.listeners, registerListenerName);
end

--v function(self: COLOURED_TEXT_BUTTON, text: string)
function ColouredTextButton.SetButtonText(self, text)
    self.textButtonText:SetStateText(text);
end

--v function(self: COLOURED_TEXT_BUTTON, disabled: boolean)
function ColouredTextButton.SetDisabled(self, disabled)
    if not(disabled == self.disabled) then
        if disabled then
            self:SetState("active");
        end
        Components.disableComponent(self.uic, disabled);
        self.disabled = disabled;
    end
end