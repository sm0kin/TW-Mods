--v function()
local function sm0_log_reset()
	if not __write_output_to_logfile then
		--return
	end
	local logTimeStamp = os.date("%d, %m %Y %X")
	--# assume logTimeStamp: string
	local popLog = io.open("sm0_log.txt","w+")
	popLog :write("NEW LOG ["..logTimeStamp.."] \n")
	popLog :flush()
	popLog :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function sm0_log(text)
	if not __write_output_to_logfile then
		--return
	end
	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","a")
	--# assume logTimeStamp: string
	popLog :write("COST:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

function sm0_recruitment_cost()
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
    end	
    core:add_listener(
		"cost_UnitCreated",
		"UnitCreated",
		true,
		function(context)
			local unit = context:unit()
			local unit_key = unit:unit_key()
			local faction = unit:faction():name()
			sm0_log("Faction = "..faction.." | unit = "..unit_key)
		end,
		true
    )
end