local function sr_vladcolony_local()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			if cm:get_faction("wh_main_vmp_schwartzhafen"):is_human() then
				cm:transfer_region_to_faction("wh2_main_devils_backbone_mahrak", "wh_main_vmp_schwartzhafen")
				cm:instantly_upgrade_building("wh2_main_devils_backbone_mahrak:0", "wh_main_vmp_settlement_minor_2")

				cm:create_force(
					"wh_main_vmp_schwartzhafen",
					"wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_dire_wolves,wh_main_vmp_inf_grave_guard_1,wh_main_vmp_mon_crypt_horrors",
					"wh2_main_deadwood_shagrath",
					815,
					145,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)

				cm:force_declare_war("wh_main_vmp_schwartzhafen", "wh2_main_vmp_the_silver_host", false, false)
			end
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
	local vladcolony = ovn:add_tweaker("vladcolony", "Von Carstein Empire", "")
	vladcolony:add_option("enable", "Enable", "")
	vladcolony:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_vladcolony_value") == "enable" then
				sr_vladcolony_local()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_vladcolony_value") == "enable" then sr_vladcolony_local() end
	end
)