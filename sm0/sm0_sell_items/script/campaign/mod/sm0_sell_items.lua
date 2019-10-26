--v function()
local function sm0_log_reset()
	if not __write_output_to_logfile then
		return
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
		return
	end
	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","a")
	--# assume logTimeStamp: string
	popLog :write("DEL:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > equipment_items_frame
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > equipment_items_frame > equipment_items_frame
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > equipment_items_frame > equipment_items_frame > icon
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > equipment_items_frame > icon_assigned
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > equipment_items_frame > icon_assigned > frame
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > equipment_items_frame > icon_unique
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > dy_name
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > dy_name > label_rarity
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > dy_name > label_upkeep
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > desc_effect_parent
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > desc_effect_parent > dy_description
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > desc_effect_parent > effect_parent
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_magic_standard_rangers_standard > desc_effect_parent > effect_parent > effect1

--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > equipment_items_frame
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > equipment_items_frame > equipment_items_frame
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > equipment_items_frame > equipment_items_frame > icon
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > equipment_items_frame > icon_assigned
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > equipment_items_frame > icon_assigned > frame
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > equipment_items_frame > icon_unique
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > dy_name
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > dy_name > label_rarity
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > dy_name > label_upkeep
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > desc_effect_parent
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > desc_effect_parent > dy_description
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > desc_effect_parent > effect_parent
--root > character_details_panel > background > character_details_subpanel > frame > ancillary_parent > ancillary_selector > listview > list_clip > list_box > wh_main_anc_talisman_talisman_of_endurance > desc_effect_parent > effect_parent > effect1


-- if icon_unique visible then dont allow selling because it's a quest item
-- use db tables to determine the value based on the items rarity and slot (followers and banners should net less)
-- use label_rarity or label_upkeep as ankor point for the sell button
-- use multiplayer trigger event

-- spawn a character, cm:force_add_ancillary(character), cm:force_remove_ancillary() or delete character

-- use export helpers ancillary_list to determine rarity of a given item
-- rare 10%, uncommon 29%, common 61% | ~ 1:3:6 | hef crafted items and unique items : rare = 1:2 | disable selling specific unique items, e.g. runefangs