local ml_tables = {}

--# assume ml_tables.default_rule: string
ml_tables.default_rule = "TT 6th edition - The Fay Enchantress"
--[[
	Beastmen (7ed)
	page: 55
    MALAGOR, THE DARK OMEN
    
    MAGIC
	Malagor [...] uses spells from
	one of the following: the Lore of Wild, Lore of 
	Death, Lore of Shadow or Lore of the Beasts.
--]]

--# assume ml_tables.default_option: string
ml_tables.default_option = "Spells for free"

--# assume ml_tables.enableAllBundle: string
ml_tables.enableAllBundle = "wh2_sm0_effect_bundle_enable_all_malagor"

--# assume ml_tables.innateSpell: string
ml_tables.innateSpell = "Viletide"

--# assume ml_tables.lores: map<string, map<string, string>>
ml_tables.lores = {
	["Lore of Wild"] = {	
		["wh_dlc03_skill_magic_wild_bray_scream"] = "Bray-Scream",
		["wh_dlc03_skill_magic_wild_devolve"] = "Devolve",
		["wh_dlc03_skill_magic_wild_mantle_of_ghorok"] = "Mantle of Ghorok",
		["wh_dlc03_skill_magic_wild_savage_dominion"] = "Savage Dominion",
		["wh_dlc03_skill_magic_wild_traitor_kin"] = "Traitor-Kin",
		["wh_dlc03_skill_magic_wild_viletide"] = "Viletide"
	},
	["Lore of Beasts"] = {	
		["wh2_main_skill_magic_beasts_flock_of_doom_lord"] = "Flock of Doom",
		["wh2_main_skill_magic_beasts_panns_impenetrable_pelt_lord"] = "Pann's Impenetrable Pelt",
		["wh2_main_skill_magic_beasts_the_amber_spear_lord"] = "The Amber Spear",
		["wh2_main_skill_magic_beasts_the_curse_of_anraheir_lord"] = "The Curse of Anraheir",
		["wh2_main_skill_magic_beasts_transformation_of_kadon_lord"] = "Transformation of Kadon",
		["wh_dlc03_skill_magic_beasts_wyssans_wildform"] = "Wyssan's Wildform"
	},
	["Lore of Death"] = {	
		["wh2_main_skill_all_magic_death_02_aspect_of_the_dreadknight_lord"] = "Aspect of the Dread Knight",
		["wh2_main_skill_all_magic_death_05_doom_and_darkness_lord"] = "Doom & Darkness",
		["wh2_main_skill_all_magic_death_04_soulblight_lord"] = "Soulblight",
		["wh2_dlc11_skill_vmp_bloodline_necrarch_magic_spirit_leech"] = "Spirit Leech",
		["wh2_main_skill_all_magic_death_09_the_fate_of_bjuna_lord"] = "The Fate of Bjuna",
		["wh2_main_skill_all_magic_death_10_the_purple_sun_of_xereus_lord"] = "The Purple Sun of Xereus"
	},
	["Lore of Shadows"] = {	
		["wh_dlc05_skill_magic_shadow_mystifying_miasma"] = "Melkoth's Mystifying Miasma",
		["wh2_main_skill_magic_shadow_okkams_mindrazor_lord"] = "Okkam's Mindrazor",
		["wh2_main_skill_magic_shadow_pit_of_shades_lord"] = "Pit of Shades",
		["wh2_main_skill_magic_shadow_enfeebling_foe_lord"] = "The Enfeebling Foe",
		["wh2_main_skill_magic_shadow_penumbral_pendulum_lord"] = "The Penumbral Pendulum",
		["wh2_main_skill_magic_shadow_the_withering_lord"] = "The Withering"
	}	
}

--# assume ml_tables.has_skills: map<string, bool>
ml_tables.has_skills = {
	["wh2_sm0_skill_magic_spell_slot_1"] = false,
	["wh2_sm0_skill_magic_spell_slot_2"] = false,
	["wh2_sm0_skill_magic_spell_slot_3"] = false,
	["wh2_sm0_skill_magic_spell_slot_4"] = false,
	["wh2_sm0_skill_magic_spell_slot_5"] = false,
	["wh2_sm0_skill_magic_spell_slot_6"] = false
} 

--# assume ml_tables.skillnames: map<string, string>
ml_tables.skillnames = {
	["wh_dlc03_skill_magic_wild_bray_scream"] = "Bray-Scream",
	["wh_dlc03_skill_magic_wild_devolve"] = "Devolve",
	["wh_dlc03_skill_magic_wild_mantle_of_ghorok"] = "Mantle of Ghorok",
	["wh_dlc03_skill_magic_wild_savage_dominion"] = "Savage Dominion",
	["wh_dlc03_skill_magic_wild_traitor_kin"] = "Traitor-Kin",
	["wh_dlc03_skill_magic_wild_viletide"] = "Viletide",
	["wh2_main_skill_magic_beasts_flock_of_doom_lord"] = "Flock of Doom",
	["wh2_main_skill_magic_beasts_panns_impenetrable_pelt_lord"] = "Pann's Impenetrable Pelt",
	["wh2_main_skill_magic_beasts_the_amber_spear_lord"] = "The Amber Spear",
	["wh2_main_skill_magic_beasts_the_curse_of_anraheir_lord"] = "The Curse of Anraheir",
	["wh2_main_skill_magic_beasts_transformation_of_kadon_lord"] = "Transformation of Kadon",
	["wh_dlc03_skill_magic_beasts_wyssans_wildform"] = "Wyssan's Wildform",
	["wh2_main_skill_all_magic_death_02_aspect_of_the_dreadknight_lord"] = "Aspect of the Dread Knight",
	["wh2_main_skill_all_magic_death_05_doom_and_darkness_lord"] = "Doom & Darkness",
	["wh2_main_skill_all_magic_death_04_soulblight_lord"] = "Soulblight",
	["wh2_dlc11_skill_vmp_bloodline_necrarch_magic_spirit_leech"] = "Spirit Leech",
	["wh2_main_skill_all_magic_death_09_the_fate_of_bjuna_lord"] = "The Fate of Bjuna",
	["wh2_main_skill_all_magic_death_10_the_purple_sun_of_xereus_lord"] = "The Purple Sun of Xereus",
	["wh_dlc05_skill_magic_shadow_mystifying_miasma"] = "Melkoth's Mystifying Miasma",
	["wh2_main_skill_magic_shadow_okkams_mindrazor_lord"] = "Okkam's Mindrazor",
	["wh2_main_skill_magic_shadow_pit_of_shades_lord"] = "Pit of Shades",
	["wh2_main_skill_magic_shadow_enfeebling_foe_lord"] = "The Enfeebling Foe",
	["wh2_main_skill_magic_shadow_penumbral_pendulum_lord"] = "The Penumbral Pendulum",
	["wh2_main_skill_magic_shadow_the_withering_lord"] = "The Withering"
}

--# assume ml_tables.effectBundles: map<string,string>
ml_tables.effectBundles = {	
	["Bray-Scream"] = "wh2_sm0_effect_bundle_disable_wild_bray_scream",
	["Devolve"] = "wh2_sm0_effect_bundle_disable_wild_devolve",
	["Mantle of Ghorok"] = "wh2_sm0_effect_bundle_disable_wild_mantle_of_ghorok",
	["Savage Dominion"] = "wh2_sm0_effect_bundle_disable_wild_savage_dominion",
	["Traitor-Kin"] = "wh2_sm0_effect_bundle_disable_wild_traitor_kin",
	["Viletide"] = "wh2_sm0_effect_bundle_disable_wild_viletide",
	["Flock of Doom"] = "wh2_sm0_effect_bundle_disable_beasts_flock_of_doom",
	["Pann's Impenetrable Pelt"] = "wh2_sm0_effect_bundle_disable_beasts_panns_impenetrable_pelt",
	["The Amber Spear"] = "wh2_sm0_effect_bundle_disable_beasts_the_amber_spear",
	["The Curse of Anraheir"] = "wh2_sm0_effect_bundle_disable_beasts_the_curse_of_anraheir",
	["Transformation of Kadon"] = "wh2_sm0_effect_bundle_disable_beasts_transformation_of_kadon",
	["Wyssan's Wildform"] = "wh2_sm0_effect_bundle_disable_beasts_wyssans_wildform",
	["Aspect of the Dread Knight"] = "wh2_sm0_effect_bundle_disable_death_aspect_of_the_dreadknight",
	["Doom & Darkness"] = "wh2_sm0_effect_bundle_disable_death_doom_and_darkness",
	["Soulblight"] = "wh2_sm0_effect_bundle_disable_death_soulblight",
	["Spirit Leech"] = "wh2_sm0_effect_bundle_disable_death_spirit_leech",
	["The Fate of Bjuna"] = "wh2_sm0_effect_bundle_disable_death_the_fate_of_bjuna",
	["The Purple Sun of Xereus"] = "wh2_sm0_effect_bundle_disable_death_the_purple_sun_of_xereus",
	["Melkoth's Mystifying Miasma"] = "wh2_sm0_effect_bundle_disable_shadows_melkoths_mystifying_miasma",
	["Okkam's Mindrazor"] = "wh2_sm0_effect_bundle_disable_shadows_okkams_mindrazor",
	["Pit of Shades"] = "wh2_sm0_effect_bundle_disable_shadows_pit_of_shades",
	["The Enfeebling Foe"] = "wh2_sm0_effect_bundle_disable_shadows_the_enfeebling_foe",
	["The Penumbral Pendulum"] = "wh2_sm0_effect_bundle_disable_shadows_the_penumbral_pendulum",
	["The Withering"] = "wh2_sm0_effect_bundle_disable_shadows_the_withering"
} 

--# assume ml_tables.spells: map<string, string>
ml_tables.spells = {
	["Bray-Scream"] = "wh_dlc03_spell_wild_bray_scream",
	["Devolve"] = "wh_dlc03_spell_wild_devolve",
	["Mantle of Ghorok"] = "wh_dlc03_spell_wild_mantle_of_ghorok",
	["Savage Dominion"] = "wh_dlc03_spell_wild_savage_dominion",
	["Traitor-Kin"] = "wh_dlc03_spell_wild_traitor_kin",
	["Viletide"] = "wh_dlc03_spell_wild_viletide",
	["Flock of Doom"] = "wh_dlc03_spell_beasts_flock_of_doom",
	["Pann's Impenetrable Pelt"] = "wh_dlc03_spell_beasts_panns_impenetrable_pelt",
	["The Amber Spear"] = "wh_dlc03_spell_beasts_the_amber_spear",
	["The Curse of Anraheir"] = "wh_dlc03_spell_beasts_the_curse_of_anraheir",
	["Transformation of Kadon"] = "wh_dlc03_spell_beasts_transformation_of_kadon",
	["Wyssan's Wildform"] = "wh_dlc03_spell_beasts_wyssans_wildform",
	["Aspect of the Dread Knight"] = "wh_main_spell_death_aspect_of_the_dreadknight",
	["Doom & Darkness"] = "wh_main_spell_death_doom_and_darkness",
	["Soulblight"] = "wh_main_spell_death_soulblight",
	["Spirit Leech"] = "wh_main_spell_death_spirit_leech",
	["The Fate of Bjuna"] = "wh_main_spell_death_the_fate_of_bjuna",
	["The Purple Sun of Xereus"] = "wh_main_spell_death_the_purple_sun_of_xereus",
	["Melkoth's Mystifying Miasma"] = "wh_dlc05_spell_shadow_melkoths_mystifying_miasma",
	["Okkam's Mindrazor"] = "wh_dlc05_spell_shadow_okkams_mindrazor",
	["Pit of Shades"] = "wh_dlc05_spell_shadow_pit_of_shades",
	["The Enfeebling Foe"] = "wh_dlc05_spell_shadow_the_enfeebling_foe",
	["The Penumbral Pendulum"] = "wh_dlc05_spell_shadow_the_penumbral_pendulum",
	["The Withering"] = "wh_dlc05_spell_shadow_the_withering"
} 

--# assume ml_tables.spellToLore: map<string, string>
ml_tables.spellToLore = {
	["Flock of Doom"] = "Lore of Beasts",
	["Pann's Impenetrable Pelt"] = "Lore of Beasts",
	["The Amber Spear"] = "Lore of Beasts",
	["The Curse of Anraheir"] = "Lore of Beasts",
	["Transformation of Kadon"] = "Lore of Beasts",
	["Wyssan's Wildform"] = "Lore of Beasts",
	["Aspect of the Dread Knight"] = "Lore of Death",
	["Doom & Darkness"] = "Lore of Death",
	["Soulblight"] = "Lore of Death",
	["Spirit Leech"] = "Lore of Death",
	["The Fate of Bjuna"] = "Lore of Death",
	["The Purple Sun of Xereus"] = "Lore of Death",
	["Bray-Scream"] = "Lore of Wild",
	["Devolve"] = "Lore of Wild",
	["Mantle of Ghorok"] = "Lore of Wild",
	["Savage Dominion"] = "Lore of Wild",
	["Traitor-Kin"] = "Lore of Wild",
	["Viletide"] = "Lore of Wild",
	["Melkoth's Mystifying Miasma"] = "Lore of Shadows",
	["Okkam's Mindrazor"] = "Lore of Shadows",
	["Pit of Shades"] = "Lore of Shadows",
	["The Enfeebling Foe"] = "Lore of Shadows",
	["The Penumbral Pendulum"] = "Lore of Shadows",
	["The Withering"] = "Lore of Shadows"
} 

return ml_tables