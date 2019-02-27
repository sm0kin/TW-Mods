local function sr_orcwaagh()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh2_main_yvresse_elessaeli", "wh_main_grn_greenskins")
			cm:transfer_region_to_faction("wh2_main_the_black_flood_shroktak_mount", "wh_main_grn_orcs_of_the_bloody_hand")

			cm:create_force(
				"wh_main_grn_greenskins",
				"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				277,
				300,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh_main_grn_orcs_of_the_bloody_hand",
				"wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orc_big_uns,wh_main_grn_inf_savage_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_cav_goblin_wolf_riders_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				30,
				585,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:force_declare_war("wh2_main_hef_yvresse", "wh_main_grn_greenskins", true, true)
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
	local orcwaagh = ovn:add_tweaker("orcwaagh", "POiNty eAd WAAAGH!", "")
	orcwaagh:add_option("enable", "Enable", "")
	orcwaagh:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_orcwaagh_value") == "enable" then
				sr_orcwaagh()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_orcwaagh_value") == "enable" then sr_orcwaagh() end
	end
)