package cloud.oj.core.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
public class UserStatistics {
    private Results results;
    private List<Language> preference;
    private Map<String, Integer> activities;
    
    // 手动添加setter方法
    public void setActivities(HashMap<String, Integer> activities) {
        this.activities = activities;
    }
}
