--# assume math.clamp: function(number, number, number)
--# type global CA_CQI = number | int

-- CLASS DECLARATION
--# assume global class CM
--# assume global class CUIM
--# assume global class CUIM_OVERRIDE
--# assume global class CA_CampaignUI
--# assume global class CA_UIC
--# assume global class CA_Component
--# assume global class CA_UIContext
--# assume global class CA_CHAR_CONTEXT
--# assume global class CA_SETTLEMENT_CONTEXT
--# assume global class CA_BUILDING_CONTEXT
----# assume global class CA_CQI
--# assume global class CA_CHAR
--# assume global class CA_CHAR_LIST
--# assume global class CA_MILITARY_FORCE
--# assume global class CA_MILITARY_FORCE_LIST
--# assume global class CA_REGION
--# assume global class CA_REGION_LIST
--# assume global class CA_REGION_MANAGER
--# assume global class CA_SEA_REGION
--# assume global class CA_SEA_REGION_LIST
--# assume global class CA_SEA_MANAGER
--# assume global class CA_REGDATA
--# assume global class CA_REGDATA_LIST
--# assume global class CA_SETTLEMENT
--# assume global class CA_GARRISON_RESIDENCE
--# assume global class CA_SLOT_LIST
--# assume global class CA_SLOT
--# assume global class CA_FOREIGN_SLOT
--# assume global class CA_FOREIGN_SLOT_LIST
--# assume global class CA_BUILDING
--# assume global class CA_FACTION
--# assume global class CA_FACTION_LIST
--# assume global class CA_GAME
--# assume global class CA_MODEL
--# assume global class CA_WORLD
--# assume global class CA_EFFECT
--# assume global class CA_PENDING_BATTLE
--# assume global class CA_UNIT
--# assume global class CA_UNIT_LIST
--# assume global class CA_POOLED
--# assume global class CA_POOLED_LIST
--# assume global class CA_FACTION_RITUALS
--# assume global class CA_RITUAL
--# assume global class CA_RITUAL_LIST
--# assume global class CA_VFS
--# assume global class CA_CUSTOM_EFFECT_BUNDLE
--# assume global class CA_POOLED_FACTOR
--# assume global class CA_POOLED_FACTOR_LIST
--# assume global class CA_TIMER_MANAGER
--# assume global class CA_CHAPTER_MISSION
--# assume global class CA_INTERVENTION
--# assume global class CA_BATTLE_MANAGER
--# assume global class EMPIRE_BATTLE
--# assume global class CA_GENERATED_ARMY
--# assume global class CA_GENERATED_BATTLE
--# assume global class CA_GENERATED_CUTSCENE
--# assume global class CA_CAMERA
--# assume global class IM
--# assume global class CORE
--# assume global class _G
--# assume global class CA_SCRIPT_MESSAGER
--# assume global class CAM_VECTOR
--# assume global class VECTOR
--# assume global class CA_UNIT_PURCHASABLE_EFFECT
--# assume global class CA_EVENTS

-- TYPES
--# type global CA_EventName = 
--# "CharacterCreated"      | "ComponentLClickUp"     | "ComponentMouseOn"    |
--# "PanelClosedCampaign"   | "PanelOpenedCampaign" |
--# "TimeTrigger"           | "UICreated"

--# type global BUTTON_STATE = 
--# "active" | "hover" | "down" | 
--# "selected" | "selected_hover" | "selected_down" |
--# "drop_down" | "inactive" |
--# "custom_state_1" | "custom_state_2" | "custom_state_3" |
--# "custom_state_4" | "custom_state_5"


--# type global BATTLE_SIDE =
--# "Attacker" | "Defender" 

--# type global CA_MARKER_TYPE = 
--# "pointer" | "move_to_vfx" | "look_at_vfx" | "tutorial_marker"

--# type global BATTLE_TYPE = "ambush" | "campaign_battle" | "capture_point" | "classic" | "coastal_battle" | "free_for_all" | "historic" | "limes" | "napoleon_historic" | "naval" | "naval_siege" | "river_crossing_battle" |
--# "siege" | "Tutorial" | "underground_intercept" | "unfortified_port" | "unfortified_settlement" |
--# "land_ambush" | "land_bridge" | "land_normal" | "naval_blockade" | "naval_breakout" | "naval_normal" | "port_assault" | "settlement_relief" | "settlement_sally" | "settlement_standard" | "settlement_unfortified"

-- BATTLE
--# assume CA_BATTLE_MANAGER.modify_battle_speed: method(gamespeed: number)

-- CAMERA
--# assume CA_CAMERA.fade: method(UNKNOWN: bool, duration: number|int)
--# assume CA_CAMERA.move_to: method(v1: VECTOR, v2: VECTOR, UNKNOWN: number, UNKNOWN1: boolean, UNKNOWN2: number)

-- BATTLE_MANAGER
--# assume CA_BATTLE_MANAGER.new: method(EMPIRE_BATTLE) --> CA_BATTLE_MANAGER
--# assume EMPIRE_BATTLE.new: method() --> EMPIRE_BATTLE

--# assume CA_BATTLE_MANAGER.camera: method() --> CA_CAMERA
--# assume CA_BATTLE_MANAGER.register_phase_change_callback: method(phase: string, callback: function())
--# assume CA_BATTLE_MANAGER.callback: method(callback: function(), time_delay: number | int, key: string?)
--# assume CA_BATTLE_MANAGER.repeat_callback: method(callback: function(), time_delay: number | int, key: string?)
--# assume CA_BATTLE_MANAGER.cache_camera: method()

--# assume CA_BATTLE_MANAGER.get_cached_camera_pos: method() --> CAM_VECTOR
--# assume CA_BATTLE_MANAGER.get_cached_camera_targ: method() --> CAM_VECTOR

--# assume CAM_VECTOR.get_x: method() --> number|int
--# assume CAM_VECTOR.get_y: method() --> number|int
--# assume CAM_VECTOR.get_z: method() --> number|int

-- SCRIPT MESSAGER
--# assume CA_SCRIPT_MESSAGER.add_listener: method(phase: string, callback: function())
--# assume CA_SCRIPT_MESSAGER.trigger_message: method(message: string)

-- GENERATED ARMY
--# assume CA_GENERATED_ARMY.message_on_rout_proportion: method(message_to_send: string, rout_proportion: number)
--# assume CA_GENERATED_ARMY.message_on_casualties: method(message_to_send: string, casualty_percent: number)

--# assume CA_GENERATED_ARMY.reinforce_on_message: method(on_message: string)
--# assume CA_GENERATED_ARMY.attack_on_message: method(on_message: string, wait_offset: number?)
--# assume CA_GENERATED_ARMY.message_on_victory: method(message: string)
--# assume CA_GENERATED_ARMY.force_victory_on_message: method(on_message: string, UNKNOWN1: number|int)
--# assume CA_GENERATED_ARMY.release_on_message: method(on_message: string)
--# assume CA_GENERATED_ARMY.teleport_to_start_location_offset_on_message: method(on_message: string, x: number|int, y: number|int)

-- GENERATED BATTLE
--# assume CA_GENERATED_BATTLE.new: method(screen_starts_black: boolean?, prevent_deployment_for_player: boolean?, prevent_deployment_for_ai: boolean?, intro_cutscene: function?, is_debug: boolean?) --> CA_GENERATED_BATTLE
--# assume CA_GENERATED_BATTLE.get_player_alliance_num: method() --> number
--# assume CA_GENERATED_BATTLE.get_non_player_alliance_num: method() --> number
--# assume CA_GENERATED_BATTLE.get_army: method(alliance_num: number, army_number: number?, script_name: string?) --> CA_GENERATED_ARMY

--# assume CA_GENERATED_BATTLE.set_objective_on_message: method(on_message: string, objective_key: string, wait_offset: number?, objective_param_1: number?, objective_param_2: number?)
--# assume CA_GENERATED_BATTLE.complete_objective_on_message: method(on_message: string, objective_key: string, wait_offset: number?)
--# assume CA_GENERATED_BATTLE.queue_help_on_message: method(on_message: string, help: string, UNKNOWN1: number|int, UNKNOWN2: number|int, UNKNOWN3: number|int)
--# assume CA_GENERATED_BATTLE.sm: CA_SCRIPT_MESSAGER

-- GENERATED CUTSCENE
--# assume CA_GENERATED_CUTSCENE.new: method(is_debug: boolean?, disable_outro_camera: boolean?, ignore_last_camera_index: boolean?) --> CA_GENERATED_CUTSCENE
--# assume CA_GENERATED_CUTSCENE.add_element: method(sfx_name: string, subtitle: string, camera: string, min_length: number, wait_for_vo: boolean, wait_for_camera: boolean, play_taunt_at_start: boolean, message_on_start: string?)

-- CONTEXT
--# assume CA_UIContext.component: CA_Component
--# assume CA_UIContext.string: string
--# assume CA_SETTLEMENT_CONTEXT.garrison_residence: method() --> CA_GARRISON_RESIDENCE
--# assume CA_CHAR_CONTEXT.character: method() --> CA_CHAR
--# assume CA_BUILDING_CONTEXT.building: method() --> CA_BUILDING
--# assume CA_BUILDING_CONTEXT.garrison_residence: method() --> CA_GARRISON_RESIDENCE

-- UIC
--# assume CA_UIC.Address: method() --> CA_Component
--# assume CA_UIC.Adopt: method(pointer: CA_Component)
--# assume CA_UIC.ChildCount: method() --> number
--# assume CA_UIC.ClearSound: method()
--# assume CA_UIC.CreateComponent: method(name: string, path: string)
--# assume CA_UIC.CurrentState: method() --> BUTTON_STATE
--# assume CA_UIC.DestroyChildren: method()
--# assume CA_UIC.Dimensions: method() --> (number, number)
--# assume CA_UIC.Find: method(arg: number | string) --> CA_Component
--# assume CA_UIC.GetTooltipText: method() --> string
--# assume CA_UIC.Id: method() --> string
--# assume CA_UIC.MoveTo: method(x: number, y: number)
--# assume CA_UIC.Parent: method() --> CA_Component
--# assume CA_UIC.Position: method() --> (number, number)
--# assume CA_UIC.Resize: method(w: number, h: number)
--# assume CA_UIC.SetInteractive: method(interactive: boolean)
--# assume CA_UIC.SetOpacity: method(opacity: number)
--# assume CA_UIC.SetState: method(state: BUTTON_STATE)
--# assume CA_UIC.SetStateText: method(text: string)
--# assume CA_UIC.SetVisible: method(visible: boolean)
--# assume CA_UIC.SetDisabled: method(disabled: boolean)
--# assume CA_UIC.SetDockingPoint: method(dock_point: number)
--# assume CA_UIC.ShaderTechniqueSet: method(technique: string | number, unknown: boolean)
--# assume CA_UIC.ShaderVarsSet: method(p1: number, p2: number, p3: number, p4: number, unknown: boolean)
--# assume CA_UIC.SimulateClick: method()
--# assume CA_UIC.SimulateMouseOn: method()
--# assume CA_UIC.SimulateMouseOff: method()
--# assume CA_UIC.SimulateMouseMove: method(x: number?, y: number?)
--# assume CA_UIC.SimulateKey: method(key_id: string)
--# assume CA_UIC.SimulateKeyDown: method(key_id: string)
--# assume CA_UIC.SimulateKeyUp: method(key_id: string)
--# assume CA_UIC.Visible: method() --> boolean
--# assume CA_UIC.RegisterTopMost: method()
--# assume CA_UIC.RemoveTopMost: method()
--# assume CA_UIC.SetImagePath: method(path: string)
--# assume CA_UIC.SetCanResizeHeight: method(state: boolean)
--# assume CA_UIC.SetCanResizeWidth: method(state: boolean)
--# assume CA_UIC.SetTooltipText: method(tooltip: string, text_source: string, state: boolean) --text_source: source of text in format of a stringtable key (tablename_recordname_key)
--# assume CA_UIC.GetStateText: method() --> string
--# assume CA_UIC.PropagatePriority: method(priority: number)
--# assume CA_UIC.Priority: method() --> number
--# assume CA_UIC.Bounds: method() --> (number, number)
--# assume CA_UIC.Height: method() --> number
--# assume CA_UIC.Width: method() --> number
--# assume CA_UIC.SetImageRotation:  method(unknown: number, rotation: number)
--# assume CA_UIC.ResizeTextResizingComponentToInitialSize: method(width: number, height: number)
--# assume CA_UIC.SimulateLClick:method(x: number?, y: number?)
--# assume CA_UIC.SimulateRClick: method(x: number?, y: number?)
--# assume CA_UIC.SimulateDblLClick: method(x: number?, y: number?)
--# assume CA_UIC.SimulateDblRClick: method(x: number?, y: number?)

--# assume CA_UIC.Divorce: method()
--# assume CA_UIC.GetImagePath: method(index_num: number?) --> string
--# assume CA_UIC.SetMoveable: method(enable: boolean)
--# assume CA_UIC.CopyComponent: method(uicomponent: string) --> string
-- CurrentStateImage
--# assume CA_UIC.GetCurrentStateImageIndex: method(state_image_index: number) --> number
--# assume CA_UIC.NumCurrentStateImages: method() --> number
--# assume CA_UIC.SetCurrentStateImageOpacity: method(state_image_index: number, opacity: number)
--# assume CA_UIC.GetCurrentStateImageOpacity: method(state_image_index: number) --> number
--# assume CA_UIC.GetCurrentStateImageWidth: method(state_image_index: number) --> number
--# assume CA_UIC.GetCurrentStateImageHeight: method(state_image_index: number) --> number
--# assume CA_UIC.GetCurrentStateImageDimensions: method(state_image_index: number) --> (number, number)
--# assume CA_UIC.ResizeCurrentStateImage: method(state_image_index: number, width: number, height: number)
--# assume CA_UIC.CanResizeCurrentStateImageWidth: method(state_image_index: number) --> boolean
--# assume CA_UIC.CanResizeCurrentStateImageHeight: method(state_image_index: number) --> boolean
--# assume CA_UIC.SetCanResizeCurrentStateImageWidth: method(state_image_index: number, can_resize: boolean)
--# assume CA_UIC.SetCanResizeCurrentStateImageHeight: method(state_image_index: number, can_resize: boolean)
-- CAMPAIGN MANAGER
--# assume CM.get_game_interface: method() --> CA_GAME
--# assume CM.model: method() --> CA_MODEL
--# assume CM.get_intervention_manager: method() --> IM
--# assume CM.is_multiplayer: method() --> boolean
--# assume CM.is_new_game: method() --> boolean
--# assume CM.get_local_faction: method(force: boolean?) --> string
--# assume CM.whose_turn_is_it: method() --> string
--# assume CM.get_human_factions: method() --> vector<string>
--# assume CM.turn_number: method() --> number
--# assume CM.is_any_cutscene_running: method() --> boolean
--# assume CM.get_campaign_name: method() --> string
--get functions
--# assume CM.get_highest_ranked_general_for_faction: method(faction_key: string) --> CA_CHAR
--# assume CM.get_character_by_cqi: method(cqi: CA_CQI) --> CA_CHAR
--# assume CM.get_region: method(regionName: string) --> CA_REGION
--# assume CM.get_faction: method(factionName: string) --> CA_FACTION
--# assume CM.get_character_by_mf_cqi: method(cqi: CA_CQI) --> CA_CHAR
--# assume CM.char_lookup_str: method(char: CA_CQI | CA_CHAR | number) --> string
--UI
--# assume CM.get_campaign_ui_manager: method() --> CUIM
--# assume CM.disable_end_turn: method(opt: boolean)
--# assume CM.disable_shortcut: method(button: string, action: string, opt: boolean)
--# assume CM.override_ui: method(override: string, opt: boolean)
--# assume CM.steal_user_input: method(opt: bool)
--Camera
--# assume CM.scroll_camera_from_current: WHATEVER
--# assume CM.get_camera_position: method() --> (number, number, number, number)
--# assume CM.fade_scene: method(unknown: number, unknown2: number)
--# assume CM.set_camera_position: method(x: number, y: number, d: number, b: number, h: number)
--callbacks
--# assume CM.first_tick_callbacks: vector<(function(context: WHATEVER?))>
--# assume CM.add_pre_first_tick_callback: method(callback: function)
--# assume CM.add_game_created_callback: method(callback: function)
--# assume CM.callback: method(
--#     callback: function(),
--#     delay: number?,
--#     name: string?
--# )
--# assume CM.add_first_tick_callback_sp_each: method(callback: function)
--# assume CM.remove_callback: method(name: string)
--# assume CM.repeat_callback: method(
--#     callback: function(),
--#     delay: number,
--#     name: string
--# )
--# assume CM.add_turn_countdown_event: method(faction_name: string, turn_offset: number, event_name: string, context_str: string?)
--# assume CM.load_global_script: method(script_name: string)
--random number
--# assume CM.random_number: method(max: number | int, min: number? | int?) --> number | int
--message events
--# assume CM.show_message_event_located: method(
--#     faction_key: string,
--#     title_loc_key: string,
--#     primary_detail_loc_key: string,
--#     secondary_detail_loc_key: string,
--#     location_x: number,
--#     location_y: number,
--#     show_immediately: boolean,
--#     event_picture_id: number,
--#     callback: (function())?,
--#     callback_delay: number?
--#)
--# assume CM.show_message_event: method(
--#    faction_key: string,
--#    title_loc_key: string,
--#    primary_detail_loc_key: string,
--#    secondary_detail_loc_key: string,
--#    show_immediately: boolean,
--#    event_picture_id: number,
--#    callback: function?,
--#    callback_delay: number?,
--#    dont_whitelist: boolean?
--#)
--traits, ancillaries & skills
--# assume CM.force_add_trait: method(lookup: string, trait_key: string, showMessage: boolean)
--# assume CM.force_add_trait_on_selected_character: method(trait_key: string)
--# assume CM.force_remove_trait: method(lookup: string, trait_key: string)
--# assume CM.zero_action_points: method(charName: string)
--# assume CM.add_agent_experience: method(charName: string, experience: number, by_level: boolean?)
--# assume CM.force_add_skill: method(lookup: string, skill_key: string)
--# assume CM.force_reset_skills: method(lookup: string)
--# assume CM.force_add_ancillary: method(character: CA_CHAR, ancillary: string, force_equip: boolean, suppress_event_feed: boolean)
--# assume CM.force_remove_ancillary: method(character: CA_CHAR, ancillary: string, remove_to_pool: boolean, suppress_event_feed: boolean)
--# assume CM.force_remove_ancillary_from_faction: method(faction: CA_FACTION, ancillary: string)
--# assume CM.add_ancillary_to_faction: method(faction: CA_FACTION, ancillary: string, suppress_event_feed: boolean)
--More character commands
--# assume CM.add_experience_to_units_commanded_by_character: method(char_lookup_str: string, level: int) --add_experience_to_units_commanded_by_character("faction:f,type:t,ability:a,surname:s,forename:f,garrison:g,x:1,y:2,r:3", level)
--# assume CM.kill_character: method(lookup: CA_CQI | string, kill_army: boolean, throughcq: boolean)
--# assume CM.kill_character_and_commanded_unit: method(lookup: CA_CQI | string, kill_army: boolean, throughcq: boolean)
--# assume CM.wound_character: method(lookup: CA_CQI | string, turns: number, throughcq: boolean)
--# assume CM.set_character_immortality: method(lookup: string, immortal: boolean)
--# assume CM.set_character_unique: method(lookup: string, unique: boolean)
--# assume CM.kill_all_armies_for_faction: method(factionName: CA_FACTION)
--# assume CM.teleport_to: method(charString: string, xPos: number, yPos: number, useCommandQueue: boolean)
--# assume CM.replenish_action_points: method(lookup: string) -- A unary AP proportion (0-1) may optionally be specified.
--# assume CM.stop_character_convalescing: method(character_cqi: CA_CQI)
--# assume CM.cancel_actions_for: method(character_lookup: string)
--# assume CM.convert_force_to_type: method(military_force: CA_MILITARY_FORCE, force_type: string)
--# assume CM.add_unit_to_province_mercenary_pool: method(
--#    province: CA_REGION, 
--#    unit_record: string, 
--#    count: number, 
--#    replenishment_chance_percentage: number, 
--#    max_units: number, 
--#    max_units_replenished_per_turn: number, 
--#    xp_level: number,
--#    faction_restricted_record: string?,
--#    subculture_restricted_record: string?,
--#    tech_restricted_record: string?
--#)
--# assume CM.add_unit_to_faction_mercenary_pool: method(
--#    faction: CA_FACTION, 
--#    unit_record: string, 
--#    count: number, 
--#    replenishment_chance_percentage: number, 
--#    max_units: number, 
--#    max_units_replenished_per_turn: number, 
--#    xp_level: number,
--#    faction_restricted_record: string?,
--#    subculture_restricted_record: string?,
--#    tech_restricted_record: string?,
--#    partial_replenishment: bool
--#)
--spawning
--# assume CM.create_force_with_general: method(
--#     faction_key: string,
--#     army_list: string,
--#     region_key: string,
--#     xPos: number,
--#     yPos: number,
--#     agent_type: string,
--#     agent_subtype: string,
--#     forename: string,
--#     clan_name: string,
--#     family_name: string,
--#     other_name: string,
--#     make_faction_leader: boolean,
--#     success_callback: (function(CA_CQI))?
--# )
--# assume CM.create_force: method(
--#     faction_key: string,
--#     unitstring: string,
--#     region_key: string,
--#     xPos: number,
--#     yPos: number,
--#     exclude_named_chars: boolean,
--#     success_callback: (function(CA_CQI))?,
--#     command_queue: boolean?
--# )
--# assume CM.spawn_character_to_pool: method(
--#    faction_key: string,
--#    forename: string,
--#    family_name: string,
--#    clanName: string,
--#    otherName: string,
--#    age: int,
--#    is_male: boolean,
--#    agent_type: string,
--#    agent_subtype: string, 
--#    is_immortal: boolean,
--#    art_set_id: string
--# )
--# assume CM.create_agent: method(
--#    faction_key: string,
--#    agent_type: string,
--#    agent_subtype: string,
--#    x: number,
--#    y: number,
--#    command_queue: boolean,
--#    success_callback: (function(CA_CQI))?
--# )
--# assume CM.create_force_with_existing_general: method(
--#    charlookup: string,
--#    factionKey: string,
--#    armyList: string,
--#    regionKey: string,
--#    xPos: number,
--#    yPos: number,
--#    success_callback: (function(CA_CQI))?
--# )
--# assume CM.force_attack_of_opportunity: method(attacking_mf: CA_CQI, defending_mf: CA_CQI, thruCq: bool)
--# assume CM.pending_battle_cache_is_quest_battle: method() --> boolean
--# assume CM.add_first_tick_callback: method(function)
--# assume CM.force_rebellion_in_region: method(region: string, unitsize: number, unit_list: string, xpos: number, ypos: number, suppress_message: boolean)
--# assume CM.set_public_order_of_province_for_region: method(region: string, public_order: number)
--# assume CM.spawn_unique_agent: method(faction_CQI: CA_CQI, agent_type: string, force: boolean)
--# assume CM.spawn_unique_agent_at_region: method(faction_CQI: CA_CQI, agent_type: string, region_cqi: CA_CQI, force: boolean)
--# assume CM.spawn_unique_agent_at_character: method(faction_CQI: CA_CQI, agent_type: string, character_cqi: CA_CQI, force: boolean)
--# assume CM.spawn_agent_at_military_force: method(owning_faction: CA_FACTION, target_force: CA_MILITARY_FORCE, agent_type: string, agent_subtype_record: string?)
--# assume CM.spawn_agent_at_settlement: method(owning_faction: CA_FACTION, target_settlement: CA_SETTLEMENT, agent_type: string, agent_subtype_record: string?)
--# assume CM.spawn_agent_at_position: method(owning_faction: CA_FACTION, x: number, y: number, agent_type: string, agent_subtype_record: string?)
--# assume CM.embed_agent_in_force: method(agent: CA_CHAR, military_force: CA_MILITARY_FORCE)
--spawn location finding
--# assume CM.find_valid_spawn_location_for_character_from_settlement: method(faction_key: string, settlement_region_key: string, on_sea: boolean, in_same_region: boolean, preferred_spawn_distance: number?) --> (number, number)
--# assume CM.find_valid_spawn_location_for_character_from_character: method(faction_key: string, character_lookup: string, in_same_region: boolean, preferred_spawn_distance: number?) --> (number, number)
--# assume CM.find_valid_spawn_location_for_character_from_position: method(faction_key: string, start_x: number, start_y: number, in_same_region: boolean, preferred_spawn_distance: number?) --> (number, number)
--saving and loading
--# assume CM.add_saving_game_callback: method(function(context: WHATEVER))
--# assume CM.add_loading_game_callback: method(function(context: WHATEVER))
--# assume CM.set_saved_value: method(valueKey: string, value: any)
--# assume CM.get_saved_value: method(valueKey: string) --> WHATEVER
--# assume CM.save_named_value: method(name: string, value: any, context: WHATEVER?)
--# assume CM.load_named_value: method(name: string, default: any, context: WHATEVER?) --> WHATEVER
--# assume CM.disable_saving_game: method(opt: boolean)
--# assume CM.autosave_at_next_opportunity: method()
--serialisation
--# assume CM.load_values_from_string: method(datastring: string) --> table
--# assume CM.process_table_save: method(savetable: table, prev_string: string?) --> string
--effect bundle commands
--# assume CM.apply_effect_bundle_to_region: method(bundle: string, region: string, turns: number)
--# assume CM.remove_effect_bundle_from_region: method(bundle: string, region: string)
--# assume CM.apply_effect_bundle_to_force: method(bundle: string, force: CA_CQI, turns: number)
--# assume CM.apply_effect_bundle: method(bundle: string, faction: string, turns: number)
--# assume CM.remove_effect_bundle: method(bundle: string, faction: string)
--# assume CM.apply_effect_bundle_to_characters_force: method(bundleKey: string, charCqi: CA_CQI, turns: number, useCommandQueue: boolean)
--# assume CM.remove_effect_bundle_from_characters_force: method(bundle_key: string, char_cqi: CA_CQI)
--# assume CM.apply_effect_bundle_to_character: method(bundleKey: string, character: CA_CHAR, turns: number)
--# assume CM.apply_effect_bundle_to_faction_province: method(bundleKey: string, region: CA_REGION, turns: number)
--# assume CM.remove_effect_bundle_from_faction_province: method(bundleKey: string, region: CA_REGION)
--# assume CM.remove_effect_bundle_from_character: method(bundleKey: string, character: CA_CHAR)
--# assume CM.create_new_custom_effect_bundle: method(bundleKey: string) --> CA_CUSTOM_EFFECT_BUNDLE
--# assume CM.apply_custom_effect_bundle_to_faction: method(effect_bundle: CA_CUSTOM_EFFECT_BUNDLE, faction: CA_FACTION)
--# assume CM.apply_custom_effect_bundle_to_character: method(effect_bundle: CA_CUSTOM_EFFECT_BUNDLE, character: CA_CHAR)
--# assume CM.apply_custom_effect_bundle_to_force: method(effect_bundle: CA_CUSTOM_EFFECT_BUNDLE, military_force: CA_MILITARY_FORCE)
--# assume CM.apply_custom_effect_bundle_to_characters_force: method(effect_bundle: CA_CUSTOM_EFFECT_BUNDLE, character: CA_CHAR)
--# assume CM.apply_custom_effect_bundle_to_region: method(effect_bundle: CA_CUSTOM_EFFECT_BUNDLE, region: CA_REGION)
--# assume CM.apply_custom_effect_bundle_to_faction_province: method(effect_bundle: CA_CUSTOM_EFFECT_BUNDLE, target_region: CA_REGION)
--unit manipulation
--# assume CM.remove_unit_from_character: method(lookup_string: string, unitID: string)
--# assume CM.grant_unit_to_character: method(lookup: string , unit: string)
--# assume CM.remove_all_units_from_general: method(character: CA_CHAR)
--# assume CM.force_character_force_into_stance: method(lookup: string, stance: string)
--# assume CM.set_unit_hp_to_unary_of_maximum: method(unit: CA_UNIT, unary_hp: number)
--diplomacy commands
--# assume CM.force_diplomacy: method(faction: string, other_faction: string, record: string, offer: boolean, accept: boolean, do_not_enable_payments: boolean)
--# assume CM.make_diplomacy_available: method(faction: string, other_faction: string)
--# assume CM.force_make_peace: method(faction: string, other_faction: string)
--# assume CM.force_declare_war: method(declarer: string, declaree: string, attacker_allies: boolean, defender_allies: boolean, command_queue: boolean?)
--# assume CM.force_make_vassal: method(vassaliser: string, vassal: string)
--# assume CM.force_make_trade_agreement: method(faction1: string, faction2: string)
--# assume CM.faction_has_trade_agreement_with_faction: method( first_faction: CA_FACTION, second_faction: CA_FACTION)
--# assume CM.faction_has_nap_with_faction: method(first_faction: CA_FACTION, second_faction: CA_FACTION)
--# assume CM.force_confederation: method(confederator: string, confederated: string)
--# assume CM.force_alliance: method(faction: string, other_faction: string, is_military_alliance: boolean)
--pending battle commands
--# assume CM.pending_battle_cache_get_defender: method(pos: int) --> (CA_CQI, CA_CQI, string) -- string: faction
--# assume CM.pending_battle_cache_get_attacker: method(pos: int) --> (CA_CQI, CA_CQI, string) 
--# assume CM.pending_battle_cache_get_enemies_of_char: method(char: CA_CHAR) --> vector<CA_CHAR>
--# assume CM.pending_battle_cache_attacker_victory: method() --> boolean
--# assume CM.pending_battle_cache_defender_victory: method() --> boolean
--# assume CM.pending_battle_cache_faction_is_involved: method(faction_key: string) --> boolean
--# assume CM.pending_battle_cache_faction_is_attacker: method(faction_key: string) --> boolean
--# assume CM.pending_battle_cache_faction_is_defender: method(faction_key: string) --> boolean
--# assume CM.pending_battle_cache_num_attackers: method() --> int
--# assume CM.pending_battle_cache_num_defenders: method() --> int
--# assume CM.pending_battle_cache_human_is_involved: method() --> boolean
--# assume CM.is_processing_battle: method() --> boolean
--CAI
--# assume CM.force_change_cai_faction_personality: method(key: string, personality: string)
---Markers
--# assume CM.add_marker: method(
--# name: string,
--# marker_type: CA_MARKER_TYPE,
--# location_x: number,
--# location_y: number,
--# location_z: number )
--# assume CM.remove_marker: method (name: string)
--Region Commands
--# assume CM.transfer_region_to_faction: method(region: string, faction:string)
--# assume CM.set_region_abandoned: method(region: string)
--# assume CM.set_public_order_disabled_for_province_for_region_for_all_factions_and_set_default: method(region_key: string, bool: boolean)
--# assume CM.exempt_province_from_tax_for_all_factions_and_set_default: method(region_key: string, bool: boolean)
--# assume CM.region_slot_instantly_upgrade_building: method (slot: CA_SLOT, target_building_key: string) --> CA_BUILDING
--# assume CM.region_slot_instantly_dismantle_building: method (slot: string) --<region_key>:<slot_number>
--# assume CM.instantly_set_settlement_primary_slot_level: method (settlement: CA_SETTLEMENT, level: number) --> CA_BUILDING
--# assume CM.region_slot_instantly_repair_building: method (slot: string) --<region_key>:<slot_number>
--# assume CM.foreign_slot_instantly_upgrade_building: method (slot: CA_FOREIGN_SLOT, upgrade_building_key: string) 
--# assume CM.foreign_slot_instantly_dismantle_building: method (slot: CA_FOREIGN_SLOT) --<region_key>:<slot_number>
--# assume CM.add_development_points_to_region: method (region: string, development_points: number )
--# assume CM.cai_disable_targeting_against_settlement: method (settlement: string)
--# assume CM.cai_enable_targeting_against_settlement: method (settlment: string)
--# assume CM.heal_garrison: method(region_cqi: number)
--autoresolve
--# assume CM.win_next_autoresolve_battle: method(faction: string)
--# assume CM.modify_next_autoresolve_battle: method(attacker_win_chance: number, defender_win_chance: number, attacker_losses_modifier: number, defender_losses_modifier: number, wipe_out_loser: boolean)
--events
--# assume CM.trigger_incident_with_targets: method(owning_faction_cqi: CA_CQI, incident_key: string, faction_cqi: CA_CQI | 0, secondary_faction_cqi: CA_CQI | 0, character_cqi: CA_CQI | 0, military_force_cqi: CA_CQI | 0, region_cqi: CA_CQI | 0, settlement_cqi: CA_CQI | 0)
--# assume CM.trigger_custom_incident: method(faction_key: string, dilemma_key: string, trigger_immediately: boolean?, payload: string) --> boolean
--# assume CM.trigger_dilemma: method(faction_key: string, dilemma_key: string, trigger_immediately: boolean?) --> boolean
--# assume CM.trigger_dilemma_with_targets: method(faction_cqi: CA_CQI, dilemma_key: string, target: CA_CQI?, secondary: CA_CQI?, character: CA_CQI?, military_force: CA_CQI?, region: CA_CQI?, settlement: CA_CQI?, callback: (function(CA_CQI))?) --> boolean
--# assume CM.trigger_incident: method(factionName: string, incidentKey: string, fireImmediately: boolean?, whitelist: boolean?)
--# assume CM.trigger_mission: method(faction_key: string, mission_key: string, trigger_immediately: boolean)
--# assume CM.cancel_custom_mission: method(faction_key: string, mission_key: string)
--# assume CM.disable_event_feed_events: method(disable: boolean, categories: string, subcategories: string, events: string)
--# assume CM.complete_scripted_mission_objective: method(mission_key: string, objective_key: string, success: boolean)
--locks and unlocks
--# assume CM.lock_technology: method(faction_key: string, tech_key: string)
--# assume CM.restrict_technologies_for_faction: method(factionKey: string, techList: vector<string>, disable: boolean)
--# assume CM.unlock_starting_general_recruitment: method(startpos: string, faction: string)
--# assume CM.lock_starting_general_recruitment: method(startpos: string, faction: string)
--# assume CM.unlock_technology: method(faction_key: string, tech_key: string)
--# assume CM.add_event_restricted_building_record_for_faction: method(unit: string, faction_key: string)
--# assume CM.remove_event_restricted_building_record_for_faction: method(unit: string, faction_key: string)
--# assume CM.add_event_restricted_unit_record_for_faction: method(unit: string, faction_key: string)
--# assume CM.remove_event_restricted_unit_record_for_faction: method(unit: string, faction_key: string)
--# assume CM.add_restricted_building_level_record: method(faction_key: string, building_key: string)
--# assume CM.remove_restricted_building_level_record: method(faction_key: string, building_key: string)
--buildings
--# assume CM.add_building_to_force: method(cqi: CA_CQI, building_level: string | vector<string>)
--rituals commands
--# assume CM.perform_ritual: method(performing_faction: string, target_faction: string, ritual_key: string)
--# assume CM.set_ritual_unlocked: method(cqi: CA_CQI, rite_key: string, unlock: boolean)
--# assume CM.set_ritual_chain_unlocked: method(cqi: CA_CQI, ritual_chain_key: string, unlock: boolean)
--# assume CM.rollback_linked_ritual_chain: method(chain_key: string, level: number)
--faction wide variables
--# assume CM.treasury_mod: method(faction_key: string, quantity: number)
--# assume CM.pooled_resource_mod: method(cqi: CA_CQI, pooled_resource: string, factor: string, quantity: number)
--# assume CM.faction_set_food_factor_value: method(faction_key: string, factor_key: string, quantity: number)
--# assume CM.faction_add_pooled_resource: method(faction_key: string, pooled_resource: string, factor: string, quantity: number)
--checks
--# assume CM.char_is_mobile_general_with_army: method(char: CA_CHAR) --> boolean
--# assume CM.char_in_owned_region: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_in_region_list: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_governor: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_general_with_navy: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_general_with_army: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_defeated_general: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_victorious_general: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_general: method(character: CA_CHAR) --> boolean
--# assume CM.char_is_agent: method(character: CA_CHAR) --> boolean
--# assume CM.char_has_navy: method(character: CA_CHAR) --> boolean
--# assume CM.char_has_army: method(character: CA_CHAR) --> boolean
--# assume CM.is_local_players_turn: method() --> boolean
--# assume CM.is_dlc_flag_enabled: method(dlc: string) --> boolean
--model overrides
--# assume CM.override_building_chain_display: method(building_chain: string, settlement_skin: string, region_name: string)
--aux
--# assume CM.show_shroud: method(opt: boolean)
--# assume CM.make_region_visible_in_shroud: method(faction_key: string, region_key: string)
--# assume CM.end_turn: method(opt: boolean)
--# assume CM.whitelist_event_feed_event_type: method(event_type: string)
--# assume CM.force_normal_character_locomotion_speed_for_turn: method(boolean)
--# assume CM.hide_character: method(character_lookup: string, command_queue: boolean)
--# assume CM.unhide_character: method(character_lookup: string, x_pos: number, y_pos: number, command_queue: boolean)
--# assume CM.add_circle_area_trigger: method(x: number, y: number, radius: number, trigger_name: string, character_lookup: string, trigger_on_enter: boolean, trigger_on_exit: boolean, trigger_once: boolean)
--# assume CM.add_outline_area_trigger: method(trigger_name: string, character_lookup: string, trigger_on_enter: boolean, trigger_on_exit: boolean, trigger_once: boolean, any...)
--# assume CM.remove_area_trigger: method(trigger_name: string)
--# assume CM.add_hex_area_trigger: method(trigger_name: string, x: number, y: number, radius: number, faction: string?, subculture: string?)
--# assume CM.remove_hex_area_trigger: method(trigger_name: string)
--battle stuff
--# assume CM.add_custom_battlefield: method(
--#     id: string,
--#     xPos: number,
--#     yPos: number,
--#     radius: number,
--#     dump_campaign: boolean,
--#     loading_override: string,
--#     script_override: string,
--#     battle_override: string,
--#     player_alliance: number,
--#     launch_immediately: boolean,
--#     is_land_battle: boolean,
--#     force_autoresolve: boolean
--#)
--# assume CM.remove_custom_battlefield: method(id: string)
-- campaign markers
--# assume CM.add_interactable_campaign_marker: method(
--#    uniqueID: string,
--#    markerKey: string,
--#    xPos: number,
--#    yPos: number,
--#    radius: number,
--#    factionKey: string?,
--#    subcultureKey: string?
--# )

--# assume CM.start_faction_region_change_monitor: method(faction_name: string)
--# assume CM.add_foreign_slot_set_to_region_for_faction: method(faction_cqi: CA_CQI, region_cqi: CA_CQI, slot_set: string)
--# assume CM.remove_faction_foreign_slots_from_region: method(faction_cqi: CA_CQI, region_cqi: CA_CQI)

-- scrap
--# assume CM.faction_set_unit_purchasable_effect_lock_state: method(faction: CA_FACTION, purchasable_effect: string, lock_reason: string, should_lock: boolean)
--# assume CM.faction_purchase_unit_effect: method(faction: CA_FACTION, unit: CA_UNIT, purchasable_effect: CA_UNIT_PURCHASABLE_EFFECT)

-- merc pool
--# assume CM.add_units_to_faction_mercenary_pool: method(faction_cqi: CA_CQI, unit_key: string, count: number)

-- prison
--# assume CM.faction_imprison_character: method(faction: CA_FACTION, character: CA_CHAR)

-- CAMPAIGN UI MANAGER
--# assume CUIM.get_char_selected: method() --> string
--# assume CUIM.settlement_selected: string -- format = "settlement:"..regionname
--# assume CUIM.override: method(ui_override: string) --> CUIM_OVERRIDE
--# assume CUIM.start_scripted_sequence: method()
--# assume CUIM.stop_scripted_sequence: method()
--# assume CUIM.is_panel_open: method(panel: string)
--# assume CUIM.get_char_selected_cqi: method() --> CA_CQI
--# assume CUIM_OVERRIDE.lock_ui: method()
--# assume CUIM_OVERRIDE.unlock_ui: method(force: bool, silent: bool)
--# assume CUIM.is_char_selected_from_faction: method(factionKey: string) --> bool
--# assume CUIM.suppress_end_of_turn_warning: method(warning: string, disable: bool)

-- CAMPAIGN UI MANAGER OVERRIDES
--# assume CUIM_OVERRIDE.set_allowed: method(allowed: bool)

-- MODEL
--# assume CA_MODEL.world: method() --> CA_WORLD
--# assume CA_MODEL.difficulty_level: method() --> number
--# assume CA_MODEL.turn_number: method() --> number
--# assume CA_MODEL.pending_battle: method() --> CA_PENDING_BATTLE
--# assume CA_MODEL.combined_difficulty_level: method() --> int
--# assume CA_MODEL.campaign_name: method(campaign_name: string) --> boolean
--# assume CA_MODEL.campaign_type: method() --> number
--# assume CA_MODEL.is_multiplayer: method() --> boolean
--# assume CA_MODEL.military_force_for_command_queue_index: method(cqi: CA_CQI) --> CA_MILITARY_FORCE
--# assume CA_MODEL.character_for_command_queue_index: method(cqi: CA_CQI) --> CA_CHAR
--# assume CA_MODEL.random_percent: method(chance: number) --> boolean
--# assume CA_MODEL.faction_is_local: method(faction_key: string) --> boolean
--# assume CA_MODEL.faction_for_command_queue_index: method(cqi: CA_CQI) --> CA_FACTION

-- WORLD
--# assume CA_WORLD.faction_list: method() --> CA_FACTION_LIST
--# assume CA_WORLD.faction_by_key: method(faction_key: string) --> CA_FACTION
--# assume CA_WORLD.whose_turn_is_it: method() --> CA_FACTION
--# assume CA_WORLD.region_manager: method() --> CA_REGION_MANAGER
--# assume CA_WORLD.sea_region_manager: method() --> CA_SEA_MANAGER
--# assume CA_WORLD.faction_exists: method(faction_key: string) --> boolean
--# assume CA_WORLD.ancillary_exists: method(ancillary_key: string) --> boolean
--# assume CA_WORLD.climate_phase_index: method() --> number
--# assume CA_WORLD.region_data: method() --> CA_REGDATA_LIST
--# assume CA_WORLD.land_region_data: method() --> CA_REGDATA_LIST
--# assume CA_WORLD.sea_region_data: method() --> CA_REGDATA_LIST

-- CA CAMPAIGN_UI
--# assume CA_CampaignUI.TriggerCampaignScriptEvent: function(cqi: CA_CQI, event: string)
--# assume CA_CampaignUI.ClearSelection: function()
--# assume CA_CampaignUI.UpdateSettlementEffectIcons: function()

-- GAME INTERFACE
--# assume CA_GAME.filesystem_lookup: method(filePath: string, matchRegex:string) --> string

-- CHARACTER
--# assume CA_CHAR.has_trait: method(traitName: string) --> boolean
--# assume CA_CHAR.logical_position_x: method() --> int
--# assume CA_CHAR.logical_position_y: method() --> int
--# assume CA_CHAR.display_position_x: method() --> int
--# assume CA_CHAR.display_position_y: method() --> int
--# assume CA_CHAR.character_subtype_key: method() --> string
--# assume CA_CHAR.region: method() --> CA_REGION
--# assume CA_CHAR.faction: method() --> CA_FACTION
--# assume CA_CHAR.military_force: method() --> CA_MILITARY_FORCE
--# assume CA_CHAR.garrison_residence: method() --> CA_GARRISON_RESIDENCE
--# assume CA_CHAR.character_subtype: method(subtype: string) --> boolean
--# assume CA_CHAR.character_type: method(char_type: string) --> boolean
--# assume CA_CHAR.character_type_key: method() --> string
--# assume CA_CHAR.get_forename: method() --> string
--# assume CA_CHAR.get_surname: method() --> string
--# assume CA_CHAR.command_queue_index: method() --> CA_CQI
---# assume CA_CHAR.cqi: method() --> CA_CQI -- dont use! because reasons
--# assume CA_CHAR.rank: method() --> int
--# assume CA_CHAR.won_battle: method() --> boolean
--# assume CA_CHAR.battles_fought: method() --> number
--# assume CA_CHAR.is_wounded: method() --> boolean
--# assume CA_CHAR.has_military_force: method() --> boolean
--# assume CA_CHAR.is_faction_leader: method() --> boolean
--# assume CA_CHAR.family_member: method() --> CA_CHAR
--# assume CA_CHAR.is_null_interface: method() --> boolean
--# assume CA_CHAR.has_skill: method(skill_key: string) --> boolean
--# assume CA_CHAR.is_politician: method() --> boolean
--# assume CA_CHAR.has_garrison_residence: method() --> boolean
--# assume CA_CHAR.has_region: method() --> boolean 
--# assume CA_CHAR.is_besieging: method() --> boolean
--# assume CA_CHAR.is_blockading: method() --> boolean
--# assume CA_CHAR.performed_action_this_turn: method() --> boolean
--# assume CA_CHAR.is_ambushing: method() --> boolean
--# assume CA_CHAR.turns_in_own_regions: method() --> int
--# assume CA_CHAR.turns_in_enemy_regions: method() --> int
--# assume CA_CHAR.is_at_sea: method() --> boolean
--# assume CA_CHAR.is_embedded_in_military_force: method() --> boolean
--# assume CA_CHAR.action_points_remaining_percent: method() --> (number | integer)
--# assume CA_CHAR.has_ancillary: method(ancillary: string) --> boolean

-- CHARACTER LIST
--# assume CA_CHAR_LIST.num_items: method() --> number
--# assume CA_CHAR_LIST.item_at: method(index: number) --> CA_CHAR

-- MILITARY FORCE
--# assume CA_MILITARY_FORCE.general_character: method() --> CA_CHAR
--# assume CA_MILITARY_FORCE.unit_list: method() --> CA_UNIT_LIST
--# assume CA_MILITARY_FORCE.command_queue_index: method() --> CA_CQI
--# assume CA_MILITARY_FORCE.has_effect_bundle: method(bundle: string) --> boolean
--# assume CA_MILITARY_FORCE.character_list: method() --> CA_CHAR_LIST
--# assume CA_MILITARY_FORCE.has_general: method() --> boolean
--# assume CA_MILITARY_FORCE.is_armed_citizenry: method() --> boolean
--# assume CA_MILITARY_FORCE.morale: method() --> number
--# assume CA_MILITARY_FORCE.active_stance: method() --> string
--# assume CA_MILITARY_FORCE.faction: method() --> CA_FACTION
--# assume CA_MILITARY_FORCE.is_null_interface: method() --> boolean

----# assume CA_MILITARY_FORCE.force_type: method() --> FORCE_TYPE



-- MILITARY FORCE LIST
--# assume CA_MILITARY_FORCE_LIST.num_items: method() --> number
--# assume CA_MILITARY_FORCE_LIST.item_at: method(index: number) --> CA_MILITARY_FORCE

-- UNIT
--# assume CA_UNIT.faction: method() --> CA_FACTION
--# assume CA_UNIT.unit_key: method() --> string
--# assume CA_UNIT.has_force_commander: method() --> boolean
--# assume CA_UNIT.force_commander: method() --> CA_CHAR
--# assume CA_UNIT.military_force: method() --> CA_MILITARY_FORCE
--# assume CA_UNIT.has_military_force: method() --> boolean
--# assume CA_UNIT.percentage_proportion_of_full_strength: method() --> number
--# assume CA_UNIT.get_unit_custom_battle_cost: method() --> number

-- UNIT_LIST
--# assume CA_UNIT_LIST.num_items: method() --> number
--# assume CA_UNIT_LIST.item_at: method(j: number) --> CA_UNIT
--# assume CA_UNIT_LIST.has_unit: method(unit: string) --> boolean
--# assume CA_UNIT_LIST.is_empty: method() --> boolean

-- REGION_MANAGER
--# assume CA_REGION_MANAGER.region_list: method() --> CA_REGION_LIST
--# assume CA_REGION_MANAGER.region_by_key: method(key: string) --> CA_REGION

-- REGION
--# assume CA_REGION.settlement: method() --> CA_SETTLEMENT
--# assume CA_REGION.cqi: method() --> number
--# assume CA_REGION.garrison_residence: method() --> CA_GARRISON_RESIDENCE
--# assume CA_REGION.name: method() --> string
--# assume CA_REGION.province_name: method() --> string
--# assume CA_REGION.public_order: method() --> number
--# assume CA_REGION.is_null_interface: method() --> boolean
--# assume CA_REGION.is_abandoned: method() --> boolean
--# assume CA_REGION.owning_faction: method() --> CA_FACTION
--# assume CA_REGION.slot_list: method() --> CA_SLOT_LIST
--# assume CA_REGION.is_province_capital: method() --> boolean
--# assume CA_REGION.building_exists: method(building: string) --> boolean
--# assume CA_REGION.resource_exists: method(resource_key: string) --> boolean
--# assume CA_REGION.any_resource_available: method() --> boolean
--# assume CA_REGION.adjacent_region_list: method() --> CA_REGION_LIST
--# assume CA_REGION.logical_position_x: method() --> int
--# assume CA_REGION.logical_position_y: method() --> int
--# assume CA_REGION.religion_proportion: method(religion: string) --> number

--REGION LIST
--# assume CA_REGION_LIST.num_items: method() --> number
--# assume CA_REGION_LIST.item_at: method(i: number) --> CA_REGION
--# assume CA_REGION_LIST.is_empty: method() --> boolean

-- SETTLEMENT
--# assume CA_SETTLEMENT.logical_position_x: method() --> int
--# assume CA_SETTLEMENT.logical_position_y: method() --> int
--# assume CA_SETTLEMENT.display_position_x: method() --> int
--# assume CA_SETTLEMENT.display_position_y: method() --> int
--# assume CA_SETTLEMENT.get_climate: method() --> string
--# assume CA_SETTLEMENT.is_null_interface: method() --> boolean
--# assume CA_SETTLEMENT.faction: method() -->CA_FACTION
--# assume CA_SETTLEMENT.commander: method() --> CA_CHAR
--# assume CA_SETTLEMENT.has_commander: method() --> boolean
--# assume CA_SETTLEMENT.slot_list: method() --> CA_SLOT_LIST
--# assume CA_SETTLEMENT.is_port: method() --> boolean
--# assume CA_SETTLEMENT.region: method() --> CA_REGION
--# assume CA_SETTLEMENT.primary_slot: method() --> CA_SLOT
--# assume CA_SETTLEMENT.port_slot: method() --> CA_SLOT
--# assume CA_SETTLEMENT.active_secondary_slots: method() --> CA_SLOT_LIST
--# assume CA_SETTLEMENT.first_empty_active_secondary_slot: method() --> CA_SLOT

-- SLOT LIST
--# assume CA_SLOT_LIST.num_items: method() --> number
--# assume CA_SLOT_LIST.item_at: method(index: number) --> CA_SLOT
--# assume CA_SLOT_LIST.slot_type_exists: method(slot_key: string) --> boolean
--# assume CA_SLOT_LIST.building_type_exists: method(building_key: string) --> boolean

-- SLOT
--# assume CA_SLOT.has_building: method() --> boolean
--# assume CA_SLOT.building: method() --> CA_BUILDING
--# assume CA_SLOT.resource_key: method() --> string
--# assume CA_SLOT.name: method() --> string

-- BUILDING
--# assume CA_BUILDING.name: method() --> string
--# assume CA_BUILDING.building_level: method() --> number | int
--# assume CA_BUILDING.chain: method() --> string
--# assume CA_BUILDING.superchain: method() --> string
--# assume CA_BUILDING.faction: method() --> CA_FACTION
--# assume CA_BUILDING.region: method() --> CA_REGION
--# assume CA_BUILDING.percent_health: method() --> number | int

-- GARRISON RESIDENCE
--# assume CA_GARRISON_RESIDENCE.region: method() --> CA_REGION
--# assume CA_GARRISON_RESIDENCE.faction: method() --> CA_FACTION
--# assume CA_GARRISON_RESIDENCE.is_under_siege: method() --> boolean
--# assume CA_GARRISON_RESIDENCE.settlement_interface: method() --> CA_SETTLEMENT
--# assume CA_GARRISON_RESIDENCE.army: method() --> CA_MILITARY_FORCE
--# assume CA_GARRISON_RESIDENCE.command_queue_index: method() --> CA_CQI
--# assume CA_GARRISON_RESIDENCE.unit_count: method() --> number
--# assume CA_GARRISON_RESIDENCE.can_be_occupied_by_faction: method(faction_key: string) --> boolean

-- CA REGION DATA
--# assume CA_REGDATA.is_null_interface: method() --> boolean
--# assume CA_REGDATA.key: method() --> string
--# assume CA_REGDATA.is_sea: method() --> boolean

-- CA REGION DATA LIST
--# assume CA_REGDATA_LIST.item_at: method(i: int) --> CA_REGDATA
--# assume CA_REGDATA_LIST.is_empty: method() --> boolean
--# assume CA_REGDATA_LIST.num_items: method() --> int

-- CA SEA MANAGER
--# assume CA_SEA_MANAGER.sea_region_list: method() --> CA_SEA_REGION_LIST
--# assume CA_SEA_MANAGER.faction_sea_region_list: method(faction_key: string) --> CA_SEA_REGION_LIST
--# assume CA_SEA_MANAGER.sea_region_by_key: method(region_key: string) --> CA_SEA_REGION

-- CA SEA REGION
--# assume CA_SEA_REGION.name: method() --> string
--# assume CA_SEA_REGION.is_null_interface: method() --> boolean

-- CA SEA REGION LIST 
--# assume CA_SEA_REGION_LIST.item_at: method(i: int) --> CA_SEA_REGION
--# assume CA_SEA_REGION_LIST.num_items: method() --> number

-- FACTION
--# assume CA_FACTION.character_list: method() --> CA_CHAR_LIST
--# assume CA_FACTION.treasury: method() --> number
--# assume CA_FACTION.name: method() --> string
--# assume CA_FACTION.subculture: method() --> string
--# assume CA_FACTION.culture: method() --> string
--# assume CA_FACTION.military_force_list: method() --> CA_MILITARY_FORCE_LIST
--# assume CA_FACTION.is_human: method() --> boolean
--# assume CA_FACTION.is_dead: method() --> boolean
--# assume CA_FACTION.is_vassal_of: method(faction: CA_FACTION) --> boolean
--# assume CA_FACTION.is_vassal: method() --> boolean
--# assume CA_FACTION.is_ally_vassal_or_client_state_of: method(faction: string) --> boolean
--# assume CA_FACTION.diplomatic_standing_with: method(faction: string ) --> number
--# assume CA_FACTION.allied_with: method(faction: CA_FACTION)
--# assume CA_FACTION.at_war_with: method(faction: CA_FACTION) --> boolean
--# assume CA_FACTION.region_list: method() --> CA_REGION_LIST
--# assume CA_FACTION.has_effect_bundle: method(bundle:string) --> boolean
--# assume CA_FACTION.home_region: method() --> CA_REGION
--# assume CA_FACTION.command_queue_index: method() --> CA_CQI
--# assume CA_FACTION.is_null_interface: method() --> boolean
--# assume CA_FACTION.faction_leader: method() --> CA_CHAR
--# assume CA_FACTION.has_home_region: method() --> boolean
--# assume CA_FACTION.factions_met: method() --> CA_FACTION_LIST
--# assume CA_FACTION.factions_at_war_with: method() --> CA_FACTION_LIST
--# assume CA_FACTION.factions_trading_with: method() --> CA_FACTION_LIST
--# assume CA_FACTION.at_war: method() --> boolean
--# assume CA_FACTION.has_pooled_resource: method(resource: string) --> boolean
--# assume CA_FACTION.pooled_resources: method() --> CA_POOLED_LIST
--# assume CA_FACTION.pooled_resource: method(resource: string) --> CA_POOLED
--# assume CA_FACTION.rituals: method() --> CA_FACTION_RITUALS
--# assume CA_FACTION.has_rituals: method() --> boolean
--# assume CA_FACTION.holds_entire_province: method(province_key: string, include_vassals: boolean)
--# assume CA_FACTION.has_technology: method(technology: string) --> boolean
--# assume CA_FACTION.imperium_level: method() --> number
--# assume CA_FACTION.factions_of_same_subculture: method() --> CA_FACTION_LIST
--# assume CA_FACTION.foreign_slot_managers: method() --> CA_FOREIGN_SLOT_LIST
--# assume CA_FACTION.ancillary_exists: method(ancillary: string) --> boolean
--# assume CA_FACTION.is_quest_battle_faction: method() --> boolean
--# assume CA_FACTION.is_rebel: method() --> boolean

-- FACTION LIST
--# assume CA_FACTION_LIST.num_items: method() --> number
--# assume CA_FACTION_LIST.item_at: method(index: number) --> CA_FACTION

-- FOREIGN SLOT LIST
--# assume CA_FOREIGN_SLOT_LIST.num_items: method() --> number
--# assume CA_FOREIGN_SLOT_LIST.item_at: method(index: number) --> CA_FACTION

-- EFFECT
--# assume CA_EFFECT.get_localised_string: function(key: string) --> string
--# assume CA_EFFECT.get_skinned_image_path: function(key: string) --> string

-- PENDING BATTLE
--# assume CA_PENDING_BATTLE.is_null_interface: method() --> boolean
--# assume CA_PENDING_BATTLE.attacker: method() --> CA_CHAR
--# assume CA_PENDING_BATTLE.defender: method() --> CA_CHAR
--# assume CA_PENDING_BATTLE.secondary_attackers: method() --> CA_CHAR_LIST
--# assume CA_PENDING_BATTLE.secondary_defenders: method() --> CA_CHAR_LIST
--# assume CA_PENDING_BATTLE.ambush_battle: method() --> boolean
--# assume CA_PENDING_BATTLE.has_been_fought: method() --> boolean
--# assume CA_PENDING_BATTLE.set_piece_battle_key: method() --> string
--# assume CA_PENDING_BATTLE.has_contested_garrison: method() --> boolean
--# assume CA_PENDING_BATTLE.contested_garrison: method() --> CA_GARRISON_RESIDENCE
--# assume CA_PENDING_BATTLE.battle_type: method() --> BATTLE_TYPE
--# assume CA_PENDING_BATTLE.is_active: method() --> boolean
--# assume CA_PENDING_BATTLE.has_attacker: method() --> boolean
--# assume CA_PENDING_BATTLE.has_defender: method() --> boolean
--# assume CA_PENDING_BATTLE.attacker_battle_result: method() --> string
--# assume CA_PENDING_BATTLE.defender_battle_result: method() --> string
--# assume CA_PENDING_BATTLE.percentage_of_defender_killed: method() --> number
--# assume CA_PENDING_BATTLE.percentage_of_attacker_killed: method() --> number
--# assume CA_PENDING_BATTLE.night_battle: method() --> boolean

-- CORE
--# assume CORE.get_ui_root: method() --> CA_UIC
--# assume CORE.add_listener: method(
--#     listenerName: string,
--#     eventName: string,
--#     conditionFunc: (function(context: WHATEVER?) --> boolean) | boolean,
--#     listenerFunc: function(context: WHATEVER?),
--#     persistent: boolean
--# )
--# assume CORE.remove_listener: method(listenerName: string)
--# assume CORE.add_ui_created_callback: method(function())
--# assume CORE.get_screen_resolution: method() --> (number, number)
--# assume CORE.trigger_event: method(event_name: string, any...)
--# assume CORE.add_static_object: method(name: string, value: any, override: boolean?)
--# assume CORE.is_campaign: method() --> boolean
--# assume CORE.cache_and_set_tooltip_for_component_state: method(component: CA_UIC, state: BUTTON_STATE, ui_tr: string)
--# assume CORE.svr_load_string: method(svrname: string) --> string
--# assume CORE.svr_load_bool: method(svrname: string) --> boolean
--# assume CORE.svr_save_string: method(svrname: string, value: string)
--# assume CORE.svr_save_bool: method(svrname: string, value: boolean)
--# assume CORE.progress_on_uicomponent_animation_finished: method(component: CA_UIC, callback: function())
--# assume CORE.progress_on_loading_screen_dismissed: method(callback: function())
--# assume CORE.is_mod_loaded: method(mod_name: string)

-- VFS
--# assume CA_VFS.exists: function(filepath: string) --> boolean

-- POOLED RESOURCE LIST
--# assume CA_POOLED_LIST.is_empty: method() --> boolean
--# assume CA_POOLED_LIST.item_at: method(index: number) --> CA_POOLED
--# assume CA_POOLED_LIST.num_items: method() --> number

-- POOLED RESOURCE
--# assume CA_POOLED.value: method() --> number
--# assume CA_POOLED.key: method() --> string
--# assume CA_POOLED.maxium_value: method() --> number
--# assume CA_POOLED.number_of_effect_types: method() --> number
--# assume CA_POOLED.active_effect: method() --> WHATEVER
--# assume CA_POOLED.minimum_value: method() --> number
--# assume CA_POOLED.percentage_of_capacity: method() --> number
--# assume CA_POOLED.factors: method() --> CA_POOLED_FACTOR_LIST

-- FACTION RITUALS
--# assume CA_FACTION_RITUALS.active_rituals: method() --> CA_RITUAL_LIST
--# assume CA_FACTION_RITUALS.ritual_status: method(ritual_key: string) --> boolean

-- RITUAL
--# assume CA_RITUAL.ritual_sites: method() --> CA_REGION_LIST
--# assume CA_RITUAL.ritual_chain_key: method() --> string
--# assume CA_RITUAL.ritual_key: method() --> string
--# assume CA_RITUAL.is_part_of_chain: method() --> boolean
--# assume CA_RITUAL.target_faction: method() --> CA_FACTION
--# assume CA_RITUAL.cast_time: method() --> number
--# assume CA_RITUAL.is_null_interface: method() --> boolean
--# assume CA_RITUAL.cooldown_time: method() --> number
--# assume CA_RITUAL.expended_resources: method() --> number
--# assume CA_RITUAL.slave_cost: method() --> number
--# assume CA_RITUAL.ritual_category: method() --> string

-- RITUAL LIST
--# assume CA_RITUAL_LIST.item_at: method(index: number) --> CA_RITUAL
--# assume CA_RITUAL_LIST.is_empty: method() --> boolean
--# assume CA_RITUAL_LIST.num_items: method() --> int

-- CUSTOM EFFECT BUNDLES
--# assume CA_CUSTOM_EFFECT_BUNDLE.add_effect: method(effect_key: string, effect_scope: string, effect_value: int)
--# assume CA_CUSTOM_EFFECT_BUNDLE.set_duration: method(duration: int) --> int
--# assume CA_CUSTOM_EFFECT_BUNDLE.key: method() --> string
--# assume CA_CUSTOM_EFFECT_BUNDLE.duration: method() --> int

-- GLOBAL FUNCTIONS
-- COMMON
--# assume global find_uicomponent: function(parent: CA_UIC, string...) --> CA_UIC
--# assume global set_component_visible_with_parent: function(is_visible: boolean, parent: CA_UIC, string...)
--# assume global find_child_uicomponent: function(parent: CA_UIC, child: string) --> CA_UIC
--# assume global UIComponent: function(pointer: CA_Component) --> CA_UIC
--# assume global find_uicomponent_from_table: function(root: CA_UIC, findtable: vector<string>) --> CA_UIC
--# assume global uicomponent_descended_from: function(root: CA_UIC, parent_name: string) --> boolean
--# assume global out: function(out: string | number)  
--# assume global print_all_uicomponent_children: function(component: CA_UIC)
--# assume global is_uicomponent: function(object: any) --> boolean
--# assume global output_uicomponent: function(uic: CA_UIC, omit_children: boolean?)
--# assume global wh_faction_is_horde: function(faction: CA_FACTION) --> boolean
--# assume global uicomponent_to_str: function(component: CA_UIC) --> string
--# assume global is_string: function(arg: any) --> boolean
--# assume global is_table: function(arg: any) --> boolean
--# assume global is_number: function(arg: any) --> boolean
--# assume global is_function: function(arg: any) --> boolean
--# assume global is_boolean: function(arg: any) --> boolean
--# assume global is_nil: function(arg: any) --> boolean
--# assume global get_timestamp: function() --> string
--# assume global script_error: function(msg: string)
----# assume global to_number: function(n: any) --> number
--# assume global load_script_libraries: function()
--# assume global force_require: function(file: string)
--# assume global highlight_component: function(value: bool, is_square: bool, string...)
--# assume global pulse_uicomponent: function(uic: CA_UIC, should_pulse: bool, brightness_modifier: number?, propagate: bool?, state_name: BUTTON_STATE?) --buttons: brightness_modifier = 10, frames: brightness_modifier = 5
--# assume global is_valid_spawn_point: function(x: number, y: number) --> boolean
--# assume global Give_Trait: function(character: CA_CHAR, trait: string, _points: number?, _chance: number?)
-- CAMPAIGN
--# assume global get_cm: function() --> CM
--# assume global get_bm: function() --> CA_BATTLE_MANAGER
----# assume global get_events: function() --> map<string, vector<function(context:WHATEVER?)>> Removed with the WAAAGH update
--# assume global Get_Character_Side_In_Last_Battle: function(char: CA_CHAR) --> BATTLE_SIDE
--# assume global q_setup: function()
--# assume global set_up_rank_up_listener: function(quest_table: vector<vector<string | number>>, subtype: string, infotext: vector<string | number>)
--# assume global char_with_forename_has_no_military_force: function(forename: string) --> boolean
--# assume global is_surtha_ek: function(char: CA_CHAR) --> boolean
--# assume global is_character: function(char: CA_CHAR) --> boolean
--# assume global is_faction: function(char: CA_FACTION) --> boolean
--# assume global add_vow_progress: function(char: CA_CHAR, trait: string, ai: bool, agents: bool)

-- CA LUA OBJECTS:
--RITES UNLOCK OBJECT
--# assume global class RITE_UNLOCK
--# assume RITE_UNLOCK.new: method(rite_key: string, event_name: string, condition: function(context: WHATEVER, faction_name: string)--> boolean, faction: string?) --> RITE_UNLOCK
--# assume RITE_UNLOCK.start: method(human_faction_name: string)

--MISSION MANAGER OBJECT
--# assume global class MISSION_MANAGER
--# type global CA_MISSION_OBJECTIVE =
--# "CAPTURE_REGIONS" | "SCRIPTED" | "RAZE_OR_SACK_N_DIFFERENT_SETTLEMENTS_INCLUDING" |
--# "ELIMINATE_CHARACTER_IN_BATTLE" | "MOVE_TO_REGION" | "DEFEAT_N_ARMIES_OF_FACTION"
--creation
--# assume MISSION_MANAGER.new: method(faction_key: string, mission_key: string, success_callback: function?, failure_callback: function?, cancellation_callback: function?) --> MISSION_MANAGER

--basic
--# assume MISSION_MANAGER.add_new_objective: method(objective_type: CA_MISSION_OBJECTIVE)
--# assume MISSION_MANAGER.add_condition: method(condition_string: string)
--# assume MISSION_MANAGER.add_payload: method(payload_string: string)
--# assume MISSION_MANAGER.set_turn_limit: method(turns: number)
--# assume MISSION_MANAGER.set_chapter: method(turns: integer)
--# assume MISSION_MANAGER.set_mission_issuer: method(issuer: string)
--# assume MISSION_MANAGER.set_should_whitelist: method(boolean)
--localisation
--# assume MISSION_MANAGER.add_heading: method(heading_loc_key: string)
--# assume MISSION_MANAGER.add_description: method(description_loc_key: string)
--scripted objectives
------Here, string key can be ommited when creating an objective. This will generate it randomly. The script key can only be ommitted from other functions if there is only one scripted objective.
--# assume MISSION_MANAGER.add_new_scripted_objective: method(objective_loc_key: string, event: string, condition: function(context: WHATEVER) --> boolean, script_key: string?)
--# assume MISSION_MANAGER.add_scripted_objective_success_condition: method(event: string, condition: function(context: WHATEVER) --> boolean, script_key: string?)
--# assume MISSION_MANAGER.add_scripted_objective_failure_condition: method(event: string, condition: function(context: WHATEVER) --> boolean, script_key: string?)
--# assume MISSION_MANAGER.force_scripted_objective_success: method(script_key: string?)
--# assume MISSION_MANAGER.force_scripted_objective_failure: method(script_key: string?)
--# assume MISSION_MANAGER.update_scripted_objective_text: method(override_text_loc: string, script_key: string?)
--# assume MISSION_MANAGER.set_should_cancel_before_issuing: method(boolean)
--# assume MISSION_MANAGER.set_should_should_whitelist: method(boolean)
--# assume MISSION_MANAGER.set_first_time_startup_callback: method(callback: function())
--# assume MISSION_MANAGER.set_each_time_startup_callback: method(callback: function())
--# assume MISSION_MANAGER.trigger: method(dismiss_callback: function?, delay: number?)

--# assume CM.get_mission_manager: method(mission_key: string) --> MISSION_MANAGER

-- RANDOM ARMY MANAGER OBJECT
--# assume global class RAM
--# assume RAM.new_force: method(key: string)
--# assume RAM.add_mandatory_unit: method(forcekey: string, unitkey: string, q: number)
--# assume RAM.add_unit: method(forcekey: string, unitkey: string, q: number)
--# assume RAM.generate_force: method(id: string, sizes: {number, number}, is_table: boolean?) --> string

-- CAMPAIGN CUTSCENE OBJECT
--# assume global class CA_CUTSCENE
--# assume CA_CUTSCENE.new: method(key: string, time: number) --> CA_CUTSCENE
--# assume CA_CUTSCENE.set_disable_settlement_labels: method(setting: boolean)
--# assume CA_CUTSCENE.set_restore_shroud: method(setting: boolean)
--# assume CA_CUTSCENE.action: method(action: function(), timer: number)
--# assume CA_CUTSCENE.set_skip_camera: method(x: number, y: number, d: number, b: number, h: number)
--# assume CA_CUTSCENE.set_dismiss_advice_on_end: method(dismiss_advice: boolean?)
--# assume CA_CUTSCENE.wait_for_advisor: method(delay: number?)
--# assume CA_CUTSCENE.start: method()
--# assume CA_CUTSCENE.set_skippable: method(skippable: boolean?, callback: function?)
--# assume CA_CUTSCENE.cindy_playback: method(cindy_filepath: string, clear_anim_scenes: boolean, expire_camera: boolean)

-- LL UNLOCK OBJECT
--# assume global class LL_UNLOCK
--# assume LL_UNLOCK.new: method(faction_key: string, startpos_id: string, forename_key: string, event: string, condition: (function(context: WHATEVER) --> boolean)) --> LL_UNLOCK
--# assume LL_UNLOCK.start: method()

-- INVASION MANAGER OBJECT
--# assume global class INVASION_MANAGER
--# assume global class INVASION
--# type global INVASION_TARGETS = "NONE" | "REGION" | "LOCATION" | "CHARACTER" | "PATROL"
--# assume INVASION_MANAGER.new_invasion: method(name: string, faction: string, units: string, coordinates: vector<number>) --> INVASION
--# assume INVASION_MANAGER.get_invasion: method(invasion_key: string) --> INVASION
--# assume INVASION.set_target: method(target_type: INVASION_TARGETS, target: WHATEVER, target_faction_key: string)
--# assume INVASION.apply_effect: method(effect_key: string, turns: number)
--# assume INVASION.add_character_experience: method(quanity: number)
--# assume INVASION.add_unit_experience: method(quantity: number)
--# assume INVASION.start_invasion: method(callback: function(self: WHATEVER), declare_war: boolean?, invite_attacker_allies: boolean?, invite_defender_allies: boolean?)
--# assume INVASION.kill: method(general_only: bool)

-- CHAPTER MISSIONS
--# assume CA_CHAPTER_MISSION.new: method(chapter_number: number, faction_name: string, mission_key: string, advice_key: string?, infotext: vector<string>?)
--# assume CA_CHAPTER_MISSION.manual_start: method()
--# assume CA_CHAPTER_MISSION.has_been_issued: method() --> boolean

-- FACTION START
--# assume global class CA_FACTION_START
--# assume CA_FACTION_START.new: method(faction_name: string, x: number, y: number, d: number, b: number, h: number) --> CA_FACTION_START
--# assume CA_FACTION_START.register_new_sp_game_callback: method(callback: function())
--# assume CA_FACTION_START.register_each_sp_game_callback: method(callback: function())
--# assume CA_FACTION_START.register_new_mp_game_callback: method(callback: function())
--# assume CA_FACTION_START.register_each_mp_game_callback: method(callback: function())
--# assume CA_FACTION_START.register_intro_cutscene_callback: method(callback: function())
--# assume CA_FACTION_START.start: method(should_show_cutscene: boolean?, wait_for_loading_screen: boolean?, suppress_cinematic_borders: boolean?)

-- INTERVENTIONS
--# assume CA_INTERVENTION.new: method(name: string, priority: number, callback: function(), is_debug: boolean?)
--# assume CA_INTERVENTION.start: method()
--# assume CA_INTERVENTION.add_precondition: method(function())
--# assume CA_INTERVENTION.add_advice_key_precondition: method(advice_key: string)
--# assume CA_INTERVENTION.add_precondition_unvisited_page: method(help_page: string)
--# assume CA_INTERVENTION.add_trigger_condition: method(event: string, conditional_check: function() --> boolean)
--# assume CA_INTERVENTION.set_disregard_cost_when_triggering: method(disregard_priority: boolean?)
--# assume CA_INTERVENTION.set_suppress_pause_before_triggering: method(suppress_pause: boolean?)
--# assume CA_INTERVENTION.set_allow_when_advice_disabled: method(allow_advice: boolean?)
--# assume CA_INTERVENTION.set_min_advice_level: method(min_advice_level: number)
--# assume CA_INTERVENTION.set_player_turn_only: method(player_turn_only: boolean?)
--# assume CA_INTERVENTION.set_min_turn: method(minimum_turn: number)
--# assume CA_INTERVENTION.get_min_turn: method() --> number
--# assume CA_INTERVENTION.set_wait_for_battle_complete: method(wait_for_battle: boolean?)
--# assume CA_INTERVENTION.set_allow_attacking: method(allow_attacking: boolean?)
--# assume CA_INTERVENTION.set_wait_for_event_dismissed: method(wait_for_event: boolean?)
--# assume CA_INTERVENTION.set_wait_for_dilemma: method(wait_for_dilemma: boolean?)
--# assume CA_INTERVENTION.set_wait_for_fullscreen_panel_dismissed: method(wait_for_panel: boolean?)
--# assume CA_INTERVENTION.play_advice_for_intervention: method(advice_key: string, infotext: vector<string>?, mission: any?, mission_delay: number?)
--# assume CA_INTERVENTION.give_priority_to_intervention: method(intervention_name: string)

-- TIMER MANAGER
--# assume CA_TIMER_MANAGER.new: method() --> CA_TIMER_MANAGER
--# assume CA_TIMER_MANAGER.callback: method(callback: function(), delay: number, name: string?)
---# assume CA_TIMER_MANAGER.remove_callback: method(key: string)
---# assume CA_TIMER_MANAGER.repeat_callback: method(callback: function(), delay_and_repeat: number, name: string?)

-- INTERVENTION MANAGER
--# assume IM.lock_ui: method(bool, bool)
--# assume IM.override: method(ui_override: string) --> CUIM_OVERRIDE



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --# type global CA_SLOT_TYPE = "foreign" | "horde_primary" | "horde_secondary" | "port" | "primary" | "secondary"
-- --# assume CA_SLOT.type: method() --> CA_SLOT_TYPE -- problem: ".type" is a keyword

-- load_values_from_string = USELESS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------
-----------------
-- WH2 UIC API --
-----------------
-----------------

--List of all valid methods for the UIC game object! I've tried to write it as clearly as I can. If I've messed anything up, or forgotten anything, or need to clarify, do let me know.
--
--    Whatever is within the first brackets are arguments for the method; after the --> is the return values. I've tried to limit descriptors to what is actually necessary.
--    
--    Enjoy!
--    
--    ------------
--    ---- EVENTS
--    ------------
--    
--    Every event has the same two accessible variables:
--    - context.string
--    - context.component
--    
--    The former is the Id of the UIC referenced in the event.
--    The latter is the actual UIC. You have to use `UIComponent(context.component)` to actually get the object. I dunno why, don't ask me.
--    
--    Every event requires the same two conditions. The UIC must not be disabled, and the UIC must be interactive.
--    
--    
--    "ComponentMouseOn"
--    -- Triggered upon hovered over a UIC.
--    
--    "ComponentLClickUp"
--    -- Triggered upon clicking a UIC with the left mouse button.
--    
--    "ComponentRClickUp"
--    -- Triggered upon clicking a UIC with the right mouse button.
--    
--    "ComponentCreated"
--    -- Triggered upon the creation of a new UIC object.
    
    
--    --# assume CA_UIC.Visible() --> (is_visible: boolean)
--    --# assume CA_UIC.ChildCount() --> (num_children: number)
--    --# assume CA_UIC.TextDimensions() --> (width: number, height: number)
--    --# assume CA_UIC.NumImages() --> (num_images: number) 
--    --# assume CA_UIC.GetImagePath(index_num: number) --> (image_path: string)
--    --# assume CA_UIC.NumStates() --> (num_states: number)
--    --# assume CA_UIC.GetStateByIndex(index_num: number) --> (state: string)
--    --# assume CA_UIC.CurrentState() --> (current_state: string)
--    --# assume CA_UIC.Id() --> (id: string)
--    --# assume CA_UIC.Parent() --> (parent: UIC)
--    --# assume CA_UIC.Position() --> (x: number, y: number)
--    --# assume CA_UIC.Height() --> (height: number)
--    --# assume CA_UIC.Width() --> (width: number)
--    --# assume CA_UIC.Bounds() --> (width: number, height: number)
--    --# assume CA_UIC.Dimensions() --> (width: number, height: number)
--    
--    --# assume CA_UIC.GetStateText() --> (state_text: string)
--    --# assume CA_UIC.GetTooltipText() --> (tooltip_text: string)
--    --# assume CA_UIC.Address() --> (address: string) -- only used for parent_uic:Adopt(child_uic:Address()), grabs the UIC's memory address
--    --# assume CA_UIC.Opacity() --> (opacity: number) -- 0-100, I believe
--    --# assume CA_UIC.Priority() --> (priority: number) -- z-axis priority
--    --# assume CA_UIC.IsInteractive() --> (is_interactive: boolean)
--    --# assume CA_UIC.IsMoveable() --> (is_moveable: boolean)
--    --# assume CA_UIC.Find(index: number) --> (child: UIC) -- gets the child UIC at specified index. starts at 0
--    
--    --# assume CA_UIC.GetProperty(property_key: string) --> (value: string)
--    --# assume CA_UIC.DockingPoint() --> (docking_point: number) 
--    
--    --# assume CA_UIC.CurrentAnimationId() --> (animation: string) -- returns "" if not currently animated
--    --# assume CA_UIC.IsMouseOverChildren() --> (is: boolean) -- does not return true if it's over the UIC itself, only its children
--    
--    ------------
--    ---- SETTERS 
--    ------------
--    
--    --# assume CA_UIC.SetImageRotation(unknown1: number, unknown2: number)
--    --# assume CA_UIC.SetImage(image_path: string, index_num: number?)
--    --# assume CA_UIC.SetCanResizeHeight(enable: boolean)
--    --# assume CA_UIC.SetCanResizeWidth(enable: boolean)
--    
--    --# assume CA_UIC.MoveTo(x_pos: number, y_pos: number)
--    
--    --# assume CA_UIC.SetContextObject(obj_key: string) -- Unknown usage, probably super powerful
--    --# assume CA_UIC.SetProperty(property_key: string, value: string)
--    
--    --# assume CA_UIC.SetOpacity -- unknown args
--    --# assume CA_UIC.PropagateOpacity -- unknown args
--    --# assume CA_UIC.PropagateVisibility -- unknown args
--    --# assume CA_UIC.SetInteractive(enable: boolean)
--    --# assume CA_UIC.SetTooltipText(tooltip_text: string, enable: boolean)
--    --# assume CA_UIC.PropagatePriority(priority: number)
--    --# assume CA_UIC.Resize(width: number, height: number) -- use SetCanResizeHeight/Width prior and after
--    --# assume CA_UIC.SetDockingPoint
--    --# assume CA_UIC.SetMoveable(enable: boolean)
--    --# assume CA_UIC.LockPriority(priority: number) -- keep at specific z-axis prio
--    --# assume CA_UIC.UnLockPriority() -- allow prio to change
--    --# assume CA_UIC.SetDisabled(disable: boolean)
--    
--    
--    ------------
--    ---- ACTIONS
--    ------------
--    
--    --# assume CA_UIC.Highlight(should_highlight: boolean, unknown1: boolean, unknown2: boolean)


--    
--    
--    --# assume CA_UIC.CreateComponent(id: string, layout_file: string) -- makes a new child of the targeted UIC, with specified ID and layout file. Use `UIComponent(uic:CreateComponent(a, b))` to return the UIC created
--    --# assume CA_UIC.Adopt(address: string) -- makes the targeted address (use uic:Address()) UIC a child of the one being called
--    --# assume CA_UIC.Divorce(address: string) -- removes the targeted address (ditto) UIC a non-child of the one being called
--    --# assume CA_UIC.DestroyChildren() -- destroys all children of this UIC.
--    
--    --# assume CA_UIC.RegisterTopMost() -- keep on top
--    --# assume CA_UIC.RemoveTopMost() -- stop being on top
--    
--    --# assume CA_UIC.ResizeTextResizingComponentToInitialSize(width: number, height: number) -- force the text to a specified size, useful when changing state text
--    
--    
--    ------------
--    ---- UNKNOWN
--    ------------
--    
--    --# assume CA_UIC.Layout -- returns the layout file path?
--    --# assume CA_UIC.SetTooltipTextWithRLSKey
--    
--    --# assume CA_UIC.new -- unusable
--    
--    --# assume CA_UIC.TextShaderTechniqueSet
--    --# assume CA_UIC.InterfaceFunction
--    --# assume CA_UIC.StealShortcutKey
--    --# assume CA_UIC.ShaderTechniqueGet
--    --# assume CA_UIC.WidthOfTextLine
--    --# assume CA_UIC.StartPulseHighlight
--    --# assume CA_UIC.StopPulseHighlight
--    --# assume CA_UIC.FullScreenHighlight
--    --# assume CA_UIC.SequentialFind
--    --# assume CA_UIC.TextShaderVarsGet
--    --# assume CA_UIC.CallbackId
--    --# assume CA_UIC.TextShaderVarsSet
--    --# assume CA_UIC.ShaderVarsSet
--    --# assume CA_UIC.ShaderVarsGet
--    --# assume CA_UIC.ShaderTechniqueSet
--    --# assume CA_UIC.TriggerAnimation
--    --# assume CA_UIC.TextDimensionsForText
--    --# assume CA_UIC.HasInterface 
--    --# assume CA_UIC.IsDragged
--    --# assume CA_UIC.TriggerShortcut
--   -- StealInputFocus


--# assume math.clamp: function(number, number, number)

--# assume CA_UIC.TextDimensions: method() --> (number, number, number)
--# assume CA_UIC.SetProperty: method(key: string, value: string)


--# assume CM.move_character: method(char_cqi: CA_CQI, move_x: number, move_y: number, replenish_ap: boolean?, allow_post_movement: boolean?, success_callback: function?, failure_callback: function?)
--# assume CM.set_advice_enabled: method(advice_enabled: boolean?)
--# assume CM.show_advice: method(advice_key: string)
--# assume CM.modify_advice: method(boolean)
--# assume CM.pending_battle_cache_attacker_value: method() --> int
--# assume CM.pending_battle_cache_defender_value: method() --> int 

--# assume CA_EFFECT.tweaker_value: function(tweaker_key: string) --> number
--# assume CA_EFFECT.clear_advice_session_history: function()
--# assume CA_EFFECT.CharacterCharacterTargetAction: function()

--# assume CORE.get_or_create_component: method(key: string, template: string, parent: CA_UIC) --> CA_UIC
--# assume CORE.get_static_object: method(key: string) --> WHATEVER
--# assume CORE.is_battle: method() --> boolean 
--# assume CORE.is_frontend: method() --> boolean

-- POOLED RESOURCE FACTOR LIST
--# assume CA_POOLED_FACTOR_LIST.is_empty: method() --> boolean
--# assume CA_POOLED_FACTOR_LIST.item_at: method(index: number) --> CA_POOLED_FACTOR
--# assume CA_POOLED_FACTOR_LIST.num_items: method() --> number

-- POOLED RESOURCE FACTOR
--# assume CA_POOLED_FACTOR.value: method() --> number
--# assume CA_POOLED_FACTOR.maximum_value: method() --> number
--# assume CA_POOLED_FACTOR.minimum_value: method() --> number

-- GLOBAL FUNCTIONS
-- COMMON
--# assume global is_nil: function(arg: any) --> boolean

-- CAMPAIGN
--# assume global get_tm: function() --> CA_TIMER_MANAGER

--SaB
--[[
new
cm:add_agent_experience_through_family_member(FAMILY_MEMBER_SCRIPT_INTERFACE character, number points)
cm:move_to_queued(string character lookup, number x, number y)
cm:attack_queued(string character lookup, string target character lookup, boolean lay siege)
cm:set_army_trespass_disabled(boolean should disable)
cm:change_custom_faction_name(string faction key, string name)
cm:change_custom_settlement_name(SETTLEMENT_SCRIPT_INTERFACE settlement, string name key)
cm:change_localised_settlement_name(SETTLEMENT_SCRIPT_INTERFACE settlement, string name)
cm:change_custom_region_name(REGION_SCRIPT_INTERFACE region, string name key)
cm:change_localised_region_name(REGION_SCRIPT_INTERFACE region, string name)
cm:change_custom_unit_name(UNIT_SCRIPT_INTERFACE unit, string name key)
cm:change_localised_unit_name(UNIT_SCRIPT_INTERFACE unit, string name)
cm:create_new_ritual_setup(FACTION_SCRIPT_INTERFACE performing faction, string ritual key)
cm:perform_ritual_with_setup(RITUAL_SETUP_SCRIPT_INTERFACE interface ritual setup)
cm:lock_ritual(FACTION_SCRIPT_INTERFACE faction, string ritual key)
cm:unlock_ritual(FACTION_SCRIPT_INTERFACE faction, string ritual key, number duration)
cm:lock_ritual_chain(FACTION_SCRIPT_INTERFACE faction, string ritual_chain_key)
cm:unlock_ritual_chain(FACTION_SCRIPT_INTERFACE faction, string ritual chain key, number duration)
cm:lock_rituals_in_category(FACTION_SCRIPT_INTERFACE faction, string ritual_category_key)
cm:unlock_rituals_in_category(
  FACTION_SCRIPT_INTERFACE faction,
  string ritual_category_key,
  number duration
)
cm:apply_active_ritual(FACTION_SCRIPT_INTERFACE faction, ACTIVE_RITUAL_SCRIPT_INTERFACE ritual)
cm:apply_active_rituals(FACTION_SCRIPT_INTERFACE faction)
cm:spawn_plague_at_settlement(SETTLEMENT_SCRIPT_INTERFACE settlement, string plague key)
cm:spawn_plague_at_region(REGION_SCRIPT_INTERFACE region, string plague key)
cm:spawn_plague_at_military_force(MILITARY_FORCE_SCRIPT_INTERFACE military force, string plague key)
cm:set_unit_hp_to_unary_of_maximum(UNIT_SCRIPT_INTERFACE unit, number unary hp)
campaign_manager:get_border_regions_of_faction(
  faction faction,
  boolean outside_border True returns regions bordering the faction that do not belong to the faction,
  [boolean return_unique_list]
)
campaign_manager:get_factions_that_border_faction(faction faction, [boolean return_unique_list])
campaign_manager:get_regions_within_distance_of_character(
  character character interface,
  number distance,
  boolean not razed,
  [boolean return_unique_list]
)
random_army_manager:set_faction(force_key, faction_key)
math.normalize(value, vmin, vmax)

kill_faction(faction_key)
unique_table:new()
unique_table:insert(item)
unique_table:remove(item)
unique_table:contains(item)
unique_table:index_of(item)
unique_table:to_table()
unique_table:table_to_unique_table(tab)
unique_table:faction_list_to_unique_table(faction_list, cqi_list)
unique_table:character_list_to_unique_table(character_list)
unique_table:region_list_to_unique_table(region_list, cqi_list)

Changed:
cm:add_unit_to_faction_mercenary_pool(
  FACTION_SCRIPT_INTERFACE faction,
  string unit,
  number count,
  number replenishment chance,
  number max units,
  number max per turn,
  number xp,
  string faction restriction,
  string subculture restriction,
  string tech restriction,
  boolean partial replenishment
)

Removed:
set_ritual_unlocked
set_ritual_chain_unlocked
--]]


-- The Total WAAAGH! Update
--function cutscene:new_from_cindyscene(name, players_army, end_callback, cindy_scene, blend_in_duration, blend_out_duration)
--function cutscene:add_cinematic_trigger_listener(id, callback)
--function campaign_cutscene:new(name, length, end_callback, send_metrics_data) <- function campaign_cutscene:new(name, length, end_callback)
--function campaign_cutscene:new_from_cindyscene(name, end_callback, cindy_scene, blend_in_duration, blend_out_duration, send_metrics_data)
--function campaign_manager:are_any_factions_human(faction_list, tolerate_errors)
--function campaign_manager:progress_on_advice_finished_poll(callback, playtime, use_os_clock, count) <- function campaign_manager:progress_on_advice_finished_poll(callback, delay, playtime, use_os_clock, count)
-- deleted: function campaign_manager:call_if_no_exceptions_human(callback, exception_list)
--function find_uicomponent(...) <- function find_uicomponent(parent, ...)
-- new: function core_object:svr_save_persistent_bool(name, value)
-- new: function core_object:svr_load_persistent_bool(name)
-- new: function core_object:svr_save_persistent_string(name, value)
-- new: function core_object:svr_load_persistent_bool(name) <- should be "svr_load_persistent_string"
--function core_object:clean_listeners(eventname) <- function core_object:clean_listeners()
--function core_object:remove_listener(name_to_remove) <- function core_object:remove_listener(name_to_remove, start_point)
-- new: function core_object:trigger_custom_event(event, context_data)
--function core_object:get_unique_counter(classification) <- function core_object:get_unique_counter()
--function core_object:check_bit(test_value, bit_position) <- function check_bit(test_value, bit_position)
--function core_object:add_static_object(name, object, classification, overwrite) <- function core_object:add_static_object(name, object, overwrite)
--function core_object:get_static_object(name, classification) <- function core_object:get_static_object(name)
-- new: function custom_context:add_data_with_key(value, function_name)
--function help_page:set_record_state(uic, record, state) <- function help_page:set_record_state(uic, record, state, make_active)
-- new: function string.starts_with(input, start_str, ignore_case)
-- new: function string.ends_with(input, end_str, ignore_case)
-- new: function math.ceilTo(value, multiplier)
-- new: function math.clamp(value, minv, maxv)
-- new: function math.floorTo(value, nearest)
-- new: function math.normalize(value, vmin, vmax)
--function start_early_game_public_order_mission_listener(advice_key, infotext, mission_key, mission_issuer, region_key, mission_rewards, disregard_first_turn_flag) <- function start_early_game_public_order_mission_listener(advice_key, infotext, mission_key, mission_issuer, region_key, mission_rewards)
-- new: function confed_missions:setup()
-- new: function confed_missions:generate_mission_listener(confed_mission)
-- new: function confed_missions:generate_dilemma_listener(confed_mission)
-- new: function confed_missions:disable_cai_targeting_against_faction_capital(confed_mission)
-- new: function confed_missions:enable_cai_targeting_against_faction_capital(confed_mission)
-- new: function confed_missions:disable_diplomatic_confed(confed_mission)
-- new: function confed_missions:enable_diplomatic_confed(confed_mission)
-- new: function qbh:setup_qb_effect_bundle_listener(effect_bundle_key,set_piece_battle_key,condition,opt_side) 
-- new: function rite_agent_spawn(faction_key, type_key, subtype_key)
-- deleted: function malus_rite_agent_spawn(faction_key, type_key, subtype_key)

--# assume global kill_faction: function(faction_key: string)

-- GLOBAL VARIABLES
--leave at the bottom of this file
--# assume global cm: CM
--# assume global core: CORE
--# assume global effect: CA_EFFECT
--# assume global events: CA_EVENTS
--# assume global __write_output_to_logfile: boolean
--# assume global mission_manager: MISSION_MANAGER
--# assume global rite_unlock: RITE_UNLOCK
--# assume global ll_unlock: LL_UNLOCK
--# assume global random_army_manager: RAM
--# assume global campaign_cutscene: CA_CUTSCENE
--# assume global invasion_manager: INVASION_MANAGER
--# assume global CampaignUI: CA_CampaignUI
--# assume global vfs: CA_VFS
--# assume global chapter_mission: CA_CHAPTER_MISSION
--# assume global intervention: CA_INTERVENTION
--# assume global faction_start: CA_FACTION_START
--# assume global timer_manager: CA_TIMER_MANAGER

--# assume global empire_battle: EMPIRE_BATTLE
--# assume global battle_manager: CA_BATTLE_MANAGER
--# assume global generated_battle: CA_GENERATED_BATTLE
--# assume global generated_cutscene: CA_GENERATED_CUTSCENE

--# assume global __logfile_path: string

--string extensions

--- New commands and methods and interface for changing and reading a military force's type (between normal/horde/etc):
--cm:convert_force_to_type()
--force_interface:force_type()
--force_type_interface:key()
--force_type_interface:has_feature()
--force_type_interface:can_convert_to_type()
--force_type_interface:can_automatically_convert_to_type()
--- There is much more exposure of effects to Lua now. It's easier to read what effects are currently affecting a region, character, faction, province, and military force.
--
--CHANGED/FIXED:
--- Fundamental change to the __write_output_to_file boolean. In order to get script logs to output, you just have to put a file in `script` called `enable_console_logging`, and put any text within the file.


-- Da Nutz ‘N’ Boltz Update

--- @function pending_battle_cache_get_attacker_subtype
--- @desc Returns just the subtype of a particular attacker in the cached pending battle. The attacker is specified by numerical index, with the first being accessible at record 1.
--- @p @number index of attacker
--- @return @string subtype
--function campaign_manager:pending_battle_cache_get_attacker_subtype(index)

--- @function pending_battle_cache_get_defender_subtype
--- @desc Returns just the subtype of a particular defender in the cached pending battle. The defender is specified by numerical index, with the first being accessible at record 1.
--- @p @number index of defender
--- @return @string subtype
--function campaign_manager:pending_battle_cache_get_defender_subtype(index)