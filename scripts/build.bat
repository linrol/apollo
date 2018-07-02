@echo off

rem apollo config db info
set apollo_config_db_url="jdbc:mysql://101.37.253.34:3306/ApolloConfigDB_test?characterEncoding=utf8"
set apollo_config_db_username="apolloconfigdb_test"
set apollo_config_db_password="apolloconfigdb_test"

rem apollo portal db info
set apollo_portal_db_url="jdbc:mysql://101.37.253.34:3306/ApolloPortalDB?characterEncoding=utf8"
set apollo_portal_db_username="apolloportaldb_test"
set apollo_portal_db_password="apolloportaldb_test"

rem meta server url, different environments should have different meta server addresses

set fat_meta="http://47.96.129.29:8001"
set pro_meta="http://47.96.129.29:8000"

set META_SERVERS_OPTS=-Dfat_meta=%fat_meta% -Dpro_meta=%pro_meta%

rem =============== Please do not modify the following content =============== 
rem go to script directory
cd "%~dp0"

cd ..

rem package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

call mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=%apollo_config_db_url% -Dspring_datasource_username=%apollo_config_db_username% -Dspring_datasource_password=%apollo_config_db_password%

echo "==== building config-service and admin-service finished ===="

echo "==== starting to build portal ===="

call mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=%apollo_portal_db_url% -Dspring_datasource_username=%apollo_portal_db_username% -Dspring_datasource_password=%apollo_portal_db_password% %META_SERVERS_OPTS%

echo "==== building portal finished ===="

echo "==== starting to build client ===="

call mvn clean install -DskipTests -pl apollo-client -am %META_SERVERS_OPTS%

echo "==== building client finished ===="

pause
