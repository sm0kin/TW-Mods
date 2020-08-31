--wh_chaos_invasion
function ci_get_difficulty()
	local is_multiplayer = cm:is_multiplayer();
	local difficulty = cm:model():combined_difficulty_level();
	
	if cm:get_local_faction(true) then
		if difficulty == 0 then
			difficulty = 2;				-- normal
		elseif difficulty == -1 then
			difficulty = 3;				-- hard
		elseif difficulty == -2 then
			difficulty = 5;				-- very hard
		elseif difficulty == -3 then
			difficulty = 5;				-- legendary
		else
			difficulty = 1;				-- easy
		end;
	else
	-- autorun
		if difficulty == 0 then
			difficulty = 2;				-- normal
		elseif difficulty == 1 then
			difficulty = 3;				-- hard
		elseif difficulty == 2 then
			difficulty = 5;				-- very hard
		elseif difficulty == 3 then
			difficulty = 5;				-- legendary
		else
			difficulty = 1;				-- easy
		end;
	end;
	
	return difficulty;
end;

--wh_dlc08_norsca_chaos_invasion
function NCI_Add_Army_XP(cqi, force_xp)
	local xp = force_xp;
	
	if xp == nil then
		local difficulty = cm:model():difficulty_level();
		
		if difficulty == -1 then
			-- Hard
			xp = 2;
		elseif difficulty == -2 then
			-- Very Hard
			xp = 7;
		elseif difficulty == -3 then
			-- Legendary
			xp = 7;
		else
			xp = 0;
		end
	end
	
	cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(cqi), xp);
end

--wh2_vortex_rituals
function vortex_get_difficulty()
	local difficulty = cm:model():combined_difficulty_level();
	
	local local_faction = cm:get_local_faction(true);
	
	if local_faction and cm:get_faction(local_faction) then
		if difficulty == 0 then
			difficulty = "normal";
		elseif difficulty == -1 then
			difficulty = "hard";
		elseif difficulty == -2 then
			difficulty = "legendary";
		elseif difficulty == -3 then
			difficulty = "legendary";
		else
			difficulty = "easy";
		end;
	else
	-- autorun
		if difficulty == 0 then
			difficulty = "normal";
		elseif difficulty == 1 then
			difficulty = "hard";
		elseif difficulty == 2 then
			difficulty = "legendary";
		elseif difficulty == 3 then
			difficulty = "legendary";
		else
			difficulty = "easy";
		end;
	end;
	
	return difficulty;
end;