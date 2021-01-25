--------------------------------------------------------------
-- Модуль исключающий образование петель внутри свича --------
--------------------------------------------------------------

package.loaded.c_validator = dofile'/usr/local/etc/opensips/extensions/core/c_validator.lua'
package.loaded.c_digest = dofile'/usr/local/etc/opensips/extensions/core/c_digest.lua'
package.loaded.c_config = dofile'/usr/local/etc/opensips/extensions/core/c_config.lua'

local c_validator = require "c_validator"
local c_digest = require "c_digest"
local c_config = require "c_config"

local cm_loop = {}

		cm_loop.name = "cm_loop"
		cm_loop.description = "Модуль предотвращения петель - LOOP"
		cm_loop.status = "Метод на стадии проверки петли"
		cm_loop.success = "Петель не обнаружено"
		cm_loop.message = "Количество раз отправки транзакции превысило допустимое значение - 7 LOOP"

	function cm_loop:loop_set (arg,level)
		local presence_loop = moduleFunc (arg,"search","Loop: 0");
                if presence_loop == -1 then
			moduleFunc (arg,"append_hf","Loop: 0");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,cm_loop.success,level);
		end;
		if presence_loop == 1 then
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 1",level);
			local set = "set";
			return set
		end;
	end;
	
	function cm_loop:loop_loop (arg,level)
		local presence_loop0 = moduleFunc (arg,"search","Loop: 0");
                if presence_loop0 == 1 then
			moduleFunc (arg,"replace","Loop: 0","Loop: 1");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 2",level);
			return	
		end;

		local presence_loop1 = moduleFunc (arg,"search","Loop: 1");
		if presence_loop1 == "1" then
			moduleFunc (arg,"replace","Loop: 1","Loop: 2");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 3",level);
			return
		end;

		local presence_loop2 = moduleFunc (arg,"search","Loop: 2");
                if presence_loop2 == "1" then
                        moduleFunc (arg,"replace","Loop: 2","Loop: 3");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 4",level);
                        return
                end;

		local presence_loop3 = moduleFunc (arg,"search","Loop: 3");
                if presence_loop3 == "1" then
                        moduleFunc (arg,"replace","Loop: 3","Loop: 4");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 5",level);
                        return
                end;

		local presence_loop4 = moduleFunc (arg,"search","Loop: 4");
                if presence_loop4 == "1" then
                        moduleFunc (arg,"replace","Loop: 4","Loop: 5");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 6",level);
                        return
                end;
                
		local presence_loop5 = moduleFunc (arg,"search","Loop: 5");
                if presence_loop5 == "1" then
                        moduleFunc (arg,"replace","Loop: 5","Loop: 6");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 7",level);
                        return
                end;

		local presence_loop6 = moduleFunc (arg,"search","Loop: 6");
                if presence_loop6 == "1" then
                        moduleFunc (arg,"replace","Loop: 6","Loop: 7");
			local loop_status = DIALOG:new (arg);
                        loop_status:event (arg,cm_loop.name,cm_loop.description,"Найдена петля, итерация: 8",level);
                        return
                end;

		local presence_loop7 = moduleFunc (arg,"search","Loop: 7");
                        if presence_loop7 == "1" then
                                moduleFunc (arg,"remove_hf","Loop: 7");
                                local loop_number = DIALOG:new (arg);
                		loop_number:event (arg,cm_loop.name,cm_loop.description,cm_loop.message,level);
				local status = "loop_max";
				return status
                        end;

      	end;

return cm_loop

