package cloud.oj.core.config;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.simple.JdbcClient;

@Configuration
@RequiredArgsConstructor
public class DatabaseMigration {

    private final JdbcClient client;

    @PostConstruct
 public void init() {
        // Check if column exists first
        var checkColumnSql = """
            SELECT COUNT(*)
            FROM information_schema.COLUMNS
            WHERE TABLE_SCHEMA = DATABASE()
            AND TABLE_NAME = 'user'
            AND COLUMN_NAME = 'real_name'
            """;
            
        var columnExists = client.sql(checkColumnSql)
            .query(Integer.class)
            .single() > 0;

        if (!columnExists) {
            var sql1 = "ALTER TABLE user ADD COLUMN real_name char(16) null after nickname";
            client.sql(sql1).update();
        }

        // Check if index exists first
        var checkIndexSql = """
            SELECT COUNT(*)
            FROM information_schema.STATISTICS
            WHERE TABLE_SCHEMA = DATABASE()
            AND TABLE_NAME = 'user'
            AND INDEX_NAME = 'idx_real_name'
            """;
            
        var indexExists = client.sql(checkIndexSql)
            .query(Integer.class)
            .single() > 0;

        if (!indexExists) {
            var sql2 = "CREATE INDEX idx_real_name ON user (real_name)";
            client.sql(sql2).update();
        }
    }
}
