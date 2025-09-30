# Nacos 配置指南

本文档提供了 Cloud-OJ 项目中 Nacos 的配置说明。

## Nacos 基本信息

- 版本：2.4.3
- 命名空间：Cloud-OJ
- 命名空间ID：3fde09c7-0223-4dd8-9c14-888c9e282bc6
- 配置格式：YAML

## 必要配置

在 Nacos 中，您需要为每个服务创建以下配置：

### Gateway 服务配置

**Data ID**: gateway.yaml  
**Group**: DEFAULT_GROUP  
**配置内容**:

```yaml
server:
  port: 8080

spring:
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://${DB_HOST:localhost:3306}/cloud_oj?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true
    username: ${DB_USER:root}
    password: ${DB_PASSWORD:123456}
    hikari:
      minimum-idle: ${DB_POOL_SIZE:6}
      maximum-pool-size: ${DB_POOL_SIZE:6}
  jackson:
    default-property-inclusion: non_null
  cache:
    type: caffeine
    caffeine:
      spec: maximumSize=1000,expireAfterWrite=20m
  cloud:
    gateway:
      mvc:
        routes:
          - id: core
            uri: lb://core
            filters:
              - StripPrefix=2
            predicates:
              - Path=/api/core/**
          - id: judge
            uri: lb://judge
            filters:
              - StripPrefix=2
            predicates:
              - Path=/api/judge/**
          - id: auth
            uri: lb://gateway
            filters:
              - StripPrefix=2
            predicates:
              - Path=/api/auth/**
```

### Core 服务配置

**Data ID**: core.yaml  
**Group**: DEFAULT_GROUP  
**配置内容**:

```yaml
server:
  port: 8180

spring:
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://${DB_HOST:localhost:3306}/cloud_oj?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true
    username: ${DB_USER:root}
    password: ${DB_PASSWORD:123456}
    hikari:
      minimum-idle: ${DB_POOL_SIZE:6}
      maximum-pool-size: ${DB_POOL_SIZE:6}
  jackson:
    default-property-inclusion: non_null
  servlet:
    multipart:
      max-file-size: 100MB
      max-request-size: 128MB

management:
  endpoint:
    health:
      show-details: ALWAYS
```

### Judge 服务配置

**Data ID**: judge.yaml  
**Group**: DEFAULT_GROUP  
**配置内容**:

```yaml
server:
  port: 8280

spring:
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://${DB_HOST:localhost:3306}/cloud_oj?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true
    username: ${DB_USER:root}
    password: ${DB_PASSWORD:123456}
    hikari:
      minimum-idle: ${DB_POOL_SIZE:6}
      maximum-pool-size: ${DB_POOL_SIZE:6}
  rabbitmq:
    host: ${RABBIT_URL:localhost}
    port: ${RABBIT_PORT:5672}
    username: ${RABBIT_USER:guest}
    password: ${RABBIT_PASSWORD:guest}
    listener:
      simple:
        prefetch: 1
        acknowledge-mode: manual
  jackson:
    default-property-inclusion: non_null

management:
  endpoint:
    health:
      show-details: always
```

## 配置说明

1. 以上配置文件需要在 Nacos 控制台中手动创建
2. 确保命名空间ID正确：`3fde09c7-0223-4dd8-9c14-888c9e282bc6`
3. 配置文件的 Data ID 必须与服务名称一致，并添加 `.yaml` 后缀
4. 环境变量可以在启动服务时通过命令行参数覆盖

## 注意事项

- 首次启动服务前，必须确保 Nacos 中已创建相应的配置
- 修改配置后，服务会自动刷新大部分配置，但某些配置可能需要重启服务才能生效
- 建议在开发环境中使用本地配置文件，在生产环境中使用 Nacos 配置中心