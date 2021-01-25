---------------------------------------------------
-- Модуль обработки сообщений 401 и 407 U_Server --
---------------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"

local cm_authinvite = {}

	cm_authinvite.name = "m_authinvite"
	cm_authinvite.description = "Модуль обработки сообщений 401 и 407 U_Server"
        cm_authinvite.reply = "4XX REPLY"
	cm_authinvite.message = "Отправка 401|407"
	cm_authinvite.authorize = "Отправка данных для авторизации при INVITE"
	cm_authinvite.failed = "Данные для авторизации при INVITE не найдены"
	
	function cm_authinvite:authinvite_conduct (arg,reply,level)
		local authinvite_event = DIALOG:new (arg);
                authinvite_event:event (arg,cm_authinvite.name,cm_authinvite.description,cm_authinvite.message,level);
		local source_ip = AVP_get("REPLYSOURCEIP");
		local source_port = AVP_get("REPLYSOURCEPORT");
		local authorized = s_mediaauthorized;

		local authinvite_sql = CORE:new (arg);
		local sql = authinvite_sql:sql ("opensips","select","select realm,user_authorized,user_password from unauthorized where ip_address = '" .. source_ip .. "' and user_authorized = '" .. authorized .. "'",reply);

		if not sql or sql == nil then
			local authinvite_event = DIALOG:new (arg);
			authinvite_event:event (arg,cm_authinvite.name,cm_authinvite.description,cm_authinvite.failed,level);
			return
		else
			local authinvite_event = DIALOG:new (arg);
			authinvite_event:event (arg,cm_authinvite.name,cm_authinvite.description,cm_authinvite.authorize,level);
			AVP_set ("realm",sql.realm);
			AVP_set ("user",sql.user_authorized);
			AVP_set ("pass",sql.user_password);
		end;

		return source_ip,source_port
	end;

return cm_authinvite
