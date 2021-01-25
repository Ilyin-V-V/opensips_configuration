------------------------------------------
-- Модуль обработки сообщения PRACK ------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_prack = {}

		cm_prack.name = "cm_prack"
		cm_prack.description = "Модуль обработки сообщения PRACK"
		cm_prack.message = "Отправка подтверждения приема PRACK"
	
	function cm_prack:prack_confirm (arg,level)
		local prack_confirm = DIALOG:new (arg);
		prack_confirm:event (arg,cm_prack.name,cm_prack.description,cm_prack.message,level);
      	end;

	function cm_prack:prack_hiding (arg,tag,level)
                if tag == "tag" then
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                else
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                end;
        end;

	function cm_prack:prack_authorization (arg,level)
		if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

	function cm_prack:prack_socket (arg,socket,level)
                c_digest.c_digest ("cm_prack","prack_socket");
                if socket == "enable" then
                        local prack_socket = CORE:new (arg);
                        prack_socket:socket (arg,"request","none");
                else
                        return
                end;
        end;

return cm_prack

