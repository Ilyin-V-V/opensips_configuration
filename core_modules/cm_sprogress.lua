-------------------------------------------------------
-- Модуль обработки сообщения 183 Session Progress ----
-------------------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_sprogress = {}

		cm_sprogress.name = "cm_sprogress"
		cm_sprogress.description = "Модуль обработки сообщения 183 Session Progress"
		cm_sprogress.message = "Отправка 183 Session Progress"
		cm_sprogress.reply = "183 SESSION PROGRESS"
	
	function cm_sprogress:sprogress_sprogress (arg,level)
		local sprogress_sprogress = DIALOG:new (arg);
		sprogress_sprogress:event (arg,cm_sprogress.name,cm_sprogress.description,cm_sprogress.message,level);
      	end;

	function cm_sprogress:sprogress_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_sprogress","sprogress_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_sprogress.reply);
        end;

return cm_sprogress

