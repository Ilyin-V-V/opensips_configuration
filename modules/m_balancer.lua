------------------------------------------
-- Модуль балансировки нагрузки U_Server -
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_balancer = {}

		m_balancer.name = "m_balancer"
		m_balancer.description = "Модуль балансировки нагрузки U_Server"
		m_balancer.successfully = "Вызов отправлен на медиасервер"
		m_balancer.fail = "Сбой отправки вызова на медиасервер"
	
	function m_balancer:balancer_dispather (arg,level)
		local balancer_event = CORE:new (arg);
                balancer_event:event (arg,m_balancer.name,m_balancer.description,"request",level);

		local ip_destination = AVP_get("DESTIP");
                local ip_interface = s_face[ip_destination];

		if ip_interface == "WAN" then
			local balancer = moduleFunc (arg,"ds_select_dst","1","4");
			if balancer == 1 then
					balancer_event:event (arg,m_balancer.name,m_balancer.description,m_balancer.successfully,level);
					local sending = "sending";
					return sending
				else
					balancer_event:event (arg,m_balancer.name,m_balancer.description,m_balancer.fail,level);
					local fail = "fail";
					return fail
			end;
		else
			return
		end;
      	end;

return m_balancer
