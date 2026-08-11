-- ============================================================
-- account 合并暂存 (flyway-pre, 时间戳 < __C_account 260810013655732)
-- 作用: 把参与合并的旧表腾空/改名, 让 autotable CREATE 出空 account(PK(id,client))
--       真实数据回填在 flyway-post (INSERT...SELECT FROM 暂存表)
-- 依据: REPORT.md §5 + D-66。旧 account 399 行按 client 炸成 418 行。
-- 幂等: 用 IF EXISTS/IF NOT EXISTS 包裹, 可重复跑。
-- ============================================================

-- 1) 旧 account 改名暂存 (保 399 行原始数据), 让 account 名腾空给 autotable
DROP TABLE IF EXISTS `_mig_account_old`;
RENAME TABLE `account` TO `_mig_account_old`;

-- 2) 旧 admin_account 暂存 (1 行, id=1001 → client='admin')
--    admin_account 不是新库表名, 无 autotable 冲突, 仅改名保数据留给 post
DROP TABLE IF EXISTS `_mig_admin_account_old`;
RENAME TABLE `admin_account` TO `_mig_admin_account_old`;

-- 3) sys_user 暂存 (859 行) — post 阶段按手机号匹配同步 user_account
--    sys_user 是纯旧表(新库无对应, 迁移后删), 改名后 post 读它做 UPDATE
DROP TABLE IF EXISTS `_mig_sys_user_old`;
RENAME TABLE `sys_user` TO `_mig_sys_user_old`;
