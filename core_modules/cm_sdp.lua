----------------------------------------------
-- Модуль обработки сообщения 200 OK SDP -----
----------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_sdp = {}

		cm_sdp.name = "cm_sdp"
		cm_sdp.description = "Модуль обработки сообщения 200 OK SDP"
		cm_sdp.message = "Отправка 200 OK SDP"
		cm_sdp.reply = "200 OK SDP"		
	
	function cm_sdp:sdp_ok (arg,level)
		local sdp_ok = DIALOG:new (arg);
		sdp_ok:event (arg,cm_sdp.name,cm_sdp.description,cm_sdp.message,level);
      	end;

	function cm_sdp:sdp_hiding (arg,tag,level)
                c_validator.c_validator (arg,tag);
                c_digest.c_digest ("cm_sdp","sdp_hiding");
                local top_hiding = CORE:new (arg);
                top_hiding:tophiding (arg,tag,"reply",cm_sdp.reply);
        end;

	function cm_sdp:sdp_rtp (arg,rtp,level)
		c_digest.c_digest ("cm_rtp","sdp_rtp");
                if rtp == "enable" then
                        local sdp_rtp = CORE:new (arg);
                        local rewrite = "rewrite";
                        sdp_rtp:rtp (arg,rewrite,"none","reply",cm_sdp.reply);
                else
                        return
                end;
        end;

return cm_sdp

