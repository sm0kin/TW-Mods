local ml_tables = {}

--# assume ml_tables.default_rule: string
ml_tables.default_rule = "TT 8th edition - Morathi";
--[[
	Dark Elves (8ed)
	page: 54
	MORATHI

	MAGIC: Morathi [...] uses spells from 
	the Lore of Death, the Lore of Shadow and the Lore Dark
	Magic. She can generate all of her spells from 
	the same lore, or two or more of the above lores in any
	combination. Declare how many spells she will generate from
	each lore before spells are generated.	
--]]

--# assume ml_tables.default_option: string
ml_tables.default_option = "Skill - based";

--# assume ml_tables.enableAllBundle: string
ml_tables.enableAllBundle = "wh2_sm0_effect_bundle_enable_all_morathi";

--# assume ml_tables.lores: map<string, map<string, string>>
ml_tables.lores = {
	["Lore of Dark Magic"] = {
		["wh2_main_skill_magic_dark_power_of_darkness_lord"] = "Power of Darkness",
		["wh2_main_skill_magic_dark_chillwind"] = "Chillwind",
		["wh2_main_skill_magic_dark_word_of_pain_lord"] = "Word of Pain",
		["wh2_main_skill_magic_dark_soul_stealer_lord"] = "Soul Stealer",
		["wh2_main_skill_magic_dark_doombolt_lord"] = "Doombolt",
		["wh2_main_skill_magic_dark_bladewind_lord"] = "Bladewind"
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
	["wh2_main_skill_magic_dark_power_of_darkness_lord"] = false,
	["wh2_main_skill_magic_dark_chillwind"] = false,
	["wh2_main_skill_magic_dark_word_of_pain_lord"] = false,
	["wh2_main_skill_magic_dark_soul_stealer_lord"] = false,
	["wh2_main_skill_magic_dark_doombolt_lord"] = false,
	["wh2_main_skill_magic_dark_bladewind_lord"] = false,
	["wh2_main_skill_all_magic_death_02_aspect_of_the_dreadknight_lord"] = false,
	["wh2_main_skill_all_magic_death_05_doom_and_darkness_lord"] = false,
	["wh2_main_skill_all_magic_death_04_soulblight_lord"] = false,
	["wh2_dlc11_skill_vmp_bloodline_necrarch_magic_spirit_leech"] = false,
	["wh2_main_skill_all_magic_death_09_the_fate_of_bjuna_lord"] = false,
	["wh2_main_skill_all_magic_death_10_the_purple_sun_of_xereus_lord"] = false,
	["wh_dlc05_skill_magic_shadow_mystifying_miasma"] = false,
	["wh2_main_skill_magic_shadow_okkams_mindrazor_lord"] = false,
	["wh2_main_skill_magic_shadow_penumbral_pendulum_lord"] = false,
	["wh2_main_skill_magic_shadow_pit_of_shades_lord"] = false,
	["wh2_main_skill_magic_shadow_enfeebling_foe_lord"] = false,
	["wh2_main_skill_magic_shadow_the_withering_lord"] = false
} 

--# assume ml_tables.skillnames: map<string, string>
ml_tables.skillnames = {
	["wh2_main_skill_magic_dark_power_of_darkness_lord"] = "Power of Darkness",
	["wh2_main_skill_magic_dark_chillwind"] = "Chillwind",
	["wh2_main_skill_magic_dark_word_of_pain_lord"] = "Word of Pain",
	["wh2_main_skill_magic_dark_soul_stealer_lord"] = "Soul Stealer",
	["wh2_main_skill_magic_dark_doombolt_lord"] = "Doombolt",
	["wh2_main_skill_magic_dark_bladewind_lord"] = "Bladewind",
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
	["Power of Darkness"] = "wh2_sm0_effect_bundle_disable_dark_power_of_darkness",
	["Chillwind"] = "wh2_sm0_effect_bundle_disable_dark_chillwind",
	["Word of Pain"] = "wh2_sm0_effect_bundle_disable_dark_word_of_pain",
	["Soul Stealer"] = "wh2_sm0_effect_bundle_disable_dark_soul_stealer",
	["Doombolt"] = "wh2_sm0_effect_bundle_disable_dark_doombolt",
	["Bladewind"] = "wh2_sm0_effect_bundle_disable_dark_bladewind",
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
	["Power of Darkness"] = "wh2_main_spell_dark_magic_power_of_darkness",
	["Chillwind"] = "wh2_main_spell_dark_magic_chillwind",
	["Word of Pain"] = "wh2_main_spell_dark_magic_word_of_pain",
	["Soul Stealer"] = "wh2_main_spell_dark_magic_soul_stealer",
	["Doombolt"] = "wh2_main_spell_dark_magic_doombolt",
	["Bladewind"] = "wh2_main_spell_dark_magic_bladewind",
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

return ml_tables;