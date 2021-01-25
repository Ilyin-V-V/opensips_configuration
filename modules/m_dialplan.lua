------------------------------------------
-- Модуль план набора номера U_Server ----
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_dialplan = {}

		m_dialplan.name = "m_dialplan"
		m_dialplan.description = "Модуль плана набора номера U_Server"
		m_dialplan.to_me_external = "Входящий вызов на городской номер"
		m_dialplan.to_me_internal = "Исходящий вызов с терминала"
		m_dialplan.to_me_access = "Проверяю наличие городского Б. номера в базе"
		m_dialplan.to_me_allow = "Вызываемый номер Б. найден в базе, таблица telephone"
		m_dialplan.to_me_fail = "Вызываемый номер Б. в базе не существует, таблица telephone"	
		m_dialplan.from_me_spec = "Исходящий вызов на спецномера"
		m_dialplan.from_me_local = "Исходящий вызов на внутренний номер"
		m_dialplan.from_me_group = "Исходящий вызов на группу"
		m_dialplan.from_me_asbest = "Исходящий вызов на номера г.Асбест"
		m_dialplan.from_me_city = "Исходящий вызов на местные"
		m_dialplan.from_me_russia = "Исходящий вызов по России"
		m_dialplan.from_me_world = "Исходящий вызов по Миру"
		m_dialplan.wan = "Диалплан получил запрос на WAN интерфейс"
		m_dialplan.lan = "Диалплан получил запрос на LAN интерфейс"

	function m_dialplan:dialplan_involve (arg,level)
                local dialplan_event = CORE:new (arg);
                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,"request",level);
		local ip_destination = AVP_get("DESTIP");
                local ip_interface = s_face[ip_destination];

		if ip_interface == "WAN" then
				local dialplan_state = "wan";
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.wan,level);
				return dialplan_state
		end;

		if ip_interface == "LAN" then
				local dialplan_state = "lan";
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.lan,level);
				return dialplan_state
		end;
        end;

	function m_dialplan:dialplan_wanincoming (arg,level)
                local dialplan_event = CORE:new (arg);
                local uri = AVP_get("URI");
		local from = AVP_get("FROMUSER");

			if from:match("[7][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]") or from:match("[8][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.to_me_external,level);
				local type = "external"
				return type 
			end;
	
			if from:match("[0-9][0-9][0-9][0-9][0-9][0-9][9][0-9][0-9][0-9]") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.to_me_internal,level);
				local type = "internal"
				return type
			end;
        end;

	function m_dialplan:dialplan_telephone (arg,level)
		local dialplan_event = CORE:new (arg);
		local uri_user = AVP_get("UURI");
		local from_sql = CORE:new (arg);
			local from_sql = from_sql:sql ("opensips","select","select service_id from telephone where phone = '" .. uri_user .. "'","request");
				if not from_sql or from_sql == nil then
					local telephone = "not found"
					return telephone
				else
					AVP_set("INCOMING","YES");
                                	AVP_set("SERVICEID",from_sql.service_id);
					local from_user = AVP_get("FROMUSER");
					local to_user = AVP_get("TOUSER");	
					local To = "sip:" .. to_user .. "@" .. domain
					moduleFunc (arg,"remove_hf","To");
					moduleFunc (arg,"append_hf","To: <".. To ..">\r\n");	                                
				end;
	end;

	function m_dialplan:dialplan_lanincoming (arg,level)
                local dialplan_event = CORE:new (arg);
                local uri = AVP_get("URI");

                        if uri:match("^sip:[0][1-9]@") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_spec,level);
				local type = "spec"
				return spec
			elseif uri:match("^sip:[1][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_spec,level);
				local type = "spec"
                                return type
			end;

			if uri:match("^sip:[0-9][0-9][0-9][0-9][0-9][0-9][9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
                        elseif uri:match("^sip:[9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[2][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[3][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[4][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[5][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"	
                                return type
			elseif uri:match("^sip:[6][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[7][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[8][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_local,level);
				local type = "local"
                                return type
			elseif uri:match("^sip:[*][8]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_group,level);
                                local type = "local"
                                return type
			elseif uri:match("^sip:[6][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_group,level);
				local type = "local"
                                return type
                        end;

			if uri:match("^sip:[0-9][0-9][0-9][0-9][0-9]@") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_asbest,level);
				local type = "asbest"
                                return type
			end;
		
			if uri:match("^sip:[2-3][0-9][0-9][0-9][0-9][0-9][0-9]@") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_city,level);
				local type = "city"
                                return type
			elseif uri:match("^sip:[0-9][0-9][0-9][0-9][0-9][0-9]@") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_city,level);
				local type = "city"
                                return type
			end;

			if uri:match("^sip:[8][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_russia,level);
				local type = "russia"
                                return type
			elseif uri:match("^sip:[7][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_russia,level);
				local type = "russia"
                                return type
			elseif uri:match("^sip:[+][7][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_russia,level);
				local type = "russia"
                                return type
			end;

			if uri:match("^sip:[8][8][1][0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
				dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_world,level);
				local type = "world"	
                                return type
			elseif uri:match("^sip:[8][8][1][0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_world,level);
				local type = "world"
                                return type
			elseif uri:match("^sip:[8][8][1][0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_world,level);
				local type = "world"
                                return type
			elseif uri:match("^sip:[8][1][0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_world,level);
				local type = "world"
                                return type
			elseif uri:match("^sip:[8][1][0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_world,level);
				local type = "world"
                                return type
			elseif uri:match("^sip:[8][1][0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]@") then
                                dialplan_event:event (arg,m_dialplan.name,m_dialplan.description,m_dialplan.from_me_world,level);
				local type = "world"
                                return type
			end;

		local type = "forbidden"
		return type	
        end;

return m_dialplan
