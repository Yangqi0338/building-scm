-- ============================================================
-- RBAC 初始化数据 (flyway-post, 时间戳 > __C_)
-- 来源: 用户提供 seed (2026-08-10)。role/permission/permission_relation 均新增表,
--       autotable CREATE 空表 → 此处灌初始数据。
-- 表继承 BaseDO: 含 executor/creator_id/create_time/update_time/del_flag(@ColumnDefault 0)。
--   seed 只填业务列 + create_time/update_time, del_flag 靠列默认 0, executor/creator_id NULL。
-- 幂等: ON DUPLICATE KEY UPDATE, 可重复执行。
-- 枚举列已核实全部 @EnumValue String code(存枚举 name 字符串):
--   PermissionEnum.Type MENU/FUNC; RelationEnum.Type ACCOUNT_ROLE/ROLE_PERMISSION/ACCOUNT_PERMISSION;
--   RelationEnum.Source DIRECT/ROLE_DERIVED。→ seed 字符串字面量 'MENU'/'ACCOUNT_ROLE'/'DIRECT' 直插正确。
-- ============================================================

-- 权限关系: 账号1 ↔ 角色1 (超管绑定)
INSERT INTO `permission_relation`
  (`id`, `type`, `source_id`, `target_id`, `source`, `create_time`, `update_time`)
VALUES
  (1, 'ACCOUNT_ROLE', 1, 1, 'DIRECT', NOW(), NOW())
ON DUPLICATE KEY UPDATE `type`=VALUES(`type`), `source_id`=VALUES(`source_id`),
  `target_id`=VALUES(`target_id`), `source`=VALUES(`source`);

-- 父菜单: 系统管理
INSERT INTO `permission`
  (`id`, `pid`, `type`, `code`, `name`, `route`, `icon`, `sort`, `create_time`, `update_time`)
VALUES (1001, 0, 'MENU', 'menu:admin', '系统管理', NULL, '{Setting}', 60, NOW(), NOW())
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `route`=VALUES(`route`),
  `icon`=VALUES(`icon`), `sort`=VALUES(`sort`);

-- 子菜单: 权限管理
INSERT INTO `permission`
  (`id`, `pid`, `type`, `code`, `name`, `route`, `icon`, `sort`, `create_time`, `update_time`)
VALUES (1002, 1001, 'MENU', 'menu:admin:permissions', '权限管理', '/admin/permissions', NULL, 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `route`=VALUES(`route`), `sort`=VALUES(`sort`);

-- 子菜单: 角色管理
INSERT INTO `permission`
  (`id`, `pid`, `type`, `code`, `name`, `route`, `icon`, `sort`, `create_time`, `update_time`)
VALUES (1003, 1001, 'MENU', 'menu:admin:roles', '角色管理', '/admin/roles', NULL, 0, NOW(), NOW())
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `route`=VALUES(`route`), `sort`=VALUES(`sort`);

-- 角色: 超级管理员
INSERT INTO `role`
  (`id`, `code`, `name`, `description`, `sort`, `create_time`, `update_time`)
VALUES (1, 'SUPER_ADMIN', '超级管理员', '拥有所有权限', 0, NOW(), NOW())
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`);

