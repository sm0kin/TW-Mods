phoenixcrown = 0

local function sr_phoenix_crown()
	if cm:model():campaign_name("main_warhammer") then
		if phoenixcrown == 0 then
			core:add_listener(
				"kakoccupylistner",
				"GarrisonOccupiedEvent",
				function(context)
					return context:character():region():name() == "wh_main_the_silver_road_karaz_a_karak"
				end,
				function()
					occupy_kak()
				end,
				true
			)
		end
	end
end

function occupy_kak()
	local kak_region = cm:get_region("wh_main_the_silver_road_karaz_a_karak")

	if kak_region:owning_faction():name() == "wh2_main_hef_eataine" then
		cm:apply_effect_bundle("wh2_main_hef_return_phoenix_crown", "wh2_main_hef_eataine", -1)
		cm:treasury_mod("wh2_main_hef_eataine", 8000)
		phoenixcrownmess()
		phoenixcrown = 1
		core:remove_listener("kakoccupylistner")
	elseif kak_region:owning_faction():name() == "wh2_main_hef_order_of_loremasters" then
		cm:apply_effect_bundle("wh2_main_hef_return_phoenix_crown", "wh2_main_hef_order_of_loremasters", -1)
		cm:treasury_mod("wh2_main_hef_order_of_loremasters", 8000)
		phoenixcrownmess()
		phoenixcrown = 1
		core:remove_listener("kakoccupylistner")
	elseif kak_region:owning_faction():name() == "wh2_main_hef_nagarythe" then
		cm:apply_effect_bundle("wh2_main_hef_return_phoenix_crown", "wh2_main_hef_nagarythe", -1)
		cm:treasury_mod("wh2_main_hef_nagarythe", 8000)
		phoenixcrownmess()
		phoenixcrown = 1
		core:remove_listener("kakoccupylistner")
	elseif kak_region:owning_faction():name() == "wh2_main_hef_avelorn" then
		cm:apply_effect_bundle("wh2_main_hef_return_phoenix_crown", "wh2_main_hef_avelorn", -1)
		cm:treasury_mod("wh2_main_hef_avelorn", 8000)
		phoenixcrownmess()
		phoenixcrown = 1
		core:remove_listener("kakoccupylistner")
	end
end

function phoenixcrownmess()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_phoenixcrownmess_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_phoenixcrownmess_secondary_detail",
			true,
			870
		)
	end
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("phoenixcrown", phoenixcrown, context)
	end
)

cm:add_loading_game_callback(
	function(context)
		phoenixcrown = cm:load_named_value("phoenixcrown", 0, context)
	end
)

local mcm = _G.mcm

if not not mcm then
	local ovn = nil;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local phoenix_crown = ovn:add_tweaker("phoenix_crown", "Phoenix Crown", "")
	phoenix_crown:add_option("enable", "Enable", "")
	phoenix_crown:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_phoenix_crown_value") == "enable" then
				sr_phoenix_crown()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_phoenix_crown_value") == "enable" then sr_phoenix_crown() end
	end
)