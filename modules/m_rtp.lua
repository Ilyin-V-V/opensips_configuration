------------------------------------------
-- Модуль RTP команд U_Server ------------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_rtp = {}

		m_rtp.name = "m_rtp"
		m_rtp.description = "Модуль отправки команд rtp U_Server"
		m_rtp.internal = "Перезаписываю тело sdp c internal_ip_face на external_ip_face"
		m_rtp.external = "Перезаписываю тело sdp c external_ip_face на internal_ip_face"
		m_rtp.rtpengine = "Перезаписываю тело sdp на internal_ip_face"
		m_rtp.reset = "Сбрасываю коннекты к rtp серверу"  
	
	function m_rtp:rtp_rewrite (arg,rewrite,direction,method,level)
		local rtp_event = CORE:new (arg);
		if direction == "request" then
                	rtp_event:event (arg,m_rtp.name,m_rtp.description,"request",level);
		elseif direction == "reply" then
			rtp_event:event (arg,m_rtp.name,m_rtp.description,method,level);
		end;	
		local ip_destination = AVP_get("DESTIP");
                local ip_interface = s_face[ip_destination];

		if s_rtp_local == "enable" then
			if direction == "request" then
				if ip_interface == "LAN" then
					rtp_event:event (arg,m_rtp.name,m_rtp.description,m_rtp.internal,level);
					moduleFunc (arg,"rtpengine_offer","replace-origin replace-session-connection ICE=remove in-iface=internal out-iface=external");
				elseif ip_interface == "WAN" then
					rtp_event:event (arg,m_rtp.name,m_rtp.description,m_rtp.external,level);
					moduleFunc (arg,"rtpengine_offer","replace-origin replace-session-connection ICE=remove in-iface=external out-iface=internal");
				end;
			end;

			if direction == "reply" then
                        	if ip_interface == "LAN" then
                                	rtp_event:event (arg,m_rtp.name,m_rtp.description,m_rtp.internal,level);
                                	moduleFunc (arg,"rtpengine_offer","replace-origin replace-session-connection ICE=remove in-iface=external out-iface=internal");
                        	elseif ip_interface == "WAN" then
                                	rtp_event:event (arg,m_rtp.name,m_rtp.description,m_rtp.external,level);
                                	moduleFunc (arg,"rtpengine_offer","replace-origin replace-session-connection ICE=remove in-iface=internal out-iface=external");
                        	end;
                	end;
		else
			rtp_event:event (arg,m_rtp.name,m_rtp.description,m_rtp.rtpengine,level);
                        moduleFunc (arg,"rtpengine_offer","replace-origin replace-session-connection ICE=remove");
		end;			
		
      	end;

	function m_rtp:rtp_reset (arg,reset,level)
                local rtp_event = CORE:new (arg);
                rtp_event:event (arg,m_rtp.name,m_rtp.description,"request",level);
		rtp_event:event (arg,m_rtp.name,m_rtp.description,m_rtp.reset,level);
		moduleFunc (arg,"rtpengine_delete");
	end;

return m_rtp
