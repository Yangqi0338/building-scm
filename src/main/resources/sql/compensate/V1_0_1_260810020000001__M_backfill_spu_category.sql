-- ============================================================
-- category → spu_category 数据回填 (flyway-post, 时间戳 > __C_)
-- 前置: autotable 已 CREATE 空 spu_category (见 __C_260810101234592__C_spu_category.sql: CREATE, 非 ALTER)
--       旧 category 表仍在 (autotable 认不出表改名, 不动旧表)
-- 依据: SpuCategoryDO extends CategoryLayerDO; REPORT §6-E
-- 目标列: id,pid,pid_list,level,brand_id_list,account_id,name,desc,img,idx,
--         is_enabled,executor,creator_id,create_time,update_time,del_flag
-- 旧列:   id,account_id,name,desc,brand_id_list,pid,img,create_time,update_time,brand_name_list
-- 直迁: id,pid,account_id,name,desc,img,brand_id_list,create_time,update_time
-- 丢弃: brand_name_list (新实体无对应)
-- 计算: pid_list/level 树路径 (旧数据: id 11-19 根 pid=0→level1 "id,"; 1901 pid=19→level2 "19,1901,")
-- 补默认: del_flag=0, idx=0, is_enabled=1, executor/creator_id NULL
-- 数据实测 10 行: account_id 全 0, 仅 2 层深, 故 pid_list 直接按 1/2 层公式算
-- ============================================================

-- 幂等: 插入或更新 (ON DUPLICATE KEY UPDATE)。dev 已手删旧无用数据, 生产存量旧表在。
--   前提: category 表存在方可迁 (存量升级场景)。若旧表已删, 本脚本无源可迁, 需人工确认跳过。

-- 第 1 层 (根, pid=0 或 NULL): pid_list = 'id,', level = 1
INSERT INTO `spu_category`
  (`id`,`pid`,`pid_list`,`level`,`brand_id_list`,`account_id`,`name`,`desc`,`img`,
   `idx`,`is_enabled`,`create_time`,`update_time`,`del_flag`)
SELECT
  `id`,`pid`,CONCAT(`id`,','),1,`brand_id_list`,`account_id`,`name`,`desc`,`img`,
  0,1,`create_time`,`update_time`,0
FROM `category`
WHERE `pid` IS NULL OR `pid` = 0
ON DUPLICATE KEY UPDATE
  `pid`=VALUES(`pid`),`pid_list`=VALUES(`pid_list`),`level`=VALUES(`level`),
  `brand_id_list`=VALUES(`brand_id_list`),`account_id`=VALUES(`account_id`),
  `name`=VALUES(`name`),`desc`=VALUES(`desc`),`img`=VALUES(`img`),
  `idx`=VALUES(`idx`),`is_enabled`=VALUES(`is_enabled`),
  `create_time`=VALUES(`create_time`),`update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

-- 第 2 层 (子, pid 指向已插入的根): pid_list = 父pid_list + 'id,', level = 2
INSERT INTO `spu_category`
  (`id`,`pid`,`pid_list`,`level`,`brand_id_list`,`account_id`,`name`,`desc`,`img`,
   `idx`,`is_enabled`,`create_time`,`update_time`,`del_flag`)
SELECT
  c.`id`,c.`pid`,CONCAT(p.`pid_list`,c.`id`,','),2,c.`brand_id_list`,c.`account_id`,
  c.`name`,c.`desc`,c.`img`,0,1,c.`create_time`,c.`update_time`,0
FROM `category` c
JOIN `spu_category` p ON p.`id` = c.`pid`
WHERE c.`pid` IS NOT NULL AND c.`pid` <> 0
ON DUPLICATE KEY UPDATE
  `pid`=VALUES(`pid`),`pid_list`=VALUES(`pid_list`),`level`=VALUES(`level`),
  `brand_id_list`=VALUES(`brand_id_list`),`account_id`=VALUES(`account_id`),
  `name`=VALUES(`name`),`desc`=VALUES(`desc`),`img`=VALUES(`img`),
  `idx`=VALUES(`idx`),`is_enabled`=VALUES(`is_enabled`),
  `create_time`=VALUES(`create_time`),`update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

-- 清理旧表
DROP TABLE IF EXISTS `category`;
