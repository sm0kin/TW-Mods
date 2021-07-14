local missing_anc = {
	{["faction"] = "wh2_main_hef_avelorn", ["subtype"] = "wh2_dlc10_hef_alarielle", ["key"] = "wh2_dlc10_anc_magic_standard_banner_of_avelorn"},
	{["faction"] = "wh2_main_hef_avelorn", ["subtype"] = "wh2_dlc10_hef_alarielle", ["key"] = "wh2_dlc10_anc_arcane_item_stave_of_avelorn"},
	{["faction"] = "wh2_main_skv_clan_skyre", ["subtype"] = "wh2_dlc12_skv_ikit_claw", ["key"] = "wh2_dlc12_anc_armour_iron_frame"},
	{["faction"] = "wh_main_grn_crooked_moon", ["subtype"] = "dlc06_grn_skarsnik", ["key"] = "wh_dlc06_anc_magic_standard_skarsniks_boyz"},
	{["faction"] = "wh2_dlc12_lzd_cult_of_sotek", ["subtype"] = "wh2_dlc12_lzd_tehenhauin", ["key"] = "wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue"},
	{["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_grimgor_ironhide", ["key"] = "wh_main_anc_magic_standard_da_immortulz"},
	{["faction"] = "wh2_main_hef_eataine", ["subtype"] = "wh2_main_hef_prince_alastar", ["key"] = "wh2_main_anc_armour_lions_pelt"},
	{["faction"] = "wh_main_emp_middenland", ["subtype"] = "dlc03_emp_boris_todbringer", ["key"] = "wh_main_anc_talisman_the_white_cloak_of_ulric"},
	{["faction"] = "wh2_main_hef_nagarythe", ["subtype"] = "wh2_dlc10_hef_alith_anar", ["key"] = "wh2_dlc10_anc_talisman_stone_of_midnight"},
	{["faction"] = "wh2_dlc11_vmp_the_barrow_legion", ["subtype"] = "vmp_heinrich_kemmler", ["key"] = "wh2_dlc11_anc_follower_vmp_the_ravenous_dead"},
	{["faction"] = "wh2_main_lzd_tlaqua", ["subtype"] = "wh2_dlc12_lzd_tiktaqto", ["key"] = "wh2_dlc12_anc_weapon_the_blade_of_ancient_skies"},
	{["faction"] = "wh2_dlc11_cst_vampire_coast", ["subtype"] = "wh2_dlc11_cst_harkon", ["key"] = "wh2_dlc11_anc_follower_captain_drekla"}
} --:vector<map<string, string>>

function sm0_missing_anc()
	-- this method won't add the item before the factions turn (important for ai)
	--core:add_listener(
	--	"sm0_missing_anc_CharacterTurnStart",
	--	"CharacterTurnStart",
	--	function(context)
	--		return context:character():character_subtype("wh2_dlc13_lzd_gor_rok") and context:character():rank() >= 1 
	--		and not cm:model():world():ancillary_exists("wh2_dlc13_anc_weapon_mace_of_ulumak")
	--	end,
	--	function(context)
	--		cm:force_add_ancillary(context:character(), "wh2_dlc13_anc_weapon_mace_of_ulumak", true, true)
	--	end,
	--	false
	--)

	-- this method is better because it behaves the same way starting items are added to Tehenhauin and Tiktaq'to
	core:add_listener(
		"sm0_missing_anc_FactionTurnStart",
		"FactionTurnStart",
		true,
		function(context)
			for _, anc in ipairs(missing_anc) do
				if not cm:model():world():ancillary_exists(anc.key) then
					local faction = cm:get_faction(anc.faction)
					local not_found = true
					if faction then
						local character_list = faction:character_list()
						for i = 0, character_list:num_items() - 1 do
							local character = character_list:item_at(i)
							if character:character_subtype(anc.subtype) and character:rank() >= 1 then
								cm:force_add_ancillary(character, anc.key, true, true)
								not_found = false
								break
							end
						end
						if not_found then
							local faction_list = faction:factions_of_same_subculture()
							for i = 0, faction_list:num_items() - 1 do
								local subc_faction = faction_list:item_at(i)
								local character_list = subc_faction:character_list()
								for j = 0, character_list:num_items() - 1 do
									local character = character_list:item_at(j)
									if character:character_subtype(anc.subtype) and character:rank() >= 1 then
										cm:force_add_ancillary(character, anc.key, true, true)
										break
									end
								end
							end
						end
					end
				end
			end
		end,
		true
	)
end