local function sr_tombking()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			if cm:get_faction("wh2_dlc09_tmb_exiles_of_nehek"):is_human() then
				cm:transfer_region_to_faction("wh_main_the_vaults_zarakzil", "wh2_dlc09_tmb_exiles_of_nehek")
				cm:create_force(
					"wh2_dlc09_tmb_exiles_of_nehek",
					"wh2_dlc09_tmb_mon_ushabti_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					512,
					266,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)

				cm:apply_effect_bundle("sr_raise_tmb_army_capacity", "wh2_dlc09_tmb_exiles_of_nehek", 0)
				cm:force_declare_war("wh2_dlc09_tmb_exiles_of_nehek", "wh_main_grn_broken_nose", false, false)
			else
				cm:transfer_region_to_faction("wh_main_the_vaults_zarakzil", "wh2_dlc09_tmb_khemri")
				cm:create_force(
					"wh2_dlc09_tmb_khemri",
					"wh2_dlc09_tmb_mon_ushabti_0,wh2_pro06_tmb_mon_bone_giant_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					512,
					266,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)

				cm:force_declare_war("wh2_dlc09_tmb_khemri", "wh_main_grn_broken_nose", false, false)
			end

			cm:transfer_region_to_faction("wh2_main_huahuan_desert_chamber_of_visions", "wh2_dlc09_tmb_lybaras")
			cm:transfer_region_to_faction("wh_main_desolation_of_nagash_spitepeak", "wh2_dlc09_tmb_followers_of_nagash")

			local spitepeak_region = cm:model():world():region_manager():region_by_key("wh_main_desolation_of_nagash_spitepeak")
			cm:instantly_set_settlement_primary_slot_level(spitepeak_region:settlement(), 3)
			cm:region_slot_instantly_upgrade_building(
				spitepeak_region:settlement():active_secondary_slots():item_at(2),
				"wh2_dlc09_tmb_defence_minor_2"
			)

			cm:apply_effect_bundle("sr_raise_tmb_army_capacity", "wh2_dlc09_tmb_lybaras", 0)
			cm:apply_effect_bundle("sr_raise_tmb_army_capacity", "wh2_dlc09_tmb_khemri", 0)
			cm:apply_effect_bundle("sr_raise_tmb_army_capacity", "wh2_dlc09_tmb_followers_of_nagash", 0)

			cm:create_force(
				"wh2_dlc09_tmb_lybaras",
				"wh2_dlc09_tmb_mon_sepulchral_stalkers_0,wh2_dlc09_tmb_cav_necropolis_knights_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				35,
				62,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force_with_general(
				"wh2_dlc09_tmb_followers_of_nagash",
				"wh2_dlc09_tmb_mon_ushabti_0,wh2_pro06_tmb_mon_bone_giant_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
				"wh2_main_land_of_assassins_sorcerers_islands",
				783,
				235,
				"general",
				"wh2_dlc09_tmb_tomb_king",
				"names_name_999982292",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:force_declare_war("wh2_dlc09_tmb_lybaras", "wh2_main_skv_clan_pestilens", false, false)
			cm:force_declare_war("wh2_dlc09_tmb_khemri", "wh_main_grn_broken_nose", false, false)
			cm:force_declare_war("wh2_dlc09_tmb_followers_of_nagash", "wh_main_dwf_karak_azul", false, false)
		end
	end
end

local mcm = _G.mcm
local mct = core:get_static_object("mod_configuration_tool")
if not (not mcm) and not mct then
	local ovn = nil
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn")
	else
		ovn = mcm:register_mod("ovn", "OvN - Second Start", "Let's you enable/disable various parts of the mod.")
	end
	local tombking =
		ovn:add_tweaker(
		"tombking",
		"Tomb King Colonies",
		"Gives major Tomb King factions a second settlement in exotic locations, see mod page for exact settlements"
	)
	tombking:add_option("enable", "Enable", "")
	tombking:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_tombking_value") == "enable" then
				sr_tombking()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if mct then
			local sr = mct:get_mod_by_key("sr")
			local enable = sr:get_option_by_key("enable")
			enable:set_read_only(true)
			enable_setting = enable:get_finalized_setting()
			local tombking = sr:get_option_by_key("tombking")
			tombking:set_read_only(true)
			tombking_setting = tombking:get_finalized_setting()
			if enable_setting and tombking_setting then 
				sr_tombking()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_tombking_value") == "enable" then
			sr_tombking()
		end
	end
)
