--# assume mct: MCT
local loc_prefix = "mct_execute_"
local execute = mct:register_mod("execute")
execute:set_title(loc_prefix.."mod_title", true)
execute:set_author("sm0kin")
execute:set_description(loc_prefix.."mod_desc", true)

local enable = execute:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

local blacklist = execute:add_new_option("b_blacklisted", "checkbox")
blacklist:set_default_value(false)
blacklist:set_text(loc_prefix.."b_blacklisted_txt", true)
blacklist:set_tooltip_text(loc_prefix.."b_blacklisted_tt", true)