# Базовый образ Ubuntu TLS
FROM ubuntu:latest

# Разработчик
MAINTAINER Vjcheslav Ilyin <i.v.v.sl@yandex.ru>

# Установим рабочую директорию
WORKDIR /usr/local/src/opensips/

# Не интерактивный режим установки пакетов
ENV DEBIAN_FRONTEND noninteractive

# Скопируем исходники opensips
COPY ./ /usr/local/src/opensips/

# Инсталлируем необходимые пакеты
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.conf && \
	echo 'nameserver 8.8.4.4' >> /etc/resolv.conf && \
	apt-get update && \
	apt-get install -y tzdata \
	apt-utils \
	gcc \
	build-essential \
	make bison flex \
	libpq-dev \
	libncurses5-dev \
	libsnmp-dev \
	libpcre3-dev \
	lua5.1 \
	liblua5.1-0-dev \
	libmysqlclient-dev \
	libmemcached-dev \
	libmicrohttpd-dev \
	locales \
	rsyslog \
	postgresql-client \
	net-tools \
	iputils-ping \
	dnsutils \
	luarocks \
	unixodbc \
	unixodbc-dev \
	odbc-postgresql \
	git \
	nano

#Настраиваем сервер
RUN locale-gen ru_RU.UTF-8 && \
        update-locale && \
	rm /etc/localtime && \
	echo "Asia/Yekaterinburg" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata
ENV LANGUAGE ru_RU.UTF-8
ENV LANG ru_RU.UTF-8
ENV LC_COLLATE ru_RU.UTF-8
ENV LC_CTYPE ru_RU.UTF-8
ENV LC_MESSAGES ru_RU.UTF-8
ENV LC_MONETARY ru_RU.UTF-8
ENV LC_TIME ru_RU.UTF-8
ENV LC_NUMERIC POSIX

# Установим Opensips
RUN make install skip_modules="aaa_radius \
	alias_db \
	auth_aaa \
	b2b_entities \
	b2b_logic \
	b2b_sca \
	benchmark \
	cachedb_cassandra \
	cachedb_couchbase \
	cachedb_memcached \
	cachedb_mongodb \
	cachedb_redis \
	cachedb_sql \
	call_center \
	call_control \
	carrierroute \
	cgrates \
	clusterer \
	compression \
	cpl_c \
	db_berkeley \
	db_cachedb \
	db_flatstore \
	db_http \
	db_mysql \
	db_oracle \
	db_perlvdb \
	db_sqlite \
	db_text \
	db_unixodbc \
	db_virtual \
	diversion \
	dns_cache \
	emergency \
	enum \
	event_datagram \
	event_flatstore \
	event_jsonrpc \
	event_rabbitmq \
	event_route \
	event_routing \
	event_virtual \
	event_xmlrpc \
	fraud_detection \
	freeswitch \
	freeswitch_scripting \
	h350 \
	identity \
	imc \
	jabber \
	json \
	jsonrpc \
	ldap \
	mangler \
	mathops \
	mediaproxy \
	mi_datagram \
	mi_xmlrpc_ng \
	mid_registrar \
	mmgeoip \
	msilo \
	nat_traversal \
	options \
	osp \
	peering \
	perl \
	pi_http \
	presence \
	presence_callinfo \
	presence_dialoginfo \
	presence_mwi \
	presence_xcapdiff \
	presence_xml \
	proto_bin \
	proto_hep \
	proto_sctp \
	proto_tls \
	proto_ws \
	proto_wss \
	pua \
	pua_bla \
	pua_dialoginfo \
	pua_mi \
	pua_usrloc \
	pua_xmpp \
	python \
	qos \
	rabbitmq \
	ratelimit \
	rest_client \
	rls \
	rtpproxy \
	script_helper \
	seas \
	sip_i \
	sipcapture \
	siprec \
	sms \
	sngtc \
	speeddial \
	sql_cacher \
	sst \
	stun \
	tls_mgm \
	uac_redirect \
	userblacklist \
	xcap \
	xcap_client \
	xml \
	xmpp" modules

# Добавим модули Opensips
RUN make install modules=modules/db_postgres modules && \
	make install modules=modules/snmpstats modules && \
	make install modules=modules/regex modules && \
	make install modules=modules/lua modules && \
	make install modules=modules/dialplan modules && \
	make install modules=modules/fraud_detection modules && \
	make install modules=modules/httpd modules && \
	make install modules=modules/tls_mgm modules && \
	make install modules=modules/proto_hep modules

# Готовим окружение
RUN mkdir /etc/opensips-2.4.2-TLS && \
	mkdir /etc/opensips-2.4.2-TLS/console && \
	mkdir /etc/opensips-2.4.2-TLS/help && \
	mkdir /usr/local/etc/opensips/extensions && \
	mkdir /usr/local/etc/opensips/extensions/core && \
	mkdir /usr/local/etc/opensips/extensions/core_modules && \
	mkdir /usr/local/etc/opensips/extensions/modules && \
	mkdir /usr/local/etc/opensips/extensions/dvo && \
	mkdir /var/log/opensips/ && \
	echo '#===================================================================================#' > /etc/default/opensips && \
	echo '#======================== Опции запуска OPENSIPS ===================================#' >> /etc/default/opensips && \
	echo '#===================================================================================#' >> /etc/default/opensips && \
	echo '' >> /etc/default/opensips && \
	echo '# OPENSIPS будет активным для запуска - yes, no' >> /etc/default/opensips && \
	echo 'RUN_OPENSIPS=yes' >> /etc/default/opensips && \
	echo '' >> /etc/default/opensips && \
	echo '# Пользователь под которым будет работать OPENSIPS' >> /etc/default/opensips && \
	echo 'USER=opensips' >> /etc/default/opensips && \
	echo '' >> /etc/default/opensips && \
	echo '# Группа под которой будет работать OPENSIPS' >> /etc/default/opensips && \
	echo 'GROUP=opensips' >> /etc/default/opensips && \
	echo '' >> /etc/default/opensips && \
	echo '# Количество разделяемой памяти используемой OPENSIPS сервером в Мб' >> /etc/default/opensips && \
	echo '# Amount of shared memory to allocate for the running OpenSIPS server (in Mb)' >> /etc/default/opensips && \
	echo 'S_MEMORY=256' >> /etc/default/opensips && \
	echo '' >> /etc/default/opensips >> /etc/default/opensips && \
	echo '# Количество памяти используемой одним экземпляром OPENSIPS в Mб' >> /etc/default/opensips && \
	echo 'P_MEMORY=64' >> /etc/default/opensips >> /etc/default/opensips && \
	echo '' >> /etc/default/opensips && \
	echo '# Создавать ли дамп при крахе OPENSIPS - yes, no' >> /etc/default/opensips && \
	echo 'DUMP_CORE=no' >> /etc/default/opensips && \
	echo 'local0.*                        -/var/log/opensips/opensips.log' >> /etc/rsyslog.d/50-default.conf && \
	echo '192.168.1.8    media_server' >> /etc/hosts && \
	cp /usr/local/src/opensips/packaging/debian/opensips.init /etc/init.d/opensips && \
	sed -i 's/RUN_OPENSIPS=no/RUN_OPENSIPS=yes/' /etc/init.d/opensips && \
	sed -i 's#DAEMON=/sbin/opensips#DAEMON=/usr/local/sbin/opensips#g' /etc/init.d/opensips && \
	sed -i 's#CFGFILE=/etc/opensips/opensips.cfg#CFGFILE=/usr/local/etc/opensips/opensips.cfg#g' /etc/init.d/opensips && \
	sed -i 's#M4CFGFILE=/etc/opensips/opensips.m4#M4CFGFILE=/usr/local/etc/opensips/opensips.m4#g' /etc/init.d/opensips && \
	sed -i 's#M4ARCHIVEDIR=/etc/opensips/archive#M4ARCHIVEDIR=/usr/local/etc/opensips/archive#g' /etc/init.d/opensips && \
	sed -i 's/rotate 4/rotate 7/g' /etc/logrotate.d/rsyslog && \
	sed -i '/load="imklog"/s/^/#/' /etc/rsyslog.conf && \
	sed -i '/$PrivDropToUser/s/^/#/' /etc/rsyslog.conf && \
	sed -i '/$PrivDropToGroup/s/^/#/' /etc/rsyslog.conf && \
	adduser --quiet --system --group --disabled-password --shell /bin/false --gecos "Opensips" --home /var/run/opensips opensips && \
	set ownership to /var/run/opensips && \
	touch /var/log/opensips/opensips.log && \
	touch /var/log/syslog && \
	touch /etc/logrotate.d/opensips && \
	touch /tmp/echo && \
	touch /usr/local/etc/opensips/permissions.allow && \
	touch /usr/local/etc/opensips/permissions.deny && \
	echo '/var/log/opensips/opensips.log' >> /etc/logrotate.d/opensips && \
	echo '{' >> /etc/logrotate.d/opensips && \
	echo '	rotate 90' >> /etc/logrotate.d/opensips && \
	echo '	daily' >> /etc/logrotate.d/opensips && \
	echo '	missingok' >> /etc/logrotate.d/opensips && \
	echo '	notifempty' >> /etc/logrotate.d/opensips && \
	echo '	delaycompress' >> /etc/logrotate.d/opensips && \
	echo '	compress' >> /etc/logrotate.d/opensips && \
	echo '	create 660 root opensips' >> /etc/logrotate.d/opensips && \
	echo '	postrotate' >> /etc/logrotate.d/opensips && \
	echo '		/etc/init.d/rsyslog force-reload' >> /etc/logrotate.d/opensips && \
	echo '	endscript' >> /etc/logrotate.d/opensips && \
	echo '}' >> /etc/logrotate.d/opensips && \
	echo '#!/bin/bash' >> /tmp/echo && \
	echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "Контейнер запущен по умолчанию с нулевой конфигурацией, для его старта"' >> /tmp/echo && \
	echo 'echo "с полной конфигурацией запустите контейнер с пробросом папок /var/log/opensips/"' >> /tmp/echo && \
	echo 'echo "/etc/opensips/ - сеть по умолчанию host"' >> /tmp/echo && \
	echo 'echo "конфигурация и файлы в /usr/local/src/"' >> /tmp/echo && \
	echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "Инструкция разворачивания базы данных Opensips"' >> /tmp/echo && \
	echo 'echo "1) /usr/local/sbin/opensipsdbctl create - в контейнере"' >> /tmp/echo && \
	echo 'echo "2) GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "userbd"; - на сервере баз данных"' >> /tmp/echo && \
	echo 'echo "***********************************************************************"' >> /tmp/echo && \
        echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "Первоначальеая настройка:"' >> /tmp/echo && \
	echo 'echo "1) Создать домен: /usr/local/sbin/opensipsctl domain add sbc.profintel.ru"' >> /tmp/echo && \
	echo 'echo "2) Добавить устройства: /usr/local/sbin/opensipsctl add 102@sbc.profintel.ru 102"' >> /tmp/echo && \
	echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "PS - В текущей версии 2.4 ошибки:"' >> /tmp/echo && \
	echo 'echo "Не верный тип данных location -> expires integer -> date"' >> /tmp/echo && \
	echo 'echo "ALTER TABLE location ALTER COLUMN expires TYPE timestamp without time zone using expires::text::timestamp without time zone;"' >> /tmp/echo && \
	echo 'echo "ALTER TABLE location ALTER COLUMN expires set NOT NULL;"' >> /tmp/echo && \
	echo 'echo "ALTER TABLE location ALTER COLUMN expires set DEFAULT '2020-05-28 21:32:15'::timestamp without time zone;"' >> /tmp/echo && \
        echo 'echo "***********************************************************************"' >> /tmp/echo && \
        echo 'echo "***********************************************************************"' >> /tmp/echo && \
	echo 'echo "скрипт /tmp/echo"' >> /tmp/echo && \
        echo 'echo "***********************************************************************"' >> /tmp/echo && \
	ln -s /usr/local/etc/opensips/ /etc/opensips-2.4.2-TLS/cfg && \
	ln -s /usr/local/lib64/opensips/modules/ /etc/opensips-2.4.2-TLS/modules && \
	ln -s /usr/local/sbin/opensips /etc/opensips-2.4.2-TLS/console/opensips && \
	ln -s /usr/local/sbin/opensipsctl /etc/opensips-2.4.2-TLS/console/opensipsctl && \
	ln -s /usr/local/sbin/opensipsdbctl /etc/opensips-2.4.2-TLS/console/opensipsdbctl && \
	ln -s /usr/local/sbin/opensipsunix /etc/opensips-2.4.2-TLS/console/opensipsunix && \
	ln -s /usr/local/sbin/osipsconfig /etc/opensips-2.4.2-TLS/console/osipsconfig && \
	ln -s /usr/local/sbin/osipsconsole /etc/opensips-2.4.2-TLS/console/osipsconsole && \
	ln -s /etc/default/opensips /etc/opensips-2.4.2-TLS/cfg/opensips_default && \
	ln -s /usr/local/share/doc/opensips /etc/opensips-2.4.2-TLS/help/opensips && \
	ln -s /usr/local/share/man/ /etc/opensips-2.4.2-TLS/help/man5-8 && \
	ln -s /var/log/opensips/opensips.log /etc/opensips-2.4.2-TLS/log && \
	ln -s /var/log/syslog /etc/opensips-2.4.2-TLS/syslog && \
	ln -s /usr/local/etc/opensips/extensions/ /etc/opensips-2.4.2-TLS/extensions && \
	rm /usr/local/etc/opensips/opensips.cfg.sample && \
	rm /usr/local/etc/opensips/opensipsctlrc.sample && \
	rm /usr/local/etc/opensips/osipsconsolerc.sample && \
	rm /usr/local/etc/opensips/opensipsctlrc && \
	rm /usr/local/etc/opensips/osipsconsolerc && \
	cp ./main/opensips.cfg /etc/opensips-2.4.2-TLS/cfg/opensips.cfg && \
	cp ./main/core.lua /usr/local/etc/opensips/extensions/core/core.lua && \
        cp ./main/opensips_modules.cfg /etc/opensips-2.4.2-TLS/cfg/opensips_modules.cfg && \
        cp ./main/core.cfg /usr/local/etc/opensips/extensions/core/core.cfg && \
	cp ./main/opensipsctlrc /usr/local/etc/opensips/opensipsctlrc && \
	cp ./main/osipsconsolerc /usr/local/etc/opensips/osipsconsolerc && \
	cp ./main/opensips.sh /usr/local/etc/opensips/ && \
	chown -R root:opensips /etc/opensips-2.4.2-TLS/ && \
	chown -R root:opensips /usr/local/sbin/ && \
	chown -R root:opensips /usr/local/etc/ && \
        chown root:opensips /etc/init.d/opensips && \
        chown -R root:opensips /usr/local/lib64/opensips/modules/ && \
	chown -R root:opensips /usr/local/etc/opensips/extensions/ && \
        chown root:opensips /etc/default/opensips && \
	chown root:opensips /var/log/opensips/ && \
        chown root:opensips /var/log/opensips/opensips.log && \
	chown root:opensips /var/log/syslog && \
        chown opensips:opensips /var/run/opensips && \
	chown root:opensips /usr && \
	chown root:opensips /usr/local && \
	chown root:opensips /usr/local/etc && \
	chown root:opensips /usr/local/etc/opensips && \
	chown root:opensips /usr/local/etc/opensips/extensions && \
	chown root:opensips /usr/local/etc/opensips/extensions/core && \
	chown root:opensips /usr/local/etc/opensips/extensions/core/core.lua && \
	chown root:opensips /usr/local/etc/opensips/permissions.allow && \
	chown root:opensips /usr/local/etc/opensips/permissions.deny && \
	chmod 640 /usr/local/etc/opensips/opensips.cfg && \
	chmod 640 /usr/local/etc/opensips/opensips_modules.cfg && \
	chmod 640 /usr/local/etc/opensips/opensipsctlrc && \
	chmod 640 /usr/local/etc/opensips/osipsconsolerc && \
	chmod 640 /usr/local/etc/opensips/permissions.allow && \
	chmod 640 /usr/local/etc/opensips/permissions.deny && \
	chmod 755 /etc/init.d/opensips && \
	chmod 755 /usr/local/etc/opensips/opensips.sh && \
	chmod 755 /tmp/echo && \
	chmod 664 /var/log/opensips/ && \
	chmod 664 /var/log/opensips/opensips.log && \
	chmod 664 /var/log/syslog && \
	chmod 664 /etc/default/opensips && \
	chmod -R 640 /usr/local/etc/opensips/extensions/ && \
	chmod 755 /usr && \
        chmod 755 /usr/local && \
        chmod 755 /usr/local/etc && \
        chmod 755 /usr/local/etc/opensips && \
        chmod 755 /usr/local/etc/opensips/extensions && \
        chmod 755 /usr/local/etc/opensips/extensions/core && \
        chmod 755 /usr/local/etc/opensips/extensions/core/core.lua && \
	update-rc.d opensips defaults 99 && \
	luarocks install json-lua && \
	luarocks install luasocket && \
	luarocks install odbc && \
	echo '[opensips]' >> /etc/odbc.ini && \
	echo 'Description = PostgreSQL connection to 'opensips' database' >> /etc/odbc.ini && \
	echo 'Driver = PostgreSQL Unicode' >> /etc/odbc.ini && \
	echo 'Database = baseopensips' >> /etc/odbc.ini && \
	echo 'Servername = serverbd' >> /etc/odbc.ini && \
	echo 'UserName = userbd' >> /etc/odbc.ini && \
	echo 'Password = passbd' >> /etc/odbc.ini && \
	echo 'Port = 5432' >> /etc/odbc.ini && \
	echo 'Protocol = 9.4' >> /etc/odbc.ini && \
	echo 'Trace = no' >> /etc/odbc.ini && \
	echo 'TraceFile = sql.log' >> /etc/odbc.ini && \
	echo 'ReadOnly = No' >> /etc/odbc.ini && \
	echo 'RowVersioning = No' >> /etc/odbc.ini && \
	echo 'ShowSystemTables = No' >> /etc/odbc.ini && \
	echo 'ShowOidColumn = No' >> /etc/odbc.ini && \
	echo 'FakeOidIndex = No' >> /etc/odbc.ini && \
	echo 'Threading = 0' >> /etc/odbc.ini && \
	echo 'UseServerSidePrepare = 1' >> /etc/odbc.ini && \
	echo '' >> /etc/odbc.ini && \
        echo '[baseasterisk]' >> /etc/odbc.ini && \
        echo 'Description = PostgreSQL connection to 'baseasterisk' database' >> /etc/odbc.ini && \
        echo 'Driver = PostgreSQL Unicode' >> /etc/odbc.ini && \
        echo 'Database = baseasterisk' >> /etc/odbc.ini && \
        echo 'Servername = serverbd' >> /etc/odbc.ini && \
        echo 'UserName = userbd' >> /etc/odbc.ini && \
        echo 'Password = passbd' >> /etc/odbc.ini && \
        echo 'Port = 5432' >> /etc/odbc.ini && \
        echo 'Protocol = 9.4' >> /etc/odbc.ini && \
        echo 'Trace = no' >> /etc/odbc.ini && \
        echo 'TraceFile = sql.log' >> /etc/odbc.ini && \
        echo 'ReadOnly = No' >> /etc/odbc.ini && \
        echo 'RowVersioning = No' >> /etc/odbc.ini && \
        echo 'ShowSystemTables = No' >> /etc/odbc.ini && \
        echo 'ShowOidColumn = No' >> /etc/odbc.ini && \
        echo 'FakeOidIndex = No' >> /etc/odbc.ini && \
        echo 'Threading = 0' >> /etc/odbc.ini && \
        echo 'UseServerSidePrepare = 1' >> /etc/odbc.ini && \
        echo '' >> /etc/odbc.ini && \
	touch /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo 'INSERT INTO version (table_name, table_version) values ('aliases','1009');' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo 'CREATE TABLE aliases (' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	id SERIAL PRIMARY KEY NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	username VARCHAR(64) DEFAULT '' NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	domain VARCHAR(64) DEFAULT '' NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	contact VARCHAR(255) DEFAULT '' NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	received VARCHAR(128) DEFAULT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	path VARCHAR(255) DEFAULT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	expires TIMESTAMP WITHOUT TIME ZONE DEFAULT '2020-05-28 21:32:15' NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	q REAL DEFAULT 1.0 NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	callid VARCHAR(255) DEFAULT 'Default-Call-ID' NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	cseq INTEGER DEFAULT 13 NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '1900-01-01 00:00:01' NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	flags INTEGER DEFAULT 0 NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	cflags VARCHAR(255) DEFAULT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	user_agent VARCHAR(255) DEFAULT '' NOT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	socket VARCHAR(64) DEFAULT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	methods INTEGER DEFAULT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	sip_instance VARCHAR(255) DEFAULT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	attr VARCHAR(255) DEFAULT NULL,' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo '	CONSTRAINT aliases_alias_idx UNIQUE (username, domain, contact, callid)' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
	echo ');' >> /usr/local/share/opensips/postgres/registrar-create.sql && \
        touch /usr/local/share/opensips/postgres/nathelper-create.sql && \
	echo 'INSERT INTO version (table_name, table_version) values ('nh_sockets','0');' >> /usr/local/share/opensips/postgres/nathelper-create.sql && \
	echo 'CREATE TABLE nh_sockets (' >> /usr/local/share/opensips/postgres/nathelper-create.sql && \
	echo '	id SERIAL PRIMARY KEY NOT NULL,' >> /usr/local/share/opensips/postgres/nathelper-create.sql && \
	echo '	rtpproxy_sock TEXT NOT NULL,' >> /usr/local/share/opensips/postgres/nathelper-create.sql && \
	echo '	set_id INTEGER NOT NULL' >> /usr/local/share/opensips/postgres/nathelper-create.sql && \
	echo ');' >> /usr/local/share/opensips/postgres/nathelper-create.sql

# Путь к рабочему каталогу opensips
WORKDIR /usr/local/etc/opensips/

# Чистим за собой
RUN /bin/rm -r /usr/local/src/*

# Общая папка хоста и контейнера
#VOLUME ["/var/log/opensips/"]
#VOLUME ["/etc/opensips/"]

# Порты с которыми будет работать opensips
EXPOSE 5060/udp 5060/tcp 8008/tcp

# Запускаем сервис opensips, игнорирует default opensips файл
#ENTRYPOINT ["/bin/bash","/etc/init.d/opensips","start"]
ENTRYPOINT ["/bin/bash","/usr/local/etc/opensips/opensips.sh"]

##########################################
#RUN echo '!#/bin/bash' >> /tmp/tmpep.sh
#RUN echo 'while true; do echo 100; sleep 1000000; done' >> /tmp/tmpep.sh
#RUN chmod +x /tmp/tmpep.sh
#ENTRYPOINT ["/bin/bash","/tmp/tmpep.sh"]
##########################################
