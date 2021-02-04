
-- [startpos id] = "image_name"
local moon_info = {
	["2140783412"] = "wh_main_political_party_dwf_barak_varr",
	["2140783401"] = "wh_main_political_party_dwf_karak_hirn",
	["2140783395"] = "wh_main_political_party_dwf_karak_norn",
	["2140783392"] = "wh_main_political_party_dwf_karak_ziflin",
	["2140783415"] = "wh_main_political_party_dwf_zhufbar",
	["2140783476"] = "wh_main_political_party_grn_teef_snatchaz",
	["2140784888"] = "wh2_main_political_party_def_clar_karond",
	["2140784912"] = "wh2_main_political_party_def_karond_kar",
	["20790248"] = "wh2_main_political_party_dwf_spine_of_sotek_dwarfs",
};


function moon_frontend()

core:add_listener(
	"moon_frontend_CampaignTransitionListener",
	"FrontendScreenTransition",
	function(context) return context.string == "sp_grand_campaign" end,
	function(context)
		local faction_list = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "top_docker", "lord_select_list", "list", "list_clip", "list_box");
		if not faction_list then
			return
		end

		for i = 0, faction_list:ChildCount() - 1 do	
			local child = UIComponent(faction_list:Find(i));
			
			-- Hide Rakarth from Vortext
			local startpos_id = child:GetProperty("lord_key");			
			if startpos_id == "2140784684" then
				child:SetVisible(false)
			end
			
			-- Hide Malida from Vortext
			local startpos_id = child:GetProperty("lord_key");			
			if startpos_id == "2140784688" then
				child:SetVisible(false)
			end
			
			-- Hide Sven from Vortext
			local startpos_id = child:GetProperty("lord_key");			
			if startpos_id == "2140784809" then
				child:SetVisible(false)
			end
			
			core:add_listener(
				"moon_frontend_lord_button_clicked",
				"ComponentLClickUp",
				function(context)
					return child == UIComponent(context.component);
				end,
				function(context)
					local startpos_id = child:GetProperty("lord_key");
					
					local custom_image = moon_movie_replacer();
					local is_custom_ll = moon_startpos_id_check(startpos_id)
					

					
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

function moon_movie_replacer()
	local portrait_frame = find_uicomponent(core:get_ui_root(), "sp_grand_campaign", "dockers", "centre_docker", "portrait_frame");	
	local custom_image = portrait_frame:Find("moon_custom_image");
	if custom_image then
		return UIComponent(custom_image);
	end
	portrait_frame:CreateComponent("moon_custom_image", "ui/campaign ui/region_info_pip");
	return UIComponent(portrait_frame:Find("moon_custom_image"));
end


function moon_startpos_id_check(start_pos_id)
	if not not moon_info[start_pos_id] then
		return moon_info[start_pos_id]
	end
end