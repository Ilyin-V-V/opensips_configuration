----------------------------------------------------------------
-- Модуль обработки сообщения 181 Call is Being Forwarded ------
----------------------------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_callisforwarded = {}

		cm_callisforwarded.name = "cm_callisforwarded"
		cm_callisforwarded.description = "Модуль обработки сообщения 181 Call is Being Forwarded"
		cm_callisforwarded.message = "Отправка 181 Call is Being Forwarded"
		cm_callisforwarded.reply = "181 CALL IS BEING FORWARDED"
	
	function cm_callisforwarded:callisforwarded_callisforwarded (arg,level)
		local callisforwarded_callisforwarded = DIALOG:new (arg);
		callisforwarded_callisforwarded:event (arg,cm_callisforwarded.name,cm_callisforwarded.description,cm_callisforwarded.message,level);
      	end;

	function cm_callisforwarded:callisforwarded_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_callisforwarded","callisforwarded_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_callisforwarded.reply);
        end;

return cm_callisforwarded

