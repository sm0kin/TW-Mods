local function sm0_print_all_uicomponent_children(uic)
	out(uicomponent_to_str(uic))
	for i = 0, uic:ChildCount() - 1 do
		local uic_child = UIComponent(uic:Find(i))
		sm0_print_all_uicomponent_children(uic_child)
	end
end

core:add_listener(
	"output_uicomponent_on_click",
	"ComponentLClickUp",
	true,
	function(context) sm0_print_all_uicomponent_children(UIComponent(context.component), true) end,
	true
)

local mixu = {
	"Marius Leitdorf",
	"Aldebrand Ludenhof",
	"Edward van der Kraal",
	"Boris Todbringer",
	"Theoderic Gausser",
	"Wolfram Hertwig",
	"Valmir von Raukov",
	"Helmut Feuerbach",
	"Elspeth von Draken",
	"Katarin the Ice Queen",
	"Alberich Haupt-Anderssen",
	"Chilfroy de Artois",
	"Bohemond Beastslayer",
	"Adalhard de Lyonesse",
	"Cassyon de Parravon",
	"Daith",
	"Kazador Dragonslayer",
	"Thorek Ironbrow",
	"Belannaer the Wise",
	"Prince Imrik",
	"Korhil",
	"Lord Huinitenuchli",
	"Gor-Rok",
	"Tetto'eko",
	"Oxyotl",
	"Tullaris Dreadbringer",
	"Sir John Tyreweld",
	"Egrimm van Horstmann",
	"Egil Styrbjorn",
	"Gorfang Rotgut",
	"Tutankhanut",
	"Naieth the Prophetess"
} 

local mixu1 = {
	["Marius Leitdorf"] = {"empire", "the empire", "empire provinces", "averland", "unlocker", "faction unlocker", "crynsos", "mixu", "mixu 1", "Mixu's Legendary Lords 1"},
	["Aldebrand Ludenhof"] = {"empire"},
	"Edward van der Kraal",
	"Boris Todbringer",
	"Theoderic Gausser",
	"Wolfram Hertwig",
	"Valmir von Raukov",
	"Helmut Feuerbach",
	"Elspeth von Draken",
	"Katarin the Ice Queen",
	"Alberich Haupt-Anderssen",
	"Chilfroy de Artois",
	"Bohemond Beastslayer",
	"Adalhard de Lyonesse",
	"Cassyon de Parravon",
	"Daith",
	"Kazador Dragonslayer",
	"Thorek Ironbrow"
} 

local mixu2 = {
	"Belannaer the Wise",
	"Prince Imrik",
	"Korhil",
	"Lord Huinitenuchli",
	"Gor-Rok",
	"Tetto'eko",
	"Oxyotl",
	"Tullaris Dreadbringer",
	"Sir John Tyreweld",
	"Egrimm van Horstmann",
	"Egil Styrbjorn",
	"Gorfang Rotgut",
	"Tutankhanut",
	"Naieth the Prophetess"
}
--[[
["Emperor Karl Franz"] = {"emperor karl franz", "emperor", "karl franz", "karl", "franz", "karl franz i", "protector of the empire", "defier of the dark", "emperor himself", "the son of emperors", "elector count of reikland", "prince of altdorf", "empire", "the empire", "empire provinces", "reikland", "CA", "vanilla", "no peace, just war", "summon the elector counts", "i am franz, they will obey", "bring me to my men", "this action does not have my consent"},
["Balthasar Gelt"] = {"balthasar gelt", "balthasar", "gelt", "supreme patriarch", "gold", "metal", "empire", "the empire", "empire provinces", "reikland", "CA", "vanilla"},
"Volkmar the Grim",
["Marius Leitdorf"] = {"marius leitdorf", "marius", "leitdorf", "mad count", "empire", "the empire", "empire provinces", "averland", "mod", "crynsos", "faction unlocker", "unlocker", "mixu", "mixu 1", "Mixu's Legendary Lords 1"},
["Aldebrand Ludenhof"] = {"empire"},
--]]

local factionLeaders = {
	"Emperor Karl Franz",
	"Balthasar Gelt",
	"Volkmar the Grim",
	"Marius Leitdorf",
	"Aldebrand Ludenhof",
	"Emil von Korden",
	"Boris Todbringer",
	"Theoderic Gausser",
	"Wolfram Hertwig",
	"Valmir von Raukov",
	"Alberich Haupt-Anderssen",
	"Helmut Feuerbach",
	"Elspeth von Draken",
	"Hans Zintler",
	"Balthasar Gelt",
	"Katarin the Ice Queen",
	"Syrgei Tannarov",
	"Xavier Rothemuur",
	"Valmir Gausser",
	"Gashnag the Black Prince",
	"Lupio Sunscryer",
	"Lucrezzia Belladonna",
	"Lord Durant",
	"Lorenzo Lupo",
	"Leonardo Catrazza",
	"Borgio the Besieger",
	"Tibaldus Marsarius de Vela",
	"El Cadavo",
	"Marco Colombo",
	"Thorgrim Grudgebearer",
	"Grombrindal - The White Dwarf",
	"Belegar Ironhammer",
	"Ungrim Ironfist",
	"Byrrnoth Grundadrakk",
	"Kazador Dragonslayer",
	"Thorek Ironbrow",
	"Alrik Ranulfsson",
	"Brokk Ironpick",
	"Rorek Granitehand",
	"Thorgard Cromson",
	"Barundin Stoneheart",
	"Thyk Skolsson",
	"Thrund Holdfast",
	"Hugrim Redaxe",
	"Louen Leoncoeur",
	"Alberic de Bordeleaux",
	"The Fay Enchantress",
	"Chilfroy",
	"Bohemond Beastslayer",
	"Adalhard",
	"Cassyon",
	"Armand d'Aquitaine",
	"Theodoric d'Brionne",
	"Hagen d'Gisoreux",
	"Taubert de L'Anguille",
	"Folcard d'Montfort",
	"Tancred II d'Quenelles",
	"Sir John Tyreweld",
	"Mogen of the Flame",
	"Baron Thegan",
	"Marcel de Parravon",
	"Orion",
	"Durthu",
	"Daith",
	"Findol",
	"Oreon",
	"Tyrion",
	"Teclis",
	"Alarielle the Radiant",
	"Alith Anar",
	"Erethond",
	"Valin",
	"Serra",
	"Gilgalion",
	"Haerrieth",
	"Surthara Bel-Kec",
	"Ingmir",
	"Lord Mazdamundi",
	"Kroq-Gar",
	"Rinki",
	"Botl-Xlotac",
	"Boqhui",
	"Oatluax",
	"Toc-chicc",
	"Uaxti",
	"Settra the Imperishable",
	"Grand Hierophant Khatep",
	"High Queen Khalida",
	"Arkhan the Black",
	"Itobom",
	"Nectanebo",
	"Hakor",
	"Ophtos",
	"Grimgor Ironhide",
	"Skarsnik",
	"Wurrzag Da Great Green Prophet",
	"Grotslik",
	"Gnashrak Badtooth",
	"Rotfang the Redcap",
	"Gorduz Backstabba",
	"Azhag the Slaughterer",
	"Gorfang Rotgut",
	"Spite Backbiter",
	"Ugrok Craktoof",
	"Morglum Necksnapper",
	"Greebitz Blackbog",
	"Vishus Gobspit",
	"Mash One-Finger",
	"Greebitz Bootlicka",
	"Mannfred von Carstein",
	"Helman Ghorst",
	"Vlad von Carstein",
	"Isabella von Carstein",
	"Heinrich Kemmler",
	"The Red Duke",
	"Zelig van Kruger",
	"W'soran",
	"Ushoran",
	"Layla the Bloody",
	"Luthor Harkon",
	"Count Noctilus",
	"Aranessa Saltspite",
	"Cylostra Direfin",
	"Count Gyula",
	"Archaon the Everchosen",
	"Kholek Suneater",
	"Prince Sigvald the Magnificent",
	"Sarthorael the Ever-Watcher",
	"Egrimm van Horstmann",
	"Arbaal the Undefeated",
	"Khazrak the One-Eye",
	"Malagor the Dark Omen",
	"Morghur the Shadowgave",
	"Srui Limb-Render",
	"Ghorroz Death-Maker",
	"Gallak Blood-Gorge",
	"Khorok Manripper",
	"Wulfrik the Wanderer",
	"Throgg",
	"Hakka the Aesling",
	"Einarr Steelfist",
	"Jormungand Sagaprophet",
	"Haargroth the Blooded",
	"Egil Styrbjorn",
	"Surtha Ek",
	"Thorhall",
	"Welch",
	"Knute",
	"Malekith",
	"Morathi",
	"Crone Hellebron",
	"Lokhir Fellheart",
	"Exarian",
	"Valanduil",
	"Alyssa",
	"Arathar",
	"Cekhullil",
	"Caladrielle",
	"Corvishish",
	"Shakkara",
	"Nocrusith",
	"Nelosi",
	"Volilosh",
	"Queek Headtaker",
	"Lord Skrolk",
	"Tretch Craventail",
	"Ulcess",
	"Shredder",
	"Rasknitt",
	"Toxer",
	"Grand Beastmaster Fetch",
	"Vomeek",
	"Morlocke",
	"Skittice",
	"Obscide",
	"Helkeek",
	"Moltskin",
	"Khar Bloodclaw",
	"Nagbad Gutstabba",
	"Bernhoff the Butcher",
	"Ashuk Spiderkilla",
	"Thogga Manflaya",
	"Kale-Qano",
	"Montez Drago",
	"Grimm Oathkeeper",
	"Gerhardt von Wulfen",
	"Sa'ved Rahtep",
	"Odin Bloodreaper",
	"Tevaril",
	"Duke Jerrod, Palatine of Asareux",
	"Grutter Wolfherda",
	"Mengil Manhide",
	"Karakas the Insane",
	"Arog Toof-Taka",
	"Tito Marcelli",
	"Carlo Buffone",
	"Salvatorio Rocchi",
	"Cedric the Cursed",
	"Siegfried Hammerheim",
	"Skraga Bloodreapa",
	"Maldred von Waldenhof",
	"Orilon",
	"Urk Bonecrusha",
	"Vashnaar the Tormentor",
	"Eldarion",
	"Sesteshal",
	"Dhulas"
} --:vector<string>

local cataph = {
	"Valmir Gausser",
	"Gashnag the Black Prince",
	"Lupio Sunscryer",
	"Lucrezzia Belladonna",
	"Leonardo Catrazza",
	"Borgio the Besieger",
	"El Cadavo",
	"Marco Colombo",
	"Thorgard Cromson"
}

local vanilla = {
	"Tyrion",
	"Teclis",
	"Alarielle the Radiant",
	"Alith Anar",
	"Lord Mazdamundi",
	"Kroq-Gar",
	"Malekith",
	"Morathi",
	"Crone Hellebron",
	"Lokhir Fellheart",
	"Queek Headtaker",
	"Lord Skrolk",
	"Tretch Craventail",
	"Luthor Harkon",
	"Count Noctilus",
	"Aranessa Saltspite",
	"Cylostra Direfin",
	"Settra the Imperishable",
	"Grand Hierophant Khatep",
	"High Queen Khalida",
	"Arkhan the Black",
	"Emperor Karl Franz",
	"Balthasar Gelt",
	"Volkmar the Grim",
	"Thorgrim Grudgebearer",
	"Grombrindal - The White Dwarf",
	"Belegar Ironhammer",
	"Ungrim Ironfist",
	"Grimgor Ironhide",
	"Azhag the Slaughterer",
	"Skarsnik",
	"Wurrzag Da Great Green Prophet",
	"Mannfred von Carstein",
	"Helman Ghorst",
	"Vlad von Carstein",
	"Isabella von Carstein",
	"Heinrich Kemmler",
	"Wulfrik the Wanderer",
	"Throgg",
	"Louen Leoncoeur",
	"Alberic de Bordeleaux",
	"The Fay Enchantress",
	"Orion",
	"Durthu",
	"Khazrak the One-Eye",
	"Malagor the Dark Omen",
	"Morghur the Shadowgave",
	"Archaon the Everchosen",
	"Kholek Suneater",
	"Prince Sigvald the Magnificent"
}

local textBox = nil --:CA_UIC
local applyButton = nil --:CA_UIC
local filterTable = {}
--local savedEntry = tonumber(core:svr_load_string("svr_battleSpeed")) or 1 --:number

--v function(uic: CA_UIC)
local function deleteUIC(uic)
    local root = core:get_ui_root()
    root:CreateComponent("Garbage", "UI/campaign ui/script_dummy")
    local component = root:Find("Garbage")
    local garbage = UIComponent(component)
    garbage:Adopt(uic:Address())
    garbage:DestroyChildren()
end

--v function()
local function deleteSelectUI()
    if textBox then
        deleteUIC(textBox)
        textBox = nil
	end
	if applyButton then
        deleteUIC(applyButton)
        core:remove_listener("sm0_applyButton")
        applyButton = nil
    end
end

--v function(lordTable: map<string, vector<string>>)
local function createSelectUI(lordTable)
	--[out] <397.7s>   root > sp_frame > menu_bar > button_tw_academy
	local menu_bar = find_uicomponent(core:get_ui_root(), "sp_frame", "menu_bar")
	--[out] <151.5s>   root > sp_grand_campaign > dockers > top_docker > lord_select_list > list
	local uiParent = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "top_docker", "lord_select_list", "list")

    local referenceButton = find_uicomponent(menu_bar, "button_tw_academy")
    local referenceButtonW, referenceButtonH = referenceButton:Bounds()
    local referenceButtonX, referenceButtonY = referenceButton:Position()

    deleteSelectUI()

    uiParent:CreateComponent("textBox", "ui/common ui/text_box")
    textBox = UIComponent(uiParent:Find("textBox"))
    uiParent:Adopt(textBox:Address())
    textBox:PropagatePriority(referenceButton:Priority())
    textBox:SetCanResizeHeight(true)
    textBox:SetCanResizeWidth(true)
    textBox:Resize(6*referenceButtonW, referenceButtonH)
    textBox:SetCanResizeHeight(false)
    textBox:SetCanResizeWidth(false)
	--textBox:MoveTo(referenceButtonX, referenceButtonY + 600)


    uiParent:CreateComponent("applyButton", "ui/templates/square_medium_button")
    applyButton = UIComponent(uiParent:Find("applyButton"))
    uiParent:Adopt(applyButton:Address())
    applyButton:PropagatePriority(referenceButton:Priority())
	applyButton:SetImage("ui/skins/warhammer2/icon_check.png") 
	applyButton:Resize(referenceButtonW, referenceButtonH)
	local textBoxW, textBoxH = textBox:Bounds()
	local textBoxX, textBoxY = textBox:Position() 
	local applyButtonX, applyButtonY = applyButton:Position()
    applyButton:MoveTo(textBoxX + textBoxW, textBoxY)
    applyButton:SetState("hover")
    applyButton:SetTooltipText("")
    applyButton:SetState("active")
    core:add_listener(
        "sm0_applyButton",
        "ComponentLClickUp",
        function(context)
            return context.string == "applyButton"
        end,
		function(context)
			local lordList = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "top_docker", "lord_select_list", "list", "list_clip", "list_box")
			local stateText = string.lower(textBox:GetStateText())
			table.insert(filterTable, stateText)
			local childCount = lordList:ChildCount()
			if string.find(stateText, "mixu") or string.find(stateText, "moxi") then
				for i=0, childCount-1  do
					local child = UIComponent(lordList:Find(i))
					for _, lord in ipairs(mixu) do
						if not string.find(string.lower(child:Id()), string.lower(lord)) and not string.find(child:Id(), "") then 
							child:SetVisible(false) 
						else
							child:SetVisible(true) 
							break
						end
					end
				end
			else
				for i=0, childCount-1  do
					local child = UIComponent(lordList:Find(i))
					if not string.find(string.lower(child:Id()), stateText) then 
						child:SetVisible(false) 
					else
						child:SetVisible(true) 
					end
				end
			end
        end,
        true
	)
end

--v function(emptyLordTable: vector<string>) --> map<string, vector<string>>
local function loadLocalisedStrings(emptyLordTable)
	local loadedLordTable = {} --:map<string, vector<string>>
	for _, lord in ipairs(emptyLordTable) do
		local i = 1
		while effect.get_localised_string(lord.."_"..i) do
			loadedLordTable[lord][i] = effect.get_localised_string(lord.."_"..i)
			i = i + 1
		end
	end
	return loadedLordTable
end

--[out] <230.7s>   root > sp_grand_campaign > dockers > top_docker > lord_select_list > list > list_clip > list_box > Tyrion

core:add_listener(
    "CampaignTransitionListener",
    "FrontendScreenTransition",
    function(context) return context.string == "sp_grand_campaign" end,
    function(context)
        --local lordList = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "top_docker", "lord_select_list", "list", "list_clip", "list_box")

		--local test = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "top_docker", "lord_select_list", "list", "list_clip", "list_box", "Tyrion")
		--test:SetVisible(false)
		local loadedLordTable = loadLocalisedStrings(factionLeaders)
		createSelectUI(loadedLordTable)
    end,
    true	
)