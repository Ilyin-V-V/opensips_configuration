------------------------------------------
-- Модуль обработки сообщения BYE --------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_bye = {}

		cm_bye.name = "cm_bye"
		cm_bye.description = "Модуль обработки сообщения BYE"
		cm_bye.message = "Завершение сеанса связи - BYE"
	
	function cm_bye:bye_confirm (arg,level)
		local bye_confirm = DIALOG:new (arg);
		bye_confirm:event (arg,cm_bye.name,cm_bye.description,cm_bye.message,level);
      	end;

	function cm_bye:bye_hiding (arg,tag,level)
                if tag == "tag" then
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                else
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                end;
        end;

	function cm_bye:bye_authorization (arg,level)
                if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

	function cm_bye:bye_rtp (arg,rtp,level)
                c_digest.c_digest ("cm_bye","bye_rtp");
                if rtp == "enable" then
                        local bye_rtp = CORE:new (arg);
                        local reset = "reset"
                        bye_rtp:rtp (arg,"none",reset,"request","none");
                else
                        return
                end;
        end;

	function cm_bye:bye_socket (arg,socket,level)
                c_digest.c_digest ("cm_bye","bye_socket");
                if socket == "enable" then
                        local bye_socket = CORE:new (arg);
                        bye_socket:socket (arg,"request","none");
                else
                        return
                end;
        end;

return cm_bye

