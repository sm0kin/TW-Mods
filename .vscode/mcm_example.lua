--EXAMPLE CODE SERVED THREE WAYS

--METHOD 1: Using a general callback
-- I have something that has a default, which should happen without MCM,
-- but want to allow MCM to change it without writing too much duplicate code

--get MCM
local mcm = _G.mcm
--set some default values: these will help you avoid writing script twice!
cm:set_saved_value("mcm_tweaker_mymod_mysetting_value", "default_value")
--if MCM is installed, register our mod!
if not not mcm then
    local mymod = mcm:register_mod("mymod", "My MCM mod!", "An example mod")
    local mysetting = mymod:add_tweaker("mysetting", "My MCM Setting", "An example setting!")
    mysetting:add_option("default_value", "My default option", "The one they don't have to click")
    mysetting:add_option("other_value", "My other option", "An option they do have to click")
end
--define what we want to happen on game start.
local my_callback = function()
    local value = cm:get_saved_value("mcm_tweaker_mymod_mysetting_value")
    if value == "default_value" then
        --do something
    elseif value == "other_value" then
        --do something else
    end
end
--if we don't have MCM, just throw it on a CA event, since we set a default value, this code will work without MCM active!
if not mcm then 
    cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = my_callback
else --if we do have MCM, add our callback!
    mcm:add_new_game_only_callback(my_callback)
    --if you want this to happen every time the game launches, and not just when it starts the first time, then change this command to
    -- mcm:add_post_process_callback(my_callback)
end

--METHOD 2: Using a listener for a single setting
-- I have something which is an optional feature, so it only happens when MCM is enabled and a setting is picked.

--get MCM
local mcm = _G.mcm
--if MCM is installed, register our mod!
if not not mcm then
    local mymod = mcm:register_mod("mymod", "My MCM mod!", "An example mod")
    local mysetting = mymod:add_tweaker("myfeatureoption", "My Optional Feature", "An example setting!")
    mysetting:add_option("optional_feature_disabled", "Disable Optional Feature", "The one they don't have to click")
    mysetting:add_option("optional_feature_enabled", "Enable Optional Feature", "An option they do have to click")
end
--add a listener for the mod setting being processed
core:add_listener(
    "MyListener",
    "mcm_tweaker_mymod_myfeatureoption_event",
    function(context)
        return context.string == "optional_feature_enabled"
    end,
    function(context)
        --code to enable my feature
    end,
    false)
    --if you want this to happen only the first time the game launches, wrap this in a save value check.

--this code is 100% safe because without MCM, the listener will just do nothing!