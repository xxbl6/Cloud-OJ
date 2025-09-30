# Cloud-OJ 本地运行指南

本文档提供了如何在本地环境中运行 Cloud-OJ 项目的详细步骤。

## 前置条件

确保您的本地环境已安装以下软件：

- OpenJDK 21
- MySQL 8.0.27+
- Nacos 2.4.3
- RabbitMQ 4.3.2+
- Maven 3.8+

## 步骤一：准备数据库

1. 启动 MySQL 服务
2. 创建数据库：
   ```sql
   CREATE DATABASE cloud_oj DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
3. 确保 MySQL 用户名为 `root`，密码为 `123456`

## 步骤二：启动 Nacos 服务

1. 下载并解压 Nacos 2.4.3
2. 启动 Nacos 服务：
   ```bash
   cd nacos/bin
   startup.cmd -m standalone
   ```
3. 访问 Nacos 控制台：http://localhost:8848/nacos/
   - 默认用户名/密码：nacos/nacos
4. 创建命名空间：
   - 命名空间名称：Cloud-OJ
   - 命名空间ID：3fde09c7-0223-4dd8-9c14-888c9e282bc6

## 步骤三：启动 RabbitMQ 服务

1. 确保 RabbitMQ 服务已启动
2. 默认访问地址：http://localhost:15672/
   - 默认用户名/密码：guest/guest

## 步骤四：编译并启动服务

按照以下顺序启动各个服务：

1. **编译项目**：
   ```bash
   cd services
   mvn clean package -DskipTests
   ```

2. **启动 Gateway 服务**：
   ```bash
   cd services/gateway
   java -jar target/gateway-1.0.0-SNAPSHOT.jar
   ```

3. **启动 Core 服务**：
   ```bash
   cd services/core
   java -jar target/core-1.0.0-SNAPSHOT.jar
   ```

4. **启动 Judge 服务**：
   ```bash
   cd services/judge
   java -jar target/judge-1.0.0-SNAPSHOT.jar
   ```

5. **启动前端服务**：
   ```bash
   cd web
   npm install
   npm run dev
   ```

## 步骤五：访问系统

启动所有服务后，可通过以下URL访问系统：

- 前端页面：http://localhost:5173/
- API网关：http://localhost:8080/

## 常见问题排查

1. 如果服务无法正常启动，请检查 Nacos 和 MySQL 是否正常运行
2. 确保所有服务的配置文件中的数据库连接信息正确
3. 检查 RabbitMQ 连接是否正常
4. 查看各服务的日志以获取更详细的错误信息