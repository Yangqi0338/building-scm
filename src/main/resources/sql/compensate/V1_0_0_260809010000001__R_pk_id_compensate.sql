-- ============================================================
-- 主键补偿: 4表新增 id 主键, 用旧主键值填充
-- 生成: 2026-08-10 | KC | 模型: claude-opus-4-8
-- 执行时机: autotable 之前(flyway-pre). 先建好 id 列并赋值, 避免 autotable ADD NOT NULL 主键时旧行为空报错
-- account_tripartite_purse/config_channel/payment: 新增id保留旧主键列; strategy: strategy_id值迁入id后旧列删除(autotable处理)
-- ============================================================

-- account_tripartite_purse: 新增代理键 id, 用旧主键 account_id 值填充(旧主键列保留为普通列)
ALTER TABLE `account_tripartite_purse` ADD COLUMN `id` bigint NULL COMMENT '主键ID' FIRST;
UPDATE `account_tripartite_purse` SET `id` = `account_id` WHERE `id` IS NULL;
-- 注: 旧表主键为 account_id, autotable 将把 PK 改为 id. id 已填充, autotable MODIFY id NOT NULL 可通过

-- config_channel: 新增代理键 id, 用旧主键 channel_id 值填充(旧主键列保留为普通列)
ALTER TABLE `config_channel` ADD COLUMN `id` bigint NULL COMMENT '主键ID' FIRST;
UPDATE `config_channel` SET `id` = `channel_id` WHERE `id` IS NULL;
-- 注: 旧表主键为 channel_id, autotable 将把 PK 改为 id. id 已填充, autotable MODIFY id NOT NULL 可通过

-- payment: 新增代理键 id, 用旧主键 trade_no 值填充(旧主键列保留为普通列)
ALTER TABLE `payment` ADD COLUMN `id` bigint NULL COMMENT '主键ID' FIRST;
UPDATE `payment` SET `id` = `trade_no` WHERE `id` IS NULL;
-- 注: 旧表主键为 trade_no, autotable 将把 PK 改为 id. id 已填充, autotable MODIFY id NOT NULL 可通过

-- strategy: 旧主键 strategy_id 值迁入新主键 id, 旧列 strategy_id 将由 autotable 删除
ALTER TABLE `strategy` ADD COLUMN `id` bigint NULL COMMENT '主键ID' FIRST;
UPDATE `strategy` SET `id` = `strategy_id` WHERE `id` IS NULL;
-- autotable 后续 DROP strategy_id, id 承接其值
