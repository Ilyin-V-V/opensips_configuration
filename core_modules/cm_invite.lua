------------------------------------------
-- Модуль обработки сообщения INVITE -----
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_invite = {}

		cm_invite.name = "cm_invite"
		cm_invite.description = "Модуль обработки сообщения INVITE"

	function cm_invite:invite_auth (arg,auth,level)
                c_validator.c_validator (arg,auth);
                c_digest.c_digest ("cm_invite","invite_auth");
		local authorization_ip = moduleFunc (arg,"check_address","0","$si", "$sp","$oP","$avp(context)","$rU");
		if authorization_ip == 1 then return end;

                if auth == "enable" then
                        local authorization = CORE:new (arg);
                        local status = authorization:authorization (arg);
			if status == "allow" then moduleFunc (arg,"remove_hf","Authorization") end;
                        return status
                end;

                if auth == "disable" then
                        local status = "allow"
                        return status
                end;
        end;

	function cm_invite:invite_call (arg,route,level)
		c_validator.c_validator (arg,route);
		c_digest.c_digest ("cm_invite","invite_call");

		if route == "location" then
			local location_search = CORE:new (arg);
			local not_found = location_search:location (arg);
			return not_found
		end;
	end;

	function cm_invite:invite_hiding (arg,tag,level)
		if tag == "tag" then
			local top_hiding = CORE:new (arg);
			top_hiding:tophiding (arg,tag,"request");
		else
			local top_hiding = CORE:new (arg);
			top_hiding:tophiding (arg,tag,"request");
		end;
	end;

	function cm_invite:invite_change_contact (arg,level)
		local ip_port = AVP_get("CONTACT"):match("[@]+(.+)[;]+");
  		local contact = "Contact: sip:" .. AVP_get ("FROMUSER") .. "@" .. AVP_get ("LANIP") .. ":" .. AVP_get ("LANPORT") .. "\n \r";
  		moduleFunc (arg,"remove_hf","Contact");
  		moduleFunc (arg,"append_hf", contact);
		return ip_port
        end;

	function cm_invite:invite_change_uri (arg,ip_port,level)
                local destination_uri = "sip"..":".. AVP_get ("TOUSER") .."@" .. ip_port .. "";
                return destination_uri
        end;

	function cm_invite:invite_authorization (arg,level)
                if s_auth == "enable" then moduleFunc (arg,"remove_hf","Authorization") end;
        end;

	function cm_invite:invite_nat (arg,nat,level)
		c_digest.c_digest ("cm_invite","invite_nat");
		if nat == "enable" then
			local invite_nat = CORE:new (arg);
			invite_nat:nat (arg,"INVITE");
		else
			return
		end;
        end;

	function cm_invite:invite_rtp (arg,rtp,level)
                c_digest.c_digest ("cm_invite","invite_rtp");
                if rtp == "enable" then
                        local invite_rtp = CORE:new (arg);
			local rewrite = "rewrite"
                        invite_rtp:rtp (arg,rewrite,"none","request","none");
                else
                        return
                end;
        end;

	function cm_invite:invite_socket (arg,socket,level)
                c_digest.c_digest ("cm_invite","invite_socket");
                if socket == "enable" then
                        local invite_socket = CORE:new (arg);
                        invite_socket:socket (arg,"request","none");
                else
                        return
                end;
        end;

	function cm_invite:invite_dialplan (arg,dialplan,level)
                c_digest.c_digest ("cm_invite","invite_dialplan");
                if dialplan == "enable" then
                        local invite_dialplan = CORE:new (arg);
                        local set = invite_dialplan:dialplan (arg);
			return set
                else
                        return
                end;
        end;

	function cm_invite:invite_dispather (arg,dispather,level)
                c_digest.c_digest ("cm_invite","invite_dispather");
                if dispather == "enable" then
                        local invite_dispather = CORE:new (arg);
                        local sending = invite_dispather:balancer (arg);
                        return sending
                else
                        return
                end;
        end;

	function cm_invite:invite_ddos (arg,ddos,validate,subscriber,level)
                c_digest.c_digest ("cm_invite","invite_ddos");
                invite_ddos = CORE:new (arg);
                local forbidden = invite_ddos:attack (arg,ddos,validate,subscriber);
		if forbidden == "forbidden" then return forbidden end;
        end;

	function cm_invite:invite_acl (arg,access,level)
                c_digest.c_digest ("cm_invite","invite_acl");
                invite_acl = CORE:new (arg);
                local forbidden = invite_acl:acl (arg,access);
                if forbidden == "forbidden" then return forbidden end;
        end;

return cm_invite
