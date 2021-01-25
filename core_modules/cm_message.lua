------------------------------------------
-- Модуль обработки сообщения MESSAGE ----
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_message = {}

		cm_message.name = "cm_message"
		cm_message.description = "Модуль обработки сообщения MESSAGE"
		cm_message.status = "Запросы диалога типа MESSAGE не обрабатываются этим сервером"		
	
	function cm_message:message_send (arg,level)
		local message_event = DIALOG:new (arg);
		message_event:event (arg,cm_message.name,cm_message.description,cm_message.status,level);
      	end;

	function cm_message:message_ddos (arg,ddos,validate,subscriber,level)
                c_digest.c_digest ("cm_message","message_ddos");
                message_ddos = CORE:new (arg);
                local forbidden = message_ddos:attack (arg,ddos,validate,subscriber);
		if forbidden == "forbidden" then return forbidden end;
        end;

return cm_message

