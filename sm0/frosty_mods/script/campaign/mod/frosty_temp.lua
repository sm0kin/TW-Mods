
local faction_list = cm:model():world():faction_list();
            
for i = 0, faction_list:num_items() - 1 do
  local faction_l1 = faction_list:item_at(i)
  if not faction_l1:is_dead() then
    for j = 0, faction_list:num_items() - 1 do
      local faction_l2 = faction_list:item_at(j)
      if not faction_l2:is_dead() and faction_l1:name() ~= faction_l2:name() and not faction_l1:at_war_with(faction_l2) then
        cm:force_declare_war(faction_l1:name(), faction_l2:name(), false, false)
      end
    end
  end
end