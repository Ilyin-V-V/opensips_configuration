----------------------------------------------
-- Модуль обработки сообщения 180 Ringing ----
----------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_ringing = {}

		cm_ringing.name = "cm_ringing"
		cm_ringing.description = "Модуль обработки сообщения 180 Ringing"
		cm_ringing.message = "Отправка 180 Ringing"
		cm_ringing.reply = "180 RINGING"
	
	function cm_ringing:ringing_ringing (arg,level)
		local ringing_ringing = DIALOG:new (arg);
		ringing_ringing:event (arg,cm_ringing.name,cm_ringing.description,cm_ringing.message,level);
      	end;

        function cm_ringing:ringing_hiding (arg,tag,level)
		c_validator.c_validator (arg,tag);
		c_digest.c_digest ("cm_ringing","ringing_hiding");
		local top_hiding = CORE:new (arg);
		top_hiding:tophiding (arg,tag,"reply",cm_ringing.reply);
        end;

return cm_ringing

