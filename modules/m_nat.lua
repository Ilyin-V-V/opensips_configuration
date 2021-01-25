------------------------------------------
-- Модуль преодоления NAT U_Server -------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_nat = {}

		m_nat.name = "m_nat"
		m_nat.description = "Модуль преодоления NAT U_Server"
		m_nat.privatenetwork = "Терминал частной сети, механизм nat pinger не задействован"
		m_nat.worldwidenetwork = "Терминал в интернет сети, применяю nat test"
		m_nat.registerevent = "Активирую NAT pinger к пакету REGISTER"
		m_nat.inviteevent = "Активирую NAT pinger к пакету INVITE"
	
	function m_nat:nat_network (arg,level)
		local nat_event = CORE:new (arg);
                nat_event:event (arg,m_nat.name,m_nat.description,"request",level);
		local ip1, ip2, ip3, ip4 = AVP_get("SOURCEIP"):match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$");
		local tetrad2 = false;
		local tetrad3 = false;
		local tetrad4 = false;

		if ip1:match("^[1][0]") then
			if ip2:match("^25[0-5]") then tetrad2 = true end; 
			if ip2:match("^2[0-4][0-9]") then tetrad2 = true end;
			if ip2:match("[0-1][0-9]{2}") then tetrad2 = true end;
			if ip2:match("[0-9]{2}") then tetrad2 = true end;
			if ip2:match("[0-9]") then tetrad2 = true end;
			if ip3:match("^25[0-5]") then tetrad3 = true end;
                	if ip3:match("^2[0-4][0-9]") then tetrad3 = true end;
                	if ip3:match("[0-1][0-9]{2}") then tetrad3 = true end;
                	if ip3:match("[0-9]{2}") then tetrad3 = true end;
                	if ip3:match("[0-9]") then tetrad3 = true end;	
			if ip4:match("^25[0-5]") then tetrad4 = true end;
                	if ip4:match("^2[0-4][0-9]") then tetrad4 = true end;
                	if ip4:match("[0-1][0-9]{2}") then tetrad4 = true end;
                	if ip4:match("[0-9]{2}") then tetrad4 = true end;
                	if ip4:match("[0-9]") then tetrad4 = true end;
		end;

		if ip1:match("^172") then
			if ip2:match("^1[6]3[0-2]") then tetrad2 = true end;
			if ip3:match("^25[0-5]") then tetrad3 = true end;
			if ip3:match("^2[0-4][0-9]") then tetrad3 = true end;
                        if ip3:match("[0-1][0-9]{2}") then tetrad3 = true end;
                        if ip3:match("[0-9]{2}") then tetrad3 = true end;
                        if ip3:match("[0-9]") then tetrad3 = true end;
                        if ip4:match("^25[0-5]") then tetrad4 = true end;
                        if ip4:match("^2[0-4][0-9]") then tetrad4 = true end;
                        if ip4:match("[0-1][0-9]{2}") then tetrad4 = true end;
                        if ip4:match("[0-9]{2}") then tetrad4 = true end;
                        if ip4:match("[0-9]") then tetrad4 = true end;
		end;

		if ip1:match("^192") then
			if ip2:match("^168") then tetrad2 = true end;
			if ip3:match("^25[0-5]") then tetrad3 = true end;
                        if ip3:match("^2[0-4][0-9]") then tetrad3 = true end;
                        if ip3:match("[0-1][0-9]{2}") then tetrad3 = true end;
                        if ip3:match("[0-9]{2}") then tetrad3 = true end;
                        if ip3:match("[0-9]") then tetrad3 = true end;
                        if ip4:match("^25[0-5]") then tetrad4 = true end;
                        if ip4:match("^2[0-4][0-9]") then tetrad4 = true end;
                        if ip4:match("[0-1][0-9]{2}") then tetrad4 = true end;
                        if ip4:match("[0-9]{2}") then tetrad4 = true end;
                        if ip4:match("[0-9]") then tetrad4 = true end;
		end;

		if tetrad2 == true and tetrad3 == true and tetrad4 == true then
                	nat_event:event (arg,m_nat.name,m_nat.description,m_nat.privatenetwork,level);
			return
			else
				nat_event:event (arg,m_nat.name,m_nat.description,m_nat.worldwidenetwork,level);
				AVP_set("SIPPING","YES");	
				local pinger = "sip_ping";
				return pinger
		end;
	end;

	function m_nat:nat_test (arg,level)
		local nat_event = CORE:new (arg);
                nat_event:event (arg,m_nat.name,m_nat.description,"request",level);
			local nat_uac_test = moduleFunc (arg,"nat_uac_test","19");	
				if nat_uac_test == "1" then
					local nat = "yes";
					return nat
				end;
      	end;

	function m_nat:nat_register (arg,level)
		local nat_event = CORE:new (arg);
                nat_event:event (arg,m_nat.name,m_nat.description,m_nat.registerevent,level);
		moduleFunc (arg,"fix_nated_register");
		AVP_set("NAT","YES");
                AVP_set("SIPPING","YES");
		local natflag = "yes";
		return natflag
	end;

	function m_nat:nat_invite (arg,level)
		local nat_event = CORE:new (arg);
                nat_event:event (arg,m_nat.name,m_nat.description,m_nat.inviteevent,level);
                moduleFunc (arg,"fix_nated_contact");
    		moduleFunc (arg,"fix_nated_sdp","3");
		AVP_set("NATB","YES");
		local natbflag = "yes";
                return natbflag
        end;


return m_nat
