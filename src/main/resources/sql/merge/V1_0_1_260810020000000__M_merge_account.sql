-- ============================================================
-- account 合并回填 (flyway-post, 时间戳 > __C_account 260810013655732)
-- 前置: flyway-pre 已 RENAME account/admin_account/sys_user 为 _mig_*_old
--       autotable 已 CREATE 空 account(PK(id,client))
-- 动作: 旧 account 按 client 炸行(399→418) + admin_account(1→admin) + sys_user 同步 user_account
-- 依据: REPORT.md §5 / §10 / D-66。逐 client INSERT...SELECT。
-- CompanyRole code→client: 1000→user,1001→supplier,1002→channel,1004/1005/1006→operator,1/2→admin
-- password: 旧 account.password 是 {"code":"bcrypt"} JSON, 按 client 取对应 code 的值(一端一密码)
--
-- 【role_id_list 按 client 过滤 (第9轮修正)】
--   旧 role_id_list 是账号全部角色 code 的混合串(如 '1000,1002,1001'), 整列复制会让
--   channel 行带上 user/supplier 的 code(冗余/错端)。故每段 role_id_list **只保留属本端的 code**:
--     user='1000,' / supplier='1001,' / channel='1002,'(WHERE 命中即该端有此单一角色)
--     operator=从旧串筛 1004/1005/1006 命中项拼接(可多级)
--   末逗号遵循项目 *_id_list 约定(右模糊 like CONCAT(code,',%') 可命中)。
--   admin: admin_account.arole_id_list 实测 NULL(单行 id=1001 username='admin' 超管),
--     旧无角色数据 → 赋 CompanyRole.PLATFORM code '1'(平台管理员)。
-- ============================================================

-- ---------- client='user' (code 1000) ----------
INSERT INTO `account`
  (`id`,`client`,`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
   `sub_user_type`,`real_name`,`password`,`state`,`last_login_time`,`name_auth_audit_state`,
   `sub_account_count`,`below_count`,`invite_account_id`,`role_id_list`,`yqm`,`phone`,
   `user_account`,`im_sync_status`,`head`,`cancel_time`,`tripartite_account_permission`,
   `tripartite_account_id`,`create_time`,`update_time`,`del_flag`)
SELECT
  `id`,'user',`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
  `sub_user_type`,`realname`,
  CASE WHEN JSON_VALID(`password`) THEN JSON_UNQUOTE(JSON_EXTRACT(`password`,'$."1000"')) ELSE NULL END,
  `state`,`last_login_time`,`name_auth_audit_state`,`sub_account_count`,`below_count`,
  `invite_account_id`,'1000,',`yqm`,`phone`,`user_account`,`im_sync_status`,`head`,
  `cancel_time`,`tripartite_account_permission`,`tripartite_account_id`,`create_time`,`update_time`,0
FROM `_mig_account_old`
WHERE FIND_IN_SET('1000',`role_id_list`) OR FIND_IN_SET('1000',`p_role_list`)
   OR (JSON_VALID(`password`) AND JSON_CONTAINS_PATH(`password`,'one','$."1000"'))
ON DUPLICATE KEY UPDATE
  `main_account_id`=VALUES(`main_account_id`),`pid`=VALUES(`pid`),`pid_list`=VALUES(`pid_list`),
  `p_role_list`=VALUES(`p_role_list`),`nickname`=VALUES(`nickname`),`username`=VALUES(`username`),
  `sub_user_type`=VALUES(`sub_user_type`),`real_name`=VALUES(`real_name`),`password`=VALUES(`password`),
  `state`=VALUES(`state`),`last_login_time`=VALUES(`last_login_time`),
  `name_auth_audit_state`=VALUES(`name_auth_audit_state`),`sub_account_count`=VALUES(`sub_account_count`),
  `below_count`=VALUES(`below_count`),`invite_account_id`=VALUES(`invite_account_id`),
  `role_id_list`=VALUES(`role_id_list`),`yqm`=VALUES(`yqm`),`phone`=VALUES(`phone`),
  `user_account`=VALUES(`user_account`),`im_sync_status`=VALUES(`im_sync_status`),`head`=VALUES(`head`),
  `cancel_time`=VALUES(`cancel_time`),`tripartite_account_permission`=VALUES(`tripartite_account_permission`),
  `tripartite_account_id`=VALUES(`tripartite_account_id`),`create_time`=VALUES(`create_time`),
  `update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

-- ---------- client='supplier' (code 1001) ----------
INSERT INTO `account`
  (`id`,`client`,`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
   `sub_user_type`,`real_name`,`password`,`state`,`last_login_time`,`name_auth_audit_state`,
   `sub_account_count`,`below_count`,`invite_account_id`,`role_id_list`,`yqm`,`phone`,
   `user_account`,`im_sync_status`,`head`,`cancel_time`,`tripartite_account_permission`,
   `tripartite_account_id`,`create_time`,`update_time`,`del_flag`)
SELECT
  `id`,'supplier',`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
  `sub_user_type`,`realname`,
  CASE WHEN JSON_VALID(`password`) THEN JSON_UNQUOTE(JSON_EXTRACT(`password`,'$."1001"')) ELSE NULL END,
  `state`,`last_login_time`,`name_auth_audit_state`,`sub_account_count`,`below_count`,
  `invite_account_id`,'1001,',`yqm`,`phone`,`user_account`,`im_sync_status`,`head`,
  `cancel_time`,`tripartite_account_permission`,`tripartite_account_id`,`create_time`,`update_time`,0
FROM `_mig_account_old`
WHERE FIND_IN_SET('1001',`role_id_list`) OR FIND_IN_SET('1001',`p_role_list`)
   OR (JSON_VALID(`password`) AND JSON_CONTAINS_PATH(`password`,'one','$."1001"'))
ON DUPLICATE KEY UPDATE
  `main_account_id`=VALUES(`main_account_id`),`pid`=VALUES(`pid`),`pid_list`=VALUES(`pid_list`),
  `p_role_list`=VALUES(`p_role_list`),`nickname`=VALUES(`nickname`),`username`=VALUES(`username`),
  `sub_user_type`=VALUES(`sub_user_type`),`real_name`=VALUES(`real_name`),`password`=VALUES(`password`),
  `state`=VALUES(`state`),`last_login_time`=VALUES(`last_login_time`),
  `name_auth_audit_state`=VALUES(`name_auth_audit_state`),`sub_account_count`=VALUES(`sub_account_count`),
  `below_count`=VALUES(`below_count`),`invite_account_id`=VALUES(`invite_account_id`),
  `role_id_list`=VALUES(`role_id_list`),`yqm`=VALUES(`yqm`),`phone`=VALUES(`phone`),
  `user_account`=VALUES(`user_account`),`im_sync_status`=VALUES(`im_sync_status`),`head`=VALUES(`head`),
  `cancel_time`=VALUES(`cancel_time`),`tripartite_account_permission`=VALUES(`tripartite_account_permission`),
  `tripartite_account_id`=VALUES(`tripartite_account_id`),`create_time`=VALUES(`create_time`),
  `update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

-- ---------- client='channel' (code 1002) ----------
INSERT INTO `account`
  (`id`,`client`,`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
   `sub_user_type`,`real_name`,`password`,`state`,`last_login_time`,`name_auth_audit_state`,
   `sub_account_count`,`below_count`,`invite_account_id`,`role_id_list`,`yqm`,`phone`,
   `user_account`,`im_sync_status`,`head`,`cancel_time`,`tripartite_account_permission`,
   `tripartite_account_id`,`create_time`,`update_time`,`del_flag`)
SELECT
  `id`,'channel',`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
  `sub_user_type`,`realname`,
  CASE WHEN JSON_VALID(`password`) THEN JSON_UNQUOTE(JSON_EXTRACT(`password`,'$."1002"')) ELSE NULL END,
  `state`,`last_login_time`,`name_auth_audit_state`,`sub_account_count`,`below_count`,
  `invite_account_id`,'1002,',`yqm`,`phone`,`user_account`,`im_sync_status`,`head`,
  `cancel_time`,`tripartite_account_permission`,`tripartite_account_id`,`create_time`,`update_time`,0
FROM `_mig_account_old`
WHERE FIND_IN_SET('1002',`role_id_list`) OR FIND_IN_SET('1002',`p_role_list`)
   OR (JSON_VALID(`password`) AND JSON_CONTAINS_PATH(`password`,'one','$."1002"'))
ON DUPLICATE KEY UPDATE
  `main_account_id`=VALUES(`main_account_id`),`pid`=VALUES(`pid`),`pid_list`=VALUES(`pid_list`),
  `p_role_list`=VALUES(`p_role_list`),`nickname`=VALUES(`nickname`),`username`=VALUES(`username`),
  `sub_user_type`=VALUES(`sub_user_type`),`real_name`=VALUES(`real_name`),`password`=VALUES(`password`),
  `state`=VALUES(`state`),`last_login_time`=VALUES(`last_login_time`),
  `name_auth_audit_state`=VALUES(`name_auth_audit_state`),`sub_account_count`=VALUES(`sub_account_count`),
  `below_count`=VALUES(`below_count`),`invite_account_id`=VALUES(`invite_account_id`),
  `role_id_list`=VALUES(`role_id_list`),`yqm`=VALUES(`yqm`),`phone`=VALUES(`phone`),
  `user_account`=VALUES(`user_account`),`im_sync_status`=VALUES(`im_sync_status`),`head`=VALUES(`head`),
  `cancel_time`=VALUES(`cancel_time`),`tripartite_account_permission`=VALUES(`tripartite_account_permission`),
  `tripartite_account_id`=VALUES(`tripartite_account_id`),`create_time`=VALUES(`create_time`),
  `update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

-- ---------- client='operator' (code 1004/1005/1006, 一端一密码取任一存在的) ----------
-- role_id_list: 从旧串筛本端命中的 code(可多级) 拼接, 末逗号
INSERT INTO `account`
  (`id`,`client`,`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
   `sub_user_type`,`real_name`,`password`,`state`,`last_login_time`,`name_auth_audit_state`,
   `sub_account_count`,`below_count`,`invite_account_id`,`role_id_list`,`yqm`,`phone`,
   `user_account`,`im_sync_status`,`head`,`cancel_time`,`tripartite_account_permission`,
   `tripartite_account_id`,`create_time`,`update_time`,`del_flag`)
SELECT
  `id`,'operator',`main_account_id`,`pid`,`pid_list`,`p_role_list`,`nickname`,`username`,
  `sub_user_type`,`realname`,
  CASE WHEN JSON_VALID(`password`) THEN COALESCE(
        JSON_UNQUOTE(JSON_EXTRACT(`password`,'$."1004"')),
        JSON_UNQUOTE(JSON_EXTRACT(`password`,'$."1005"')),
        JSON_UNQUOTE(JSON_EXTRACT(`password`,'$."1006"'))) ELSE NULL END,
  `state`,`last_login_time`,`name_auth_audit_state`,`sub_account_count`,`below_count`,
  `invite_account_id`,
  CONCAT(CONCAT_WS(',',
    IF(FIND_IN_SET('1004',`role_id_list`) OR FIND_IN_SET('1004',`p_role_list`)
       OR (JSON_VALID(`password`) AND JSON_CONTAINS_PATH(`password`,'one','$."1004"')),'1004',NULL),
    IF(FIND_IN_SET('1005',`role_id_list`) OR FIND_IN_SET('1005',`p_role_list`)
       OR (JSON_VALID(`password`) AND JSON_CONTAINS_PATH(`password`,'one','$."1005"')),'1005',NULL),
    IF(FIND_IN_SET('1006',`role_id_list`) OR FIND_IN_SET('1006',`p_role_list`)
       OR (JSON_VALID(`password`) AND JSON_CONTAINS_PATH(`password`,'one','$."1006"')),'1006',NULL)
  ),','),
  `yqm`,`phone`,`user_account`,`im_sync_status`,`head`,
  `cancel_time`,`tripartite_account_permission`,`tripartite_account_id`,`create_time`,`update_time`,0
FROM `_mig_account_old`
WHERE FIND_IN_SET('1004',`role_id_list`) OR FIND_IN_SET('1004',`p_role_list`)
   OR FIND_IN_SET('1005',`role_id_list`) OR FIND_IN_SET('1005',`p_role_list`)
   OR FIND_IN_SET('1006',`role_id_list`) OR FIND_IN_SET('1006',`p_role_list`)
   OR (JSON_VALID(`password`) AND (JSON_CONTAINS_PATH(`password`,'one','$."1004"')
        OR JSON_CONTAINS_PATH(`password`,'one','$."1005"')
        OR JSON_CONTAINS_PATH(`password`,'one','$."1006"')))
ON DUPLICATE KEY UPDATE
  `main_account_id`=VALUES(`main_account_id`),`pid`=VALUES(`pid`),`pid_list`=VALUES(`pid_list`),
  `p_role_list`=VALUES(`p_role_list`),`nickname`=VALUES(`nickname`),`username`=VALUES(`username`),
  `sub_user_type`=VALUES(`sub_user_type`),`real_name`=VALUES(`real_name`),`password`=VALUES(`password`),
  `state`=VALUES(`state`),`last_login_time`=VALUES(`last_login_time`),
  `name_auth_audit_state`=VALUES(`name_auth_audit_state`),`sub_account_count`=VALUES(`sub_account_count`),
  `below_count`=VALUES(`below_count`),`invite_account_id`=VALUES(`invite_account_id`),
  `role_id_list`=VALUES(`role_id_list`),`yqm`=VALUES(`yqm`),`phone`=VALUES(`phone`),
  `user_account`=VALUES(`user_account`),`im_sync_status`=VALUES(`im_sync_status`),`head`=VALUES(`head`),
  `cancel_time`=VALUES(`cancel_time`),`tripartite_account_permission`=VALUES(`tripartite_account_permission`),
  `tripartite_account_id`=VALUES(`tripartite_account_id`),`create_time`=VALUES(`create_time`),
  `update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

-- ---------- admin_account (1 行, id=1001) → client='admin' ----------
-- arole_id_list 实测 NULL → role_id_list 赋 CompanyRole.PLATFORM code '1,'(平台管理员超管)
INSERT INTO `account`
  (`id`,`client`,`nickname`,`username`,`password`,`state`,`head`,`phone`,`role_id_list`,
   `create_time`,`update_time`,`del_flag`)
SELECT
  `id`,'admin',`nickname`,`username`,`password`,`state`,`face`,`phone`,
  COALESCE(CONCAT(NULLIF(`arole_id_list`,''),','),'1,'),
  `create_time`,`update_time`,0
FROM `_mig_admin_account_old`
ON DUPLICATE KEY UPDATE
  `nickname`=VALUES(`nickname`),`username`=VALUES(`username`),`password`=VALUES(`password`),
  `state`=VALUES(`state`),`head`=VALUES(`head`),`phone`=VALUES(`phone`),
  `role_id_list`=VALUES(`role_id_list`),`create_time`=VALUES(`create_time`),
  `update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

-- ---------- sys_user 同步 user_account (仅 status=1, 按手机号匹配) ----------
-- 方向: sys_user.user_account 覆盖 account.user_account (client='user' 行)
-- 手机号规范化: 取后 11 位数字比对 (旧数据有 12 位脏值)
UPDATE `account` a
JOIN `_mig_sys_user_old` s
  ON s.`status` = 1
 AND RIGHT(REGEXP_REPLACE(s.`phone`,'[^0-9]',''),11) = RIGHT(REGEXP_REPLACE(a.`phone`,'[^0-9]',''),11)
SET a.`user_account` = s.`user_account`
WHERE a.`client` = 'user';

-- ---------- 清理暂存表 ----------
DROP TABLE IF EXISTS `_mig_account_old`;
DROP TABLE IF EXISTS `_mig_admin_account_old`;
DROP TABLE IF EXISTS `_mig_sys_user_old`;
