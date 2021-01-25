---------------------------------------
-- Конфигурационные переменные --------
---------------------------------------

local c_config = {}

function c_config.c_config (config)	

local name = "c_config"
local description = "Конфигурационные переменные"

	-- Уровень детализации журнала: none,verbose,full
	config = "full"
	-- Домен SBC
	domain = "host.domain.ru"
	-- Аутентификация INVITE,REGISTER: enable,disable
	s_auth = "enable"
	-- NAT Pinger INVITE,REGISTER: enable,disable
        s_nat = "enable"
	-- RTP engine INVITE,200SDP: enable,disable
        s_rtp = "enable"
	-- RTP engine поддержка LAN интерфейса, если используем mediaserver
	s_rtp_local = "enable"
	-- Смена сокета: enable,disable
        s_socket = "enable"
	-- Активировать dialplan: enable,disable
        s_dialplan = "enable"
	-- Балансировка на медиасервера: enable,disable
	s_dispather = "enable"	
	-- Дайджест валидатора: enable,disable
	digest = "enable"
	-- Безопасность
	-- pike: enable,disable
	-- validate: enable,disable
	-- subscriber: enable,disable
	-- acl: enable,disable
	s_pike = "disable"
	s_validate = "enable"
	s_subscriber = "enable"
	s_acl = "enable"
	-- Интерфейсы
	s_face = {
	["VIP"] = "WAN",
	["Wan IP"] = "WAN",
	["Lan IP"] = "LAN"
	}
	wan_ip = "Wan IP"	
	lan_ip = "Lan IP"
	-- Пользователь авторизации на медиасервер
	s_mediaauthorized = "user_auth_mediaserver";

	return config
end;	

return c_config
