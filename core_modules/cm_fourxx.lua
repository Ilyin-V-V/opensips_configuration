---------------------------------------
-- Модуль обработки сообщений 4XX -----
---------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_fourxx = {}

		cm_fourxx.name = "cm_fourxx"
		cm_fourxx.description = "Модуль обработки сообщений 4XX"
		cm_fourxx.message = "Отправка 4XX"
		cm_fourxx.reply = "4XX REPLY"		
	
	function cm_fourxx:fourxx_ok (arg,level)
		local fourxx_ok = DIALOG:new (arg);
		fourxx_ok:event (arg,cm_fourxx.name,cm_fourxx.description,cm_fourxx.message,level);
      	end;

	function cm_fourxx:fourxx_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_fourxx","fourxx_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_fourxx.reply);
        end;

	function cm_fourxx:fourxx_unauthorized (arg,unauthorized,level)
                c_validator.c_validator (arg,unauthorized);
                c_digest.c_digest ("cm_fourxx","fourxx_unauthorized");
                local unauthorized = CORE:new (arg);
                local server,port = unauthorized:authorized_invite (arg,cm_fourxx.reply);
		return server,port
        end;

return cm_fourxx

