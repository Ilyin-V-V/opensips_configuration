-------------------------------
-- Модуль acl U_Server --------
-------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_acl = {}

	m_acl.name = "m_acl"
	m_acl.description = "Модуль acl U_Server"
	m_acl.allow = "Проверка acl прошла успешно"
	m_acl.forbidden = "Доступ запрещен acl, forbidden"

	function m_acl:acl_ip_address (arg,access,level)
                local acl_event = CORE:new (arg);
                acl_event:event (arg,m_acl.name,m_acl.description,"request",level);

                if access == "enable" then
			local ip_destination = AVP_get("DESTIP");
                        local ip_interface = s_face[ip_destination];
                        	if ip_interface == "WAN" then
					local from_user = AVP_get("FROMUSER");
					local from_sql = CORE:new (arg);
                			local from_sql = from_sql:sql ("opensips","select","select ip_address from acl where username = '" .. from_user .. "'","request");
                			if not from_sql or from_sql == nil then
                        			acl_event:event (arg,m_acl.name,m_acl.description,m_acl.allow,level);
						local allow = "allow";
                        			return allow
                			else
						local source_ip = AVP_get("SOURCEIP");
							for index in string.gmatch (from_sql.ip_address,"[^,]+") do
								if source_ip == index then
									acl_event:event (arg,m_acl.name,m_acl.description,m_acl.allow,level);
                                                			local allow = "allow";
                                                			return allow
								end;
							end;
									local acl_event = CORE:new (arg);
									acl_event:event (arg,m_acl.name,m_acl.description,m_acl.forbidden,level);
                                                                	local forbidden = "forbidden";
                                                                	return forbidden
                			end;
                        	end;
                	else
                        	return
                	end;
        end;

return m_acl
