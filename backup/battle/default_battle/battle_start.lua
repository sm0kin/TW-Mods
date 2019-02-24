load_script_libraries();
bm = battle_manager:new(empire_battle:new());

local file_name, file_path = get_file_name_and_path();

package.path = file_path .. "/?.lua;" .. package.path;

bm:out("");
bm:out("* No battle script defined - default script loaded *");
bm:out("");

if core:is_tweaker_set("ALLOW_ADVICE_IN_CUSTOM_BATTLE") then
	bm:out("\tLoading advice");
	require("wh_battle_advice");
else
	bm:out("\tNot loading advice");
end;
--sm0
force_require("battle_speed")	