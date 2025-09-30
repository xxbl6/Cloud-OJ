-- 设置字符集
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

-- 用户数据
INSERT INTO user (username, nickname, real_name, password, secret, email, section, has_avatar, star, role)
VALUES 
('teacher1', N'张老师', N'张三', '$2a$10$i8D62CjX7/.z8juoUACG9ecqatDl9JkizB5XoA9UswPtb8WmnCAG6', UUID(), 'teacher1@example.com', N'计算机系', 1, 1, 1),
('student1', N'李同学', N'李四', '$2a$10$i8D62CjX7/.z8juoUACG9ecqatDl9JkizB5XoA9UswPtb8WmnCAG6', UUID(), 'student1@example.com', N'计算机1班', 0, 0, 1),
('student2', N'王同学', N'王五', '$2a$10$i8D62CjX7/.z8juoUACG9ecqatDl9JkizB5XoA9UswPtb8WmnCAG6', UUID(), 'student2@example.com', N'计算机2班', 1, 0, 1);

-- 题目数据
INSERT INTO problem (title, description, timeout, memory_limit, output_limit, score, enable, category)
VALUES 
(N'两数之和', N'给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。\n\n示例：\ninput: nums = [2,7,11,15], target = 9\noutput: [0,1]', 
1000, 16, 16, 100, 1, N'数组,哈希表'),
(N'快速排序', N'实现快速排序算法。\n\n要求：\n1. 实现快速排序的基本算法\n2. 处理边界情况\n3. 优化算法性能\n\n示例：\ninput: [3,1,4,1,5,9,2,6,5,3,5]\noutput: [1,1,2,3,3,4,5,5,5,6,9]',
2000, 32, 16, 200, 1, N'排序,算法'),
(N'链表反转', N'给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。\n\n示例：\ninput: 1->2->3->4->5\noutput: 5->4->3->2->1',
1500, 16, 16, 150, 1, N'链表');

-- 测试数据配置
INSERT INTO data_conf (problem_id, conf)
VALUES 
(1000, '{"points":[{"score":50,"input":"test1.in","output":"test1.out"},{"score":50,"input":"test2.in","output":"test2.out"}]}'),
(1001, '{"points":[{"score":40,"input":"sort1.in","output":"sort1.out"},{"score":60,"input":"sort2.in","output":"sort2.out"}]}'),
(1002, '{"points":[{"score":30,"input":"list1.in","output":"list1.out"},{"score":30,"input":"list2.in","output":"list2.out"},{"score":40,"input":"list3.in","output":"list3.out"}]}');

-- 竞赛数据
INSERT INTO contest (contest_name, invite_key, start_at, end_at, languages)
VALUES 
(N'2024春季程序设计基础测试', 'ABC123', UNIX_TIMESTAMP(), UNIX_TIMESTAMP() + 7200, 15),
(N'数据结构期中考试', 'XYZ789', UNIX_TIMESTAMP() + 86400, UNIX_TIMESTAMP() + 93600, 7);

-- 竞赛题目关联
INSERT INTO contest_problem (contest_id, problem_id, `order`)
VALUES 
(1, 1000, 1),
(1, 1001, 2),
(2, 1001, 1),
(2, 1002, 2);

-- 竞赛参与者
INSERT INTO invitee (contest_id, uid)
VALUES 
(1, 100001),
(1, 100002),
(2, 100001),
(2, 100002);

-- 提交记录
INSERT INTO solution (uid, problem_id, contest_id, title, language, state, result, total, passed, pass_rate, score, time, memory, submit_time)
VALUES 
(100001, 1000, 1, '两数之和', 1, 'JUDGED', 'AC', 2, 2, 1.0, 100, 156000, 1024, UNIX_TIMESTAMP() * 1000),
(100002, 1000, 1, '两数之和', 1, 'JUDGED', 'PA', 2, 1, 0.5, 50, 145000, 1024, UNIX_TIMESTAMP() * 1000),
(100001, 1001, 2, '快速排序', 2, 'JUDGED', 'TLE', 2, 0, 0.0, 0, 2500000, 2048, UNIX_TIMESTAMP() * 1000);

-- 源代码
INSERT INTO source_code (solution_id, code)
VALUES 
(10000, 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        Map<Integer, Integer> map = new HashMap<>();\n        for (int i = 0; i < nums.length; i++) {\n            int complement = target - nums[i];\n            if (map.containsKey(complement)) {\n                return new int[] { map.get(complement), i };\n            }\n            map.put(nums[i], i);\n        }\n        return new int[0];\n    }\n}'),
(10001, 'def twoSum(nums, target):\n    seen = {}\n    for i, value in enumerate(nums):\n        remaining = target - value\n        if remaining in seen:\n            return [seen[remaining], i]\n        seen[value] = i\n    return []'),
(10002, 'public class Solution {\n    public void quickSort(int[] arr, int low, int high) {\n        while(true) { // 错误：这里应该有终止条件\n            int pivot = partition(arr, low, high);\n            quickSort(arr, low, pivot - 1);\n            quickSort(arr, pivot + 1, high);\n        }\n    }\n}');

-- 排名数据
INSERT INTO scoreboard (uid, committed, passed, score, update_time)
VALUES 
(100001, 2, 1, 100, UNIX_TIMESTAMP() * 1000),
(100002, 1, 0, 50, UNIX_TIMESTAMP() * 1000);

-- 竞赛排名
INSERT INTO scoreboard_contest (uid, contest_id, committed, passed, score, update_time)
VALUES 
(100001, 1, 1, 1, 100, UNIX_TIMESTAMP() * 1000),
(100002, 1, 1, 0, 50, UNIX_TIMESTAMP() * 1000),
(100001, 2, 1, 0, 0, UNIX_TIMESTAMP() * 1000);

-- 系统设置
UPDATE settings 
SET always_show_ranking = 1,
    show_all_contest = 0,
    show_passed_points = 1,
    auto_del_solutions = 0
WHERE id = 0;

-- 日志数据
INSERT INTO log (service, instance_id, level, thread, class_name, message, time)
VALUES 
('judge', UUID(), 'INFO', 'main', 'cloud.oj.judge.JudgeApplication', N'判题服务启动成功', UNIX_TIMESTAMP() * 1000),
('core', UUID(), 'INFO', 'main', 'cloud.oj.core.CoreApplication', N'核心服务启动成功', UNIX_TIMESTAMP() * 1000),
('gateway', UUID(), 'INFO', 'main', 'cloud.oj.gateway.GatewayApplication', N'网关服务启动成功', UNIX_TIMESTAMP() * 1000),
('judge', UUID(), 'INFO', 'judge-1', 'cloud.oj.judge.service.JudgeService', N'评测完成：solution_id=10000', UNIX_TIMESTAMP() * 1000),
('judge', UUID(), 'WARN', 'judge-1', 'cloud.oj.judge.service.JudgeService', N'编译错误：solution_id=10002', UNIX_TIMESTAMP() * 1000);

SET FOREIGN_KEY_CHECKS=1;