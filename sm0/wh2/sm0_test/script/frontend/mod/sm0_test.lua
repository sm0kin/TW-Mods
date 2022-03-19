core:add_listener(
	"test_ComponentLClickUp",
	"ComponentLClickUp",
	function(context)
		return true
	end,
	function(context)
		print_all_uicomponent_children(UIComponent(context.component))
	end,
	true
)