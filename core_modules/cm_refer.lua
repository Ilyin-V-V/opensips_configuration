--------------------------------------------
-- Модуль обработки сообщения REFER --------
--------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_refer = {}

		cm_refer.name = "cm_refer"
		cm_refer.description = "Модуль обработки сообщения REFER"
		cm_refer.message = "Отправка метода - REFER, перевод вызова"
	
	function cm_refer:refer_confirm (arg,level)
		local refer_confirm = DIALOG:new (arg);
		refer_confirm:event (arg,cm_refer.name,cm_refer.description,cm_refer.message,level);
      	end;

	function cm_refer:refer_hiding (arg,tag,level)
                if tag == "tag" then
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                else
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                end;
        end;

	function cm_refer:refer_socket (arg,socket,level)
                c_digest.c_digest ("cm_refer","refer_socket");
                if socket == "enable" then
                        local refer_socket = CORE:new (arg);
                        refer_socket:socket (arg,"request","none");
                else
                        return
                end;
        end;

return cm_refer

