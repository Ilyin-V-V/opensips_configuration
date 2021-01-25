------------------------------------------
-- Модуль обработки сообщения PUBLISH ----
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_publish = {}

		cm_publish.name = "cm_publish"
		cm_publish.description = "Модуль обработки сообщения PUBLISH"
		cm_publish.status = "Запросы диалога типа PUBLISH не обрабатываются этим сервером"		
	
	function cm_publish:publish_send (arg,level)
		local publish_event = DIALOG:new (arg);
		publish_event:event (arg,cm_publish.name,cm_publish.description,cm_publish.status,level);
      	end;

	function cm_publish:publish_ddos (arg,ddos,validate,subscriber,level)
                c_digest.c_digest ("cm_publish","publish_ddos");
                publish_ddos = CORE:new (arg);
                local forbidden = publish_ddos:attack (arg,ddos,validate,subscriber);
		if forbidden == "forbidden" then return forbidden end;
        end;

return cm_publish

