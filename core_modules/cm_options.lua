------------------------------------------
-- Модуль обработки сообщения OPTIONS ----
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_options = {}

		cm_options.name = "cm_options"
		cm_options.description = "Модуль обработки сообщения OPTIONS"
		cm_options.message = "Отправка ответа на запрос типа OPTIONS"
		cm_options.answer = "answer"
		cm_options.no_answer = "no_answer"	
	
	function cm_options:options_send (arg,level)
		local options_event = DIALOG:new (arg);
		options_event:event (arg,cm_options.name,cm_options.description,cm_options.message,level);
		return cm_options.answer
      	end;

	function cm_options:options_ddos (arg,ddos,validate,subscriber,level)
                c_digest.c_digest ("cm_options","options_ddos");
                options_ddos = CORE:new (arg);
                local forbidden = options_ddos:attack (arg,ddos,validate,subscriber);
		if forbidden == "forbidden" then return forbidden end;
        end;

return cm_options

