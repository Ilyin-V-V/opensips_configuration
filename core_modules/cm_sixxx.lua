---------------------------------------
-- Модуль обработки сообщений 6XX -----
---------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_sixxx = {}

		cm_sixxx.name = "cm_sixxx"
		cm_sixxx.description = "Модуль обработки сообщений 6XX"
		cm_sixxx.message = "Отправка 6XX"
		cm_sixxx.reply = "6XX REPLY"		
	
	function cm_sixxx:sixxx_ok (arg,level)
		local sixxx_ok = DIALOG:new (arg);
		sixxx_ok:event (arg,cm_sixxx.name,cm_sixxx.description,cm_sixxx.message,level);
      	end;

	function cm_sixxx:sixxx_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_sixxx","sixxx_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_sixxx.reply);
        end;

return cm_sixxx

