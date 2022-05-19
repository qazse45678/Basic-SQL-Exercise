-- 創建公司資料庫表格

create table `employee`(
	`employee_id` int primary key,
    `name` varchar(20),
    `birth_date` date,
    `sex` varchar(1),
    `salary` int,
    `branch_id` int,
    `sup_id` int
);
create table `branch`(
	`branch_id` int primary key,
    `branch_name` varchar(20),
    `manager_id` int,
    foreign key(`manager_id`) references `employee`(`employee_id`) on delete set null -- 假如 manager id 對應到的 employee id 不存在，則把 manager id 設成 null
);
alter table `employee`
add foreign key (`branch_id`)
references `branch`(`branch_id`)
on delete set null;

alter table `employee`
add foreign key (`sup_id`)
references `employee`(`employee_id`)
on delete set null;

create table `client`(
	`client_id` int primary key,
    `client_name` varchar(20),
    `phone` varchar(20)
);
create table `work_with`(
	`employee_id` int,
    `client_id` int,
    `total_sales` int,
    primary key(`employee_id`, `client_id`),
    foreign key(`employee_id`) references `employee`(`employee_id`) on delete cascade, -- 如果 employee 表格中的 employee id 不存在，導致 work with 表格的 employee id 對應不到，則將 work with 的該筆資料刪掉
    foreign key(`client_id`) references `client`(`client_id`) on delete cascade
);

-- 新增員工資料

insert into `branch` values (1, '研發', null);
insert into `branch` values (2, '行政', null);
insert into `branch` values (3, '資訊', null);

insert into `employee` values (206, '小黃', '1998-10-08', 'F', 50000, 1, null);
insert into `employee` values (207, '小綠', '1985-09-06', 'M', 29000, 2, 206);  
insert into `employee` values (208, '小黑', '2000-12-19', 'M', 35000, 3, 206);
insert into `employee` values (209, '小白', '1997-01-22', 'F', 39000, 3, 207);
insert into `employee` values (210, '小藍', '1925-11-10', 'F', 84000, 1, 207);

update `branch`
set `manager_id` = 208
where `branch_id` = 3;

-- 新增客戶資料

insert into `client` values (400, '阿狗', '254354335');
insert into `client` values (401, '阿貓', '25633899');
insert into `client` values (402, '旺來', '45354345');
insert into `client` values (403, '露西', '54354365');
insert into `client` values (404, '艾瑞克', '18783783');

-- 新增 work with 資料
-- 不知為何失敗？
insert into `work_with` values (206, 400, '70000');
insert into `work_with` values (200, 401, '24000');
insert into `work_with` values (208, 400, '9800');
insert into `work_with` values (208, 403, '24000');
insert into `work_with` values (210, 404, '87940');

-- 練習

-- 1. 取得所有員工資料
select * from `employee`;

-- 2. 取得所有客戶資料
select * from `client`;

-- 3. 按薪水低到高取得員工資料
select * from `employee`
order by `salary` DESC;

-- 4. 取得薪水前三高的員工
select * from `employee`
order by `salary` DESC
limit 3;

-- 5. 取得所有員工的名字
select `name` from `employee`;

-- 6. 取得所有性別（不重複）
select distinct `sex` from `employee`;

-- aggregation functions 聚合函數

-- 1. 取得員工人數
select count(*) from `employee`;

-- 2. 取得所有出生於 1970-01-01 之後的女性員工數
select count(*) from `employee`
where `birth_date` > '1970-01-01'
and `sex` = 'F';

-- 3. 取得所有員工的平均薪水
select avg(`salary`) from `employee`;

-- 4. 取得所有員工的薪水總合
select sum(`salary`) from `employee`;

-- 5. 取得薪水最高的員工
select max(`salary`) from `employee`;

-- 6. 取得薪水最低的員工
select min(`salary`) from `employee`;

-- 萬用字元 %代表多個字元 _代表一個字元

-- 1. 取得電話號碼尾數是 335 的客戶
select * from `client`
where `phone` like '%335'; -- %放開頭，代表不論開頭為何，查找尾數；%放結尾，代表不論結尾為何，查找開頭

-- 2. 取得姓艾的客戶
select * from `client`
where `client_name` like '艾%';

-- 3. 取得生日在 12 月的員工
select * from `employee`
where `birth_date` like '%12%';

-- union 聯集

-- 1. 員工名字 union 客戶名字
select `name` as `employee_name` from `employee` -- 改變欄位名稱
union
select `client_name` from `client`
union
select `branch_name` from `branch`;

-- join 連接

-- 1. 取得所有經理的名字
select `employee_id`, `name`, `branch_name` from `employee`
left join `branch` -- 左邊表格不論條件是否成立，都會回傳資料；右邊表格則要條件成立才回傳
on `employee`.`employee_id` = `branch`.`manager_id`;

-- subquery 子查詢

-- 1. 找出研發部門經理的名字
select `name` from `employee`
where `employee_id` = (
	select `manager_id` from `branch`
	where `branch_name` = '研發'
);

-- 2. 對單一客戶銷售金額超過 50000 的員工名字
select `name` from `employee`
where `employee_id` in (
	select `employee_id` from `work_with`
	where `total_sales` > 50000
);











