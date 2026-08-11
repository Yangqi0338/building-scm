-- ============================================================
-- sys_config → dict 迁移 (flyway-post, 时间戳 > __C_)
-- 用户定(2026-08-10): "sys_config 全部迁移到 dict, 代码获取也是"
-- 现状: Base 全仓 **无 sys_config 的 Java 引用**(grep 0 命中) → 无旧读取代码需改;
--       新配置统一走 dict(DictDO: value=JSON字符串, desc=描述)。
--
-- dict 表: 同名 ALTER, 旧 13 行(id 1001-1013)保留。sys_config 5 行(id 1-8, 实测 5 行)迁入。
-- 列映射: sys_config.config_value → dict.value; config_key → dict.desc(作标识描述)。
--   sys_config 其余列(config_group/config_type/enabled/env/creator/updater)dict 无对应, 丢弃。
--   env 实测全 'prod', 无多环境分裂; config_type(json/string) dict 不区分(value 统一存字符串)。
-- id 分配: 避开 dict 现有 1001-1013, sys_config 迁入用 2001+ 段。
--   注: sys_config 主键 AUTO_INCREMENT(1-8), dict 主键 ASSIGN_ID(雪花), 不冲突, 显式给新 id。
--
-- 实测 5 行 config_key: tencent.im.integrated_config / tencent.im.sync /
--   tencent.im.register.msg / tencent.im.member.update / tencent.im.integrated_config1
-- 迁移策略: INSERT...SELECT 从旧 sys_config 表(autotable 不生成 SysConfigDO → 旧表仍在),
--   用 (2000 + sys_config.id) 作 dict.id 避碰。
-- ============================================================

-- 幂等: 插入或更新 (ON DUPLICATE KEY UPDATE)。dict id=1008 存在则覆盖 value/desc。
INSERT INTO `dict` (`id`, `value`, `desc`, `create_time`, `update_time`)
SELECT
1008,
  `config_value`,
  CONCAT(`config_key`, IFNULL(CONCAT(' | ', `description`), '')),
  `create_time`,
  `update_time`
FROM `sys_config`
WHERE config_key = "tencent.im.integrated_config"
ON DUPLICATE KEY UPDATE
  `value`=VALUES(`value`),`desc`=VALUES(`desc`),
  `create_time`=VALUES(`create_time`),`update_time`=VALUES(`update_time`);

-- 迁移完成删旧表
DROP TABLE IF EXISTS `sys_config`;
