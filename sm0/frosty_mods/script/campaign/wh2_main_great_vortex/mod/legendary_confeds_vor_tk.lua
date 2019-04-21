-- Loreful TK Confederations
-- Script by FrostyDemise

------ PHASE ONE: INITIALIZE ------

function legendary_confeds_vor_tk()
out("########## CONFIRMING STARTING CONDITIONS ##########");

if cm:is_new_game() then
			cm:callback(function() confed_commands_vor_tk() end, 1);
end;
end;

------ PHASE TWO: CONFEDERATE ------
function confed_commands_vor_tk()
out("########## TK CONFEDERATION COMMANDS LOOKING TO INITIATE ##########");

-- SETTRA (KHEMRI)
if cm:get_faction("wh2_dlc09_tmb_khemri"):is_human() then

cm:apply_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_1", "wh2_dlc09_tmb_khemri", 0);
cm:apply_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_2", "wh2_dlc09_tmb_khemri", 0);

cm:force_confederation("wh2_dlc09_tmb_khemri", "wh2_dlc09_tmb_lybaras");
cm:force_confederation("wh2_dlc09_tmb_khemri", "wh2_dlc09_tmb_exiles_of_nehek");

-- change method of raising caps
cm:callback(function() 
	cm:remove_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_1", "wh2_dlc09_tmb_khemri");
	cm:remove_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_2", "wh2_dlc09_tmb_khemri");
end, 1);

cm:apply_effect_bundle("frosty_raise_tmb_army_capacity", "wh2_dlc09_tmb_khemri", 0);
cm:apply_effect_bundle("frosty_raise_tmb_army_capacity_2", "wh2_dlc09_tmb_khemri", 0);


-- KHATEP (NEHEK EXILES)
elseif cm:get_faction("wh2_dlc09_tmb_exiles_of_nehek"):is_human() then
cm:apply_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_1", "wh2_dlc09_tmb_exiles_of_nehek", 0);
cm:force_confederation("wh2_dlc09_tmb_exiles_of_nehek", "wh2_dlc09_tmb_lybaras");

-- change method of raising caps
cm:callback(function() 
	cm:remove_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_1", "wh2_dlc09_tmb_exiles_of_nehek");
end, 1);

cm:apply_effect_bundle("frosty_raise_tmb_army_capacity", "wh2_dlc09_tmb_exiles_of_nehek", 0);

-- KHALIDA (LYBARAS)
elseif cm:get_faction("wh2_dlc09_tmb_lybaras"):is_human() then
cm:apply_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_1", "wh2_dlc09_tmb_lybaras", 0);
cm:force_confederation("wh2_dlc09_tmb_lybaras", "wh2_dlc09_tmb_exiles_of_nehek");

-- change method of raising caps
cm:callback(function() 
	cm:remove_effect_bundle("wh2_dlc09_ritual_crafting_tmb_army_capacity_1", "wh2_dlc09_tmb_lybaras");
end, 1);

cm:apply_effect_bundle("frosty_raise_tmb_army_capacity", "wh2_dlc09_tmb_lybaras", 0);

end;
end;


------ PHASE THREE: FORBID CONFEDERATIONS AGAIN ------

--I will look for you...
core:add_listener(
			"relock_confeds",
			"FactionTurnStart",
			true,
            function(context) relock_confeds(context) end,
			true
		);

function relock_confeds(context)
	local turn_number = cm:model():turn_number();

-- I will find you...
    if turn_number == 6 then
        out("########## RELOCKING CONFEDERATIONS ##########");
        cm:callback(
		function()
        cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false);
        cm:force_diplomacy("culture:wh2_dlc09_tmb_tomb_kings", "culture:wh2_dlc09_tmb_tomb_kings", "form confederation", false, false, false);
        core:remove_listener("relock_confeds");
		end, 
		1.0
		);

-- And I will kill you.
	end;
end;