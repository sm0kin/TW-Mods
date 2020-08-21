--# assume mct: MCT
local loc_prefix = "mct_frosty_tiers_"
local frosty_tiers = mct:register_mod("frosty_tiers")
frosty_tiers:set_title(loc_prefix.."mod_title", true) --"Higher Starting Tier: Capitals & Hordes"
frosty_tiers:set_author("FrostyDemise & sm0kin")
frosty_tiers:set_description(loc_prefix.."mod_desc", true) --"With this mod your starting settlements/horde can be set at a higher tier from the get-go."

local default_section = frosty_tiers:get_section_by_key("default")
default_section:set_localised_text(loc_prefix.."section_mod_status_options", true)

local _01_enableorDisable = frosty_tiers:add_new_option("_01_enableorDisable", "checkbox")
_01_enableorDisable:set_default_value(true)
_01_enableorDisable:set_text(loc_prefix.."_01_enableorDisable_txt", true) --"Mod Enable"
_01_enableorDisable:set_tooltip_text(loc_prefix.."_01_enableorDisable_tt", true) --"Enables or disables the mod."

local options_list = {
    {
        key = "_02_settlementTier",
        text = loc_prefix.."_02_settlementTier_txt", --"Capital Tier (Players)"
        tt = loc_prefix.."_02_settlementTier_tt" --"Set the Settlement Starting Tier. Keep in mind that a few of the playable factions (e.g. Skarsnik) start with just a minor settlement and these are set at their max tier of III instead."
    },
    {
        key = "_03_AI_settlementTier",
        text = loc_prefix.."_03_AI_settlementTier_txt", --"Capital Tier (Main Factions)"
        tt = loc_prefix.."_03_AI_settlementTier_tt" --"Set the Settlement Starting Tier of the different main factions. Also includes a few select cities with high est. populations in the lore such as Nuln, Itza, Kislev, Miragliano, etc."
    },
    {
        key = "_04_hordeTier",
        text = loc_prefix.."_04_hordeTier_txt", --"Horde Tier (Players)"
        tt = loc_prefix.."_04_hordeTier_tt" --"Set the Horde Starting Tier (only relevant if you are playing as a horde)."
    },   
    {
        key = "_05_settlementScope",
        text = loc_prefix.."_05_settlementScope_txt", --"Include Other City Types? (not recommended)"
        tt = loc_prefix.."_05_settlementScope_tt" --"This means not just the main capitals but the capitals of every province is upgraded. For the Hardcore who want every province to be a challenge."
    }
}

local dropdown_options = {
    {
        key = "6",
        text = "No Changes",
        tt = ""
    },
    {
        key = "2",
        text = "Tier II",
        tt = ""
    },
    {
        key = "3", 
        text = "Tier III",
        tt = ""
    }, 
    {
        key = "4",
        text = "Tier IV",
        tt = "",
        default = true
    },
    {
        key = "5",
        text = "Tier V",
        tt = ""
    }
}

frosty_tiers:add_new_section("z_01_settlement_options", loc_prefix.."section_settlement_options", true) 

_01_enableorDisable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting()
        local options = options_list

        for i = 1, #options do
            local i_option_key = options[i].key
            local i_option = option:get_mod():get_option_by_key(i_option_key)
            i_option:set_uic_visibility(val)
            i_option:set_read_only(false)
        end
    end
)

for i = 1, #options_list do
    local option_key = options_list[i].key
    local option_obj = frosty_tiers:add_new_option(option_key, "dropdown")
    local text = options_list[i].text
    local tooltip = options_list[i].tt

    -- set the text for the option, displays on the left of the dropdown
    option_obj:set_text(text, true)
    option_obj:set_tooltip_text(tooltip, true)
    option_obj:set_uic_visibility(true)

    -- add the above table as dropdown values
    if option_key ~= "_05_settlementScope" then
        option_obj:add_dropdown_values(dropdown_options)
    else
        option_obj:add_dropdown_value("e1_faction_capitals", "No", "Include Other City Types? (not recommended)", "This means not just the main capitals but the capitals of every province is upgraded. For the Hardcore who want every province to be a challenge.")
        option_obj:add_dropdown_value("e2_provinces_too", "Province Capitals", "Only main faction capitals are affected")
        option_obj:add_dropdown_value("e3_any_settlement", "Any Settlements", "All settlement main buildings start at a higher tier.")
        option_obj:set_default_value("e1_faction_capitals")
    end
end

frosty_tiers:add_new_section("z_02_horde_options", loc_prefix.."section_horde_options", true) --"Horde - Options"
local horde_option = frosty_tiers:get_option_by_key("_04_hordeTier")
horde_option:set_assigned_section("z_02_horde_options")