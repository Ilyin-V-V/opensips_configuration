-------------------------------------------------------
-- Модуль обработки сообщения 182 Call is Queued ------
-------------------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_callisqueued = {}

		cm_callisqueued.name = "cm_callisqueued"
		cm_callisqueued.description = "Модуль обработки сообщения 182 Call is Queued"
		cm_callisqueued.message = "Отправка 182 Call is Queued"
		cm_callisqueued.reply = "182 CALL IS QUEUED"
	
	function cm_callisqueued:callisqueued_callisqueued (arg,level)
		local callisqueued_callisqueued = DIALOG:new (arg);
		callisqueued_callisqueued:event (arg,cm_callisqueued.name,cm_callisqueued.description,cm_callisqueued.message,level);
      	end;

	function cm_callisqueued:callisqueued_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_callisqueued","callisqueued_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_callisqueued.reply);
        end;

return cm_callisqueued

