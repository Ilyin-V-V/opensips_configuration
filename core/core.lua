---------------------------------------
-- Ядро обработки диалога Opensips ----
---------------------------------------

--core
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'
package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_debug = dofile'/usr/local/etc/opensips/extensions/core/c_debug.lua'

local c_config = require "c_config"
local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_debug = require "c_debug"

--core_modules
package.loaded.cm_register = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_register.lua'
package.loaded.cm_invite = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_invite.lua'
package.loaded.cm_ack = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_ack.lua'
package.loaded.cm_prack = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_prack.lua'
package.loaded.cm_bye = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_bye.lua'
package.loaded.cm_cancel = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_cancel.lua'
package.loaded.cm_options = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_options.lua'
package.loaded.cm_notify = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_notify.lua'
package.loaded.cm_publish = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_publish.lua'
package.loaded.cm_subscribe = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_subscribe.lua'
package.loaded.cm_message = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_message.lua'
package.loaded.cm_refer = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_refer.lua'
package.loaded.cm_ringing = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_ringing.lua'
package.loaded.cm_callisforwarded = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_callisforwarded.lua'
package.loaded.cm_callisqueued = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_callisqueued.lua'
package.loaded.cm_sprogress = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_sprogress.lua'
package.loaded.cm_sdp = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_sdp.lua'
package.loaded.cm_ok = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_ok.lua'
package.loaded.cm_accepted = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_accepted.lua'
package.loaded.cm_threexx = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_threexx.lua'
package.loaded.cm_fourxx = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_fourxx.lua'
package.loaded.cm_authinvite = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_authinvite.lua'
package.loaded.cm_fivexx = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_fivexx.lua'
package.loaded.cm_sixxx = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_sixxx.lua'
package.loaded.cm_loop = dofile'/usr/local/etc/opensips/extensions/core_modules/cm_loop.lua'

local cm_register = require "cm_register"
local cm_invite = require "cm_invite"
local cm_ack = require "cm_ack"
local cm_prack = require "cm_prack"
local cm_bye = require "cm_bye"
local cm_cancel = require "cm_cancel"
local cm_options = require "cm_options"
local cm_notify = require "cm_notify"
local cm_publish = require "cm_publish"
local cm_subscribe = require "cm_subscribe"
local cm_message = require "cm_message"
local cm_refer = require "cm_refer"
local cm_ringing = require "cm_ringing"
local cm_callisforwarded = require "cm_callisforwarded"
local cm_callisqueued = require "cm_callisqueued"
local cm_sprogress = require "cm_sprogress"
local cm_sdp = require "cm_sdp"
local cm_ok = require "cm_ok"
local cm_accepted = require "cm_accepted"
local cm_threexx = require "cm_threexx"
local cm_fourxx = require "cm_fourxx"
local cm_authinvite = require "cm_authinvite"
local cm_fivexx = require "cm_fivexx"
local cm_sixxx = require "cm_sixxx"
local cm_loop = require "cm_loop"

--modules
package.loaded.m_authorization = dofile'/usr/local/etc/opensips/extensions/modules/m_authorization.lua'
package.loaded.m_location = dofile'/usr/local/etc/opensips/extensions/modules/m_location.lua'
package.loaded.m_tophiding = dofile'/usr/local/etc/opensips/extensions/modules/m_tophiding.lua'
package.loaded.m_nat = dofile'/usr/local/etc/opensips/extensions/modules/m_nat.lua'
package.loaded.m_rtp = dofile'/usr/local/etc/opensips/extensions/modules/m_rtp.lua'
package.loaded.m_socket = dofile'/usr/local/etc/opensips/extensions/modules/m_socket.lua'
package.loaded.m_dialplan = dofile'/usr/local/etc/opensips/extensions/modules/m_dialplan.lua'
package.loaded.m_balancer = dofile'/usr/local/etc/opensips/extensions/modules/m_balancer.lua'
package.loaded.m_ddos = dofile'/usr/local/etc/opensips/extensions/modules/m_ddos.lua'
package.loaded.m_acl = dofile'/usr/local/etc/opensips/extensions/modules/m_acl.lua'
package.loaded.m_sql = dofile'/usr/local/etc/opensips/extensions/modules/m_sql.lua'

local m_authorization = require "m_authorization"
local m_location = require "m_location"
local m_tophiding = require "m_tophiding"
local m_nat = require "m_nat"
local m_rtp = require "m_rtp"
local m_socket = require "m_socket"
local m_dialplan = require "m_dialplan"
local m_balancer = require "m_balancer"
local m_ddos = require "m_ddos"
local m_acl = require "m_acl"
local m_sql = require "m_sql"

function core(arg,arg1)

	function extended (child, parent)
    		setmetatable (child,{__index = parent})
	end;

	local level = c_config.c_config (config);

	CORE = { }

		function CORE:new (arg)

			local module = {}

			function module:event (arg,name,description,event,level)
 				c_debug.c_debug (arg,name,description,event,level);
			end;

			 function module:authorization (arg)
                                extended (m_authorization, CORE);
                                local authorization = m_authorization:new (arg);
                                authorization:event (arg,authorization.name,authorization.description,"request",level);
                                local status = authorization:authorization_conduct (arg,level);
                                if status == "forbidden" then return status end;
				if status == "Не найдены учетные данные в запросе" then return status end;
				if status == "Просроченный nonce" then return status end;
                                if status == "allow" then return status end;
                        end;

			function module:location (arg)
				extended (m_location, CORE);
				local location = m_location:new (arg);
				location:event (arg,location.name,location.description,"request",level);
				local not_found = location:location_search (arg,level);
				if not_found == "not_found" then return not_found end;
				if not_found == "method_not_supported" then return not_found end;
				if not_found == "internal_server_error" then return not_found end;
			end;

			function module:tophiding (arg,tag,status,reply)
				extended (m_tophiding, CORE);
				local tophiding = m_tophiding:new (arg);
				if status == "reply" then
					tophiding:event (arg,tophiding.name,tophiding.description,reply,level);
				elseif status == "request" then
					tophiding:event (arg,tophiding.name,tophiding.description,"request",level);
				end;
				tophiding:tophiding_hiding (arg,tag,level);
				tophiding:tophiding_hiding_user (arg,level);
			end;

			function module:nat (arg,method)
				extended (m_nat, CORE);
				local nat = m_nat:new (arg);
				nat:event (arg,nat.name,nat.description,"request",level);
				local sip_ping = nat:nat_network (arg,level);
				if sip_ping == "sip_ping" then
					local nattest = nat:nat_test (arg,level);
						if nattest == "yes" and method == "REGISTER" then
                                        		local fix_nated = nat:nat_register (arg,level);
                                                		if fix_nated == "yes" then
                                                        		local sip_ping_nat = "sip_ping_nat"
                                                        		return sip_ping_nat
                                                		end;
                                        	else
                                                	return sip_ping
						end;
						if nattest == "yes" and method == "INVITE" then nat:nat_invite (arg,level) end;
				else
					return
                                end;

			end;

			function module:rtp (arg,rewrite,reset,direction,method)
                                extended (m_rtp, CORE);
                                local rtp = m_rtp:new (arg);
				if direction == "request" then rtp:event (arg,rtp.name,rtp.description,"request",level) end;
				if direction == "reply" then rtp:event (arg,rtp.name,rtp.description,method,level) end;	
				if rewrite == "rewrite" then rtp:rtp_rewrite (arg,rewrite,direction,method,level) end;
				if reset == "reset" then rtp:rtp_reset (arg,reset,level) end;
                        end;

			function module:socket (arg,direction,method)
                                extended (m_socket, CORE);
                                local socket = m_socket:new (arg);
                                if direction == "request" then socket:event (arg,socket.name,socket.description,"request",level) end;
                                if direction == "reply" then socket:event (arg,socket.name,socket.description,method,level) end;
				socket:socket_change (arg,direction,method,level);
                        end;

			function module:dialplan (arg)
                                extended (m_dialplan, CORE);
                                local dialplan = m_dialplan:new (arg);
                                dialplan:event (arg,dialplan.name,dialplan.description,"request",level);
				local dialplan_state = dialplan:dialplan_involve (arg,level);
				if dialplan_state == "wan" then
					local dialplan_wan = dialplan:dialplan_wanincoming (arg,level);
					if dialplan_wan == "external" then
						local telephone = dialplan:dialplan_telephone (arg,level);
							if telephone == "found" then return end;
							if telephone == "not found" then return telephone end;
					end;
					if dialplan_wan == "internal" then return end;
				end;
				if dialplan_state == "lan" then
					local dialplan_lan = dialplan:dialplan_lanincoming (arg,level);
						if dialplan_lan == "spec" then return dialplan_lan end;
						if dialplan_lan == "local" then return dialplan_lan end;
						if dialplan_lan == "asbest" then return dialplan_lan end;
						if dialplan_lan == "city" then return dialplan_lan end;
						if dialplan_lan == "russia" then return dialplan_lan end;
						if dialplan_lan == "world" then return dialplan_lan end;
						if dialplan_lan == "forbidden" then return dialplan_lan end;
				end;		
                        end;

			function module:balancer (arg)
                                extended (m_balancer, CORE);
                                local balancer = m_balancer:new (arg);
                                balancer:event (arg,balancer.name,balancer.description,"request",level);
                                local dispather = balancer:balancer_dispather (arg,level);
				if dispather == "sending" then return dispather end;	
                                if dispather == "fail" then return dispather end;
                        end;

			function module:attack (arg,pike,validate,subscriber)
                                extended (m_ddos, CORE);
                                local ddos = m_ddos:new (arg);
                                ddos:event (arg,ddos.name,ddos.description,"request",level);
				local control = ddos:ddos_control (arg,pike,level);
                                local validate = ddos:validate_control (arg,validate,level);
				if validate == "forbidden" then return validate end;
				local subscriber = ddos:ddos_from (arg,subscriber,level);
				if subscriber == "forbidden" then return subscriber end;	
                        end;

			function module:acl (arg,access)
                                extended (m_acl, CORE);
                                local acl = m_acl:new (arg);
                                acl:event (arg,acl.name,acl.description,"request",level);
                                local acl_status = acl:acl_ip_address (arg,access,level);
                                if acl_status == "forbidden" then return acl_status end;
                        end;

			function module:sql (db,act_db,sql_query,reply)
                                extended (m_sql, CORE);
                                local sql = m_sql:new (arg);
				if reply == "reply" then sql:event (arg,sql.name,sql.description,reply,level) end;
                                if reply == "request" then sql:event (arg,sql.name,sql.description,"request",level) end;
				if act_db == "select" then
					local select = sql:sql_qwery (db,sql_query);
					return select
				end;
				if act_db == "select_multi" then
					local select_multi = sql:sql_qwery_multi_row (db,sql_query);
					return select_multi
				end;
				if act_db == "insert" then
					local insert = sql:sql_insert (db,sql_query);
					return insert	
				end; 
                        end;

		setmetatable (module, self)
                self.__index = self;
                return module;

                end;

	DIALOG = { }

		function DIALOG:new (arg)
			
			local method = {}

			function method:register (arg,auth,nat,pike,validate,subscriber,acl)
				extended (cm_register, DIALOG);
                		local register = cm_register:new (arg);
				register:event (arg,register.name,register.description,"request",level);
				local forbidden = register:register_ddos (arg,pike,validate,subscriber,level);
					if forbidden == "forbidden" then 
						AVP_set("DISCONTINUE","LOOP");
						return
					end;		
				local forbidden = register:register_acl (arg,acl,level);
                                        if forbidden == "forbidden" then
                                                AVP_set("DISCONTINUE","LOOP");
                                                return
                                        end;
				local sip_ping_nat = register:register_nat (arg,nat,level);
				local authentication = register:register_auth (arg,auth,level);
				if authentication == "forbidden" then
					register:send_reply (arg, "403", "Forbidden");
					return
				end;
				if authentication == "Не найдены учетные данные в запросе" then return end;
				if authentication == "Просроченный nonce" then return end;
					AVP_set("REGISTERED","YES");
				return
				--register:register_save (arg,authentication,level);
			end;

			function method:invite (arg,route,tag,auth,nat,rtp,socket,dialplan,ddos,validate,dispather,subscriber,acl)
                                extended (cm_invite, DIALOG);
                                local invite = cm_invite:new (arg);
                                invite:event (arg,invite.name,invite.description,"request",level);
				if route == "Re-INVITE" then
                                        invite:invite_hiding (arg,tag,level);
                                        invite:invite_authorization (arg,level);
					invite:invite_rtp (arg,rtp,level);
                                        return
                                end;
				local forbidden = invite:invite_ddos (arg,ddos,validate,subscriber,level);
				if forbidden == "forbidden" then
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
				local forbidden = invite:invite_acl (arg,acl,level);
                                if forbidden == "forbidden" then
                                        AVP_set("DISCONTINUE","LOOP");
                                        return
                                end;
				local authentication = invite:invite_auth (arg,auth,level);
                                if authentication == "forbidden" then
					invite:send_reply (arg, "403", "Forbidden");
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
				if authentication == "Не найдены учетные данные в запросе" then
					AVP_set("DISCONTINUE","LOOP");
					return

				end;
				if authentication == "Просроченный nonce" then
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
				invite:invite_nat (arg,nat,level);
				local set = invite:invite_dialplan (arg,dialplan,level);
				if set == "not found" then 
					invite:send_reply (arg,"404","Not Found");
                                        AVP_set ("DISCONTINUE","LOOP");
                                end;
				if set == "spec" or set == "asbest" or set == "city" or set == "russia" or set == "world" then
					invite:send_reply (arg,"404","Not Found");
                                        AVP_set ("DISCONTINUE","LOOP");
				end;
				
				if set == "forbidden" then
					invite:send_reply (arg,"404","Not Found");
                                        AVP_set ("DISCONTINUE","LOOP");
				end;
 		
				local dispather = invite:invite_dispather (arg,dispather,level);
				if dispather == "sending" then 
					route = "dispather"
					local tag = "none";
					invite:invite_hiding (arg,tag,level);
					local check_trans = moduleFunc (arg,"t_check_trans");
					if check_trans ~= 1 then invite:invite_rtp (arg,rtp,level) end;
				end;

				if route == "location" then
                                	local not_found = invite:invite_call (arg,route,level);
						if not_found == "not_found" then
							invite:send_reply (arg,"404","Not Found Location");
							AVP_set ("DISCONTINUE","LOOP");
						end;
					if not_found == "method_not_supported" then
						invite:send_reply (arg,"405","Method Not Allowed");
						AVP_set("DISCONTINUE","LOOP");
					end;
					if not_found == "internal_server_error" then
						invite:send_reply (arg,"500","Internal Server Error");
						AVP_set("DISCONTINUE","LOOP");
					end;
				local tag = "none";
					invite:invite_hiding (arg,tag,level);
					invite:invite_rtp (arg,rtp,level);
				end;
				invite:invite_socket (arg,socket,level);
                        end;

			function method:ack (arg,tag,socket)
                                extended (cm_ack, DIALOG);
                                local ack = cm_ack:new (arg);
                                ack:event (arg,ack.name,ack.description,"request",level);
				ack:loop (arg);	
                                ack:ack_confirm (arg,level);
				ack:ack_hiding (arg,tag,level);
				ack:ack_authorization (arg,level);
				ack:ack_socket (arg,socket,level);
                        end;

			function method:prack (arg,tag,socket)
                                extended (cm_prack, DIALOG);
                                local prack = cm_prack:new (arg);
                                prack:event (arg,prack.name,prack.description,"request",level);
                                prack:loop (arg);
                                prack:prack_confirm (arg,level);
                                prack:prack_hiding (arg,tag,level);
                                prack:prack_authorization (arg,level);
				prack:prack_socket (arg,socket,level);
                        end;

			function method:bye (arg,tag,rtp,socket)
                                extended (cm_bye, DIALOG);
                                local bye = cm_bye:new (arg);
                                bye:event (arg,bye.name,bye.description,"request",level);
                                bye:bye_confirm (arg,level);
                                bye:bye_hiding (arg,tag,level);
				bye:bye_authorization (arg,level);
				bye:bye_rtp (arg,rtp,level);
				bye:bye_socket (arg,socket,level);
                        end;

			function method:cancel (arg,tag,socket)
                                extended (cm_cancel, DIALOG);
                                local cancel = cm_cancel:new (arg);
                                cancel:event (arg,cancel.name,cancel.description,"request",level);
                                cancel:cancel_confirm (arg,level);
                                cancel:cancel_hiding (arg,tag,level);
				cancel:cancel_authorization (arg,level);
				cancel:cancel_rtp (arg,rtp,level);
				cancel:cancel_socket (arg,socket,level);
                        end;

			function method:options (arg,ddos,validate,subscriber)
                                extended (cm_options, DIALOG);
                                local options = cm_options:new (arg);
                                options:event (arg,options.name,options.description,"request",level);
				local forbidden = options:options_ddos (arg,ddos,validate,subscriber,level);
				if forbidden == "forbidden" then
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
                                local send = options:options_send (arg,level);
				if send == "answer" then options:send_reply (arg,"200","OK") end;
				if send == "no_answer" then return end;
                        end;

			function method:notify (arg,mode,tag,socket,ddos,validate,subscriber)
                                extended (cm_notify, DIALOG);
                                local notify = cm_notify:new (arg);
                                notify:event (arg,notify.name,notify.description,"request",level);
				local forbidden = notify:notify_ddos (arg,ddos,validate,subscriber,level);
				if forbidden == "forbidden" then
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
				if mode == "keep-alive" then 
                                	local send = notify:notify_ping (arg,ping,level);
                                	if send == "answer" then notify:send_reply (arg,"200","OK") end;
                                	if send == "no_answer" then return end;
				elseif mode == "send" then
					notify:notify_send (arg,level);
					notify:send_reply (arg,"503","Service Unavailable");
				elseif mode == "Refer-NOTIFY" then
					notify:loop (arg);
					notify:notify_send (arg,level);
					notify:notify_hiding (arg,tag,level);
                                	notify:notify_authorization (arg,level);
					notify:notify_socket (arg,socket,level);
				end;
                        end;

			function method:publish (arg,ddos,validate,subscriber)
                                extended (cm_publish, DIALOG);
                                local publish = cm_publish:new (arg);
                                publish:event (arg,publish.name,publish.description,"request",level);
				local forbidden = publish:publish_ddos (arg,ddos,validate,subscriber,level);
				if forbidden == "forbidden" then
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
                                publish:publish_send (arg,level);
				publish:send_reply (arg,"503","Service Unavailable");
                        end;

			function method:subscribe (arg,ddos,validate,subscriber)
                                extended (cm_subscribe, DIALOG);
                                local subscribe = cm_subscribe:new (arg);
                                subscribe:event (arg,subscribe.name,subscribe.description,"request",level);
				local forbidden = subscribe:subscribe_ddos (arg,ddos,validate,subscriber,level);
				if forbidden == "forbidden" then
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
                                subscribe:subscribe_send (arg,level);
				subscribe:send_reply (arg,"503","Service Unavailable");
                        end;

			function method:message (arg,ddos,validate,subscriber)
				extended (cm_message, DIALOG);
				local message = cm_message:new (arg);
				message:event (arg,message.name,message.description,"request",level);
				local forbidden = message:message_ddos (arg,ddos,validate,subscriber,level);
				if forbidden == "forbidden" then
					AVP_set("DISCONTINUE","LOOP");
					return
				end;
				message:message_send (arg,level);
				message:send_reply (arg,"503","Service Unavailable");
			end;

			function method:refer (arg,tag,socket)
                                extended (cm_refer, DIALOG);
                                local refer = cm_refer:new (arg);
                                refer:event (arg,refer.name,refer.description,"request",level);
                                refer:loop (arg);
                                refer:refer_confirm (arg,level);
                                refer:refer_hiding (arg,tag,level);
				refer:refer_socket (arg,socket,level);
                        end;

			function method:ringing (arg,tag)
                                extended (cm_ringing, DIALOG);
                                local ringing = cm_ringing:new (arg);
                                ringing:event (arg,ringing.name,ringing.description,ringing.reply,level);
                                ringing:ringing_ringing (arg,level);
				ringing:ringing_hiding (arg,tag);
                        end;

			function method:callisforwarded (arg,tag)
                                extended (cm_callisforwarded, DIALOG);
                                local callisforwarded = cm_callisforwarded:new (arg);
                                callisforwarded:event (arg,callisforwarded.name,callisforwarded.description,callisforwarded.reply,level);
                                callisforwarded:callisforwarded_callisforwarded (arg,level);
                                callisforwarded:callisforwarded_hiding (arg,tag);
                        end;			

			function method:callisqueued (arg,tag)
                                extended (cm_callisqueued, DIALOG);
                                local callisqueued = cm_callisqueued:new (arg);
                                callisqueued:event (arg,callisqueued.name,callisqueued.description,callisqueued.reply,level);
                                callisqueued:callisqueued_callisqueued (arg,level);
                                callisqueued:callisqueued_hiding (arg,tag);
                        end;

			function method:sprogress (arg,tag)
                                extended (cm_sprogress, DIALOG);
                                local sprogress = cm_sprogress:new (arg);
                                sprogress:event (arg,sprogress.name,sprogress.description,sprogress.reply,level);
                                sprogress:sprogress_sprogress (arg,level);
				sprogress:sprogress_hiding (arg,tag);
                        end;

			function method:sdp (arg,tag,rtp)
                                extended (cm_sdp, DIALOG);
                                local sdp = cm_sdp:new (arg);
                                sdp:event (arg,sdp.name,sdp.description,sdp.reply,level);
                                sdp:sdp_ok (arg,level);
				sdp:sdp_hiding (arg,tag);
				sdp:sdp_rtp (arg,rtp);
                        end;

			function method:ok (arg,tag)
                                extended (cm_ok, DIALOG);
                                local ok = cm_ok:new (arg);
                                ok:event (arg,ok.name,ok.description,ok.reply,level);
                                ok:ok_ok (arg,level);
                                ok:ok_hiding (arg,tag);
				ok:ok_authorization (arg,level);
                        end;

			function method:accepted (arg,tag)
                                extended (cm_accepted, DIALOG);
                                local accepted = cm_accepted:new (arg);
                                accepted:event (arg,accepted.name,accepted.description,accepted.reply,level);
                                accepted:accepted_accepted (arg,level);
                                accepted:accepted_hiding (arg,tag);
				accepted:accepted_authorization (arg,level);
                        end;

			function method:threexx (arg,tag)
                                extended (cm_threexx, DIALOG);
                                local threexx = cm_threexx:new (arg);
                                threexx:event (arg,threexx.name,threexx.description,threexx.reply,level);
                                threexx:threexx_ok (arg,level);
                                threexx:threexx_hiding (arg,tag);
                        end;

			function method:fourxx (arg,tag,unauthorized)
                                extended (cm_fourxx, DIALOG);
                                local fourxx = cm_fourxx:new (arg);
                                fourxx:event (arg,fourxx.name,fourxx.description,fourxx.reply,level);
                                fourxx:fourxx_ok (arg,level);
                                fourxx:fourxx_hiding (arg,tag);
                        end;

			function method:authinvite (arg)
                                extended (cm_authinvite, DIALOG);
                                local authinvite = cm_authinvite:new (arg);
                                authinvite:event (arg,authinvite.name,authinvite.description,authinvite.reply,level);
                                local server,port = authinvite:authinvite_conduct (arg);
                                AVP_set ("IPSERVER",server);
                                AVP_set ("PORTSERVER",port);
                        end;

			function method:fivexx (arg,tag)
                                extended (cm_fivexx, DIALOG);
                                local fivexx = cm_fivexx:new (arg);
                                fivexx:event (arg,fivexx.name,fivexx.description,fivexx.reply,level);
                                fivexx:fivexx_ok (arg,level);
                                fivexx:fivexx_hiding (arg,tag);
                        end;

			function method:sixxx (arg,tag)
                                extended (cm_sixxx, DIALOG);
                                local sixxx = cm_sixxx:new (arg);
                                sixxx:event (arg,sixxx.name,sixxx.description,sixxx.reply,level);
                                sixxx:sixxx_ok (arg,level);
                                sixxx:sixxx_hiding (arg,tag);
                        end;

			function method:send_reply (arg,cod,message)
				moduleFunc (arg,"send_reply",cod,message);
			end;
			
			function method:event (arg,name,description,event,level)
				c_debug.c_debug (arg,name,description,event,level);

                        end;

			function method:loop (arg)
				extended (cm_loop, DIALOG);
				local loop = cm_loop:new (arg);
                                loop:event (arg,loop.name,loop.description,loop.status,level);
				local set = loop:loop_set (arg,level);
				if set == "set" then
					local status = loop:loop_loop (arg,level);
					if status == "loop_max" then 
						loop:send_reply (arg,"500","Internal Server Error");					
						AVP_set("DISCONTINUE","LOOP");
					end;
				end;
                        end;

		setmetatable (method, self)
		self.__index = self;
		return method;

		end;


if getMethod (arg) == "REGISTER" then
	local register = DIALOG:new (arg);
	register:register (arg,s_auth,s_nat,s_pike,s_validate,s_subscriber,s_acl);
end;

if getMethod (arg) == "INVITE" then
	local invite = DIALOG:new (arg);
	local route = "location";
	if arg1 == "Re-INVITE" then
		route = "Re-INVITE";
		tag = "tag";
	end;
	invite:invite (arg,route,tag,s_auth,s_nat,s_rtp,s_socket,s_dialplan,s_pike,s_validate,s_dispather,s_subscriber,s_acl);
end;

if getMethod (arg) == "ACK" then
        local ack = DIALOG:new (arg);
	local tag = "tag";
        ack:ack (arg,tag,s_socket);
end;

if getMethod (arg) == "PRACK" then
        local prack = DIALOG:new (arg);
        local tag = "tag";
        prack:prack (arg,tag,s_socket);
end;

if getMethod (arg) == "BYE" then
        local bye = DIALOG:new (arg);
        local tag = "tag";
        bye:bye (arg,tag,s_rtp,s_socket);
end;

if getMethod (arg) == "CANCEL" then
        local cancel = DIALOG:new (arg);
        local tag = "tag";
        cancel:cancel (arg,tag,s_socket);
end;

if getMethod (arg) == "OPTIONS" then
        local options = DIALOG:new (arg);
        options:options (arg,s_pike,s_validate,s_subscriber);
end;

if getMethod (arg) == "NOTIFY" then
        local notify = DIALOG:new (arg);
	local tag = "tag";
        notify:notify (arg,arg1,tag,s_socket,s_pike,s_validate,s_subscriber);
end;

if getMethod (arg) == "PUBLISH" then
        local publish = DIALOG:new (arg);
        publish:publish (arg,s_pike,s_validate,s_subscriber);
end;

if getMethod (arg) == "SUBSCRIBE" then
        local subscribe = DIALOG:new (arg);
        subscribe:subscribe (arg,s_pike,s_validate,s_subscriber);
end;

if getMethod (arg) == "MESSAGE" then
	local message = DIALOG:new (arg);
	message:message (arg,s_pike,s_validate,s_subscriber);
end;

if getMethod (arg) == "REFER" then
        local refer = DIALOG:new (arg);
	local tag = "tag";
        refer:refer (arg,tag,s_socket);
end;

if arg1 == "180 RINGING" then
        local ringing = DIALOG:new (arg);
	local tag = "tag";
        ringing:ringing (arg,tag);
end;

if arg1 == "181 CALL IS BEING FORWARDED" then
        local callisforwarded = DIALOG:new (arg);
        local tag = "tag";
        callisforwarded:callisforwarded (arg,tag);
end;

if arg1 == "182 CALL IS QUEUED" then
        local callisqueued = DIALOG:new (arg);
        local tag = "tag";
        callisqueued:callisqueued (arg,tag);
end;

if arg1 == "183 SESSION PROGRESS" then
        local sprogress = DIALOG:new (arg);
	local tag = "tag";
        sprogress:sprogress (arg,tag);
end;

if arg1 == "200 OK SDP" then
        local sdp = DIALOG:new (arg);
	local tag = "tag";
        sdp:sdp (arg,tag,s_rtp);
end;

if arg1 == "200 OK" then
        local ok = DIALOG:new (arg);
        local tag = "tag";
        ok:ok (arg,tag);
end;

if arg1 == "202 ACCEPTED" then
        local accepted = DIALOG:new (arg);
        local tag = "tag";
        accepted:accepted (arg,tag);
end;

if arg1 == "3XX REPLY" then
        local threexx = DIALOG:new (arg);
        local tag = "tag";
        threexx:threexx (arg,tag);
end;

if arg1 == "401|407 REPLY" then
	local authinvite = DIALOG:new (arg);	
        authinvite:authinvite (arg);
end;

if arg1 == "4XX REPLY" then
        local fourxx = DIALOG:new (arg);
        local tag = "tag";
        fourxx:fourxx (arg,tag);
end;

if arg1 == "5XX REPLY" then
        local fivexx = DIALOG:new (arg);
        local tag = "tag";
        fivexx:fivexx (arg,tag);
end;

if arg1 == "6XX REPLY" then
        local sixxx = DIALOG:new (arg);
        local tag = "tag";
        sixxx:sixxx (arg,tag);
end;

end;
