------------------------------------------
-- Модуль анти dDoS атак U_Server --------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_ddos = {}

		m_ddos.name = "m_ddos"
		m_ddos.description = "Модуль анти dDoS атак U_Server"
		m_ddos.allow = "Проверка dDoS прошла успешно"
		m_ddos.forbidden = "Большое количество пакетов в единицу времени"
		m_ddos.successfully = "Проверка сообщения на валидность прошла успешно"
		m_ddos.fail = "Не пройдена проверка сообщения на валидность"
		m_ddos.from_allow = "Пользователь найден, доступ к методам диалогов разрешен"
		m_ddos.from_deny = "Пользователь не найден, доступ к методам диалогов запрещен"
	
	function m_ddos:ddos_control (arg,pike,level)
		local ddos_event = CORE:new (arg);
                ddos_event:event (arg,m_ddos.name,m_ddos.description,"request",level);
		local source_ip = AVP_get("SOURCEIP");
                local source_port = AVP_get("SOURCEPORT");
                local source_protocol = AVP_get("PROTOCOL");

                local check_address = moduleFunc (arg,"check_address","0",source_ip,source_port,source_protocol);
		if check_address == -1 then 
			if pike == "enable" then
				local ip_destination = AVP_get("DESTIP");
				local ip_interface = s_face[ip_destination];

				if ip_interface == "WAN" then
					local pike_check = moduleFunc (arg,"pike_check_req");
					if pike_check == 1 then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.allow,level);
					else
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.forbidden,level);
					end;
				end;
			else
				return
			end;
		end;
      	end;

	function m_ddos:validate_control (arg,validate,level)
		local ddos_event = CORE:new (arg);
                ddos_event:event (arg,m_ddos.name,m_ddos.description,"request",level);
		local source_ip = AVP_get("SOURCEIP");
                local source_port = AVP_get("SOURCEPORT");
                local source_protocol = AVP_get("PROTOCOL");

                local check_address = moduleFunc (arg,"check_address","0",source_ip,source_port,source_protocol);
		if check_address == -1 then
			if validate == "enable" then
				local ip_destination = AVP_get("DESTIP");
                                local ip_interface = s_face[ip_destination];
				local useragent = AVP_get("USERAGENT");
				if not useragent or useragent == nil then
					return
				end;

                        	if ip_interface == "WAN" then
					local forbidden = "forbidden";
                                	if useragent:match("friendly-scanner") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
						return forbidden
					elseif useragent:match("sipcli") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
						return forbidden
					elseif useragent:match("VaxSIPUserAgent") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
                                        	return forbidden
					elseif useragent:match("sip-scan") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
                                        	return forbidden
					elseif useragent:match("sundayddr") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
                                        	return forbidden
					elseif useragent:match("iWar") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
                                        	return forbidden
					elseif useragent:match("sipsak") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
                                        	return forbidden
					elseif useragent:match("sipvicious") then
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
                                        	return forbiddden
					elseif useragent:match("(PortSIP VoIP SDK*)") then
                                        	ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.fail,level);
                                        	return forbidden
					else
						ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.successfully,level);
						return
					end;
                        	end;
                	else
                        	return
                	end;
		end;
	end;

	function m_ddos:ddos_from (arg,subscriber,level)
                local ddos_event = CORE:new (arg);
                ddos_event:event (arg,m_ddos.name,m_ddos.description,"request",level);
		local source_ip = AVP_get("SOURCEIP");
                local source_port = AVP_get("SOURCEPORT");
                local source_protocol = AVP_get("PROTOCOL");
            
		local check_address = moduleFunc (arg,"check_address","0",source_ip,source_port,source_protocol);
		if check_address == -1 then
                	if subscriber == "enable" then
                        	local ip_destination = AVP_get("DESTIP");
                                local ip_interface = s_face[ip_destination];

                        	if ip_interface == "WAN" then
					local from_user = AVP_get("FROMUSER");
					local from_sql = CORE:new (arg);
                			local from_sql = from_sql:sql ("opensips","select","select username from subscriber where username = '" .. from_user .. "'","request");

                			if not from_sql or from_sql == nil then
                        			ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.from_deny,level);
						local forbidden = "forbidden";
                        			return forbidden
                			else
                        			ddos_event:event (arg,m_ddos.name,m_ddos.description,m_ddos.from_allow,level);
                			end;
                        	end;
                	else
                        	return
                	end;
		end;
        end;

return m_ddos
