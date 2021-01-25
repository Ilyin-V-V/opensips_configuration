------------------------------------------
-- Модуль обработки сообщения REGISTER ---
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_register = {}

		cm_register.name = "cm_register"
		cm_register.description = "Модуль обработки сообщения REGISTER"
		cm_register.success = "Успешная регистрация терминала: 200 ОК"
		cm_register.failure = "Ошибка регистрации"
		
	function cm_register:register_auth (arg,auth,level)
		c_validator.c_validator (arg,auth);
		c_digest.c_digest ("cm_register","register_auth");
		if auth == "enable" then
                        local authorization = CORE:new (arg);
                        local status = authorization:authorization (arg);
                        return status
                end;

		if auth == "disable" then
			local status = "allow"
			return status
                end;
	end;
	
	function cm_register:register_save (arg,status,level)
		c_validator.c_validator (arg,status);
		c_digest.c_digest ("cm_register","register_save");
		local register_event = DIALOG:new (arg);
              	local register_save = moduleFunc (arg,"save","location");
		if register_save ~= 1 then
			moduleFunc (arg,"sl_reply_error");
			register_event:event (arg,cm_register.name,cm_register.description,cm_register.failure,level);
                elseif
			status == "forbidden" then register_event:event (arg,cm_register.name,cm_register.description,cm_register.failure,level);
		else
			register_event:event (arg,cm_register.name,cm_register.description,cm_register.success,level);
		end;
      	end;

	function cm_register:register_nat (arg,nat,level)
		c_digest.c_digest ("cm_register","register_nat");
		if nat == "enable" then
                        local register_nat = CORE:new (arg);
                        local sip_ping_nat = register_nat:nat (arg,"REGISTER");
			return sip_ping_nat
		else
			return
		end;
        end;

	function cm_register:register_ddos (arg,pike,validate,subscriber,level)
                c_digest.c_digest ("cm_register","register_ddos");
                register_ddos = CORE:new (arg);
                local forbidden = register_ddos:attack (arg,pike,validate,subscriber);
		if forbidden == "forbidden" then return forbidden end;
        end;

	function cm_register:register_acl (arg,access,level)
                c_digest.c_digest ("cm_register","register_acl");
                register_acl = CORE:new (arg);
                local forbidden = register_acl:acl (arg,access);
                if forbidden == "forbidden" then return forbidden end;
        end;

return cm_register
