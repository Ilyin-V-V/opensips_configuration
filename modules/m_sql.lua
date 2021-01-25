------------------------------------------
-- Модуль для работы с б.д U_Server ------
------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local odbc = require "odbc"

local m_sql = {}

		m_sql.name = "m_sql"
		m_sql.description = "Модуль для работы с б.д U_Server"
		m_sql.reqest = "Не правильный запрос к базе данных"
		m_sql.reqest_nul = "Запрос к базе данных не вернул результата"
		m_sql.reqest_success = "Запрос к базе данных завершился успешно"
	
	function m_sql:sql_qwery (db,sql,level)
		local sql_event = CORE:new (arg);
                sql_event:event (arg,m_sql.name,m_sql.description,"request",level);
		local dbassert = odbc.assert;
		if db == "opensips" then
    			local connect = odbc.connect ('opensips');
			inquiry = connect:execute (sql);
		end;
		if db == "asterisk" then
			local connect = odbc.connect ('asterisk');
                        inquiry = connect:execute (sql);
                end;

		if not inquiry then
			inquiry:destroyed();
			inquiry:closed();
			sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest,level);
			return
		end

    		local row = inquiry:fetch ({}, "a");
    		local result = row;
    		inquiry:closed();

    		if result then
			sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest_success,level);
        		return result
    		else
			sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest_nul,level);
        		return
    		end;	
	end;

	function m_sql:sql_qwery_multi_row (db,sql,level)
		local sql_event = CORE:new (arg);
                sql_event:event (arg,m_sql.name,m_sql.description,"request",level);
    		local dbassert = odbc.assert;
		if db == "opensips" then
                        local connect = odbc.connect ('opensips');
                        inquiry = connect:execute (sql);
                end;
                if db == "asterisk" then
                        local connect = odbc.connect ('asterisk');
                        inquiry = connect:execute (sql);
                end;
    		
		if not inquiry then
			inquiry:destroyed();
                        inquiry:closed();
                        sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest,level);
                        return
                end

    		local index = 1;
    		local result = {};
    		result[index] = inquiry:fetch ({}, "a");
    		while result[index] do
        		index = index + 1;
        		result[index] = inquiry:fetch ({}, "a");
    		end;
    		inquiry:closed();

    		if result then
			sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest_success,level);
        		return result
    		else
			sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest_nul,level);
        		return
    		end;
	end;

	function m_sql:sql_insert (db,sql,level)
		local sql_event = CORE:new (arg);
                sql_event:event (arg,m_sql.name,m_sql.description,"request",level);
    		local dbassert = odbc.assert;
    		if db == "opensips" then
                        local connect = odbc.connect ('opensips');
                        inquiry = connect:execute (sql);
                end;
                if db == "asterisk" then
                        local connect = odbc.connect ('asterisk');
                        inquiry = connect:execute (sql);
                end;
    		inquiry:closed();

    		if not inquiry then
			sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest,level);
        		return
    		else
			sql_event:event (arg,m_sql.name,m_sql.description,m_sql.reqest_nul,level);
        		return
    		end;
	end;

return m_sql
