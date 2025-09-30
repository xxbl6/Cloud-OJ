FROM mysql:8.0.27

COPY schema.sql /docker-entrypoint-initdb.d/
COPY init.sql /docker-entrypoint-initdb.d/

ENV MYSQL_ROOT_PASSWORD=123456
ENV MYSQL_ROOT_HOST=%

# 使用 native password 认证方式
CMD ["mysqld", "--default-authentication-plugin=mysql_native_password"]