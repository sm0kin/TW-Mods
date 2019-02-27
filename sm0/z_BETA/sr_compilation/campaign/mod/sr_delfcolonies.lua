local function sr_delfcolonies()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh2_main_northern_jungle_of_pahualaxa_shrine_of_sotek", "wh2_main_def_ssildra_tor")
			cm:transfer_region_to_faction("wh2_main_nagarythe_tor_dranil", "wh2_main_def_naggarond")
			cm:transfer_region_to_faction("wh2_main_crater_of_the_walking_dead_doom_glade", "wh2_main_def_har_ganeth")
			cm:transfer_region_to_faction("wh2_main_aghol_wastelands_palace_of_princes", "wh2_main_def_cult_of_pleasure")

			cm:instantly_upgrade_building("wh2_main_crater_of_the_walking_dead_doom_glade:0", "wh2_main_def_settlement_minor_2")
			cm:instantly_upgrade_building("wh2_main_aghol_wastelands_palace_of_princes:1", "wh2_main_def_pleasure_cult_1")

			cm:create_force(
				"wh2_main_def_ssildra_tor",
				"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_inf_darkshards_1",
				"wh2_main_land_of_the_dead_zandri",
				26,
				248,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_main_def_naggarond",
				"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_darkshards_1",
				"wh2_main_land_of_the_dead_zandri",
				160,
				400,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_main_def_har_ganeth",
				"wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_inf_darkshards_1",
				"wh2_main_land_of_the_dead_zandri",
				854,
				90,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_main_def_cult_of_pleasure",
				"wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_cav_chaos_knights_0,wh2_main_def_inf_witch_elves_0,wh_main_chs_inf_chaos_warriors_0",
				"wh2_main_land_of_the_dead_zandri",
				386,
				700,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:force_declare_war("wh2_main_def_cult_of_pleasure", "wh_dlc08_nor_helspire_tribe", false, false)
			cm:force_make_vassal("wh2_main_def_cult_of_pleasure", "wh2_main_nor_aghol")
		end
	end
end

local mcm = _G.mcm

if not not mcm then
	local ovn = nil;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local delfcolonies = ovn:add_tweaker("delfcolonies", "Dark Elf Outposts", "")
	delfcolonies:add_option("enable", "Enable", "")
	delfcolonies:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_delfcolonies_value") == "enable" then
				sr_delfcolonies()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_delfcolonies_value") == "enable" then sr_delfcolonies() end
	end
)