------------------------------------------
-- Модуль смены сокета U_Server ------------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local m_socket = {}

		m_socket.name = "m_socket"
		m_socket.description = "Модуль смены сокета U_Server"
		m_socket.internal = "Смена сокета c internal_ip_face на external_ip_face"
		m_socket.external = "Смена cокета с  external_ip_face на internal_ip_face"  
	
	function m_socket:socket_change (arg,direction,method,level)
		local socket_event = CORE:new (arg);
		if direction == "request" then
                	socket_event:event (arg,m_socket.name,m_socket.description,"request",level);
		elseif 
			direction == "reply" then
			socket_event:event (arg,m_socket.name,m_socket.description,reply,level);
		end;

		local ip_destination = AVP_get("DESTIP");
                local ip_interface = s_face[ip_destination];

		if ip_interface == "WAN" then
			socket_event:event (arg,m_socket.name,m_socket.description,m_socket.internal,level);
			AVP_set("SOCKET",lan_ip);
		elseif ip_interface == "LAN" then
			socket_event:event (arg,m_socket.name,m_socket.description,m_socket.external,level);
			AVP_set("SOCKET",wan_ip);
		end;			
		
      	end;

return m_socket
