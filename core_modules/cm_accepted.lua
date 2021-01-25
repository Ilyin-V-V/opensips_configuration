----------------------------------------------
-- Модуль обработки сообщения 202 ACCEPTED ---
----------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_accepted = {}

		cm_accepted.name = "cm_accepted"
		cm_accepted.description = "Модуль обработки сообщения 202 ACCEPTED"
		cm_accepted.message = "Отправка 202 ACCEPTED"
		cm_accepted.reply = "202 ACCEPTED"		
	
	function cm_accepted:accepted_accepted (arg,level)
		local accepted_accepted = DIALOG:new (arg);
		accepted_accepted:event (arg,cm_accepted.name,cm_accepted.description,cm_accepted.message,level);
      	end;

	function cm_accepted:accepted_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_accepted","accepted_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_accepted.reply);
        end;

	function cm_accepted:accepted_authorization (arg,level)
                if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

return cm_accepted

