------------------------------------------
-- Модуль обработки сообщения NOTIFY -----
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_notify = {}

		cm_notify.name = "cm_notify"
		cm_notify.description = "Модуль обработки сообщения NOTIFY"
		cm_notify.message = "Отправка ответа на запрос типа NOTIFY"
		cm_notify.status = "Запросы диалога типа NOTIFY не обрабатываются этим сервером"
		cm_notify.answer = "answer"
		cm_notify.no_answer = "no_answer"		
	
	function cm_notify:notify_send (arg,level)
		local notify_event = DIALOG:new (arg);
		notify_event:event (arg,cm_notify.name,cm_notify.description,cm_notify.message,level);
      	end;

	function cm_notify:notify_ping (arg,ping,level)
		c_validator.c_validator (arg,ping);
		c_digest.c_digest ("cm_notify","notify_ping");
                local notify_ping = DIALOG:new (arg);
                notify_ping:event (arg,cm_notify.name,cm_notify.description,cm_notify.message,level);
                return cm_notify.answer
        end;

        function cm_notify:notify_hiding (arg,tag,level)
                if tag == "tag" then
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                else
                        local top_hiding = CORE:new (arg);
                        top_hiding:tophiding (arg,tag,"request");
                end;
        end;

        function cm_notify:notify_authorization (arg,level)
                if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

	function cm_notify:notify_socket (arg,socket,level)
                c_digest.c_digest ("cm_notify","notify_socket");
                if socket == "enable" then
                        local notify_socket = CORE:new (arg);
                        notify_socket:socket (arg,"request","none");
                else
                        return
                end;
        end;

	function cm_notify:notify_ddos (arg,ddos,validate,subscriber,level)
                c_digest.c_digest ("cm_notify","notify_ddos");
                notify_ddos = CORE:new (arg);
                local forbidden = notify_ddos:attack (arg,ddos,validate,subscriber);
		if forbidden == "forbidden" then return forbidden end;
        end;	

return cm_notify

