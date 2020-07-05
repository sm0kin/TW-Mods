--# assume global class MCT
--# assume global class MCT_MOD
--# assume global class MCT_SECTION
--# assume global class MCT_OPTION

-- TYPES
--# type global MCT_OPTION_TYPE = 
--# "checkbox"  |   "dropdown"  |   "textbox"   |
--# "slider"

--MOD CONFIGURATION TOOL
--mct:load_mod (filename, filename_for_out) 	                                                                  --For internal use, loads specific mod files located in script/mct/settings/.
--mct:load_module (module_name, path) 	                                                                        --Internal loader for scripts located in script/mct/modules/.
--# assume global get_mct: function() --> MCT
--# assume MCT.get_mod_by_key: method(mod_name: string) --> MCT_MOD                                             --Getter for the mct_mod with the supplied key.
--# assume MCT.log: method(text: string) 	                                                                      --Basic logging function for outputting text into the MCT log file.
--# assume MCT.error: method(text: string)                                                                      --Basic error logging function for outputting text into the MCT log file.
--# assume MCT.register_mod: method(mod_name: string) --> MCT_MOD	                                              --Primary function to begin adding settings to a "mod" Calls the internal function "mct_mod.new()"

--MCT_MOD
--mct_mod:new (key) 	                                                                                          --For internal use, called by the MCT Manager.
--# assume MCT_MOD.get_settings: method() --> map<string, string | number | boolean >                           --Returns the finalized_settings field of this mct_mod.
--# assume MCT_MOD.add_new_section: method(section_key: string, localised_name: string) 	                      --Add a new section to the mod's settings view, to separate them into several categories.
--# assume MCT_MOD.get_options_by_section: method(section_key: string) --> map<string, MCT_OPTION>              --Returns a k/v table of {optionkey=optionobj} for options that are linked to this section.
--# assume MCT_MOD.get_sections: method() --> map<string, string>	                                              --Returns a table of all "sections" within the mct_mod.
--# assume MCT_MOD.get_section_by_key: method(section_key: string) --> MCT_SECTION 	                            --Return a specific section within the mct_mod.
--# assume MCT_MOD.set_section_visibility: method(section_key: string, visible: boolean) 	                      --Set the rows of a section visible or invisible.
--# assume MCT_MOD.get_key: method() --> string	                                                                --Getter for the mct_mod's key
--# assume MCT_MOD.set_title: method(title_text: string, is_localised: boolean) 	                              --Enable localisation for this mod's title.
--# assume MCT_MOD.set_author: method(author_text: string) 	                                                    --Set the Author text for this mod.
--# assume MCT_MOD.set_description: method(desc_text: string, is_localised: boolean) 	                          --Enable localisation for this mod's description.
--# assume MCT_MOD.get_title: method() --> string	                                                              --Grabs the title text.
--# assume MCT_MOD.get_author: method() --> string	                                                     	      --Grabs the author text.
--# assume MCT_MOD.get_description: method() --> string	 	                                                      --Grabs the description text.
--# assume MCT_MOD.get_localised_texts: method() --> (string, string, string)                         	 	      --Returns all three localised texts - title, author, description.
--# assume MCT_MOD.get_options: method() --> map<string, MCT_OPTION>                                       	    --Returns every mct_option attached to this mct_mod.
--# assume MCT_MOD.get_option_keys_by_type: method(option_type: MCT_OPTION_TYPE) --> vector<MCT_OPTION>         --Returns every mct_option of a type.
--# assume MCT_MOD.get_option_by_key: method(option_key: string) --> MCT_OPTION         	                      --Returns a mct_option with the specific key on the mct_mod.
--# assume MCT_MOD.add_new_option: method(option_key: string, option_type: MCT_OPTION_TYPE) --> MCT_OPTION      --Creates a new mct_option with the specified key, of the desired type.

--MCT_OPTION
--mct_option:new (mod, option_key, type) 	                                                                      --For internal use only.
--mct_option:is_val_valid_for_type (val) 	                                                                      --Internal checker to see if the values passed through mct_option methods are valid.
--# assume MCT_OPTION.get_read_only: method() --> boolean 	                                                    --Read whether this mct_option can be edited or not at the moment.
--# assume MCT_OPTION.set_read_only: method(enabled: boolean) 	                                                --Set whether this mct_option can be edited or not at the moment.
--# assume MCT_OPTION.set_assigned_section: method(section_key: string) 	                                      --Assigns the section_key that this option is a member of.
--# assume MCT_OPTION.get_assigned_section: method() --> string	                                                --Reads the assigned_section for this option.
--# assume MCT_OPTION.get_mod: method() --> MCT_MOD 	                                                          --Get the mct_mod object housing this option.
--# assume MCT_OPTION.set_uic_visibility: method(enable: boolean) 	                                            --Set a UIC as visible or invisible, dynamically.
--# assume MCT_OPTION.get_uic_visibility: method() --> boolean	                                                --Get the current visibility for this mct_option.
--# assume MCT_OPTION.add_option_set_callback: method(callback: function(context: MCT_OPTION)) 	                --Create a callback triggered whenever this option's setting changes within the MCT UI.
--# assume MCT_OPTION.override_position: method(x: number, y: number) 	                                        --Manually set the x/y position for this option, within its section.
--# assume MCT_OPTION.get_finalized_setting: method() --> string | number | boolean 	                          --Getter for the "finalized_setting" for this mct_option.
--# assume MCT_OPTION.set_default_value: method(default_value: string | number | boolean ) 	                    --Set the default selected setting when the mct_mod is first created and loaded.
--# assume MCT_OPTION.get_selected_setting: method() --> string | number | boolean                              --Getter for the current selected setting.
----# assume MCT_OPTION.slider_set_values: method(min: number, max: number, current: number) 	                  --set-value wrapped for sliders.
--# assume MCT_OPTION.slider_set_min_max: method(min: number, max: number) 	                                    --set-value wrapped for sliders.
--# assume MCT_OPTION.slider_set_step_size: method(step_size: number)                                           --defaults to 1 if unused
--# assume MCT_OPTION.add_dropdown_values: method(dropdown_table: table)                                        --Method to set the dropdown_values.
--# assume MCT_OPTION.add_dropdown_value: method(key: string, text: string, tt: string, is_default: boolean?) 	--Used to create a single dropdown_value; also called within mct_option:add_dropdown_values
--# assume MCT_OPTION.get_key: method() --> string	                                                            --Getter for this option's key.
--# assume MCT_OPTION.set_text: method(text: string, is_localised: boolean) 	                                  --Setter for this option's text, which displays next to the dropdown box/checkbox.
--# assume MCT_OPTION.set_tooltip_text: method(text: string, is_localised: boolean) 	                          --Setter for this option's tooltip, which displays when hovering over the option or the text.
--# assume MCT_OPTION.get_text: method() --> string 	                                                          --Getter for this option's text.
--# assume MCT_OPTION.get_tooltip_text: method() --> string                                                     --Getter for this option's text.

-- GLOBAL VARIABLES
--# assume global mct: MCT
    
--[[
                                               .--.
                                               `.  \
                                                 \  \
                                                  .  \
                                                  :   .
                                                  |    .
                                                  |    :
                                                  |    |
  ..._  ___                                       |    |
 `."".`''''""--..___                              |    |
 ,-\  \             ""-...__         _____________/    |
 / ` " '                    `""""""""                  .
 \                                                      L
 (>                                                      \
/                                                         \
\_    ___..---.                                            L
  `--'         '.                                           \
                 .                                           \_
                _/`.                                           `.._
             .'     -.                                             `.
            /     __.-Y     /''''''-...___,...--------.._            |
           /   _."    |    /                ' .      \   '---..._    |
          /   /      /    /                _,. '    ,/           |   |
          \_,'     _.'   /              /''     _,-'            _|   |
                  '     /               `-----''               /     |
                  `...-'                                       `...-'
--]]