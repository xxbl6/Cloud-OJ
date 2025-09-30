package cloud.oj.core.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * 用户 AC 记录
 *
 * <p>按(problem_id，date)分组；按(problem_id，language)计数</p>
 */
@Getter
@Setter
public class AcCount {
    private Integer pid;
    private String date;
    private Integer count;
    
    // 手动添加getter/setter方法
    public Integer getPid() {
        return pid;
    }
    
    public void setPid(Integer pid) {
        this.pid = pid;
    }
    
    public String getDate() {
        return date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    
    public Integer getCount() {
        return count;
    }
    
    public void setCount(Integer count) {
        this.count = count;
    }
}
