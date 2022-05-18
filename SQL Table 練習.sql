CREATE DATABASE sql_exercise;
SHOW databases;
use sql_exercise;

drop table `student`;

CREATE TABLE `student` (
	`student_id` INT AUTO_INCREMENT,
	`name` VARCHAR(20) NOT NULL, /*constraint 限制/約束*/
	`major` VARCHAR(20) DEFAULT '歷史',
    `score` int,
	PRIMARY KEY (`student_id`)
);

INSERT INTO `student` (`student_id`, `name`, `score`) VALUES (1, '小黑', 90);
INSERT INTO `student`  VALUES (2, '小綠', '英語', '30');
INSERT INTO `student` (`name`, `major`, `score`) VALUES ('小白', '地理', '50');
INSERT INTO `student` (`name`, `major`, `score`) VALUES ('小灰', '國文', '76');
INSERT INTO `student` (`name`, `major`, `score`) VALUES ('小紫', '歷史', '80');

set sql_safe_updates = 0;

SELECT * FROM `student`;

/*修改、刪除資料*/

update `student`
set `major` = '英語', `name` = '小灰'
where `major` = '英語文學';

delete from `student`
where `student_id` = 3;

/*取得資料*/

select * from `student`
where `major` in ('歷史', '地理') = '英語' OR `score` <> 70 /*不等於*/
order by `score`, `student_id` desc /*先根據 score 排序，如果 score 一樣就根據 student id 排序*/
limit 3;