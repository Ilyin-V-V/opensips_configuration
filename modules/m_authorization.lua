------------------------------------------
-- Модуль авторизации U_Server -----------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_authorization = {}

		m_authorization.name = "m_authorization"
		m_authorization.description = "Модуль авторизации U_Server"
		m_authorization.success = "Успешная авторизация"
		m_authorization.general_error = "Общая ошибка"
		m_authorization.no_credentials_found = "Не найдены учетные данные в запросе"
		m_authorization.overdue_nonce = "Просроченный nonce"
		m_authorization.invalid_password = "Не правильный пароль"
		m_authorization.user_not_found = "Пользователь не найден"
		m_authorization.forbidden = "forbidden"
		m_authorization.permit = "allow"	
	
	function m_authorization:authorization_conduct (arg,level)
		local source_ip = AVP_get("SOURCEIP");
		local source_port = AVP_get("SOURCEPORT");
		local source_protocol = AVP_get("PROTOCOL");
		
		local authorization_event = DIALOG:new (arg);
		local domain = domain;
		moduleFunc (arg,"check_address","0",source_ip,source_port,source_protocol);
		local authorization = moduleFunc (arg,"www_authorize",domain,"subscriber");
		local authorization = tostring(authorization);

		if authorization == "-5" then
			authorization_event:event (arg,m_authorization.name,m_authorization.description,m_authorization.general_error,level);
			return m_authorization.forbidden
		elseif
			authorization == "-4" then
			authorization_event:event (arg,m_authorization.name,m_authorization.description,m_authorization.no_credentials_found,level);
			local authentication = moduleFunc (arg,"www_challenge","","0");
			return m_authorization.no_credentials_found
		elseif
			authorization == "-3" then
                    	authorization_event:event (arg,m_authorization.name,m_authorization.description,m_authorization.overdue_nonce,level);
                        local authentication = moduleFunc (arg,"www_challenge","","0");
			return m_authorization.overdue_nonce
		elseif
			authorization == "-2" then
                        authorization_event:event (arg,m_authorization.name,m_authorization.description,m_authorization.invalid_password,level);
			return m_authorization.forbidden
		elseif
			authorization == "-1" then
                        authorization_event:event (arg,m_authorization.name,m_authorization.description,m_authorization.user_not_found,level);
			return m_authorization.forbidden
		else
			authorization_event:event (arg,m_authorization.name,m_authorization.description,m_authorization.success,level);
			return m_authorization.permit
		end;
		
      	end;

return m_authorization
