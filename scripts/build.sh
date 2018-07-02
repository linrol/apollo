#!/bin/sh

# apollo config db info
apollo_config_db_url=jdbc:mysql://101.37.253.34:3306/ApolloConfigDB?characterEncoding=utf8
apollo_config_db_username=apolloconfigdb_test
apollo_config_db_password=apolloconfigdb_test

# apollo portal db info
apollo_portal_db_url=jdbc:mysql://101.37.253.34:3306/ApolloPortalDB?characterEncoding=utf8
apollo_portal_db_username=apolloportaldb_test
apollo_portal_db_password=apolloportaldb_test

# meta server url, different environments should have different meta server addresses
#fat_meta=http://118.31.51.231:8001 #测试环境
pro_meta=http://118.31.51.231:8000 #生成环境

META_SERVERS_OPTS="-Dpro_meta=$pro_meta"

# =============== Please do not modify the following content =============== #
# go to script directory
cd "${0%/*}"

cd ..

# package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password

echo "==== building config-service and admin-service finished ===="

echo "==== starting to build portal ===="

mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=$apollo_portal_db_url -Dspring_datasource_username=$apollo_portal_db_username -Dspring_datasource_password=$apollo_portal_db_password $META_SERVERS_OPTS

echo "==== building portal finished ===="

echo "==== starting to build client ===="

mvn clean install -DskipTests -pl apollo-client -am $META_SERVERS_OPTS

echo "==== building client finished ===="

