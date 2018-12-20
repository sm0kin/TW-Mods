local loreButton_charPanel = nil --:BUTTON
local loreButton_preBattle = nil --:CA_UIC
local loreButton_unitsPanel = nil --:BUTTON
local spellBrowserButton = nil --:CA_UIC
local optionButton = nil --:CA_UIC
local resetButton = nil --:CA_UIC
local loreFrame = nil --:FRAME
local spellButtonContainer = nil --:CONTAINER
local loreButtonContainer = nil --:CONTAINER
local spellSlotButtonContainer = nil --:CONTAINER
local spellSlotButtons = {} --:vector<TEXT_BUTTON>
local loreSpellText = nil --:TEXT
local loreAttributeText = nil --:TEXT
local pX --:number
local pY --:number
local dummyButton = TextButton.new("dummyButton", core:get_ui_root(), "TEXT", "dummy");
local dummyButtonX, dummyButtonY = dummyButton:Bounds();
dummyButton:Delete();
local spellSlotSelected = nil --:string
local bookIconPath = "ui/icon_lorebook2.png";
local browserIconPath = "ui/icon_spell_browser2.png";
local optionsIconPath = "ui/icon_options2.png";
local resetIconPath = "ui/icon_stats_reset_small2.png";
local charSubMazdamundi = "wh2_main_lzd_lord_mazdamundi";
local loreTable = 	{	["Lore of High Magic"] = {	["sm0_mazda_wh2_main_skill_magic_high_apotheosis"] = "Apotheosis", 
													["sm0_mazda_wh2_main_skill_magic_high_arcane_unforging"] = "Arcane Unforging", 
													["sm0_mazda_wh2_main_skill_magic_high_fiery_convocation"] = "Fiery Convocation", 
													["sm0_mazda_wh2_main_skill_magic_high_hand_of_glory"] = "Hand of Glory", 
													["sm0_mazda_wh2_main_skill_magic_high_soul_quench"] = "Soul Quench", 
													["sm0_mazda_wh2_main_skill_magic_high_tempest"] = "Tempest"},
						["Lore of Light"] = {		["sm0_mazda_wh2_main_skill_magic_light_banishment"] = "Banishment",
													["sm0_mazda_wh2_main_skill_magic_light_bironas_timewarp"] = "Birona's Timewarp",
													["sm0_mazda_wh2_main_skill_magic_light_light_of_battle"] = "Light of Battle",
													["sm0_mazda_wh2_main_skill_magic_light_net_of_amyntok"] = "Net of Amyntok",
													["sm0_mazda_wh2_main_skill_magic_light_phas_protection"] = "Pha's Protection",
													["sm0_mazda_wh2_main_skill_magic_light_shems_burning_gaze"] = "Shem's Burning Gaze"},
						["Lore of Life"] = {		["sm0_mazda_wh2_main_skill_magic_life_awakening_of_the_wood"] = "Awakening of the Wood",
													["sm0_mazda_wh2_main_skill_magic_life_earth_blood"] = "Earth Blood",
													["sm0_mazda_wh2_main_skill_magic_life_flesh_to_stone"] = "Flesh to Stone",
													["sm0_mazda_wh2_main_skill_magic_life_regrowth"] = "Regrowth",
													["sm0_mazda_wh2_main_skill_magic_life_shield_of_thorns"] = "Shield of Thorns",
													["sm0_mazda_wh2_main_skill_magic_life_the_dwellers_below"] = "The Dwellers Below"},
						["Lore of Beasts"] = {		["sm0_mazda_wh2_main_skill_magic_beasts_flock_of_doom"] = "Flock of Doom",
													["sm0_mazda_wh2_main_skill_magic_beasts_panns_impenetrable_pelt"] = "Pann's Impenetrable Pelt",
													["sm0_mazda_wh2_main_skill_magic_beasts_the_amber_spear"] = "The Amber Spear",
													["sm0_mazda_wh2_main_skill_magic_beasts_the_curse_of_anraheir"] = "The Curse of Anraheir",
													["sm0_mazda_wh2_main_skill_magic_beasts_transformation_of_kadon"] = "Transformation of Kadon",
													["sm0_mazda_wh2_main_skill_magic_beasts_wyssans_wildform"] = "Wyssan's Wildform"},
						["Lore of Fire"] = {		["sm0_mazda_wh2_main_skill_magic_fire_cascading_fire-cloak"] = "Cascading Fire Cloak",
													["sm0_mazda_wh2_main_skill_magic_fire_fireball"] = "Fireball",
													["sm0_mazda_wh2_main_skill_magic_fire_flame_storm"] = "Flame Storm",
													["sm0_mazda_wh2_main_skill_magic_fire_flaming_sword_of_rhuin"] = "Flaming Sword of Rhuin",
													["sm0_mazda_wh2_main_skill_magic_fire_piercing_bolts_of_burning"] = "Piercing Bolts of Burning",
													["sm0_mazda_wh2_main_skill_magic_fire_the_burning_head"] = "The Burning Head"},
						["Lore of Heavens"] = {		["sm0_mazda_wh2_main_skill_magic_heavens_chain_lightning"] = "Chain Lightning",
													["sm0_mazda_wh2_main_skill_magic_heavens_comet_of_casandora"] = "Comet of Casandora",
													["sm0_mazda_wh2_main_skill_magic_heavens_curse_of_the_midnight_wind"] = "Curse of the Midnight Wind",
													["sm0_mazda_wh2_main_skill_magic_heavens_harmonic_convergence"] = "Harmonic Convergence",
													["sm0_mazda_wh2_main_skill_magic_heavens_urannons_thunderbolt"] = "Urannon's Thunderbolt",
													["sm0_mazda_wh2_main_skill_magic_heavens_wind_blast"] = "Wind Blast"},
						["Lore of Metal"] = {		["sm0_mazda_wh2_main_skill_magic_metal_final_transmutation"] = "Final Transmutation",
													["sm0_mazda_wh2_main_skill_magic_metal_gehennas_golden_hounds"] = "Gehenna's Golden Hounds",
													["sm0_mazda_wh2_main_skill_magic_metal_glittering_robe"] = "Glittering Robe",
													["sm0_mazda_wh2_main_skill_magic_metal_plague_of_rust"] = "Plague of Rust",
													["sm0_mazda_wh2_main_skill_magic_metal_searing_doom"] = "Searing Doom",
													["sm0_mazda_wh2_main_skill_magic_metal_transmutation_of_lead"] = "Transmutation of Lead"},
						["Lore of Death"] = {		["sm0_mazda_wh2_main_skill_magic_death_aspect_of_the_dreadknight"] = "Aspect of the Dreadknight",
													["sm0_mazda_wh2_main_skill_magic_death_doom_and_darkness"] = "Doom and Darkness",
													["sm0_mazda_wh2_main_skill_magic_death_soulblight"] = "Soulblight",
													["sm0_mazda_wh2_main_skill_magic_death_spirit_leech"] = "Spirit Leech",
													["sm0_mazda_wh2_main_skill_magic_death_the_fate_of_bjuna"] = "The Fate of Bjuna",
													["sm0_mazda_wh2_main_skill_magic_death_the_purple_sun_of_xereus"] = "The Purple Sun of Xereus"},
						["Lore of Shadows"] = {		["sm0_mazda_wh2_main_skill_magic_shadow_mystifying_miasma"] = "Melkoth's Mystifying Miasma",
													["sm0_mazda_wh2_main_skill_magic_shadow_okkams_mindrazor"] = "Okkam's Mindrazor",
													["sm0_mazda_wh2_main_skill_magic_shadow_pit_of_shades"] = "Pit of Shades",
													["sm0_mazda_wh2_main_skill_magic_shadow_enfeebling_foe"] = "The Enfeebling Foe",
													["sm0_mazda_wh2_main_skill_magic_shadow_penumbral_pendulum"] = "The Penumbral Pendulum",
													["sm0_mazda_wh2_main_skill_magic_shadow_the_withering"] = "The Withering"}	} --: map<string, map<string, string>>
local skillTable = {["sm0_mazda_wh2_main_skill_magic_high_apotheosis"] = false, 
					["sm0_mazda_wh2_main_skill_magic_high_arcane_unforging"] = false, 
					["sm0_mazda_wh2_main_skill_magic_high_fiery_convocation"] = false, 
					["sm0_mazda_wh2_main_skill_magic_high_hand_of_glory"] = false, 
					["sm0_mazda_wh2_main_skill_magic_high_soul_quench"] = false, 
					["sm0_mazda_wh2_main_skill_magic_high_tempest"] = false, 
					["sm0_mazda_wh2_main_skill_magic_light_banishment"] = false, 
					["sm0_mazda_wh2_main_skill_magic_light_bironas_timewarp"] = false, 
					["sm0_mazda_wh2_main_skill_magic_light_light_of_battle"] = false, 
					["sm0_mazda_wh2_main_skill_magic_light_net_of_amyntok"] = false, 
					["sm0_mazda_wh2_main_skill_magic_light_phas_protection"] = false, 
					["sm0_mazda_wh2_main_skill_magic_light_shems_burning_gaze"] = false, 
					["sm0_mazda_wh2_main_skill_magic_life_awakening_of_the_wood"]= false, 
					["sm0_mazda_wh2_main_skill_magic_life_earth_blood"] = false, 
					["sm0_mazda_wh2_main_skill_magic_life_flesh_to_stone"] = false, 
					["sm0_mazda_wh2_main_skill_magic_life_regrowth"] = false, 
					["sm0_mazda_wh2_main_skill_magic_life_shield_of_thorns"] = false, 
					["sm0_mazda_wh2_main_skill_magic_life_the_dwellers_below"] = false, 
					["sm0_mazda_wh2_main_skill_magic_beasts_flock_of_doom"] = false, 
					["sm0_mazda_wh2_main_skill_magic_beasts_panns_impenetrable_pelt"] = false, 
					["sm0_mazda_wh2_main_skill_magic_beasts_the_amber_spear"] = false, 
					["sm0_mazda_wh2_main_skill_magic_beasts_the_curse_of_anraheir"] = false, 
					["sm0_mazda_wh2_main_skill_magic_beasts_transformation_of_kadon"] = false, 
					["sm0_mazda_wh2_main_skill_magic_beasts_wyssans_wildform"] = false, 
					["sm0_mazda_wh2_main_skill_magic_fire_cascading_fire-cloak"] = false, 
					["sm0_mazda_wh2_main_skill_magic_fire_fireball"] = false, 
					["sm0_mazda_wh2_main_skill_magic_fire_flame_storm"] = false, 
					["sm0_mazda_wh2_main_skill_magic_fire_flaming_sword_of_rhuin"] = false, 
					["sm0_mazda_wh2_main_skill_magic_fire_piercing_bolts_of_burning"] = false, 
					["sm0_mazda_wh2_main_skill_magic_fire_the_burning_head"] = false, 
					["sm0_mazda_wh2_main_skill_magic_heavens_chain_lightning"] = false, 
					["sm0_mazda_wh2_main_skill_magic_heavens_comet_of_casandora"] = false, 
					["sm0_mazda_wh2_main_skill_magic_heavens_curse_of_the_midnight_wind"] = false, 
					["sm0_mazda_wh2_main_skill_magic_heavens_harmonic_convergence"] = false, 
					["sm0_mazda_wh2_main_skill_magic_heavens_urannons_thunderbolt"] = false, 
					["sm0_mazda_wh2_main_skill_magic_heavens_wind_blast"] = false, 
					["sm0_mazda_wh2_main_skill_magic_metal_final_transmutation"] = false, 
					["sm0_mazda_wh2_main_skill_magic_metal_gehennas_golden_hounds"] = false, 
					["sm0_mazda_wh2_main_skill_magic_metal_glittering_robe"] = false, 
					["sm0_mazda_wh2_main_skill_magic_metal_plague_of_rust"] = false, 
					["sm0_mazda_wh2_main_skill_magic_metal_searing_doom"] = false, 
					["sm0_mazda_wh2_main_skill_magic_metal_transmutation_of_lead"] = false, 
					["sm0_mazda_wh2_main_skill_magic_death_aspect_of_the_dreadknight"] = false, 
					["sm0_mazda_wh2_main_skill_magic_death_doom_and_darkness"]= false, 
					["sm0_mazda_wh2_main_skill_magic_death_soulblight"] = false, 
					["sm0_mazda_wh2_main_skill_magic_death_spirit_leech"] = false, 
					["sm0_mazda_wh2_main_skill_magic_death_the_fate_of_bjuna"] = false, 
					["sm0_mazda_wh2_main_skill_magic_death_the_purple_sun_of_xereus"] = false, 
					["sm0_mazda_wh2_main_skill_magic_shadow_mystifying_miasma"] = false, 
					["sm0_mazda_wh2_main_skill_magic_shadow_okkams_mindrazor"] = false, 
					["sm0_mazda_wh2_main_skill_magic_shadow_pit_of_shades"] = false, 
					["sm0_mazda_wh2_main_skill_magic_shadow_enfeebling_foe"] = false, 
					["sm0_mazda_wh2_main_skill_magic_shadow_penumbral_pendulum"] = false, 
					["sm0_mazda_wh2_main_skill_magic_shadow_the_withering"] = false} --:map<string, bool>
local effectBundleTable = {	["Apotheosis"] = "sm0_mazda_wh2_main_effect_bundle_enable_high_magic_apotheosis",
							["Arcane Unforging"] = "sm0_mazda_wh2_main_effect_bundle_enable_high_magic_arcane_unforging",
							["Fiery Convocation"] = "sm0_mazda_wh2_main_effect_bundle_enable_high_magic_fiery_convocation",
							["Hand of Glory"] = "sm0_mazda_wh2_main_effect_bundle_enable_high_magic_hand_of_glory",
							["Soul Quench"] = "sm0_mazda_wh2_main_effect_bundle_enable_high_magic_soul_quench",
							["Tempest"] = "sm0_mazda_wh2_main_effect_bundle_enable_high_magic_tempest",
							["Flock of Doom"] = "sm0_mazda_wh2_main_effect_bundle_enable_beasts_flock_of_doom",
							["Pann's Impenetrable Pelt"] = "sm0_mazda_wh2_main_effect_bundle_enable_beasts_panns_impenetrable_pelt",
							["The Amber Spear"] = "sm0_mazda_wh2_main_effect_bundle_enable_beasts_the_amber_spear",
							["The Curse of Anraheir"] = "sm0_mazda_wh2_main_effect_bundle_enable_beasts_the_curse_of_anraheir",
							["Transformation of Kadon"] = "sm0_mazda_wh2_main_effect_bundle_enable_beasts_transformation_of_kadon",
							["Wyssan's Wildform"] = "sm0_mazda_wh2_main_effect_bundle_enable_beasts_wyssans_wildform",
							["Awakening of the Wood"] = "sm0_mazda_wh2_main_effect_bundle_enable_life_awakening_of_the_wood",
							["Earth Blood"] = "sm0_mazda_wh2_main_effect_bundle_enable_life_earth_blood",
							["Flesh to Stone"] = "sm0_mazda_wh2_main_effect_bundle_enable_life_flesh_to_stone",
							["Regrowth"] = "sm0_mazda_wh2_main_effect_bundle_enable_life_regrowth",
							["Shield of Thorns"] = "sm0_mazda_wh2_main_effect_bundle_enable_life_shield_of_thorns",
							["The Dwellers Below"] = "sm0_mazda_wh2_main_effect_bundle_enable_life_the_dwellers_below",
							["Melkoth's Mystifying Miasma"] = "sm0_mazda_wh2_main_effect_bundle_enable_shadow_melkoths_mystifying_miasma",
							["Okkam's Mindrazor"] = "sm0_mazda_wh2_main_effect_bundle_enable_shadow_okkams_mindrazor",
							["Pit of Shades"] = "sm0_mazda_wh2_main_effect_bundle_enable_shadow_pit_of_shades",
							["The Enfeebling Foe"] = "sm0_mazda_wh2_main_effect_bundle_enable_shadow_the_enfeebling_foe",
							["The Penumbral Pendulum"] = "sm0_mazda_wh2_main_effect_bundle_enable_shadow_the_penumbral_pendulum",
							["The Withering"] = "sm0_mazda_wh2_main_effect_bundle_enable_shadow_the_withering",
							["Aspect of the Dreadknight"] = "sm0_mazda_wh2_main_effect_bundle_enable_death_aspect_of_the_dreadknight",
							["Doom and Darkness"] = "sm0_mazda_wh2_main_effect_bundle_enable_death_doom_and_darkness",
							["Soulblight"] = "sm0_mazda_wh2_main_effect_bundle_enable_death_soulblight",
							["Spirit Leech"] = "sm0_mazda_wh2_main_effect_bundle_enable_death_spirit_leech",
							["The Fate of Bjuna"] = "sm0_mazda_wh2_main_effect_bundle_enable_death_the_fate_of_bjuna",
							["The Purple Sun of Xereus"] = "sm0_mazda_wh2_main_effect_bundle_enable_death_the_purple_sun_of_xereus",
							["Cascading Fire Cloak"] = "sm0_mazda_wh2_main_effect_bundle_enable_fire_cascading_fire_cloak",
							["Fireball"] = "sm0_mazda_wh2_main_effect_bundle_enable_fire_fireball",
							["Flame Storm"] = "sm0_mazda_wh2_main_effect_bundle_enable_fire_flame_storm",
							["Flaming Sword of Rhuin"] = "sm0_mazda_wh2_main_effect_bundle_enable_fire_flaming_sword_of_rhuin",
							["Piercing Bolts of Burning"] = "sm0_mazda_wh2_main_effect_bundle_enable_fire_piercing_bolts_of_burning",
							["The Burning Head"] = "sm0_mazda_wh2_main_effect_bundle_enable_fire_the_burning_head",
							["Chain Lightning"] = "sm0_mazda_wh2_main_effect_bundle_enable_heavens_chain_lightning",
							["Comet of Casandora"] = "sm0_mazda_wh2_main_effect_bundle_enable_heavens_comet_of_casandora",
							["Curse of the Midnight Wind"] = "sm0_mazda_wh2_main_effect_bundle_enable_heavens_curse_of_the_midnight_wind",
							["Harmonic Convergence"] = "sm0_mazda_wh2_main_effect_bundle_enable_heavens_harmonic_convergence",
							["Urannon's Thunderbolt"] = "sm0_mazda_wh2_main_effect_bundle_enable_heavens_urannons_thunderbolt",
							["Wind Blast"] = "sm0_mazda_wh2_main_effect_bundle_enable_heavens_wind_blast",
							["Banishment"] = "sm0_mazda_wh2_main_effect_bundle_enable_light_banishment",
							["Birona's Timewarp"] = "sm0_mazda_wh2_main_effect_bundle_enable_light_bironas_timewarp",
							["Light of Battle"] = "sm0_mazda_wh2_main_effect_bundle_enable_light_light_of_battle",
							["Net of Amyntok"] = "sm0_mazda_wh2_main_effect_bundle_enable_light_net_of_amyntok",
							["Pha's Protection"] = "sm0_mazda_wh2_main_effect_bundle_enable_light_phas_protection",
							["Shem's Burning Gaze"] = "sm0_mazda_wh2_main_effect_bundle_enable_light_shems_burning_gaze",
							["Final Transmutation"] = "sm0_mazda_wh2_main_effect_bundle_enable_metal_final_transmutation",
							["Gehenna's Golden Hounds"] = "sm0_mazda_wh2_main_effect_bundle_enable_metal_gehennas_golden_hounds",
							["Glittering Robe"] = "sm0_mazda_wh2_main_effect_bundle_enable_metal_glittering_robe",
							["Plague of Rust"] = "sm0_mazda_wh2_main_effect_bundle_enable_metal_searing_doom",
							["Searing Doom"] = "sm0_mazda_wh2_main_effect_bundle_enable_metal_transmutation_of_lead",
							["Transmutation of Lead"] = "sm0_mazda_wh2_main_effect_bundle_enable_metal_plague_of_rust"} --:map<string,string>
local spellTable = {	["Apotheosis"]  = "sm0_mazda_wh2_main_spell_high_magic_apotheosis",
						["Arcane Unforging"]  = "sm0_mazda_wh2_main_spell_high_magic_arcane_unforging",
						["Fiery Convocation"]  = "sm0_mazda_wh2_main_spell_high_magic_fiery_convocation",
						["Hand of Glory"]  = "sm0_mazda_wh2_main_spell_high_magic_hand_of_glory",
						["Soul Quench"]  = "sm0_mazda_wh2_main_spell_high_magic_soul_quench",
						["Tempest"]  = "sm0_mazda_wh2_main_spell_high_magic_tempest",
						["Flock of Doom"]  = "sm0_mazda_wh2_main_spell_beasts_flock_of_doom",
						["Pann's Impenetrable Pelt"]  = "sm0_mazda_wh2_main_spell_beasts_panns_impenetrable_pelt",
						["The Amber Spear"]  = "sm0_mazda_wh2_main_spell_beasts_the_amber_spear",
						["The Curse of Anraheir"]  = "sm0_mazda_wh2_main_spell_beasts_the_curse_of_anraheir",
						["Transformation of Kadon"]  = "sm0_mazda_wh2_main_spell_beasts_transformation_of_kadon",
						["Wyssan's Wildform"]  = "sm0_mazda_wh2_main_spell_beasts_wyssans_wildform",
						["Awakening of the Wood"]  = "sm0_mazda_wh2_main_spell_life_awakening_of_the_wood",
						["Earth Blood"]  = "sm0_mazda_wh2_main_spell_life_earth_blood",
						["Flesh to Stone"]  = "sm0_mazda_wh2_main_spell_life_flesh_to_stone",
						["Regrowth"]  = "sm0_mazda_wh2_main_spell_life_regrowth",
						["Shield of Thorns"]  = "sm0_mazda_wh2_main_spell_life_shield_of_thorns",
						["The Dwellers Below"]  = "sm0_mazda_wh2_main_spell_life_the_dwellers_below",
						["Melkoth's Mystifying Miasma"]  = "sm0_mazda_wh2_main_spell_shadow_melkoths_mystifying_miasma",
						["Okkam's Mindrazor"]  = "sm0_mazda_wh2_main_spell_shadow_okkams_mindrazor",
						["Pit of Shades"]  = "sm0_mazda_wh2_main_spell_shadow_pit_of_shades",
						["The Enfeebling Foe"]  = "sm0_mazda_wh2_main_spell_shadow_the_enfeebling_foe",
						["The Penumbral Pendulum"]  = "sm0_mazda_wh2_main_spell_shadow_the_penumbral_pendulum",
						["The Withering"]  = "sm0_mazda_wh2_main_spell_shadow_the_withering",
						["Aspect of the Dreadknight"]  = "sm0_mazda_wh2_main_spell_death_aspect_of_the_dreadknight",
						["Doom and Darkness"]  = "sm0_mazda_wh2_main_spell_death_doom_and_darkness",
						["Soulblight"]  = "sm0_mazda_wh2_main_spell_death_soulblight",
						["Spirit Leech"]  = "sm0_mazda_wh2_main_spell_death_spirit_leech",
						["The Fate of Bjuna"]  = "sm0_mazda_wh2_main_spell_death_the_fate_of_bjuna",
						["The Purple Sun of Xereus"]  = "sm0_mazda_wh2_main_spell_death_the_purple_sun_of_xereus",
						["Cascading Fire Cloak"]  = "sm0_mazda_wh2_main_spell_fire_cascading_fire_cloak",
						["Fireball"]  = "sm0_mazda_wh2_main_spell_fire_fireball",
						["Flame Storm"]  = "sm0_mazda_wh2_main_spell_fire_flame_storm",
						["Flaming Sword of Rhuin"]  = "sm0_mazda_wh2_main_spell_fire_flaming_sword_of_rhuin",
						["Piercing Bolts of Burning"]  = "sm0_mazda_wh2_main_spell_fire_piercing_bolts_of_burning",
						["The Burning Head"]  = "sm0_mazda_wh2_main_spell_fire_the_burning_head",
						["Chain Lightning"]  = "sm0_mazda_wh2_main_spell_heavens_chain_lightning",
						["Comet of Casandora"]  = "sm0_mazda_wh2_main_spell_heavens_comet_of_casandora",
						["Curse of the Midnight Wind"]  = "sm0_mazda_wh2_main_spell_heavens_curse_of_the_midnight_wind",
						["Harmonic Convergence"]  = "sm0_mazda_wh2_main_spell_heavens_harmonic_convergence",
						["Urannon's Thunderbolt"]  = "sm0_mazda_wh2_main_spell_heavens_urannons_thunderbolt",
						["Wind Blast"]  = "sm0_mazda_wh2_main_spell_heavens_wind_blast",
						["Banishment"]  = "sm0_mazda_wh2_main_spell_light_banishment",
						["Birona's Timewarp"]  = "sm0_mazda_wh2_main_spell_light_bironas_timewarp",
						["Light of Battle"]  = "sm0_mazda_wh2_main_spell_light_light_of_battle",
						["Net of Amyntok"]  = "sm0_mazda_wh2_main_spell_light_net_of_amyntok",
						["Pha's Protection"]  = "sm0_mazda_wh2_main_spell_light_phas_protection",
						["Shem's Burning Gaze"]  = "sm0_mazda_wh2_main_spell_light_shems_burning_gaze",
						["Final Transmutation"]  = "sm0_mazda_wh2_main_spell_metal_final_transmutation",
						["Gehenna's Golden Hounds"]  = "sm0_mazda_wh2_main_spell_metal_gehennas_golden_hounds",
						["Glittering Robe"]  = "sm0_mazda_wh2_main_spell_metal_glittering_robe",
						["Plague of Rust"]  = "sm0_mazda_wh2_main_spell_metal_plague_of_rust",
						["Searing Doom"]  = "sm0_mazda_wh2_main_spell_metal_searing_doom",
						["Transmutation of Lead"]  = "sm0_mazda_wh2_main_spell_metal_transmutation_of_lead"} --:map<string, string>

local createSpellSlotButtonContainer --:function(char: CA_CHAR, spellSlots: vector<string>)

--v function()
function resetSaveTable()
	local spellSlots = {"Spell Slot - 1 -", "Spell Slot - 2 -", "Spell Slot - 3 -", "Spell Slot - 4 -", "Spell Slot - 5 -", "Spell Slot - 6 -"} --:vector<string>
	local saveString = "return {"..cm:process_table_save(spellSlots).."}";
	cm:set_saved_value("sm0_mazdamundi", saveString);
end

local tableString = cm:get_saved_value("sm0_mazdamundi");
if not tableString then
	resetSaveTable();
end

--v function() --> CA_CHAR					
function getSelectedCharacter()
	local selectedCharacterCqi = cm:get_campaign_ui_manager():get_char_selected_cqi();
	return cm:get_character_by_cqi(selectedCharacterCqi);
end

--v function(charSubtype: string, faction: CA_FACTION) --> CA_CHAR					
function getCAChar(charSubtype, faction)
	local characterList = faction:character_list();
	local char = nil --:CA_CHAR
	for i = 0, characterList:num_items() - 1 do
		local currentChar = characterList:item_at(i)	
		if currentChar:character_subtype(charSubtype) then
			char = currentChar;
		end
	end
	return char;
end

--v function(char: CA_CHAR)
function updateSkillTable(char)
	for skill, _ in pairs(skillTable) do
		if char:has_skill(skill) then
			skillTable[skill] = true;
		else
			skillTable[skill] = false;
		end
	end
end

--v function(table: table, element: any) --> bool
function tableContains(table, element)
	for _, value in pairs(table) do
	  if value == element then
		return true
	  end
	end
	return false
end

--v function(char: CA_CHAR, spellSlots: vector<string>)					
function applySpellEnableEffect(char, spellSlots)
	local charCqi = char:cqi();
	for _, effectBundle in pairs(effectBundleTable) do
		if char:military_force():has_effect_bundle(effectBundle) then
			cm:remove_effect_bundle_from_characters_force(effectBundle, charCqi);
		end
	end
	for _, spell in ipairs(spellSlots) do 
		if effectBundleTable[spell] then
			cm:apply_effect_bundle_to_characters_force(effectBundleTable[spell], charCqi, -1, false);
		end
	end
end

--v [NO_CHECK] function(spellName: any) --> vector<string>
function updateSaveTable(spellName)
	local spellSlots = loadstring(cm:get_saved_value("sm0_mazdamundi"))();
	if spellName then
		for i, spellSlot in ipairs(spellSlots) do
			if "Spell Slot - "..i.." -" == spellSlotSelected then
				spellSlots[i] = spellName;
				local saveString = "return {"..cm:process_table_save(spellSlots).."}";
				cm:set_saved_value("sm0_mazdamundi", saveString);
			end
		end
	end
	return spellSlots;
end

--v [NO_CHECK] function(lore: map<string, string>, char: CA_CHAR)
function createSpellButtonContainer(lore, char)
	local spellButtonList = ListView.new("SpellButtonList", loreFrame, "VERTICAL");
	spellButtonList:Resize(pX/2 - 18, pY - dummyButtonY/2);
	spellButtonContainer = Container.new(FlowLayout.VERTICAL);	
	local spellButtons = {} --:vector<TEXT_BUTTON>
	local spellSlots = updateSaveTable(false);
	for skill, spell in pairs(lore) do
		local spellButton = TextButton.new(spell, loreFrame, "TEXT", spell);
		spellButton:SetState("hover");
		spellButton.uic:SetTooltipText("Select "..spell.." to replace "..spellSlots[tonumber(string.match(spellSlotSelected, "%d"))]..".");	
		spellButton:SetState("active");
		for _, spellSlot in ipairs(spellSlots) do
			if spellSlot == spell then
				spellButton:SetDisabled(true);
				spellButton.uic:SetTooltipText("This spell has already been selected.");	
			end
		end
		if not skillTable[skill] then
			spellButton:SetDisabled(true);
			local reqTooltip = "Required Skill: "..effect.get_localised_string("character_skills_localised_name_"..skill);
			spellButton.uic:SetTooltipText(reqTooltip);	
		end
		table.insert(spellButtons, spellButton);
		spellButton:RegisterForClick(
			function(context)
				local spellSlots = updateSaveTable(spellButton.name);
				createSpellSlotButtonContainer(char, spellSlots);
				applySpellEnableEffect(char, spellSlots)
			end
		)
		spellButtonList:AddComponent(spellButton);
	end
	spellButtonContainer:AddComponent(spellButtonList);
	spellButtonContainer:PositionRelativeTo(loreFrame, pX/2 + 35, dummyButtonY/4);
	loreFrame:AddComponent(spellButtonContainer);
end

--v function(buttons: vector<TEXT_BUTTON>, char: CA_CHAR)
function setupSingleSelectedButtonGroup(buttons, char)
	for _, button in ipairs(buttons) do
		button:SetState("active");
		button:RegisterForClick(
			function(context)
				for _, otherButton in ipairs(buttons) do
					if button.name == otherButton.name then
						otherButton:SetState("selected_hover");
						otherButton.uic:SetTooltipText("Select your prefered spell of the "..button.name..".");
					else
						otherButton:SetState("hover");
						otherButton.uic:SetTooltipText("Select the Lore of Magic you want to pick a spell from.");
						otherButton:SetState("active");
					end
				end
				if spellButtonContainer then
					spellButtonContainer:Clear();
				end
				createSpellButtonContainer(loreTable[button.name], char);
			end
		);
	end
end

--v function(char: CA_CHAR)
function createLoreButtonContainer(char)
	spellSlotButtonContainer:Clear();
	local loreButtonList = ListView.new("LoreButtonList", loreFrame, "VERTICAL");
	loreButtonList:Resize(pX/2 - 9, pY - dummyButtonY/2); -- width vslider 18
	loreButtonContainer = Container.new(FlowLayout.VERTICAL);
	local loreButtons = {} --:vector<TEXT_BUTTON>
	local loreEnable = {};
	for lore, _ in pairs(loreTable) do
		local loreButton = TextButton.new(lore, loreFrame, "TEXT_TOGGLE", lore);
		table.insert(loreButtons, loreButton);
		loreButtonList:AddComponent(loreButton);
	end	
	setupSingleSelectedButtonGroup(loreButtons, char);
	loreButtonContainer:AddComponent(loreButtonList);
	loreButtonContainer:PositionRelativeTo(loreFrame, 22, dummyButtonY/4);
	loreFrame:AddComponent(loreButtonContainer);
end

createSpellSlotButtonContainer = function(char, spellSlots)
	if loreButtonContainer then loreButtonContainer:Clear(); end
	if spellButtonContainer then spellButtonContainer:Clear(); end
	local spellSlotButtonList = ListView.new("SpellSlotButtonList", loreFrame, "VERTICAL");
	spellSlotButtonList:Resize(dummyButtonX, pY - dummyButtonY/2); --(pX/2 - 13, pY - 40);
	spellSlotButtonContainer = Container.new(FlowLayout.VERTICAL);
	for i, spellSlot in ipairs(spellSlots) do
		local spellSlotButton = TextButton.new("Spell Slot - "..i.." -", loreFrame, "TEXT", spellSlot);
		table.insert(spellSlotButtons, spellSlotButton);
		spellSlotButton:RegisterForClick(
			function(context)
				spellSlotSelected = spellSlotButton.name;
				createLoreButtonContainer(char);
			end
		)
		spellSlotButtonList:AddComponent(spellSlotButton);
	end
	spellSlotButtonContainer:AddComponent(spellSlotButtonList);
	Util.centreComponentOnComponent(spellSlotButtonContainer, loreFrame);
	loreFrame:AddComponent(spellSlotButtonContainer);
end

--v function() --> CA_CHAR
function getMazdaCharacter()
	local char = nil --:CA_CHAR
	if not cm:model():pending_battle():is_active() then
		char = getSelectedCharacter();
		if not char then
			local focusButton = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"); 
			local focusButtonText = focusButton:GetStateText();
			if string.find(focusButtonText,"Mazdamundi") then
				 char = getCAChar(charSubMazdamundi, cm:get_faction(cm:get_local_faction(true)));
			end
		end
	elseif cm:model():pending_battle():attacker():faction():is_human() then
		char = cm:model():pending_battle():attacker();
		if not char:character_subtype(charSubMazdamundi) and cm:model():pending_battle():secondary_attackers():num_items() >= 1 then
			local attackers = cm:model():pending_battle():secondary_attackers();
			for i = 0, attackers:num_items() - 1 do
				if attackers:item_at(i):character_subtype(charSubMazdamundi) then
					char = attackers:item_at(i);
				end
			end
		end
	elseif cm:model():pending_battle():defender():faction():is_human() then
		char = cm:model():pending_battle():defender();
		if not char:character_subtype(charSubMazdamundi) and cm:model():pending_battle():secondary_defenders():num_items() >= 1 then
			local defenders = cm:model():pending_battle():secondary_defenders();
			for i = 0, defenders:num_items() - 1 do
				if defenders:item_at(i):character_subtype(charSubMazdamundi) then
					char = defenders:item_at(i);
				end
			end
		end
	end
	return char;
end

--v function()
function re_init()
	loreButtonContainer = nil;
	spellButtonContainer = nil;
	spellSlotButtonContainer = nil;
	spellSlotSelected = nil;
	optionButton = nil;
	spellBrowserButton = nil;
	resetButton = nil
	loreFrame = nil;
end

local setupListener --:function()

--v function()
function editSpellBrowserUI()
	local spell_browser = find_uicomponent(core:get_ui_root(), "spell_browser");
	if loreFrame then
		loreFrame:PositionRelativeTo(spell_browser, spell_browser:Width(), spell_browser:Height() - loreFrame:Height() + 53);
	end
	if getSelectedCharacter():character_subtype(charSubMazdamundi) then
		local spellSlots = updateSaveTable(false);
		for spellName, button in pairs(spellTable) do
			local compositeSpell = find_uicomponent(core:get_ui_root(), "spell_browser", "composite_lore_parent", "composite_spell_list", button);
			if not tableContains(spellSlots, spellName) then
				Util.delete(compositeSpell);
			end
		end
	end
end

--v function()
function createSpellBrowserButton()
	local parent = find_uicomponent(core:get_ui_root(), "Lore of Magic");
	spellBrowserButton = Util.createComponent("spellBrowserButton", parent, "ui/templates/round_small_button");
	Util.registerComponent("spellBrowserButton", spellBrowserButton);
	spellBrowserButton:Resize(28, 28);
	local posFrameX, posFrameY = loreFrame:Position();
	local offsetX, offsetY = 10, 10;
	spellBrowserButton:MoveTo(posFrameX + offsetX, posFrameY + offsetY);
	spellBrowserButton:SetImage(browserIconPath);
	spellBrowserButton:SetState("hover");
	spellBrowserButton:SetTooltipText("Spell Browser");
	spellBrowserButton:PropagatePriority(100);
	spellBrowserButton:SetState("active");
	local button_spell_browser = find_uicomponent(core:get_ui_root(), "button_spell_browser");
	if not button_spell_browser then
		spellBrowserButton:SetDisabled(true);
	else
		spellBrowserButton:SetDisabled(false);
	end
	Util.registerForClick(spellBrowserButton, "sm0_spellBrowserButtonListener",
		function(context)
			button_spell_browser:SimulateLClick();
			--editSpellBrowserUI();
			--root > spell_browser > composite_lore_parent > composite_spell_list
			--local spell_browser = find_uicomponent(core:get_ui_root(), "spell_browser");
			--spell_browser:Adopt(loreFrame.uic:Address());
			--loreFrame.uic:SetDisabled(false);
			--loreFrame.uic:SetInteractive(true);
			--intervention_manager:lock_ui(false, false);
			--cm:get_intervention_manager():lock_ui(false, false);
			--local loreFrame = find_uicomponent(core:get_ui_root(), "Lore of Magic");
			--cm:get_intervention_manager():override("Lore of Magic"):unlock();
			--core:get_or_create_component("Lore of Magic", "ui/campaign ui/objectives_screen", spell_browser);
			--setupListener();
		end
	)
	loreFrame:AddComponent(spellBrowserButton);
end

--v function()
function createOptionButton()
	local parent = find_uicomponent(core:get_ui_root(), "Lore of Magic");
	optionButton = Util.createComponent("optionButton", parent, "ui/templates/round_small_button");
	Util.registerComponent("optionButton", optionButton);
	optionButton:Resize(28, 28);
	local posFrameX, posFrameY = loreFrame:Position();
	local sizeFrameX, sizeFrameY = loreFrame:Bounds(); 
	local offsetX, offsetY = 10, 10;
	optionButton:MoveTo(posFrameX + sizeFrameX - (offsetX + optionButton:Width()), posFrameY + offsetY);
	optionButton:SetImage(optionsIconPath);
	optionButton:SetState("hover");
	optionButton:SetTooltipText("Options");
	optionButton:PropagatePriority(100);
	optionButton:SetState("active");
	Util.registerForClick(optionButton, "sm0_optionButtonListener",
		function(context)
			--
		end
	)
	loreFrame:AddComponent(optionButton);
end

--v function()
function createResetButton()
	local parent = find_uicomponent(core:get_ui_root(), "Lore of Magic");
	resetButton = Util.createComponent("resetButton", parent, "ui/templates/round_small_button");
	Util.registerComponent("resetButton", resetButton);
	resetButton:Resize(28, 28);
	local posFrameX, posFrameY = loreFrame:Position();
	local sizeFrameX, sizeFrameY = loreFrame:Bounds(); 
	local offsetX, offsetY = 10, 10;
	resetButton:MoveTo(posFrameX + sizeFrameX - (offsetX + 2*resetButton:Width()), posFrameY + offsetY);
	resetButton:SetImage(resetIconPath);
	resetButton:SetState("hover");
	resetButton:SetTooltipText("Reset");
	resetButton:PropagatePriority(100);
	resetButton:SetState("active");
	Util.registerForClick(resetButton, "sm0_resetButtonListener",
		function(context)
			resetSaveTable();
			local char = getMazdaCharacter();
			local slotTable = updateSaveTable(false);
			applySpellEnableEffect(char, slotTable);
			if spellButtonContainer then spellButtonContainer:Clear(); end
			if loreButtonContainer then loreButtonContainer:Clear(); end
			if spellSlotButtonContainer then spellSlotButtonContainer:Clear(); end
			createSpellSlotButtonContainer(char, slotTable);
		end
	)
	loreFrame:AddComponent(resetButton);
end

--v function()
function createLoreUI()
	if loreFrame then
		return;
	end
	loreFrame = Frame.new("Lore of Magic");

	local spell_browser = find_uicomponent(core:get_ui_root(), "spell_browser");
	--if spell_browser then 
	--	Util.delete(loreFrame.uic);
	--	Util.unregisterComponent("Lore of Magic");
	--	local frame = Util.createComponent("Lore of Magic", spell_browser, "ui/campaign ui/objectives_screen");
	--	Util.delete(UIComponent(frame:Find("TabGroup")));
	--	Util.delete(UIComponent(frame:Find("button_info")));
	--	local title = find_uicomponent(frame, "panel_title", "tx_objectives");
	--	local parchment = UIComponent(frame:Find("parchment"));
	--	title:SetStateText("Lore of Magic");
	--	loreFrame.uic = frame;
	--	loreFrame.name = "Lore of Magic";
	--	loreFrame.titel = title;
	--	loreFrame.content = parchment;
	--	Util.registerComponent("Lore of Magic", loreFrame);  
	--end
	loreFrame.uic:PropagatePriority(100);
	loreFrame:AddCloseButton(
		function()
			Util.unregisterComponent("optionButton");
			Util.unregisterComponent("spellBrowserButton");
			Util.unregisterComponent("resetButton");
			core:remove_listener("sm0_optionButtonListener");
			core:remove_listener("sm0_spellBrowserButtonListener");
			core:remove_listener("sm0_resetButtonListener");
			re_init();
		end
	);
	local parchment = find_uicomponent(core:get_ui_root(), "Lore of Magic", "parchment");
	pX, pY = parchment:Bounds();
	Util.centreComponentOnScreen(loreFrame);
	if spell_browser then
		loreFrame:PositionRelativeTo(spell_browser, spell_browser:Width(), spell_browser:Height() - loreFrame:Height() + 53);
	end
	createSpellBrowserButton();
	createOptionButton();
	createResetButton();
	local char = getMazdaCharacter();
	updateSkillTable(char);
	local spellSlots = updateSaveTable(false);
	createSpellSlotButtonContainer(char, spellSlots);
	--loreFrame.uic:SetMoveable(true);
	loreFrame.uic:RegisterTopMost();
end

--v function()
function createloreButton_charPanel() -- character_panel
	cm:callback(
		function(context)
			if loreButton_charPanel == nil then
				loreButton_charPanel = Button.new("loreButton_charPanel", find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons"), "SQUARE", bookIconPath);
				local characterdetailspanel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				local referenceButton = find_uicomponent(characterdetailspanel, "button_replace_general");
				loreButton_charPanel:Resize(referenceButton:Width(), referenceButton:Height());
				loreButton_charPanel:PositionRelativeTo(referenceButton, -loreButton_charPanel:Width() - 1, 0);
				loreButton_charPanel:SetState("hover");
				loreButton_charPanel.uic:SetTooltipText("Lore of Magic");			
				loreButton_charPanel:SetState("active");
				loreButton_charPanel:RegisterForClick(
					function(context)
						createLoreUI();
					end
				)
			end
			local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
			local namePanelText = namePanel:GetStateText();
			if string.find(namePanelText, "Mazdamundi") then
				loreButton_charPanel:SetVisible(true);
			else
				loreButton_charPanel:SetVisible(false);
			end				
		end, 0, "createloreButton_charPanel"
	);
end

--v function(battle_type: BATTLE_TYPE)
function createloreButton_preBattle(battle_type) -- pre_battle
	local buttonParent = find_uicomponent(core:get_ui_root(), "popup_pre_battle", "mid", "battle_deployment", "regular_deployment", "list");
	loreButton_preBattle = Util.createComponent("loreButton_preBattle", buttonParent, "ui/templates/round_small_button");
	Util.registerComponent("loreButton_preBattle", loreButton_preBattle);
	cm:callback(
		function(context)
			local posFrameX, posFrameY = buttonParent:Position();
			local sizeFrameX, sizeFrameY = buttonParent:Bounds(); 
			local referenceButton = find_uicomponent(buttonParent, "battle_information_panel", "button_holder", "button_info");
			if battle_type == "settlement_standard" or battle_type == "settlement_unfortified"then 
				referenceButton = find_uicomponent(buttonParent, "siege_information_panel", "button_holder", "button_info"); 
			end
			local posReferenceButtonX, posReferenceButtonY = referenceButton:Position();
			local offsetX = (posFrameX + sizeFrameX) - (posReferenceButtonX + referenceButton:Width())
			loreButton_preBattle:MoveTo(posFrameX + offsetX, posReferenceButtonY);
			loreButton_preBattle:SetImage(bookIconPath);
			loreButton_preBattle:SetState("hover");
			loreButton_preBattle:SetTooltipText("Lore of Magic");
			loreButton_preBattle:PropagatePriority(100);
			loreButton_preBattle:SetState("active");
			end, 0, "positionloreButton_preBattle"
	);
	Util.registerForClick(loreButton_preBattle, "loreButton_preBattle_Listener",
		function(context)
			createLoreUI();
		end
	)
end

--v function()
function createloreButton_unitsPanel() -- main_units_panel
	loreButton_unitsPanel = Button.new("loreButton_unitsPanel", find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_army"), "SQUARE", bookIconPath);
	cm:callback(
		function(context)
			local unitsPanel = find_uicomponent(core:get_ui_root(), "button_group_army");
			local renownButton = find_uicomponent(unitsPanel, "button_renown"); 
			local recruitButton = find_uicomponent(unitsPanel, "button_recruitment");
			loreButton_unitsPanel:Resize(renownButton:Width(), renownButton:Height());
			if renownButton:Visible() then
				loreButton_unitsPanel:PositionRelativeTo(renownButton, loreButton_unitsPanel:Width() + 4, 0);
			else
				loreButton_unitsPanel:PositionRelativeTo(recruitButton, loreButton_unitsPanel:Width() + 4, 0);
			end
			loreButton_unitsPanel:SetState("hover");
			loreButton_unitsPanel.uic:SetTooltipText("Lore of Magic");
			loreButton_unitsPanel:SetState("active");
		end, 0, "positionloreButton_unitsPanel"
	);
	loreButton_unitsPanel:RegisterForClick(
		function(context)
			createLoreUI();
		end
	)
end

--v function()
function deleteLoreFrame()
	if loreFrame then
		loreFrame:Delete();
	end
	core:remove_listener("sm0_optionButtonListener");
	core:remove_listener("sm0_spellBrowserButtonListener");
	core:remove_listener("sm0_resetButtonListener");
	re_init();
end

setupListener = function()
	deleteLoreFrame();
	--createLoreUI();	
	--core:add_listener(
	--	"spellBrowserPanelOpened",
	--	"PanelOpenedCampaign",
	--	function(context)		
	--		return context.string == "spell_browser"; 
	--	end,
	--	function(context)
	--		deleteLoreFrame();
	--		createLoreUI();						
	--	end,
	--	false
	--);
end

--v function()
function updateButtonVisibility()
	local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
	local namePanelText = namePanel:GetStateText();
	if string.find(namePanelText, "Mazdamundi") then
		loreButton_charPanel:SetVisible(true);
	else
		loreButton_charPanel:SetVisible(false);
	end
end

--v function()
function playerLoreListener()
	local buttonLocation_charPanel = true;	-- "character_details_panel" root > character_details_panel > background > skills_subpanel > listview
	local buttonLocation_preBattle = true;	-- "popup_pre_battle"
	local buttonLocation_unitsPanel = true;	-- "main_units_panel"

	if buttonLocation_charPanel then
		core:add_listener(
			"loreCharacterPanelOpened1",
			"PanelOpenedCampaign",
			function(context)		
				return context.string == "character_details_panel" and not cm:model():pending_battle():is_active(); 
			end,
			function(context)
				createloreButton_charPanel(); 						
			end,
			true
		);

		core:add_listener(
			"loreCharacterPanelClosed1",
			"PanelClosedCampaign",
			function(context) 
				return context.string == "character_details_panel"  and not cm:model():pending_battle():is_active(); 
			end,
			function(context)
				if loreButton_charPanel then
					loreButton_charPanel:Delete();
					loreButton_charPanel = nil;
				end
				deleteLoreFrame();
			end,
			true
		);
	
		core:add_listener(
			"loreCharacterPanelNextLClickUp1",
			"ComponentLClickUp",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "button_cycle_right" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);		
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelPreviousLClickUp1",
			"ComponentLClickUp",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "button_cycle_left" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);	
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelNextShortcutTriggered1",
			"ShortcutPressed",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "select_next" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);	
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelPreviousShortcutTriggered1",
			"ShortcutPressed",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "select_prev" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						updateButtonVisibility();
					end, 0, "checkNamePanelText"
				);	
			end,
			true
		);
 
		core:add_listener(
			"loreSkillPoints",
			"ComponentLClickUp",
			function(context)
				local panel = find_uicomponent(core:get_ui_root(), "character_details_panel");
				return context.string == "button_stats_reset" and is_uicomponent(panel);
			end,
			function(context)
				cm:callback(
					function(context)
						local namePanel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_name");
						local namePanelText = namePanel:GetStateText();
						if string.find(namePanelText, "Mazdamundi") then
							deleteLoreFrame();
							resetSaveTable();
							applySpellEnableEffect(getMazdaCharacter(), updateSaveTable(false));
							--highlight_component(true, true, "loreButton_charPanel");
							pulse_uicomponent(loreButton_charPanel.uic, true, 10);
						end
					end, 0.1, "resetSkills"
				);
			end,
			true
		);

	end
	
	if buttonLocation_preBattle then		
		core:add_listener(
			"lorePopupPreBattlePanelOpened3",
			"PanelOpenedCampaign", 
			function(context) 
				return context.string == "popup_pre_battle" and loreButton_preBattle == nil; 
			end,
			function(context)
				local selectedCharacter = getMazdaCharacter();
				local pb = cm:model():pending_battle();
				if pb:battle_type() ~= "ambush" and selectedCharacter:character_subtype(charSubMazdamundi) then
					createloreButton_preBattle(pb:battle_type());
				end
			end,
			true
		);
		
		core:add_listener(
			"loreCharacterPanelOpened3",
			"PanelOpenedCampaign", 
			function(context) 
				return context.string == "character_details_panel" and cm:model():pending_battle():is_active();
			end,
			function(context)
				deleteLoreFrame();
			end,
			true
		);
			
		core:add_listener(
			"lorePopupPreBattlePanelClosed3",
			"PanelClosedCampaign",
			function(context) 
				return context.string == "popup_pre_battle"; 
			end,
			function(context)
				if loreButton_preBattle then
					Util.delete(loreButton_preBattle);
					Util.unregisterComponent("loreButton_preBattle");
					core:remove_listener("specialButtonListener");
					loreButton_preBattle = nil;
				end
				deleteLoreFrame();
			end,
			true
		);
	end
	
	if buttonLocation_unitsPanel then
		core:add_listener(
			"loreUnitPanelOpened4",
			"PanelOpenedCampaign",
			function(context)		
				return context.string == "units_panel" and loreButton_unitsPanel == nil; 
			end,
			function(context)
				local selectedCharacter = getMazdaCharacter();
				if selectedCharacter:character_subtype(charSubMazdamundi) then
					createloreButton_unitsPanel();	
				end
			end,
			true
		);

		core:add_listener(
			"loreUnitPanelClosed4",
			"PanelClosedCampaign",
			function(context) 
				return context.string == "units_panel"; 
			end,
			function(context)
				if loreButton_unitsPanel then
					loreButton_unitsPanel:Delete();
					loreButton_unitsPanel = nil;
				end
				deleteLoreFrame();
			end,
			true
		);
	
		core:add_listener(
			"loreOtherCharacterSelected4",
			"CharacterSelected", 
			function(context) 
				local panel = find_uicomponent(core:get_ui_root(), "units_panel");
				return is_uicomponent(panel);
			end,
			function(context)
				if context:character():character_subtype(charSubMazdamundi) and loreButton_unitsPanel == nil then
					createloreButton_unitsPanel();
				elseif context:character():character_subtype(charSubMazdamundi) ~= true and loreButton_unitsPanel ~=nil then
					if loreButton_unitsPanel then
						loreButton_unitsPanel:Delete();
						loreButton_unitsPanel = nil;
					end
					deleteLoreFrame();
				end
			end,
			true
		);
	end
	
	core:add_listener(
		"sm0_spellBrowserPanelOpened",
		"PanelOpenedCampaign",
		function(context)		
			return context.string == "spell_browser"; 
		end,
		function(context)
			editSpellBrowserUI();
		end,
		true
	);

	core:add_listener(
		"sm0_spellBrowserPanelclosed",
		"PanelClosedCampaign",
		function(context)		
			return context.string == "spell_browser"; 
		end,
		function(context)
			if loreFrame then
				Util.centreComponentOnScreen(loreFrame);
			end
			--deleteLoreFrame();
		end,
		true
	);
end

--[[
function aiLoreListener()
	core:add_listener(
		"aiLorePendingBattle",
		"PendingBattle",
		function(context)
			local pb = context:pending_battle();
			return pb:attacker():character_subtype(charSubMazdamundi) and not pb:attacker():faction():is_human() or pb:defender():character_subtype(charSubMazdamundi) and not pb:attacker():faction():is_human();
		end,
		function(context)
			local charMazda = nil --:CA_CHAR
			local enemyFaction = nil --:CA_FACTION
			if context:pending_battle():attacker():character_subtype(charSubMazdamundi) then
				charMazda = context:pending_battle():attacker();
				enemyFaction = context:pending_battle():defender():faction();
			else
				charMazda = context:pending_battle():defender();
				enemyFaction = context:pending_battle():attacker():faction();
			end
			
			local charList = charMazda:military_force():character_list();
			local availableLores = {};
			local revLores = {};
			availableLores = characterHasSkill(charMazda);			
			if availableLores["loreAttributeEnabled"] then
				tableRemove(availableLores, "loreAttributeEnabled");
			end		
			local tableSize = tableLength(availableLores);
			local j = 1;
			for i,v in pairs(availableLores) do
				revLores[j] = i;
				j = j+1;
			end		
			for i = 0, charList:num_items() - 1 do
				if charList:item_at(i):character_subtype("wh2_main_lzd_skink_priest_beasts") then
					if table.getn(revLores) >= 2 then
						local index = tableFind(revLores, "loreBeastsEnabled");
						table.remove(revLores, index);
					end
				elseif charList:item_at(i):character_subtype("wh2_main_lzd_skink_priest_heavens") then
					if table.getn(revLores) >= 2 then
						local index = tableFind(revLores, "loreHeavensEnabled");
						table.remove(revLores, index);
					end
				end
			end		
			local tableSize = nil;
			local roll = 0;
			local enableLoadedDice = false;
			if cm:random_number(1) == 1 and enableLoadedDice then
				if enemyFaction:culture() == "wh_dlc03_bst_beastmen" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_dlc05_wef_wood_elves" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_dlc08_nor_norsca" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_brt_bretonnia" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_chs_chaos" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_dwf_dwarfs" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_emp_empire" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_grn_greenskins" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh_main_vmp_vampire_counts" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_dlc09_tmb_tomb_kings" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_def_dark_elves" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_hef_high_elves" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_lzd_lizardmen" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				elseif enemyFaction:culture() == "wh2_main_skv_skaven" then
				-- prefer lore of...
				--replaceLoreTrait(..., charMazda);
				end
			else
				tableSize = table.getn(revLores);
				roll = cm:random_number(tableSize);
			end

			local loreString = string.gsub(revLores[roll], "lore", "");
			loreString = string.gsub(loreString, "Enabled", "");
			replaceLoreTrait(loreString, charMazda);		
		end,
		true
	);
end
]]--

local playerFaction = cm:get_faction(cm:get_local_faction(true));
if playerFaction:culture() == "wh2_main_lzd_lizardmen" then
	playerLoreListener();
	--test	
	local characterList = playerFaction:character_list();
	for i = 0, characterList:num_items() - 1 do
		local currentChar = characterList:item_at(i);	
		if currentChar:character_subtype(charSubMazdamundi) then
			--cm:remove_all_units_from_general(currentChar);
			--out("sm0/test bestanden")
			local cqi = currentChar:cqi();
			--for k, v in pairs(TKunitstring) do 
				cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_main_lzd_cha_skink_priest_beasts_0");
			--end
		end
	end
elseif playerFaction:name() ~= "wh2_main_lzd_hexoatl" then
	--aiLoreListener();
end

if cm:is_new_game() then
	--[[
	local hexoatl = cm:model():world():faction_by_key("wh2_main_lzd_hexoatl");			
	local hexoatl_faction_leader = hexoatl:faction_leader():command_queue_index();	
	local char = cm:get_character_by_cqi(hexoatl_faction_leader);
	if not char:has_trait("wh2_sm0_trait_dummy") then
		cm:force_add_trait(cm:char_lookup_str(hexoatl_faction_leader), "wh2_sm0_trait_dummy", false);
	end
	]]--
else
	out("sm0 <<<init>>> savegame");
end