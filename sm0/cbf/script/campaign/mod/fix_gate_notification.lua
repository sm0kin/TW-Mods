function fix_gate_notification()
    local id = 810 --hef
	
	local culture = cm:get_faction(cm:get_local_faction(true)):culture()
	
	if culture == "wh2_main_def_dark_elves" then
		id = 811
	elseif culture == "wh2_main_lzd_lizardmen" then
		id = 812
	elseif culture == "wh2_main_skv_skaven" then
		id = 813
	elseif culture == "wh2_dlc09_tmb_tomb_kings" then
		id = 902	
	elseif culture == "wh2_dlc11_cst_vampire_coast" then
		id = 904	
	end

	core:add_listener(
		"gate_notif_RegionGainedDevlopmentPoint",
		"RegionGainedDevlopmentPoint",
        function(context)
            return context:region():owning_faction():is_human()
        end,
        function(context)
            out("sm0/RegionGainedDevlopmentPoint")
			cm:show_message_event(
                context:region():owning_faction():name(),
                "event_feed_targeted_events_title_provinces_development_points_availableevent_feed_target_province_faction",
                "event_feed_strings_text_wh_event_feed_string_province_settlement_province_secondary_detail",
                "event_feed_strings_text_wh_event_feed_string_province_development_points_available_secondary_detail",
                true,
                id
            )
		end,
		true
	)
end