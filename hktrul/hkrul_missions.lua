

local function hkrul_spawn_hendrik(faction_key, agent_subtype)
  local agent_interface = cm:model():world():faction_by_key(faction_key)
  local agent_faction_cqi = agent_interface:command_queue_index()       
  cm:spawn_unique_agent(agent_faction_cqi,agent_subtype,true)
end

local function hkrul_mar_setup_missions(faction_key)
  local scmm = mission_manager:new(faction_key, "hkrul_mar_hendrik1")
  scmm:add_new_objective("HAVE_AT_LEAST_X_MONEY");
  scmm:add_condition("total 10000");
  scmm:add_payload("money 2500");
  scmm:add_payload("grant_agent{location wh3_main_combi_region_marienburg;agent_key dignitary;agent_subtype_key hkrul_hendrik;ap_factor 100;}")
  scmm:trigger()   
end

-- starting the scripted missions
cm:add_first_tick_callback_new(
function()
  if cm:get_saved_value("hkrul_hendrik_spawned") == nil then
    local jaan_interface = cm:model():world():faction_by_key("wh_main_emp_marienburg")

    if jaan_interface:is_human() == true then
          hkrul_mar_setup_missions("wh_main_emp_marienburg")        
    else -- for the AI
          hkrul_spawn_hendrik("wh_main_emp_marienburg", "hkrul_hendrik")
    end

cm:set_saved_value("hkrul_hendrik_spawned", true);
  end
end
)

core:add_listener(
"HendrikRename",
"CharacterCreated",
function(context)
  return context:character():character_subtype("hkrul_hendrik");
end,
function(context)
      local character = context:character()
      cm:change_character_custom_name(character, "Simon", "Goudenkruin", "", "")
end,
true
);

local function hkrul_mar_setup_follower_1_mission(faction_key)
local scmm = mission_manager:new(faction_key, "hkrul_mar_jk_follower_1")
scmm:add_new_objective("MOVE_TO_REGION");
scmm:add_condition("region wh3_main_combi_region_sjoktraken");
scmm:add_payload("add_ancillary_to_faction_pool{ancillary_key hkrul_mar_nijmenk;}");
scmm:add_payload("money 750");
scmm:trigger()
end

-- starting the scripted missions
cm:add_first_tick_callback_new(
function()
  if cm:get_saved_value("hkrul_follower1_granted") == nil then
    local jaan_interface = cm:model():world():faction_by_key("wh_main_emp_marienburg")

    if jaan_interface:is_human() == true then
      hkrul_mar_setup_follower_1_mission("wh_main_emp_marienburg")
    else -- for the AI
      cm:add_ancillary_to_faction("wh_main_emp_marienburg", "hkrul_mar_fooger", false)
    end

    cm:set_saved_value("hkrul_follower1_granted", true);
  end
end
)


local function hkrul_mar_setup_follower_2_mission(faction_key)
local scmm = mission_manager:new(faction_key, "hkrul_mar_jk_follower_2")
scmm:add_new_objective("MOVE_TO_REGION");
scmm:add_condition("region wh3_main_combi_region_magritta");
scmm:add_payload("add_ancillary_to_faction_pool{ancillary_key hkrul_mar_roelef;}");
scmm:add_payload("money 1000");
scmm:trigger()
end

-- starting the scripted missions
cm:add_first_tick_callback_new(
function()
  if cm:get_saved_value("hkrul_follower2_granted") == nil then
    local jaan_interface = cm:model():world():faction_by_key("wh_main_emp_marienburg")

    if jaan_interface:is_human() == true then
      hkrul_mar_setup_follower_2_mission("wh_main_emp_marienburg")
    else -- for the AI
      cm:add_ancillary_to_faction("wh_main_emp_marienburg", "hkrul_mar_roelef", false)
    end

    cm:set_saved_value("hkrul_follower2_granted", true);
  end
end
)

local function hkrul_mar_setup_follower_3_mission(faction_key)
local scmm = mission_manager:new(faction_key, "hkrul_mar_jk_follower_3")
scmm:add_new_objective("HAVE_RESOURCES");
scmm:add_condition("resource res_rom_iron");
scmm:add_payload("add_ancillary_to_faction_pool{ancillary_key hkrul_mar_fooger;}");
scmm:add_payload("money 500");
scmm:trigger()
end

-- starting the scripted missions
cm:add_first_tick_callback_new(
function()
  if cm:get_saved_value("hkrul_follower3_granted") == nil then
    local jaan_interface = cm:model():world():faction_by_key("wh_main_emp_marienburg")

    if jaan_interface:is_human() == true then
      hkrul_mar_setup_follower_3_mission("wh_main_emp_marienburg")
    else -- for the AI
      cm:add_ancillary_to_faction("wh_main_emp_marienburg", "hkrul_mar_fooger", false)
    end

    cm:set_saved_value("hkrul_follower3_granted", true);
  end
end
)

local function hkrul_mar_setup_follower_4_mission(faction_key)
local scmm = mission_manager:new(faction_key, "hkrul_mar_jk_follower_4")
scmm:add_new_objective("MAKE_TRADE_AGREEMENT");
scmm:add_condition("faction wh2_main_hef_eataine");
scmm:add_payload("add_ancillary_to_faction_pool{ancillary_key hkrul_mar_rothemuur;}");
scmm:add_payload("money 800");
scmm:trigger()
end

-- starting the scripted missions
cm:add_first_tick_callback_new(
function()
  if cm:get_saved_value("hkrul_follower4_granted") == nil then
    local jaan_interface = cm:model():world():faction_by_key("wh_main_emp_marienburg")

    if jaan_interface:is_human() == true then
      hkrul_mar_setup_follower_4_mission("wh_main_emp_marienburg")
    else -- for the AI
      cm:add_ancillary_to_faction("wh_main_emp_marienburg", "hkrul_mar_rothemuur", false)
    end

    cm:set_saved_value("hkrul_follower4_granted", true);
  end
end
)

local function hkrul_mar_setup_follower_5_mission(faction_key)
local scmm = mission_manager:new(faction_key, "hkrul_mar_jk_follower_5")
scmm:add_new_objective("KILL_X_ENTITIES");
scmm:add_condition("total 3000")
scmm:add_payload("add_ancillary_to_faction_pool{ancillary_key hkrul_mar_scheldt;}");
scmm:add_payload("money 500");
scmm:trigger()
end

-- starting the scripted missions
cm:add_first_tick_callback_new(
function()
  if cm:get_saved_value("hkrul_follower5_granted") == nil then
    local jaan_interface = cm:model():world():faction_by_key("wh_main_emp_marienburg")

    if jaan_interface:is_human() == true then
      hkrul_mar_setup_follower_5_mission("wh_main_emp_marienburg")
    else -- for the AI
      cm:add_ancillary_to_faction("wh_main_emp_marienburg", "hkrul_mar_scheldt", false)
    end

    cm:set_saved_value("hkrul_follower5_granted", true);
  end
end
)

cm:add_first_tick_callback(function() 
if not cm:get_saved_value("hkrul_follower_set_done") then
  core:add_listener(
    "hkrul_follower_set_CharacterAncillaryGained",
    "CharacterAncillaryGained",
    function(context)
      out("CharacterAncillaryGained works")
      local character = context:character()
      local ancillary = context:ancillary()
      return character:character_subtype("hkrul_hendrik")
      and (ancillary == "hkrul_mar_fooger" or ancillary == "hkrul_mar_nijmenk" or ancillary == "hkrul_mar_scheldt" 
      or ancillary == "hkrul_mar_stadsraad" or ancillary == "hkrul_mar_rothemuur" or ancillary == "hkrul_mar_roelef" or ancillary == "wh2_dlc13_anc_talisman_stadsraad_key")
      and character:has_ancillary("hkrul_mar_fooger") and character:has_ancillary("hkrul_mar_nijmenk") and character:has_ancillary("hkrul_mar_scheldt")
      and character:has_ancillary("hkrul_mar_stadsraad") and character:has_ancillary("hkrul_mar_rothemuur") and character:has_ancillary("hkrul_mar_roelef") 
      and character:has_ancillary("wh2_dlc13_anc_talisman_stadsraad_key")
    end,
    function(context)
      out("hkrul_follower_set_CharacterAncillaryGained conditions work")
      cm:set_saved_value("hkrul_follower_set_done", true)
      cm:show_message_event(
        context:character():faction():name(),
        "event_feed_strings_text_title_event_hkrul_mar_set_completed",
        "event_feed_strings_text_title_event_hkrul_mar_set_completed",
        "event_feed_strings_text_description_event_hkrul_mar_set_completed",
        true,
        1 --event picture index: change to correct marienburg index
    )
    end,
    false
  )
end
end)