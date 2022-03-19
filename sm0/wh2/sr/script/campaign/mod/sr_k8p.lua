local function sr_k8p()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:teleport_to("faction:wh_main_grn_red_fangs,forename:2147344615", 688, 222, true)
			cm:teleport_to("faction:wh_main_grn_necksnappers,forename:2147344849", 720, 235, true)
			cm:force_declare_war("wh_main_dwf_karak_izor", "wh2_main_skv_clan_mors", false, false)
			cm:force_declare_war("wh_main_grn_crooked_moon", "wh2_main_skv_clan_mors", false, false)

			cm:transfer_region_to_faction("wh_main_eastern_badlands_crooked_fang_fort", "wh_main_grn_necksnappers")

			if cm:get_faction("wh_main_dwf_karak_izor"):is_human() then
				if 1 == cm:random_number(2, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_grn_crooked_moon")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				else
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_grn_crooked_moon")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_dwf_karak_izor")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				end
			elseif cm:get_faction("wh2_main_skv_clan_mors"):is_human() then
				if 1 == cm:random_number(2, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_grn_crooked_moon")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh2_main_skv_clan_mors")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				else
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_grn_crooked_moon")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				end
			elseif cm:get_faction("wh_main_grn_crooked_moon"):is_human() then
				if 1 == cm:random_number(2, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_grn_crooked_moon")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				else
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_grn_crooked_moon")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh2_main_skv_clan_mors")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				end
			end

			---NON PLAYER SCRIPT

			if
				not cm:get_faction("wh_main_grn_crooked_moon"):is_human() and
					not cm:get_faction("wh2_main_skv_clan_mors"):is_human() and
					not cm:get_faction("wh_main_dwf_karak_izor"):is_human()
			 then
				if 1 == cm:random_number(6, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_grn_crooked_moon")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				elseif 2 == cm:random_number(6, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_grn_crooked_moon")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_dwf_karak_izor")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				elseif 3 == cm:random_number(6, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_grn_crooked_moon")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh2_main_skv_clan_mors")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				elseif 4 == cm:random_number(6, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_grn_crooked_moon")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				elseif 5 == cm:random_number(6, 1) then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh2_main_skv_clan_mors")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh_main_grn_crooked_moon")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				else
					cm:transfer_region_to_faction("wh_main_eastern_badlands_valayas_sorrow", "wh_main_grn_crooked_moon")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_dwf_karak_izor")
					cm:transfer_region_to_faction("wh_main_eastern_badlands_dringorackaz", "wh2_main_skv_clan_mors")

					cm:create_force(
						"wh_main_dwf_karak_izor",
						"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						723,
						266,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh_main_grn_crooked_moon",
						"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_goblin_wolf_riders_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						700,
						260,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)

					cm:create_force(
						"wh2_main_skv_clan_mors",
						"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						744,
						241,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				end
			end

			local dringo_region = cm:get_region("wh_main_eastern_badlands_dringorackaz")
			local val_region = cm:get_region("wh_main_eastern_badlands_valayas_sorrow")

			cm:instantly_set_settlement_primary_slot_level(dringo_region:settlement(), 3)
			cm:instantly_set_settlement_primary_slot_level(val_region:settlement(), 3)

			if val_region:owning_faction():name() == "wh2_main_skv_clan_mors" then
				cm:region_slot_instantly_upgrade_building(
					val_region:settlement():active_secondary_slots():item_at(2),
					"wh2_main_skv_defence_minor_2"
				)
			elseif val_region:owning_faction():name() == "wh_main_grn_crooked_moon" then
				cm:region_slot_instantly_upgrade_building(
					val_region:settlement():active_secondary_slots():item_at(2),
					"wh_dlc06_grn_garrison_2_skarsnik"
				)
			elseif val_region:owning_faction():name() == "wh_main_dwf_karak_izor" then
				cm:region_slot_instantly_upgrade_building(
					val_region:settlement():active_secondary_slots():item_at(2),
					"wh_main_dwf_garrison_2"
				)
			end

			if dringo_region:owning_faction():name() == "wh2_main_skv_clan_mors" then
				cm:region_slot_instantly_upgrade_building(
					dringo_region:settlement():active_secondary_slots():item_at(2),
					"wh2_main_skv_defence_minor_2"
				)
			elseif dringo_region:owning_faction():name() == "wh_main_grn_crooked_moon" then
				cm:region_slot_instantly_upgrade_building(
					dringo_region:settlement():active_secondary_slots():item_at(2),
					"wh_dlc06_grn_garrison_2_skarsnik"
				)
			elseif dringo_region:owning_faction():name() == "wh_main_dwf_karak_izor" then
				cm:region_slot_instantly_upgrade_building(
					dringo_region:settlement():active_secondary_slots():item_at(2),
					"wh_main_dwf_garrison_2"
				)
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
	local k8p =
		ovn:add_tweaker(
		"k8p",
		"War for Karak Eight Peaks",
		"Gives Clan Mors, Crooked Mood and Clan Angrund a random settlement around Karak Eight Peaks"
	)
	k8p:add_option("enable", "Enable", "")
	k8p:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_k8p_value") == "enable" then
				sr_k8p()
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
			local k8p = sr:get_option_by_key("k8p")
			k8p:set_read_only(true)
			k8p_setting = k8p:get_finalized_setting()
			if enable_setting and k8p_setting then 
				sr_k8p()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_k8p_value") == "enable" then
			sr_k8p()
		end
	end
)
