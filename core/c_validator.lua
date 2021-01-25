---------------------------------------
-- Валидатор параметров ---------------
---------------------------------------

package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'
local c_config = require "c_config"

local c_validator = {}

function c_validator.c_validator (...)	

local name = "c_validator"
local description = "Валидатор параметров"

        local leader = {}
                leader["leader"] = "Модуль: => " .. name .. "; Описание: => " .. description .. ""

        local no_value_arg = {}
                no_value_arg["no_value_arg"] = "Аргумент: => не может быть nil"

	local config = c_config.c_config (config);

	for i = 1, arg.n do
		local to_string = tostring(arg[i])
		if to_string == "" or to_string == "nil" then
			if config == "verbose" or config == "full" then
				xlog ("NOTICE => " .. leader["leader"] .. ";")
        			xlog ("NOTICE => " .. no_value_arg["no_value_arg"] .. " => " .. to_string .. "; =>" .. tostring(arg[i]) .. ";")
			end;
		return;
	end;		
end;

end;

return c_validator
