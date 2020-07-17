local loc_prefix = "mct_chaos_gates_"
local chaos_gates = mct:register_mod("chaos_gates")
chaos_gates:set_title(loc_prefix.."mod_title", true)
chaos_gates:set_author("Drunk Flamingo")
chaos_gates:set_description(loc_prefix.."mod_desc", true)

local beastmen = chaos_gates:add_new_option("a_beastmen", "checkbox")
beastmen:set_default_value(false)
beastmen:set_text(loc_prefix.."a_beastmen_txt", true)
beastmen:set_tooltip_text(loc_prefix.."a_beastmen_tt", true)

local norscaruins = chaos_gates:add_new_option("b_norscaruins", "checkbox")
norscaruins:set_default_value(false)
norscaruins:set_text(loc_prefix.."b_norscaruins_txt", true)
norscaruins:set_tooltip_text(loc_prefix.."b_norscaruins_tt", true)

local spawn_rate = chaos_gates:add_new_option("c_spawn_rate", "slider")
spawn_rate:set_text(loc_prefix.."c_spawn_rate_txt", true)
spawn_rate:set_tooltip_text(loc_prefix.."c_spawn_rate_tt", true)
spawn_rate:slider_set_min_max(2, 90)
spawn_rate:set_default_value(10)
spawn_rate:slider_set_step_size(4)

local max_army_size = chaos_gates:add_new_option("d_max_army_size", "slider")
max_army_size:set_text(loc_prefix.."d_max_army_size_txt", true)
max_army_size:set_tooltip_text(loc_prefix.."d_max_army_size_tt", true)
max_army_size:slider_set_min_max(5, 20)
max_army_size:set_default_value(14)
max_army_size:slider_set_step_size(1)