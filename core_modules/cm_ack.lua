------------------------------------------
-- Модуль обработки сообщения ACK --------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_ack = {}

		cm_ack.name = "cm_ack"
		cm_ack.description = "Модуль обработки сообщения ACK"
		cm_ack.message = "Отправка подтверждения приема 200 sdp - ACK"
	
	function cm_ack:ack_confirm (arg,level)
		local ack_confirm = DIALOG:new (arg);
		ack_confirm:event (arg,cm_ack.name,cm_ack.description,cm_ack.message,level);
      	end;

	function cm_ack:ack_hiding (arg,tag,level)
                if tag == "tag" then
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                else
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                end;
        end;

	function cm_ack:ack_authorization (arg,level)
		if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

	function cm_ack:ack_socket (arg,socket,level)
                c_digest.c_digest ("cm_ack","ack_socket");
                if socket == "enable" then
                        local ack_socket = CORE:new (arg);
                        ack_socket:socket (arg,"request","none");
                else
                        return
                end;
        end;

return cm_ack

