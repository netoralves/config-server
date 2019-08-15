FROM openjdk:8-jdk-alpine

ENV jar_file target/*.jar
ARG jar_file=$jar_file

# START: Spring Cloud Configuration
ENV server_port 8080
ARG server_port=$server_port

ENV spring_application_name config-server
ARG spring_application_name=$spring_application_name

ENV spring_profiles_active hmlg
ARG spring_profiles_active=$spring_profiles_active

ENV management_endpoints_web_exposure_include *
ARG management_endpoints_web_exposure_include=$management_endpoints_web_exposure_include

ENV management_security_enabled false
ARG management_security_enabled=$management_security_enabled
# END: Spring Cloud Configuration

# START: Spring Boot Admin Configuration
ENV spring_boot_admin_client_enabled true
ARG spring_boot_admin_client_enabled=$spring_boot_admin_client_enabled

ENV spring_boot_admin_client_url http://admin-server.hmlg.svc:8080/
ARG spring_boot_admin_client_url=$spring_boot_admin_client_url

ENV spring_boot_admin_client_auto_registration true
ARG spring_boot_admin_client_auto_registration=$spring_boot_admin_client_auto_registration

ENV spring_boot_admin_client_prefer_ip true
ARG spring_boot_admin_client_prefer_ip=$spring_boot_admin_client_prefer_ip
# END: Spring Boot Admin Configuration

ENV spring_cloud_config_server_git_uri https://github.com/netoralves/application-config.git
ARG spring_cloud_config_server_git_uri=$spring_cloud_config_server_git_uri

#ENV spring_cloud_config_server_git_username IF_YOU_USE_CREDENTIALS
#ARG spring_cloud_config_server_git_username=$spring_cloud_config_server_git_username

#ENV spring_cloud_config_server_git_password IF_YOU_USE_CREDENTIALS
#ARG spring_cloud_config_server_git_password=$spring_cloud_config_server_git_password

RUN echo jar_file: $jar_file
RUN echo server_port: $server_port
RUN echo spring_application_name: $spring_application_name
RUN echo spring_profiles_active: $spring_profiles_active
RUN echo management_endpoints_web_exposure_include: $management_endpoints_web_exposure_include
RUN echo management_security_enabled: $management_security_enabled

RUN echo spring_cloud_config_server_git_uri: $spring_cloud_config_server_git_uri
RUN echo spring_cloud_config_server_git_username: $spring_cloud_config_server_git_username
RUN echo spring_cloud_config_server_git_password: $spring_cloud_config_server_git_password

COPY $jar_file app.jar

ENTRYPOINT [ \
	"java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar" \
	, "--server.port=${server_port}" \
	, "--spring.application.name=${spring_application_name}" \
	, "--spring.profiles.active=${spring_profiles_active}" \
	, "--management.endpoints.web.exposure.include=${management_endpoints_web_exposure_include}" \
	, "--management.security.enabled=${management_security_enabled}" \
	, "--spring.boot.admin.client.enabled=${spring_boot_admin_client_enabled}" \
	, "--spring.boot.admin.client.url=${spring_boot_admin_client_url}" \
	, "--spring.boot.admin.client.auto-registration=${spring_boot_admin_client_auto_registration}" \
	, "--spring.boot.admin.client.prefer-ip=${spring_boot_admin_client_prefer_ip}" \
	, "--spring.cloud.config.server.git.uri=${spring_cloud_config_server_git_uri}" \
	, "--spring.cloud.config.server.git.username=${spring_cloud_config_server_git_username}" \
	, "--spring.cloud.config.server.git.password=${spring_cloud_config_server_git_password}" \
]
