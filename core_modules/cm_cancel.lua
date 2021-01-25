------------------------------------------
-- Модуль обработки сообщения CANCEL -----
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_cancel = {}

		cm_cancel.name = "cm_cancel"
		cm_cancel.description = "Модуль обработки сообщения CANCEL"
		cm_cancel.message = "Отмена вызова - CANCEL"
	
	function cm_cancel:cancel_confirm (arg,level)
		local cancel_confirm = DIALOG:new (arg);
		cancel_confirm:event (arg,cm_cancel.name,cm_cancel.description,cm_cancel.message,level);
      	end;

	function cm_cancel:cancel_hiding (arg,tag,level)
                if tag == "tag" then
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                else
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                end;
        end;

	function cm_cancel:cancel_authorization (arg,level)
                if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

	function cm_cancel:cancel_rtp (arg,rtp,level)
                c_digest.c_digest ("cm_cancel","cancel_rtp");
                if rtp == "enable" then
                        local cancel_rtp = CORE:new (arg);
                        local reset = "reset"
                        cancel_rtp:rtp (arg,"none",reset,"request","none");
                else
                        return
                end;
        end;

	function cm_cancel:cancel_socket (arg,socket,level)
                c_digest.c_digest ("cm_cancel","cancel_socket");
                if socket == "enable" then
                        local cancel_socket = CORE:new (arg);
                        cancel_socket:socket (arg,"request","none");
                else
                        return
                end;
        end;

return cm_cancel

