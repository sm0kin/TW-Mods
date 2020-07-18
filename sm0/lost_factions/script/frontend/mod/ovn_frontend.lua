
-- [startpos id] = "image_name"
--[[ local ovn_startpos_ids = {
	["1624764695"] = "ovn_arb_scimitar",
	["1721501317"] = "ovn_arb_scythans",
	["365146035"] = "ovn_vor_arb_scythans",
	["1242187756"] = "ovn_vor_arb_scimitar",
	["706250780"] = "wh2_main_cst_vampire_coast_mutineers",
	["1010433037"] = "wh2_main_vor_cst_vampire_coast_mutineers",
}]]

local ovn_info = {
	["642513778"] = "wh2_main_political_party_emp_grudgebringers",
	["572093174"] = "wh2_main_political_party_vor_emp_grudgebringers",
	["40619453"] = "ovn_emp_the_moot",
	["250682859"] = "ovn_arb_araby",
	["2119533354"] = "ovn_vor_arb_araby",
	["848881665"] = "dreadking", -- vortex
	["1041928997"] = "dreadking", -- me
	["1409023687"] = "fimir",
	["440104156"] = "stormrider", --me
	["2140784771"] = "stormrider", --vor
	["937413525"] = "morrigan", --me
	["794782611"] = "morrigan", --vor
	["32930744"] = "chief_ugma",
	["2140783503"] = "walach",
	["209967969"] = "fimir", -- Formerly Treeblood
	["2052227504"] = "amazons", -- vortex
	["1407394331"] = "amazons" -- ME


};

function ovn_movie_replacer()
	local portrait_frame = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "centre_docker", "portrait_frame");	
	local custom_image = portrait_frame:Find("ovn_custom_image");
	if custom_image then
		return UIComponent(custom_image);
	end
	portrait_frame:CreateComponent("ovn_custom_image", "ui/campaign ui/region_info_pip");
	return UIComponent(portrait_frame:Find("ovn_custom_image"));
end


function ovn_startpos_id_check(start_pos_id)
	if not not ovn_info[start_pos_id] then
		return ovn_info[start_pos_id]
	end
end

function ovn_frontend()

core:add_listener(
	"ovn_frontend_CampaignTransitionListener",
	"FrontendScreenTransition",
	function(context) return context.string == "sp_grand_campaign" end,
	function(context)
		local faction_list = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "top_docker", "lord_select_list", "list", "list_clip", "list_box");
		if not faction_list then
			return
		end

		for i = 0, faction_list:ChildCount() - 1 do	
			local child = UIComponent(faction_list:Find(i));
			
			core:add_listener(
				"ovn_frontend_lord_button_clicked",
				"ComponentLClickUp",
				function(context)
					return child == UIComponent(context.component);
				end,
				function(context)
					local startpos_id = child:GetProperty("lord_key");
					
					local custom_image = ovn_movie_replacer();
					local is_custom_ll = ovn_startpos_id_check(startpos_id)
					

					
					if not is_custom_ll then
						custom_image:SetOpacity(0);	
					else
						custom_image:SetImagePath("ui/portraits/frontend/"..is_custom_ll..".png", 0);
						custom_image:SetOpacity(255);
					end
					
					local movie_frame = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "centre_docker", "portrait_frame", "movie_frame");		

					local x, y = movie_frame:Position();
						
					custom_image:MoveTo(x, y);

					custom_image:PropagatePriority(movie_frame:Priority());
							
					custom_image:SetCanResizeHeight(true)
					custom_image:SetCanResizeWidth(true)
					custom_image:Resize(464, 624)
					custom_image:SetCanResizeHeight(false)
					custom_image:SetCanResizeWidth(false)
										
				end,
				true
			);
		end
	end,
	true
);
end

core:add_ui_created_callback(
	function(context)
		ovn_frontend()
	end
)