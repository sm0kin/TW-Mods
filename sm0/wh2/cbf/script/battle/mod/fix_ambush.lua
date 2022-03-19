local bm = get_bm()

local gb = generated_battle:new(
	false,
	false,
	false,                                      	
	nil, 	
	false                                      
)

bm:out("cbf battle test!");

--local player_army = bm:get_player_army()
--local ai_army = bm:get_first_non_player_army()
local player_army = gb:get_army(gb:get_player_alliance_num(), bm:local_army())
local ai_army =  gb:get_army(gb:get_non_player_alliance_num(), bm:local_army())

local player_force = gb:get_allied_force(gb:get_player_alliance_num(), bm:local_army())
local enemy_force = gb:get_enemy_force(gb:get_player_alliance_num(), bm:local_army())
--local ai_planner = script_ai_planner:new("ai_ambush", enemy_force.sunit_list, false)


bm:register_phase_change_callback(
	"Deployed", 
	function()
		bm:out("cbf battle - Deployed")
		bm:out("cbf battle - "..tostring(ai_army:get_first_scriptunit()))

		--player_army:set_up_script_planner()
		--local player_sp  = player_army.script_ai_planner
		--player_sp:attack_force(enemy_force)
		--bm:out("cbf battle - player_sp:attack_force!")
		ai_army:set_up_script_planner()
		local ai_sp  = ai_army.script_ai_planner
		--ai_army:release_control_of_all_sunits()
		ai_sp:set_should_reorder(false)
		--ai_sp:attack_force(player_force)
		ai_sp:move_to_force(player_force)
		bm:out("cbf battle - ai_sp:attack()!")
	end
)

