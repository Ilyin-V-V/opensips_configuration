---------------------------------------
-- Валидатор параметров ---------------
---------------------------------------

package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'
local c_config = require "c_config"

local c_digest = {}

local name = "c_digest"
local description = "Валидатор параметров"

function c_digest.c_digest (module,method)
		if not module or not method then
			local module = "not";
			local method = "not";
		end;

		local config = c_config.c_config (config);
		local digest = c_config.c_config (digest);
		
		if not digest or digest == nil then return end;
		if digest == "disable" then return end;
	
		if config == "verbose" or config == "full" then
			xlog ("DIGEST => Модуль: " .. module .. "; Метод: " .. method .. ";")
		end;
end;

return c_digest
