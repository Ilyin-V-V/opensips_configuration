------------------------------------------
-- Модуль обработки сообщения SUBSCRIBE --
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_subscribe = {}

		cm_subscribe.name = "cm_subscribe"
		cm_subscribe.description = "Модуль обработки сообщения SUBSCRIBE"
		cm_subscribe.status = "Запросы диалога типа SUBSCRIBE не обрабатываются этим сервером"		
	
	function cm_subscribe:subscribe_send (arg,level)
		local subscribe_event = DIALOG:new (arg);
		subscribe_event:event (arg,cm_subscribe.name,cm_subscribe.description,cm_subscribe.status,level);
      	end;

	function cm_subscribe:subscribe_ddos (arg,ddos,validate,subscriber,level)
                c_digest.c_digest ("cm_subscribe","subscribe_ddos");
                subscribe_ddos = CORE:new (arg);
                local forbidden = subscribe_ddos:attack (arg,ddos,validate,subscriber);
		if forbidden == "forbidden" then return forbidden end;
        end;

return cm_subscribe

