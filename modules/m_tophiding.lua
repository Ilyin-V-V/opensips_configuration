------------------------------------------------
-- Модуль сокрытия топологии UA A от UA B ------
------------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local m_tophiding = {}

		m_tophiding.name = "m_tophiding"
		m_tophiding.description = "Модуль сокрытия топологии UA"
		m_tophiding.messages = "Скрываю топологию - via,r-route,contact"
		m_tophiding.user = "Скрываю топологию - user-agent"

	function m_tophiding:tophiding_hiding (arg,tag,level)
		local tophiding_event = CORE:new (arg);
		tophiding_event:event (arg,m_tophiding.name,m_tophiding.description,m_tophiding.messages,level);
		if tag == "tag" then
			moduleFunc (arg,"topology_hiding_match","C");
		else
			moduleFunc (arg,"topology_hiding","C");
		end;
      	end;

	function m_tophiding:tophiding_hiding_user (arg,level)
		local tophiding_event = CORE:new (arg);
                tophiding_event:event (arg,m_tophiding.name,m_tophiding.description,m_tophiding.user,level);
		moduleFunc (arg,"remove_hf","User-Agent");
		moduleFunc (arg,"remove_hf","Server");
	end;

return m_tophiding

