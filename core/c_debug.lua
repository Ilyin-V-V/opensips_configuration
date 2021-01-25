---------------------------------------
-- Модуль вывода событий в лог файл ---
---------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local c_debug = {}

	c_debug.name = "c_debug"
        c_debug.description = "Модуль вывода событий в лог файл"

function c_debug.c_debug (arg,name,description,event,level)

c_validator.c_validator (arg,name,description,event);

        if not level then return end;
        if level == "none" then return end;
        if level == "verbose" then
                        elseif  level == "full" then
                                else
                                        return;
        end;

	debug = { }

	function debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level)

	local how = {}

	how.user = user
	how.method = method
	how.uriuser = uriuser
	how.uri = uri
	how.from = from
	how.to = to
	how.callid = callid
	how.useragent = useragent
	how.contact = contact
	how.cseq = cseq
	how.protocol = protocol
	how.sourceip = sourceip
	how.sourceport = sourceport
	how.destinationip = destinationip
	how.destinationport = destinationport

	function how:verbose (arg,level)
	local log = {}

                log["verbose"] = {
                                        "==========================" .. user .. "===============================",
                                        "" .. user .. "| Модуль: => " .. name .. "; Описание: => " .. description .. "",
                                        "==========================" .. user .. "===============================",
                                        "" .. user .. "| Уровень логирования: " ..level .. "",
                                        "" .. user .. "| Метод транзакции: " .. method .. "",
                                        "" .. user .. "| URI_User транзакции: " .. uriuser .. "",
                                        "" .. user .. "| FROM транзакции: " .. from .. "",
                                        "" .. user .. "| TO транзакции: " .. to .. "",
                                        "" .. user .. "| ID транзакции: " .. callid .. "",
                                        "" .. user .. "| User-Agent: " .. useragent .. "",
                                        "==========================" ..user .. "==============================="
                                }

                log["full"] = {
                                        "============================" .. user .. "=============================",
                                        "" .. user .. "| Модуль: => " .. name .. "; Описание: => " .. description .. "",
                                        "============================" .. user .. "=============================",
                                        "" .. user .. "| Уровень логирования: " ..level .. "",
                                        "" .. user .. "| Метод транзакции: " .. method .. "",
                                        "" .. user .. "| URI транзакции: " .. uri .. "",
                                        "" .. user .. "| FROM транзакции: " .. from .. "",
                                        "" .. user .. "| TO транзакции: " .. to .. "",
                                        "" .. user .. "| ID транзакции: " .. callid .. "",
                                        "" .. user .. "| Контакт транзакции: " .. contact .. "",
                                        "" .. user .. "| Номер CSEQ: " .. cseq .. "",
                                        "" .. user .. "| Агент User-Agent: " .. useragent .. "",
                                        "***************************" .. user .. "******************************",
                                        "" .. user .. "| Протокол: " .. protocol .. "",
                                        "" .. user .. "| IP источника: " .. AVP_get("SOURCEIP") .. "; Порт: " .. AVP_get("SOURCEPORT") .. "",
                                        "" .. user .. "| IP назначения: " .. AVP_get("DESTIP") .. "; Порт: " .. AVP_get("DESTPORT") .. "",
                                        "============================" .. user .. "============================="
                                }

	for key, log in pairs(log[level]) do
        	xlog ("LOG => " .. log .. ";")
        end;

	end;

	function how:moduls (arg,level)
		xlog ("LOG_EVENT => =========================" .. user .. "================================")
                xlog ("" .. user .. "| LOG_EVENT => Модуль: => " .. name .. "; Описание: => " .. description .. "")
                xlog ("" .. user .. "| LOG_EVENT => " .. event .. " => " .. user .. "")
                xlog ("LOG_EVENT => ======================" .. user .. "===================================")
        end;

	setmetatable (how, self)
	self.__index = self;
	return how;
	end;

        local user = getHeader(arg,"From");
        local user = user:match(":(.*)@");
	local method = getMethod(arg);
	local uriuser = getURI_User(arg);
	local uri = AVP_get("URI");
	local from = getHeader(arg,"From");
	local to = getHeader(arg,"To");
	local callid = AVP_get("CALLID");
	local useragent = AVP_get("USERAGENT");
	local contact = AVP_get("CONTACT");
	local cseq = AVP_get("CSEQ");
	local protocol = AVP_get("PROTOCOL");
	local sourceip = AVP_get("SOURCEIP");
	local sourceport = AVP_get("SOURCEPORT");
	local destinationip = AVP_get("DESTIP");
	local destinationport = AVP_get("DESTPORT");
	if not useragent or useragent == nil then useragent = "none" end;
        if not contact or contact == nil then contact = "none" end;
	if not uri or uri == nil then uri = "none" end;

	if not event or event == nil then
		local events = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
		events:verbose (arg,level);
		return
	end;

	if event == "request" then
                local request = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                request:verbose (arg,level);
		return
        end;

	if event == "reply" then
		local method = "reply";
		local reply = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
		reply:verbose (arg,level);
		return
	end;

	if event == "180 RINGING" then
                local method = "180 RINGING";
                local ringing = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                ringing:verbose (arg,level);
                return
        end;

	if event == "181 CALL IS BEING FORWARDED" then
                local method = "181 CALL IS BEING FORWARDED";
                local forwarded = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                forwarded:verbose (arg,level);
                return
        end;

        if event == "182 CALL IS QUEUED" then
                local method = "182 CALL IS QUEUED";
                local queued = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                queued:verbose (arg,level);
                return
        end;

	if event == "183 SESSION PROGRESS" then
                local method = "183 SESSION PROGRESS";
                local sprogress = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                sprogress:verbose (arg,level);
                return
        end;

	if event == "200 OK SDP" then
                local method = "200 OK SDP";
                local sdp = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                sdp:verbose (arg,level);
                return
        end;

	if event == "200 OK" then
                local method = "200 OK";
                local ok = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                ok:verbose (arg,level);
                return
        end;

	if event == "202 ACCEPTED" then
                local method = "202 ACCEPTED";
                local accepted = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                accepted:verbose (arg,level);
                return
        end;

	if event == "3XX REPLY" then
                local method = "3XX REPLY";
                local replxxx = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                replxxx:verbose (arg,level);
                return
        end;

	if event == "4XX REPLY" then
                local method = "4XX REPLY";
                local replxxxx = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                replxxxx:verbose (arg,level);
                return
        end;

	if event == "5XX REPLY" then
                local method = "5XX REPLY";
                local replxxxxx = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                replxxxxx:verbose (arg,level);
                return
        end;

	if event == "6XX REPLY" then
                local method = "6XX REPLY";
                local replxxxxxx = debug:new (arg,user,name,description,method,uriuser,uri,from,to,callid,useragent,contact,cseq,protocol,sourceip,sourceport,destinationip,destinationport,level);
                replxxxxxx:verbose (arg,level);
                return
        end;

	local moduls = debug:new (arg,user,name,description,event,level);
	moduls:moduls (arg,level);	

end;
return c_debug
