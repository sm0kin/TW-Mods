local ml_tables = {}

--# assume ml_tables.default_rule: string
ml_tables.default_rule = "TT 6th edition - The Fay Enchantress"
--[[
	Warriors of Chaos (8ed)
	page: 48
    ARCHAON
    
    MAGIC
	Archaon [...] uses spells from
	one of the following: the Lore of Death, the Lore of Fire, the
	Lore of Metal, the Lore of Shadow or the ̶L̶o̶r̶e̶ ̶o̶f̶ ̶T̶z̶e̶e̶n̶t̶c̶h̶.
--]]

--# assume ml_tables.default_option: string
ml_tables.default_option = "Spells for free"

--# assume ml_tables.enableAllBundle: string
ml_tables.enableAllBundle = "wh2_sm0_effect_bundle_enable_all_archaon"

--# assume ml_tables.innateSpell: string
ml_tables.innateSpell = "Fireball"

--# assume ml_tables.lores: map<string, map<string, string>>
ml_tables.lores = {
	["Lore of Fire"] = {	
		["wh2_main_skill_all_magic_fire_02_cascading_fire-cloak_lord"] = "Cascading Fire-Cloak",
		["wh_main_skill_all_magic_fire_01_fireball"] = "Fireball",
		["wh2_main_skill_all_magic_fire_10_flame_storm_lord"] = "Flame Storm",
		["wh2_main_skill_all_magic_fire_03_flaming_sword_of_rhuin_lord"] = "Flaming Sword of Rhuin",
		["wh2_main_skill_all_magic_fire_09_piercing_bolts_of_burning_lord"] = "Piercing Bolts of Burning",
		["wh2_main_skill_all_magic_fire_05_the_burning_head_lord"] = "The Burning Head"
	},
	["Lore of Metal"] = {	
		["wh2_main_skill_all_magic_metal_10_final_transmutation_lord"] = "Final Transmutation",
		["wh2_main_skill_all_magic_metal_05_gehennas_golden_hounds_lord"] = "Gehenna's Golden Hounds",
		["wh2_main_skill_all_magic_metal_04_glittering_robe_lord"] = "Glittering Robe",
		["wh2_main_skill_all_magic_metal_02_plague_of_rust_lord"] = "Plague of Rust",
		["wh_main_skill_all_magic_metal_01_searing_doom"] = "Searing Doom",
		["wh2_main_skill_all_magic_metal_09_transmutation_of_lead_lord"] = "Transmutation of Lead"
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
	["wh2_main_skill_all_magic_death_02_aspect_of_the_dreadknight_lord"] = "Aspect of the Dread Knight",
	["wh2_main_skill_all_magic_death_05_doom_and_darkness_lord"] = "Doom & Darkness",
	["wh2_main_skill_all_magic_death_04_soulblight_lord"] = "Soulblight",
	["wh2_dlc11_skill_vmp_bloodline_necrarch_magic_spirit_leech"] = "Spirit Leech",
	["wh2_main_skill_all_magic_death_09_the_fate_of_bjuna_lord"] = "The Fate of Bjuna",
	["wh2_main_skill_all_magic_death_10_the_purple_sun_of_xereus_lord"] = "The Purple Sun of Xereus",
	["wh2_main_skill_all_magic_fire_02_cascading_fire-cloak_lord"] = "Cascading Fire-Cloak",
	["wh_main_skill_all_magic_fire_01_fireball"] = "Fireball",
	["wh2_main_skill_all_magic_fire_10_flame_storm_lord"] = "Flame Storm",
	["wh2_main_skill_all_magic_fire_03_flaming_sword_of_rhuin_lord"] = "Flaming Sword of Rhuin",
	["wh2_main_skill_all_magic_fire_09_piercing_bolts_of_burning_lord"] = "Piercing Bolts of Burning",
	["wh2_main_skill_all_magic_fire_05_the_burning_head_lord"] = "The Burning Head",
	["wh2_main_skill_all_magic_metal_10_final_transmutation_lord"] = "Final Transmutation",
	["wh2_main_skill_all_magic_metal_05_gehennas_golden_hounds_lord"] = "Gehenna's Golden Hounds",
	["wh2_main_skill_all_magic_metal_04_glittering_robe_lord"] = "Glittering Robe",
	["wh2_main_skill_all_magic_metal_02_plague_of_rust_lord"] = "Plague of Rust",
	["wh_main_skill_all_magic_metal_01_searing_doom"] = "Searing Doom",
	["wh2_main_skill_all_magic_metal_09_transmutation_of_lead_lord"] = "Transmutation of Lead",
	["wh_dlc05_skill_magic_shadow_mystifying_miasma"] = "Melkoth's Mystifying Miasma",
	["wh2_main_skill_magic_shadow_okkams_mindrazor_lord"] = "Okkam's Mindrazor",
	["wh2_main_skill_magic_shadow_pit_of_shades_lord"] = "Pit of Shades",
	["wh2_main_skill_magic_shadow_enfeebling_foe_lord"] = "The Enfeebling Foe",
	["wh2_main_skill_magic_shadow_penumbral_pendulum_lord"] = "The Penumbral Pendulum",
	["wh2_main_skill_magic_shadow_the_withering_lord"] = "The Withering"
}

--# assume ml_tables.effectBundles: map<string,string>
ml_tables.effectBundles = {	
	["Cascading Fire-Cloak"] = "wh2_sm0_effect_bundle_disable_fire_cascading_fire_cloak",
	["Fireball"] = "wh2_sm0_effect_bundle_disable_fire_fireball",
	["Flame Storm"] = "wh2_sm0_effect_bundle_disable_fire_flame_storm",
	["Flaming Sword of Rhuin"] = "wh2_sm0_effect_bundle_disable_fire_flaming_sword_of_rhuin",
	["Piercing Bolts of Burning"] = "wh2_sm0_effect_bundle_disable_fire_piercing_bolts_of_burning",
	["The Burning Head"] = "wh2_sm0_effect_bundle_disable_fire_the_burning_head",
	["Final Transmutation"] = "wh2_sm0_effect_bundle_disable_metal_final_transmutation",
	["Gehenna's Golden Hounds"] = "wh2_sm0_effect_bundle_disable_metal_gehennas_golden_hounds",
	["Glittering Robe"] = "wh2_sm0_effect_bundle_disable_metal_glittering_robe",
	["Plague of Rust"] = "wh2_sm0_effect_bundle_disable_metal_plague_of_rust",
	["Searing Doom"] = "wh2_sm0_effect_bundle_disable_metal_searing_doom",
	["Transmutation of Lead"] = "wh2_sm0_effect_bundle_disable_metal_transmutation_of_lead",
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
	["Cascading Fire-Cloak"] = "wh_main_spell_fire_cascading_fire_cloak",
	["Fireball"] = "wh_main_spell_fire_fireball",
	["Flame Storm"] = "wh_main_spell_fire_flame_storm",
	["Flaming Sword of Rhuin"] = "wh_main_spell_fire_flaming_sword_of_rhuin",
	["Piercing Bolts of Burning"] = "wh_main_spell_fire_piercing_bolts_of_burning",
	["The Burning Head"] = "wh_main_spell_fire_the_burning_head",
	["Final Transmutation"] = "wh_main_spell_metal_final_transmutation",
	["Gehenna's Golden Hounds"] = "wh_main_spell_metal_gehennas_golden_hounds",
	["Glittering Robe"] = "wh_main_spell_metal_glittering_robe",
	["Plague of Rust"] = "wh_main_spell_metal_plague_of_rust",
	["Searing Doom"] = "wh_main_spell_metal_searing_doom",
	["Transmutation of Lead"] = "wh_main_spell_metal_transmutation_of_lead",
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
	["Aspect of the Dread Knight"] = "Lore of Death",
	["Doom & Darkness"] = "Lore of Death",
	["Soulblight"] = "Lore of Death",
	["Spirit Leech"] = "Lore of Death",
	["The Fate of Bjuna"] = "Lore of Death",
	["The Purple Sun of Xereus"] = "Lore of Death",
	["Cascading Fire-Cloak"] = "Lore of Fire",
	["Fireball"] = "Lore of Fire",
	["Flame Storm"] = "Lore of Fire",
	["Flaming Sword of Rhuin"] = "Lore of Fire",
	["Piercing Bolts of Burning"] = "Lore of Fire",
	["The Burning Head"] = "Lore of Fire",
	["Final Transmutation"] = "Lore of Metal",
	["Gehenna's Golden Hounds"] = "Lore of Metal",
	["Glittering Robe"] = "Lore of Metal",
	["Plague of Rust"] = "Lore of Metal",
	["Searing Doom"] = "Lore of Metal",
	["Transmutation of Lead"] = "Lore of Metal",
	["Melkoth's Mystifying Miasma"] = "Lore of Shadows",
	["Okkam's Mindrazor"] = "Lore of Shadows",
	["Pit of Shades"] = "Lore of Shadows",
	["The Enfeebling Foe"] = "Lore of Shadows",
	["The Penumbral Pendulum"] = "Lore of Shadows",
	["The Withering"] = "Lore of Shadows"
} 

return ml_tables