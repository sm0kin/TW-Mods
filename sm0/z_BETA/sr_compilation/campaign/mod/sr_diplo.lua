local function sr_diplo()
    local sr_diplo_bundles = {
        ["wh_main_emp_empire"] = "sr_emp_bundle",
        ["wh_main_dwf_dwarfs"] = "sr_dwf_bundle",
        ["wh2_main_hef_high_elves"] = "sr_helf_bundle",
        ["wh_main_brt_bretonnia"] = "sr_brt_bundle",
        ["wh_dlc05_wef_wood_elves"] = "sr_welf_bundle",
        ["wh2_main_skv_skaven"] = "sr_skv_bundle",
        ["wh2_main_lzd_lizardmen"] = "sr_liz_bundle",
        ["wh2_dlc11_cst_vampire_coast"] = "sr_cst_bundle",
        ["wh2_dlc09_tmb_tomb_kings"] = "sr_tmb_bundle",
        ["wh_main_vmp_vampire_counts"] = "sr_vmp_bundle",
        ["wh_main_grn_greenskins"] = "sr_grn_bundle",
        ["wh_main_chs_chaos"] = "sr_chs_bundle",
        ["wh_dlc08_nor_norsca"] = "sr_nor_bundle",
        ["wh_dlc03_bst_beastmen"] = "sr_bst_bundle",
        ["wh2_main_rogue"] = "sr_rog_bundle"
    }

    core:add_listener(
        "sr_diplo_listener",
        "DiplomaticOfferRejected",
        true,
        function(context)
            cm:apply_effect_bundle(sr_diplo_bundles[context:proposer():culture()], context:recipient():name(), 7)
        end,
        true
    )
end

local mcm = _G.mcm

if not not mcm then
	local ovn = nil;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local diplo = ovn:add_tweaker("diplo", "Diplomacy Rejection Consequences", "")
	diplo:add_option("enable", "Enable", "")
	diplo:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_diplo_value") == "enable" then
                sr_diplo()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_diplo_value") == "enable" then sr_diplo() end
	end
)