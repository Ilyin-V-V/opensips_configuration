---------------------------------------
-- Модуль обработки сообщений 5XX -----
---------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_fivexx = {}

		cm_fivexx.name = "cm_fivexx"
		cm_fivexx.description = "Модуль обработки сообщений 5XX"
		cm_fivexx.message = "Отправка 5XX"
		cm_fivexx.reply = "5XX REPLY"		
	
	function cm_fivexx:fivexx_ok (arg,level)
		local fivexx_ok = DIALOG:new (arg);
		fivexx_ok:event (arg,cm_fivexx.name,cm_fivexx.description,cm_fivexx.message,level);
      	end;

	function cm_fivexx:fivexx_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_fivexx","fivexx_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_fivexx.reply);
        end;

return cm_fivexx

