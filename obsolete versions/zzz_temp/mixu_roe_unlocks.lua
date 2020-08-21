local empire_ror_list = {
	"wh2_mixu_emp_ror_company_of_honour",
	"wh2_mixu_emp_ror_deaths_heads",
	"wh2_mixu_emp_ror_helhuntens_redeemers",
	"wh2_mixu_emp_ror_talabheim_curs",
	"wh2_mixu_emp_ror_horned_hunters",
	"wh2_mixu_emp_ror_knights_of_the_black_lynx",
	"wh2_mixu_emp_ror_nuln_ironsides",
	"wh2_mixu_emp_ror_hergig_long_gunners",
	"wh2_mixu_emp_ror_sardellos_stickers",
	"wh2_mixu_emp_ror_fireloques_of_ferlangen",
	"wh2_mixu_emp_ror_bergjaeger",
	"wh2_mixu_emp_ror_laurelorn_waywatchers",
	"wh2_mixu_emp_ror_lions_roar",
	"wh2_mixu_emp_ror_knights_of_the_black_rose",
	"wh2_mixu_emp_ror_knights_of_taals_fury",
	"wh2_mixu_emp_ror_fellwolf_brotherhood"
};	

function mixu_roe_unlocks()

		--cm:set_saved_value("mixu_campaign_supplement_1", true);

		local player_faction = cm:get_human_factions();
		
		for i = 1, #player_faction do
			local current_faction = cm:model():world():faction_by_key(player_faction[i])
			mixu_add_ror_unlock_listeners(player_faction[i])
			if cm:is_new_game() then
				if current_faction:subculture() == "wh_main_sc_emp_empire" then
					for j = 1, #empire_ror_list do
						local current_unit = empire_ror_list[j]		
						mixu_roe_log("Adding "..current_unit.." to the merc pool and locking them for future usage.")
						if current_unit == "wh2_mixu_emp_ror_talabheim_curs" and current_faction:name() == "wh_main_emp_talabecland" then
							cm:add_unit_to_faction_mercenary_pool(current_faction, current_unit, 1, 100, 1, 0.1, 0, "", "", "")
						elseif current_faction:name() == "wh_main_emp_marienburg" then
							cm:add_unit_to_faction_mercenary_pool(current_faction, "wh2_mixu_emp_ror_mananns_blades", 1, 100, 1, 0.1, 0, "", "", "")
						elseif current_faction:has_pooled_resource("emp_loyalty") == true then
							cm:add_unit_to_faction_mercenary_pool(current_faction, current_unit, 1, 100, 1, 0.1, 0, "", "", "")
							cm:add_event_restricted_unit_record_for_faction(current_unit, current_faction:name(), "mixu_ror_lock_reason_" .. current_unit)
						end
					end
				end
			end
		end
end

--	{subtype = "emp_edward_van_der_kraal", unit_key = "wh2_mixu_emp_ror_mananns_blades", required_rank = 10, minister = nil},

function mixu_add_ror_unlock_listeners(faction_key)

local mixu_lords_with_rors = {
	{subtype = "emp_marius_leitdorf", unit_key = "wh2_mixu_emp_ror_bergjaeger", required_rank = 10, minister = "emp_averland"},
	{subtype = "emp_marius_leitdorf", unit_key = "wh2_mixu_emp_ror_knights_of_the_black_lynx", required_rank = 20, minister = "emp_averland"},
	{subtype = "mixu_elspeth_von_draken", unit_key = "wh2_mixu_emp_ror_nuln_ironsides", required_rank = 10, minister = "emp_wissenland"},
	{subtype = "emp_aldebrand_ludenhof", unit_key = "wh2_mixu_emp_ror_hergig_long_gunners", required_rank = 10, minister = "emp_hochland"},
	{subtype = "emp_theoderic_gausser", unit_key = "wh2_mixu_emp_ror_laurelorn_waywatchers", required_rank = 10, minister = "emp_nordland"},
	{subtype = "emp_wolfram_hertwig", unit_key = "wh2_mixu_emp_ror_deaths_heads", required_rank = 10, minister = "emp_ostermark"},
	{subtype = "emp_valmir_von_raukov", unit_key = "wh2_mixu_emp_ror_fireloques_of_ferlangen", required_rank = 10, minister = "emp_ostland"},
	{subtype = "emp_alberich_haupt_anderssen", unit_key = "wh2_mixu_emp_ror_helhuntens_redeemers", required_rank = 10, minister = "emp_stirland"},
	{subtype = "emp_helmut_feuerbach", unit_key = "wh2_mixu_emp_ror_horned_hunters", required_rank = 10, minister = "emp_talabecland"},
	{subtype = "emp_helmut_feuerbach", unit_key = "wh2_mixu_emp_ror_knights_of_taals_fury", required_rank = 20, minister = "emp_talabecland"},	
	{subtype = "emp_karl_franz", unit_key = "wh2_mixu_emp_ror_company_of_honour", required_rank = 10, minister = "emp_reikland"},
	{subtype = "dlc03_emp_boris_todbringer", unit_key = "wh2_mixu_emp_ror_fellwolf_brotherhood", required_rank = 10, minister = "emp_middenland"},
	{subtype = "dlc05_wef_glade_lord_fem", unit_key = "wh2_mixu_emp_ror_knights_of_the_black_rose", required_rank = 10, minister = "emp_sylvania"},
	{subtype = "dlc05_wef_glade_lord_fem", unit_key = "wh2_mixu_emp_ror_sardellos_stickers", required_rank = 10, minister = "emp_wasteland"}
};

	for i = 1, #mixu_lords_with_rors do
		local current_subtype = mixu_lords_with_rors[i].subtype
		local current_unit = mixu_lords_with_rors[i].unit_key
		local current_rank_req = mixu_lords_with_rors[i].required_rank
		local current_minister = mixu_lords_with_rors[i].minister
		local current_faction = "wh_main_"..current_minister
		
		if current_minister == "emp_reikland" then
			current_faction = "wh_main_emp_empire"
		end
		
		--if not cm:get_saved_value("mixu_roe_unlock_rors_"..current_unit) then
			mixu_roe_log("Adding listeners for RoR unlocking: "..current_unit)
			
			if faction_key == current_faction then
			--	mixu_roe_log("Adding faction leader listener for: "..current_unit)
				core:add_listener(
					"mixu_roe_unlock_rors_"..current_unit,
					"CharacterTurnStart",
					function(context)
						local character = context:character();
						local faction = character:faction();
						return faction:name() == current_faction and character:is_faction_leader() and character:character_subtype(current_subtype) and character:rank() >= current_rank_req
					end,
					function(context)
						local character = context:character();
						local faction = character:faction();
						
						--if not cm:get_saved_value("mixu_roe_unlock_rors_"..current_unit) then
							--cm:set_saved_value("mixu_roe_unlock_rors_"..current_unit, true);
							cm:remove_event_restricted_unit_record_for_faction(current_unit, faction:name())
							
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit);
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit.."_CharacterRankUp");
						--end
					end,
					true
				);
				core:add_listener(
					"mixu_roe_unlock_rors_"..current_unit.."_CharacterRankUp",
					"CharacterRankUp",
					function(context)
						local character = context:character();
						local faction = character:faction();
						return faction:name() == current_faction and character:is_faction_leader() and character:character_subtype(current_subtype) and character:rank() >= current_rank_req;
					end,
					function(context)
						local character = context:character();
						local faction = character:faction();
						
						--if not cm:get_saved_value("mixu_roe_unlock_rors_"..current_unit) then
							--cm:set_saved_value("mixu_roe_unlock_rors_"..current_unit, true);
							cm:remove_event_restricted_unit_record_for_faction(current_unit, faction:name())
							
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit);
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit.."_CharacterRankUp");
						--end
					end,
					true
				)
			else
			--	mixu_roe_log("Adding minister listener for: "..current_unit)
				core:add_listener(
					"mixu_roe_unlock_rors_"..current_unit,
					"CharacterTurnStart",
					function(context)
						local character = context:character();
						local faction = character:faction();
						return character:ministerial_position() == "wh2_main_minister_"..current_minister and character:rank() >= current_rank_req
					end,
					function(context)
						local character = context:character();
						local faction = character:faction();
						
						--if not cm:get_saved_value("mixu_roe_unlock_rors_"..current_unit) then
							--cm:set_saved_value("mixu_roe_unlock_rors_"..current_unit, true);
							cm:remove_event_restricted_unit_record_for_faction(current_unit, faction:name())
							
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit);
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit.."_CharacterRankUp");
						--end
					end,
					true
				);
				core:add_listener(
					"mixu_roe_unlock_rors_"..current_unit.."_CharacterRankUp",
					"CharacterRankUp",
					function(context)
						local character = context:character();
						local faction = character:faction();
						return faction:name() == current_faction and character:ministerial_position() == "wh2_main_minister_"..current_minister and character:rank() >= current_rank_req;
					end,
					function(context)
						local character = context:character();
						local faction = character:faction();
						
						--if not cm:get_saved_value("mixu_roe_unlock_rors_"..current_unit) then
							--cm:set_saved_value("mixu_roe_unlock_rors_"..current_unit, true);
							cm:remove_event_restricted_unit_record_for_faction(current_unit, faction:name())
							
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit);
							--core:remove_listener("mixu_roe_unlock_rors_"..current_unit.."_CharacterRankUp");
						--end
					end,
					true
				)			
			end
		end
	--end
end

--------------------------------------------------------------
------------------------- LOGGING ----------------------------
--------------------------------------------------------------
core:add_listener(
	"mixu_roe_log",
	"LoadingGame",
	true,
	function(context) 	
		if not cm:is_new_game() then
			cm:set_saved_value("mixu_log_refresh", false)
		end
		if not cm:get_saved_value("Mixu_Legendary_Lords_II") then			
			mixu_roe_refresh_log()
		end
	end,
	true
);

function mixu_roe_refresh_log()
	if cm:get_saved_value("mixu_log_refresh") then
		return 
	end
	cm:set_saved_value("mixu_log_refresh", true)
	
    if not __write_output_to_logfile then
        return;
    end
    
    local logTimeStamp = os.date("%d, %m %Y %X")
    
	local popLog = io.open("Mixu_Log.txt","w+")
    popLog :write("NEW LOG ["..logTimeStamp.."] \n")
    popLog :flush()
    popLog :close()
end


function mixu_roe_log(text)
    ftext = "ROE";
	
    if not __write_output_to_logfile then
      return;
    end

  local logText = tostring(text)
  local logContext = tostring(ftext)
  local logTimeStamp = os.date("%d, %m %Y %X")
  local popLog = io.open("Mixu_Log.txt","a")

  popLog :write(logContext .. ":  "..logText .. "    : [".. logTimeStamp .. "]\n")
  popLog :flush()
  popLog :close()
end
