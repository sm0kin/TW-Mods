-------------------------------------------------------
--- SCRIPT LAUNCHER MIXU LOST
--- Execution of the Script on campaign start CREATED BY MIXU AND LOST.
-------------------------------------------------------

--[[cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = 
function(context)
	enforest_launch();
	return true;
end;

function enforest_launch()
	enforest_setup();
end;]]

-------------------------------------------------------
--- CAMPAIGN SETUP MIXU LOST
--- The order of events leading up to completion of the scripts functions CREATED BY MIXU AND LOST.
-------------------------------------------------------

local enforest_new_forces = {
	enforest_rakarth = {
		["faction"] = "wh2_main_def_clar_karond",
		["agent_subtype"] = "def_rakarth",
		["forename"] = "names_name_555530640",
		["family_name"] = "names_name_555530641",
		["faction_leader"] = true,
		["force"] = "wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_cav_dark_riders_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_dark_riders_1,wh2_main_def_mon_war_hydra",
		x = 83,
		y = 537
	},
	enforest_malida = {
		["faction"] = "wh2_main_def_karond_kar",
		["agent_subtype"] = "def_hag_queen_malida",
		["forename"] = "names_name_555530644",
		["family_name"] = "names_name_555530645",
		["faction_leader"] = true,
		["force"] = "wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_harpies,wh2_main_def_inf_harpies,wh2_main_def_inf_darkshards_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_darkshards_0",
		x = 244,
		y = 610
	},
	enforest_alrik = {
		["faction"] = "wh_main_dwf_karak_hirn",
		["agent_subtype"] = "dwf_alrik_ranulfsson",
		["forename"] = "names_name_555530652",
		["family_name"] = "names_name_555530653",
		["faction_leader"] = true,
		["force"] = "wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_dwarf_warrior_1,wh_main_dwf_inf_longbeards_1,wh_main_dwf_inf_dwarf_warrior_1,wh_main_dwf_inf_longbeards_1",
		x = 565,
		y = 349
	},
	enforest_byrrnoth = {
		["faction"] = "wh_main_dwf_barak_varr",
		["agent_subtype"] = "dwf_byrrnoth_grundadrakk",
		["forename"] = "names_name_555530648",
		["family_name"] = "names_name_555530649",
		["faction_leader"] = true,
		["force"] = "wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_thunderers_0,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_art_cannon",
		x = 645,
		y = 322
	},
	enforest_rorek = {
		["faction"] = "wh_main_dwf_karak_ziflin",
		["agent_subtype"] = "dwf_rorek_granitehand",
		["forename"] = "names_name_555530650",
		["family_name"] = "names_name_555530651",
		["faction_leader"] = true,
		["force"] = "wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_ironbreakers,wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_0,wh_main_dwf_inf_longbeards,wh_main_dwf_art_grudge_thrower",
		x = 443,
		y = 420
	},
	enforest_gorbad = {
		["faction"] = "wh_main_grn_teef_snatchaz",
		["agent_subtype"] = "grn_gorbad_ironclaw",
		["forename"] = "names_name_555530654",
		["family_name"] = "names_name_555530655",
		["faction_leader"] = true,
		["force"] = "wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boy_big_uns,wh_main_grn_cav_orc_boar_boy_big_uns,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_inf_orc_big_uns",
		x = 615,
		y = 240
	},
	moon_sven_hasselfriesian = {
		["faction"] = "wh2_main_dwf_spine_of_sotek_dwarfs",
		["agent_subtype"] = "dwf_sven_hasselfriesian",
		["forename"] = "names_name_769673340",
		["family_name"] = "names_name_769673341",
		["faction_leader"] = true,
		["force"] = "wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_miners_1,wh_main_dwf_art_grudge_thrower,wh_main_dwf_art_grudge_thrower,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_miners_1",
		x = 73,
		y = 48
	},
	moon_barundin_stoneheart = {
		["faction"] = "wh_main_dwf_zhufbar",
		["agent_subtype"] = "dwf_barundin_stoneheart",
		["forename"] = "names_name_769673342",
		["family_name"] = "names_name_769673343",
		["faction_leader"] = true,
		["force"] = "wh_main_dwf_inf_miners_1,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_thunderers_0,wh_main_dwf_art_flame_cannon,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_thunderers_0",
		x = 705,
		y = 406
	},
	moon_brokk_ironpick = {
		["faction"] = "wh_main_dwf_karak_norn",
		["agent_subtype"] = "dwf_brokk_ironpick",
		["forename"] = "names_name_769673344",
		["family_name"] = "names_name_769673345",
		["faction_leader"] = true,
		["force"] = "wh_main_dwf_inf_miners_1,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_irondrakes_0,wh_main_dwf_art_flame_cannon,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_dwarf_warrior_0,wh_main_dwf_inf_dwarf_warrior_0",
		x = 509,
		y = 379
	}
}

local function enforest_spawn_new_forces()

	local region = "wh2_main_the_road_of_skulls_har_ganeth"

	local i = 0.1
	for _, data in pairs(enforest_new_forces) do
		if data then
			cm:callback(function()
				cm:create_force_with_general(
					data.faction,
					data.force,
					region,
					data.x,
					data.y,
					"general",
					data.agent_subtype,
					data.forename,
					"",
					data.family_name,
					"",
					data.faction_leader,
					function(cqi)
						local char_str = "character_cqi:"..cqi
						cm:set_character_immortality(char_str, true)
					end
				)
			end, i)

			i = i + 0.1
		end
	end
end

local murdered = {}

local function enforest_kill_people()
	for i = 1, #murdered do
		local cqi = murdered[i]
		local str = "character_cqi:"..cqi

		cm:set_character_immortality(str, false)
		cm:kill_character_and_commanded_unit(str, true, false)
	end
end

--- Selection of the Vanilla faction leaders which are then removed from the campaign map CREATED BY MIXU AND LOST.
local function enforest_kill()
	out("enforest is starting assassination plots")
	local clar_karond = cm:model():world():faction_by_key("wh2_main_def_clar_karond");
	local karak_hirn = cm:model():world():faction_by_key("wh_main_dwf_karak_hirn");
	local barak_varr = cm:model():world():faction_by_key("wh_main_dwf_barak_varr");
	local karak_ziflin = cm:model():world():faction_by_key("wh_main_dwf_karak_ziflin");
	local teef_snatchaz = cm:model():world():faction_by_key("wh_main_grn_teef_snatchaz");
	local zhufbar = cm:model():world():faction_by_key("wh_main_dwf_zhufbar");
	local karak_norn = cm:model():world():faction_by_key("wh_main_dwf_karak_norn");
	local spine_of_sotek_dwarfs = cm:model():world():faction_by_key("wh2_main_dwf_spine_of_sotek_dwarfs");
	local karond_kar = cm:model():world():faction_by_key("wh2_main_def_karond_kar");
	
	murdered[#murdered+1] = clar_karond:faction_leader():command_queue_index();
	murdered[#murdered+1] = karak_hirn:faction_leader():command_queue_index();
	murdered[#murdered+1] = barak_varr:faction_leader():command_queue_index();
	murdered[#murdered+1] = karak_ziflin:faction_leader():command_queue_index();
	murdered[#murdered+1] = teef_snatchaz:faction_leader():command_queue_index();
	murdered[#murdered+1] = zhufbar:faction_leader():command_queue_index();
	murdered[#murdered+1] = karak_norn:faction_leader():command_queue_index();
	murdered[#murdered+1] = spine_of_sotek_dwarfs:faction_leader():command_queue_index();
	murdered[#murdered+1] = karond_kar:faction_leader():command_queue_index();

	--[[cm:force_add_trait(cm:char_lookup_str(clar_karond_leader), "parte_trait_name_dummy_clar_karond_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(karak_hirn_leader), "parte_trait_name_dummy_karak_hirn_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(barak_varr_leader), "parte_trait_name_dummy_barak_varr_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(karak_ziflin_leader), "parte_trait_name_dummy_karak_ziflin_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(teef_snatchaz_leader), "parte_trait_name_dummy_snatchaz_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(zhufbar_leader), "moon_trait_name_dummy_zhufbar_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(karak_norn_leader), "moon_trait_name_dummy_karak_norn_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(spine_of_sotek_dwarfs_leader), "moon_trait_name_dummy_spine_of_sotek_dwarfs_hidden", true);
	cm:force_add_trait(cm:char_lookup_str(karond_kar_leader), "parte_trait_name_dummy_karond_kar_hidden", true);
	cm:set_character_immortality(cm:char_lookup_str(clar_karond_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(karak_hirn_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(barak_varr_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(karak_ziflin_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(teef_snatchaz_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(zhufbar_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(karak_norn_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(spine_of_sotek_dwarfs_leader), false);
	cm:set_character_immortality(cm:char_lookup_str(karond_kar_leader), false);
	cm:kill_character(clar_karond_leader, true, true);
	cm:kill_character(karak_hirn_leader, true, true);
	cm:kill_character(barak_varr_leader, true, true);
	cm:kill_character(karak_ziflin_leader, true, true);
	cm:kill_character(teef_snatchaz_leader, true, true);
	cm:kill_character(zhufbar_leader, true, true);
	cm:kill_character(karak_norn_leader, true, true)
	cm:kill_character(spine_of_sotek_dwarfs_leader, true, true)
	cm:kill_character(karond_kar_leader, true, true)]]
end;

local function enforest_setup()
	out("enforest is selecting population zones")

	if cm:is_new_game() then
		cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
		if cm:model():campaign_name("main_warhammer") then
			enforest_kill()
			enforest_spawn_new_forces()
		end
		cm:callback(function()
			enforest_kill_people()
		end, 1.0)
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 2)
	end
end


-------------------------------------------------------
--- FACTION LEADER OBJECTS CREATED BY MIXU AND LOST
--- Information which is read by the Legendary Lord Generator CREATED BY MIXU AND LOST.
-------------------------------------------------------	

-------------------------------------------------------
--- LEGENDARY LORD GENERATOR MIXU LI
--- Reads the Faction Leader Objects when called and spawns the Legendary Lord on the campaign map CREATED BY MIXU AND LOST.
-------------------------------------------------------
--[[function enforest_ll_generator(char_details, x1, y1)
	out("enforest is creating fungus");

	local x = x1 or 0;
	local y = y1 or 0;


	cm:create_force_with_general(
		char_details["faction"],
		char_details["force"],
		region,
		x,
		y,
		"general",
		char_details["agent_subtype"],
		char_details["forename"],
		"",
		char_details["family_name"],
		"",
		char_details["faction_leader"],
		function(cqi)
			local char_str = cm:char_lookup_str(cqi);
			cm:set_character_immortality(char_str, true);
		end
	)
end]]


cm:add_first_tick_callback(function()
	enforest_setup()
end)