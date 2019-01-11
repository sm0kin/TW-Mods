local ml_tables = {}

--# assume ml_tables.default_rule: string
ml_tables.default_rule = "TT 8th edition - Alarielle the Radiant";
--[[
	High Elves (8ed)
	page: 59
    ALARIELLE THE RADIANT
    
    MAGIC
    Alarielle the Radiant [...]
    uses spells form the Lore of Life, the Lore of Light and the
    Lore of High Magic[...]. She can generate all of
    her spells from the same, or from two or more of the
    above lores in any combination. 
--]]

--# assume ml_tables.default_option: string
ml_tables.default_option = "Skill - based";

--# assume ml_tables.enableAllBundle: string
ml_tables.enableAllBundle = "wh2_sm0_effect_bundle_enable_all_alarielle";

--# assume ml_tables.lores: map<string, map<string, string>>
ml_tables.lores = {
	["Lore of High Magic"] = {
		["wh2_main_skill_all_magic_high_02_apotheosis_slann"] = "Apotheosis",
		["wh2_sm0_skill_magic_high_arcane_unforging"] = "Arcane Unforging",
		["wh2_sm0_skill_magic_high_fiery_convocation"] = "Fiery Convocation",
		["wh2_sm0_skill_magic_high_hand_of_glory"] = "Hand of Glory",
		["wh2_main_skill_all_magic_high_01_soul_quench_slann"] = "Soul Quench",
		["wh2_main_skill_all_magic_high_05_tempest_slann"] = "Tempest"
	},
	["Lore of Light"] = {		
		["wh2_dlc10_skill_hef_magic_alarielle_banishment"] = "Banishment",
		["wh2_main_skill_all_magic_light_10_bironas_timewarp_lord"] = "Birona's Timewarp",
		["wh2_sm0_skill_magic_light_light_of_battle"] = "Light of Battle",
		["wh2_main_skill_all_magic_light_05_net_of_amyntok_lord"] = "Net of Amyntok",
		["wh2_main_skill_all_magic_light_02_phas_protection_lord"] = "Pha's Protection",
		["wh2_sm0_skill_magic_light_shems_burning_gaze"] = "Shem's Burning Gaze"
	},
	["Lore of Life"] = {	
		["wh2_sm0_skill_magic_life_awakening_of_the_wood"] = "Awakening of the Wood",
		["wh2_main_skill_magic_life_wizard_earth_blood_lord"] = "Earth Blood",
		["wh2_main_skill_magic_life_wizard_flesh_to_stone_lord"] = "Flesh to Stone",
		["wh2_main_skill_magic_life_wizard_regrowth_lord"] = "Regrowth",
		["wh2_main_skill_magic_life_wizard_shield_of_thorns_lord"] = "Shield of Thorns",
		["wh2_main_skill_magic_life_wizard_the_dwellers_below_lord"] = "The Dwellers Below"
	}
}

--# assume ml_tables.has_skills: map<string, bool>
ml_tables.has_skills = {
	["wh2_main_skill_all_magic_high_02_apotheosis_slann"] = false,
	["wh2_sm0_skill_magic_high_arcane_unforging"] = false,
	["wh2_sm0_skill_magic_high_fiery_convocation"] = false,
	["wh2_sm0_skill_magic_high_hand_of_glory"] = false,
	["wh2_main_skill_all_magic_high_01_soul_quench_slann"] = false,
	["wh2_main_skill_all_magic_high_05_tempest_slann"] = false,
	["wh2_sm0_skill_magic_life_awakening_of_the_wood"] = false,
	["wh2_main_skill_magic_life_wizard_earth_blood_lord"] = false,
	["wh2_main_skill_magic_life_wizard_flesh_to_stone_lord"] = false,
	["wh2_main_skill_magic_life_wizard_regrowth_lord"] = false,
	["wh2_main_skill_magic_life_wizard_shield_of_thorns_lord"] = false,
	["wh2_main_skill_magic_life_wizard_the_dwellers_below_lord"] = false,
	["wh2_dlc10_skill_hef_magic_alarielle_banishment"] = false,
	["wh2_main_skill_all_magic_light_10_bironas_timewarp_lord"] = false,
	["wh2_sm0_skill_magic_light_light_of_battle"] = false,
	["wh2_main_skill_all_magic_light_05_net_of_amyntok_lord"] = false,
	["wh2_main_skill_all_magic_light_02_phas_protection_lord"] = false,
	["wh2_sm0_skill_magic_light_shems_burning_gaze"] = false
} 

--# assume ml_tables.skillnames: map<string, string>
ml_tables.skillnames = {
	["wh2_main_skill_all_magic_high_02_apotheosis_slann"] = "Apotheosis",
	["wh2_sm0_skill_magic_high_arcane_unforging"] = "Arcane Unforging",
	["wh2_sm0_skill_magic_high_fiery_convocation"] = "Fiery Convocation",
	["wh2_sm0_skill_magic_high_hand_of_glory"] = "Hand of Glory",
	["wh2_main_skill_all_magic_high_01_soul_quench_slann"] = "Soul Quench",
	["wh2_main_skill_all_magic_high_05_tempest_slann"] = "Tempest",
	["wh2_sm0_skill_magic_life_awakening_of_the_wood"] = "Awakening of the Wood",
	["wh2_main_skill_magic_life_wizard_earth_blood_lord"] = "Earth Blood",
	["wh2_main_skill_magic_life_wizard_flesh_to_stone_lord"] = "Flesh to Stone",
	["wh2_main_skill_magic_life_wizard_regrowth_lord"] = "Regrowth",
	["wh2_main_skill_magic_life_wizard_shield_of_thorns_lord"] = "Shield of Thorns",
	["wh2_main_skill_magic_life_wizard_the_dwellers_below_lord"] = "The Dwellers Below",
	["wh2_dlc10_skill_hef_magic_alarielle_banishment"] = "Banishment",
	["wh2_main_skill_all_magic_light_10_bironas_timewarp_lord"] = "Birona's Timewarp",
	["wh2_sm0_skill_magic_light_light_of_battle"] = "Light of Battle",
	["wh2_main_skill_all_magic_light_05_net_of_amyntok_lord"] = "Net of Amyntok",
	["wh2_main_skill_all_magic_light_02_phas_protection_lord"] = "Pha's Protection",
	["wh2_sm0_skill_magic_light_shems_burning_gaze"] = "Shem's Burning Gaze"
}

--# assume ml_tables.effectBundles: map<string,string>
ml_tables.effectBundles = {	
	["Apotheosis"] = "wh2_sm0_effect_bundle_disable_high_magic_apotheosis",
	["Arcane Unforging"] = "wh2_sm0_effect_bundle_disable_high_magic_arcane_unforging",
	["Fiery Convocation"] = "wh2_sm0_effect_bundle_disable_high_magic_fiery_convocation",
	["Hand of Glory"] = "wh2_sm0_effect_bundle_disable_high_magic_hand_of_glory",
	["Soul Quench"] = "wh2_sm0_effect_bundle_disable_high_magic_soul_quench",
	["Tempest"] = "wh2_sm0_effect_bundle_disable_high_magic_tempest",
	["Awakening of the Wood"] = "wh2_sm0_effect_bundle_disable_life_awakening_of_the_wood",
	["Earth Blood"] = "wh2_sm0_effect_bundle_disable_life_earth_blood",
	["Flesh to Stone"] = "wh2_sm0_effect_bundle_disable_life_flesh_to_stone",
	["Regrowth"] = "wh2_sm0_effect_bundle_disable_life_regrowth",
	["Shield of Thorns"] = "wh2_sm0_effect_bundle_disable_life_shield_of_thorns",
	["The Dwellers Below"] = "wh2_sm0_effect_bundle_disable_life_the_dwellers_below",
	["Banishment"] = "wh2_sm0_effect_bundle_disable_light_banishment",
	["Birona's Timewarp"] = "wh2_sm0_effect_bundle_disable_light_bironas_timewarp",
	["Light of Battle"] = "wh2_sm0_effect_bundle_disable_light_light_of_battle",
	["Net of Amyntok"] = "wh2_sm0_effect_bundle_disable_light_net_of_amyntok",
	["Pha's Protection"] = "wh2_sm0_effect_bundle_disable_light_phas_protection",
	["Shem's Burning Gaze"] = "wh2_sm0_effect_bundle_disable_light_shems_burning_gaze"
} 

--# assume ml_tables.spells: map<string, string>
ml_tables.spells = {
	["Apotheosis"] = "wh2_main_spell_high_magic_apotheosis",
	["Arcane Unforging"] = "wh2_main_spell_high_magic_arcane_unforging",
	["Fiery Convocation"] = "wh2_main_spell_high_magic_fiery_convocation",
	["Hand of Glory"] = "wh2_main_spell_high_magic_hand_of_glory",
	["Soul Quench"] = "wh2_main_spell_high_magic_soul_quench",
	["Tempest"] = "wh2_main_spell_high_magic_tempest",
	["Awakening of the Wood"] = "wh_dlc05_spell_life_awakening_of_the_wood",
	["Earth Blood"] = "wh_dlc05_spell_life_earth_blood",
	["Flesh to Stone"] = "wh_dlc05_spell_life_flesh_to_stone",
	["Regrowth"] = "wh_dlc05_spell_life_regrowth",
	["Shield of Thorns"] = "wh_dlc05_spell_life_shield_of_thorns",
	["The Dwellers Below"] = "wh_dlc05_spell_life_the_dwellers_below",
	["Banishment"] = "wh_main_spell_light_banishment",
	["Birona's Timewarp"] = "wh_main_spell_light_bironas_timewarp",
	["Light of Battle"] = "wh_main_spell_light_light_of_battle",
	["Net of Amyntok"] = "wh_main_spell_light_net_of_amyntok",
	["Pha's Protection"] = "wh_main_spell_light_phas_protection",
	["Shem's Burning Gaze"] = "wh_main_spell_light_shems_burning_gaze"
} 

return ml_tables;