-- wh_campaign_setup.lua upkeep_penalty_condition function override
--v function(faction: CA_FACTION) --> boolean
function upkeep_penalty_condition(faction)
	local culture = faction:culture()
	local subculture = faction:subculture()
	out("sm0/upkeep_penalty_condition/culture = "..culture)
	out("sm0/upkeep_penalty_condition/subculture = "..subculture)
	return faction:is_human() and not wh_faction_is_horde(faction) and culture ~= "wh_main_brt_bretonnia" and culture ~= "wh2_dlc09_tmb_tomb_kings" and subculture ~= "wh_main_sc_nor_norsca"
end