--# assume mct: MCT
local loc_prefix = "mct_frosty_confeds_"
local frosty_confeds = mct:register_mod("frosty_confeds")
frosty_confeds:set_title(loc_prefix.."mod_title", true) --"Higher Starting Tier: Capitals & Hordes"
frosty_confeds:set_author("FrostyDemise & sm0kin")
frosty_confeds:set_description(loc_prefix.."mod_desc", true) --"With this mod your starting settlements/horde can be set at a higher tier from the get-go."

local _01_enableorDisable = frosty_confeds:add_new_option("_01_enableorDisable", "checkbox")
_01_enableorDisable:set_default_value(true)
_01_enableorDisable:set_text(loc_prefix.."_01_enableorDisable_txt", true) --"Mod Enable"
_01_enableorDisable:set_tooltip_text(loc_prefix.."_01_enableorDisable_tt", true) --"Enables or disables the mod."

frosty_confeds:add_new_section("advanced_options", loc_prefix.."section_advanced_options", true) 

local zzz03_tHeatre = frosty_confeds:add_new_option("zzz03_tHeatre", "checkbox")
zzz03_tHeatre:set_default_value(false)
zzz03_tHeatre:set_text(loc_prefix.."zzz03_tHeatre_txt", true) 
zzz03_tHeatre:set_tooltip_text(loc_prefix.."zzz03_tHeatre_tt", true) 

local zzz04_deadlyAlliances = frosty_confeds:add_new_option("zzz04_deadlyAlliances", "dropdown")
zzz04_deadlyAlliances:set_text(loc_prefix.."zzz04_deadlyAlliances_txt", true)
zzz04_deadlyAlliances:set_tooltip_text(loc_prefix.."zzz04_deadlyAlliances_tt", true)
--zzz04_deadlyAlliances:add_dropdown_value("d3_deadly_Disable", loc_prefix.."zzz04_deadlyAlliances_d3_deadly_Disable_txt", loc_prefix.."zzz04_deadlyAlliances_d3_deadly_Disable_tt", true)
--zzz04_deadlyAlliances:add_dropdown_value("d1_deadly_Enable", loc_prefix.."zzz04_deadlyAlliances_d1_deadly_Enable_txt", loc_prefix.."zzz04_deadlyAlliances_d1_deadly_Enable_tt")
--zzz04_deadlyAlliances:add_dropdown_value("d2_deadly_Enable_worldwar", loc_prefix.."zzz04_deadlyAlliances_d2_deadly_Enable_worldwar_txt", loc_prefix.."zzz04_deadlyAlliances_d2_deadly_Enable_worldwar_tt")
zzz04_deadlyAlliances:add_dropdown_value("d3_deadly_Disable", "Off (Normal)", "", true)
zzz04_deadlyAlliances:add_dropdown_value("d1_deadly_Enable", "On (Main Factions)", "*Takes a few seconds to load!* The AI-controlled Legendary Lord factions confederates to form super-factions.")
zzz04_deadlyAlliances:add_dropdown_value("d2_deadly_Enable_worldwar", "On (World War)", "*Takes a few seconds to load!* ALL AI-controlled factions, major or minor, confederates to form super-super-factions.")

--TOMB KINGS LORE RESTRICTION
if vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") then
    local zzz05_restriction = frosty_confeds:add_new_option("zzz05_restriction", "checkbox")
    zzz05_restriction:set_default_value(true)
    zzz05_restriction:set_text(loc_prefix.."zzz05_restriction_txt", true) 
    zzz05_restriction:set_tooltip_text(loc_prefix.."zzz05_restriction_tt", true) 
end

_01_enableorDisable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting()
        local options = option:get_mod():get_options()

        for option_key, option_obj in pairs(options) do
            if option_key ~= "_01_enableorDisable" then option_obj:set_uic_visibility(val) end
        end
    end
)