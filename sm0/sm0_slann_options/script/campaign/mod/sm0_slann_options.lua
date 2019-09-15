local lzd_names = {
	"1012584779",
	"1013532462",
	"1016390767",
	"1018614790",
	"1022176898",
	"1030065585",
	"1042552047",
	"1047924203",
	"1059779049",
	"1062390673",
	"1065329730",
	"1079274254",
	"1081459835",
	"1081703090",
	"108312091",
	"1085453193",
	"1090792195",
	"112708193",
	"1128670544",
	"1129661942",
	"1142846245",
	"1160723318",
	"116152545",
	"1166423003",
	"1168903698",
	"1171446914",
	"1175252513",
	"1177624275",
	"1184988248",
	"1201485733",
	"1202452913",
	"1202927510",
	"1215775979",
	"1219783641",
	"122286684",
	"1229355954",
	"1231648263",
	"12361275",
	"1236918919",
	"1250584202",
	"1259871264",
	"1263129251",
	"1264733026",
	"1269302821",
	"1278438531",
	"1280642994",
	"1288884462",
	"1294800126",
	"1310343504",
	"1310446084",
	"1324854985",
	"1324941321",
	"1326281280",
	"1326724098",
	"1353770865",
	"1356289644",
	"1356566603",
	"1362078085",
	"1363333122",
	"1364446576",
	"1368122474",
	"137612992",
	"1378812062",
	"1380066014",
	"1380744215",
	"1397995694",
	"1398505952",
	"1401313185",
	"1410675902",
	"1411077650",
	"1421003501",
	"1437874874",
	"145374666",
	"1454423472",
	"1458641200",
	"1469625992",
	"1470540545",
	"1472459423",
	"1472919279",
	"1473628061",
	"1473911762",
	"1476995896",
	"1489797581",
	"14913398",
	"1491960268",
	"1493527763",
	"1493987691",
	"1498354732",
	"1500246029",
	"1500958445",
	"1506504377",
	"1522488145",
	"1530378478",
	"1532519069",
	"1546452451",
	"1550508206",
	"1578546754",
	"1587315827",
	"1590284735",
	"1599338653",
	"1602801961",
	"1611670727",
	"1611886096",
	"1624928487",
	"1629353517",
	"1630404395",
	"1632779532",
	"1654646859",
	"1665910548",
	"1676341093",
	"1678879353",
	"1693345249",
	"1693537039",
	"1697696121",
	"1704479224",
	"1726870476",
	"1730707055",
	"1732784410",
	"1739238479",
	"1748157874",
	"1764203348",
	"1768332744",
	"1784671296",
	"1795269580",
	"1798671473",
	"1802062932",
	"1808882195",
	"1812350887",
	"1823215295",
	"1829147678",
	"1831361289",
	"1833301545",
	"1835134469",
	"1847760918",
	"185300744",
	"1864163160",
	"1870431122",
	"1912324854",
	"1953090586",
	"195872653",
	"1964602427",
	"1978036366",
	"1984387360",
	"1985824774",
	"1986631186",
	"2002934654",
	"2011017380",
	"202746040",
	"2027660324",
	"2031828253",
	"2035660367",
	"2036024401",
	"204202419",
	"204840907",
	"2049506471",
	"2051882403",
	"2052287609",
	"2054852272",
	"2056942179",
	"2064919674",
	"2071366402",
	"2078544449",
	"2085242613",
	"2096652175",
	"2097285565",
	"2100888476",
	"2118037119",
	"2126368843",
	"2132746580",
	"2135622440",
	"214350197",
	"2147358918",
	"2147358920",
	"2147358930",
	"2147358933",
	"2147358944",
	"2147358945",
	"2147358948",
	"2147358952",
	"2147358960",
	"2147358969",
	"2147358975",
	"2147358977",
	"2147359947",
	"2147360260",
	"2147360263",
	"2147360270",
	"2147360276",
	"2147360284",
	"2147360293",
	"2147360735",
	"2147360736",
	"2147360739",
	"218637075",
	"229041625",
	"229403595",
	"236862288",
	"240455301",
	"252877402",
	"270447029",
	"287174792",
	"2875364",
	"292780356",
	"29509732",
	"337192943",
	"338736429",
	"342057746",
	"342672797",
	"349011789",
	"354881608",
	"355805501",
	"36165706",
	"371041638",
	"372887619",
	"375675531",
	"380441613",
	"38378183",
	"395582160",
	"397880040",
	"397940518",
	"411297651",
	"420400453",
	"424584267",
	"434354817",
	"439407375",
	"443040352",
	"446104833",
	"44641691",
	"44644979",
	"448234856",
	"454170098",
	"457245959",
	"471506608",
	"472825808",
	"473131132",
	"480239782",
	"482340705",
	"483508432",
	"498085517",
	"500516350",
	"504006492",
	"514096541",
	"514627497",
	"519923872",
	"543927243",
	"555230641",
	"559477949",
	"568819430",
	"569646155",
	"575481233",
	"577296369",
	"58208089",
	"592760047",
	"596280289",
	"59885231",
	"599614672",
	"605457208",
	"607102253",
	"610936608",
	"615570500",
	"636689673",
	"662490903",
	"669553314",
	"674598659",
	"682342073",
	"683220671",
	"706854888",
	"708079750",
	"712653891",
	"725099876",
	"726266838",
	"779788086",
	"783204500",
	"78362439",
	"786619460",
	"789135266",
	"796631244",
	"802571571",
	"806876580",
	"807443418",
	"81034968",
	"833928687",
	"845689713",
	"84782503",
	"856507573",
	"860882676",
	"861030976",
	"873465354",
	"878403249",
	"887547711",
	"901835743",
	"904330315",
	"905029044",
	"909942348",
	"918033213",
	"929365960",
	"935166503",
	"938227648",
	"938580437",
	"951467627",
	"953626833",
	"96538978",
	"97165453",
	"977101657",
	"981847724",
	"988230570",
	"99038456",
	"997178125"
} --: map<number, string>

--v function(faction_key: string, subtype_key: string)
local function slann_spawn(faction_key, subtype_key)
	local rand = cm:random_number(#lzd_names)
	local name = lzd_names[rand]
	cm:spawn_character_to_pool(faction_key, "names_name_"..name, "names_name_2147360514", "", "", 22, true, "general", subtype_key, false, "")
end

function sm0_slann_options()
    core:remove_listener("slann_RitualCompletedEvent")
	core:remove_listener("slann_DilemmaChoiceMadeEvent")
	core:add_listener(
		"sm0_slann_RitualCompletedEvent",
		"RitualCompletedEvent",
		function(context)
			return context:succeeded()
		end,
		function(context)
			local faction = context:performing_faction()
			local faction_key = faction:name()
			local ritual = context:ritual():ritual_key()
			
			if ritual == "wh2_main_ritual_lzd_awakening" then
				if faction:is_human() == true then
					cm:trigger_dilemma(faction_key, "wh2_main_lzd_slann_selection")
				else
					local slann_rand = cm:random_number(6)

					if slann_rand == 1 then
						slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_fire")
					elseif slann_rand == 2 then
						slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_high")
					elseif slann_rand == 3 then
						slann_spawn(faction_key, "wh2_main_lzd_slann_mage_priest")
					elseif slann_rand == 4 then
						slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_life")
					elseif slann_rand == 5 then
						slann_spawn(faction_key, "wh2_sm0_lzd_slann_mage_priest_heavens")
					else
						slann_spawn(faction_key, "wh2_sm0_lzd_slann_mage_priest_mixed")
					end
				end
			end
		end,
		true
	)
	core:add_listener(
		"sm0_slann_DilemmaChoiceMadeEvent",
		"DilemmaChoiceMadeEvent",
		function(context)
			return context:dilemma() == "wh2_main_lzd_slann_selection"
		end,
		function(context)
			local faction_key = context:faction():name()
			local choice = context:choice()

			if faction_key == "wh2_dlc13_lzd_spirits_of_the_jungle" then
				if choice == 0 then
					-- Fire Slann
					slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_fire_horde")
				elseif choice == 1 then
					-- High Slann
					slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_high_horde")
				elseif choice == 2 then
					-- Light Slann
					slann_spawn(faction_key, "wh2_main_lzd_slann_mage_priest_horde")
				else
					-- Life Slann
                    --slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_life_horde")
                    cm:callback(
						function(context)
							cm:trigger_dilemma(faction_key, "wh2_main_lzd_slann_selection_2")
						end, 0.1, "w8because"
					)	
				end

			else
				if choice == 0 then
					-- Fire Slann
					slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_fire")
				elseif choice == 1 then
					-- High Slann
					slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_high")
				elseif choice == 2 then
					-- Light Slann
					slann_spawn(faction_key, "wh2_main_lzd_slann_mage_priest")
				else
					-- Life Slann
					--slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_life")
					cm:callback(
						function(context)
							cm:trigger_dilemma(faction_key, "wh2_main_lzd_slann_selection_2")
						end, 0.1, "w8because"
					)	                    
				end
			end
		end,
		true
    )
    core:add_listener(
		"sm0_slann_DilemmaChoiceMadeEvent_2",
		"DilemmaChoiceMadeEvent",
		function(context)
			return context:dilemma() == "wh2_main_lzd_slann_selection_2"
		end,
		function(context)
			local faction_key = context:faction():name()
			local choice = context:choice()

			if faction_key == "wh2_dlc13_lzd_spirits_of_the_jungle" then
				if choice == 0 then
					-- Fire Slann
					slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_life_horde")
				elseif choice == 1 then
					-- High Slann
					slann_spawn(faction_key, "wh2_sm0_lzd_slann_mage_priest_heavens_horde")
				elseif choice == 2 then
					-- Light Slann
					slann_spawn(faction_key, "wh2_sm0_lzd_slann_mage_priest_mixed_horde")
				else
					-- Life Slann
                    --slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_life_horde")
					cm:callback(
						function(context)
							cm:trigger_dilemma(faction_key, "wh2_main_lzd_slann_selection")
						end, 0.1, "w8because"
					)	 
				end

			else
				if choice == 0 then
					-- Fire Slann
					slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_life")
				elseif choice == 1 then
					-- High Slann
					slann_spawn(faction_key, "wh2_sm0_lzd_slann_mage_priest_heavens")
				elseif choice == 2 then
					-- Light Slann
					slann_spawn(faction_key, "wh2_sm0_lzd_slann_mage_priest_mixed")
				else
					-- Life Slann
                    --slann_spawn(faction_key, "wh2_dlc13_lzd_slann_mage_priest_life")
					cm:callback(
						function(context)
							cm:trigger_dilemma(faction_key, "wh2_main_lzd_slann_selection")
						end, 0.1, "w8because"
					)	 
				end
			end
		end,
		true
	)
end