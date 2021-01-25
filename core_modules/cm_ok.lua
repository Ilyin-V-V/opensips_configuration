----------------------------------------------
-- Модуль обработки сообщения 200 OK ---------
----------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_ok = {}

		cm_ok.name = "cm_ok"
		cm_ok.description = "Модуль обработки сообщения 200 OK"
		cm_ok.message = "Отправка 200 OK"
		cm_ok.reply = "200 OK"		
	
	function cm_ok:ok_ok (arg,level)
		local ok_ok = DIALOG:new (arg);
		ok_ok:event (arg,cm_ok.name,cm_ok.description,cm_ok.message,level);
      	end;

	function cm_ok:ok_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_ok","ok_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_ok.reply);
        end;

	function cm_ok:ok_authorization (arg,level)
                if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

return cm_ok

