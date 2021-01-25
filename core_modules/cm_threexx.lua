---------------------------------------
-- Модуль обработки сообщений 3XX -----
---------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_threexx = {}

		cm_threexx.name = "cm_threexx"
		cm_threexx.description = "Модуль обработки сообщений 3XX"
		cm_threexx.message = "Отправка 3XX"
		cm_threexx.reply = "3XX REPLY"		
	
	function cm_threexx:threexx_ok (arg,level)
		local threexx_ok = DIALOG:new (arg);
		threexx_ok:event (arg,cm_threexx.name,cm_threexx.description,cm_threexx.message,level);
      	end;

	function cm_threexx:threexx_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_threexx","threexx_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_threexx.reply);
        end;

return cm_threexx

