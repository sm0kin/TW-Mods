local function sr_vampcolony()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			if cm:get_faction("wh_main_vmp_schwartzhafen"):is_human() then
				cm:transfer_region_to_faction("wh2_main_devils_backbone_mahrak", "wh_main_vmp_schwartzhafen")

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
local mct = core:get_static_object("mod_configuration_tool")
if not (not mcm) and not mct then
	local ovn = nil
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn")
	else
		ovn = mcm:register_mod("ovn", "OvN - Second Start", "Let's you enable/disable various parts of the mod.")
	end
	local vladcolony =
		ovn:add_tweaker(
		"vladcolony",
		"Von Carstein Colony",
		"Gives Von Carstein a colony in Mahrak, Kingdom of Beasts (Only when player controlled)"
	)
	vladcolony:add_option("enable", "Enable", "")
	vladcolony:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_vladcolony_value") == "enable" then
				sr_vampcolony()
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
			local vampcolony = sr:get_option_by_key("vampcolony")
			vampcolony:set_read_only(true)
			vampcolony_setting = vampcolony:get_finalized_setting()
			if enable_setting and vampcolony_setting then 
				sr_vampcolony()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_vladcolony_value") == "enable" then
			sr_vampcolony()
		end
	end
)
