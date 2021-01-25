------------------------------------------
-- Модуль определения положения UA -------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local m_location = {}

		m_location.name = "m_location"
		m_location.description = "Модуль определения положения UA"
		m_location.success = "Локация терминала определена"
		m_location.failure = "Локация терминала не найдена"
		m_location.found = "found"
		m_location.not_found = "not_found"		
		m_location.method_not_supported	= "method_not_supported"
		m_location.server_error = "internal_server_error"

	function m_location:location_search (arg,level)
		local location_event = CORE:new (arg);
		location_event:event (arg,m_location.name,m_location.description,"request",level);
		local location_search = moduleFunc (arg,"lookup","location");
		local location_search = tostring (location_search);
		if location_search == "1" then
			location_event:event (arg,m_location.name,m_location.description,m_location.success,level);
		elseif location_search == "-1" then
			location_event:event (arg,m_location.name,m_location.description,m_location.failure,level);
			return  m_location.not_found
		elseif location_search == "-2" then
                        location_event:event (arg,m_location.name,m_location.description,m_location.method_not_supported,level);
                        return  m_location.method_not_supported
		elseif location_search == "-3" then
                        location_event:event (arg,m_location.name,m_location.description,m_location.server_error,level);
                        return  m_location.server_error
		else
			location_event:event (arg,m_location.name,m_location.description,m_location.failure,level);
                        return  m_location.not_found
		end; 
      	end;

return m_location

