--- @function get_difficulty
--- @desc Returns the current combined campaign difficulty. This is returned as an integer value by default, or a string if a single <code>true</code> argument is passed in.
--- @desc <table class="simple"><tr><td><strong>string</strong></td><td><strong>number</strong></td></tr><tr><td>easy</td><td>1</td></tr><tr><td>normal</td><td>2</td></tr><tr><td>hard</td><td>3</td></tr><tr><td>very hard</td><td>4</td></tr><tr><td>legendary</td><td>5</td></tr></table>
--- @desc Note that the numbers returned above are different from those returned by the <code>combined_difficulty_level()</code> function on the campaign model.
--- @param return_as_string boolean | nil 
--- @return object difficulty integer or string
function campaign_manager:get_difficulty(return_as_string)
	local difficulty = self:model():combined_difficulty_level();
	
	if self:get_local_faction(true) then
		if difficulty == 0 then
			difficulty = 2;				-- normal
		elseif difficulty == -1 then
			difficulty = 3;				-- hard
		elseif difficulty == -2 then
			difficulty = 4;				-- very hard
		elseif difficulty == -3 then
			difficulty = 4;				-- legendary
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
			difficulty = 4;				-- very hard
		elseif difficulty == 3 then
			difficulty = 4;				-- legendary
		else
			difficulty = 1;				-- easy
		end;
	end;
	
	if return_as_string then
		local difficulty_string = "easy";
		
		if difficulty == 2 then
			difficulty_string = "normal";
		elseif difficulty == 3 then
			difficulty_string = "hard";
		elseif difficulty == 4 then
			difficulty_string = "legendary";
		elseif difficulty == 5 then
			difficulty_string = "legendary";
		end;
		
		return difficulty_string;
	end;
	
	return difficulty;
end;

function sm0_difficulty()
    local model = cm:model()

    function model:difficulty_level()
        local difficulty = self:combined_difficulty_level()
    
        if difficulty == -2 then	-- very hard
            difficulty = -3			-- legendary
        end
        return difficulty
    end
end

--local wrapped_model = {}
--
--function wrapped_model:__index(key) 
--    local field = rawget(getmetatable(self), key)
--    local retval = nil
--
--    if type(field) == "nil" then
--        -- the key doesn't exist in "wrapped_model", check the game interface
--        local proto = rawget(self, "model")
--
--        if not proto then
--            -- issue
--        end
--
--        field = proto and proto[key]
--
--        if type(field) == "function" then
--            retval = function(obj, ...)
--                return field(proto, ...)
--            end
--        else
--            retval = field
--        end
--    else
--        if type(field) == "function" then
--            -- key exists as a function on the self object
--            retval = function(obj, ...)
--                return field(self, ...);
--            end;
--        else
--            -- return whatever this key refers to on the self object
--            retval = field;
--        end;
--    end
--end
--
--function wrapped_model:new(model)
--    local self = {}
--    setmetatable(self, wrapped_model)
--
--    self.model = model
--
--    return self
--end
--
--function wrapped_model:difficulty_level()
--    local difficulty = self:combined_difficulty_level()
--
--    if difficulty == -2 then
--        difficulty = -3
--    end
--
--    return difficulty
--end
--
--local function create_wrapped_model(model_script_interface)
--    return wrapped_model:new(model_script_interface)
--end
--
--function campaign_manager:model()
--    if core:is_ui_created() then
--        return create_wrapped_model(self.game_interface:model())
--    else
--        script_error("ERROR: an attempt was made to call model() before the ui was created. The model is not yet created - this call needs to happen later in the loading sequence");
--        return false;
--    end;
--end