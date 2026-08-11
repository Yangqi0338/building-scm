-- ============================================================
-- member.residence 回填 (flyway-post, autotable ALTER 后 residence 列已存在)
-- 前置: pre __R_stage_member_residence 已暂存拼接值到 _mig_member_residence
-- 动作: 按 id JOIN 回填 member.residence, 再清理暂存表。
-- 幂等: 直接 SET 覆盖, 可重跑。
-- ============================================================

UPDATE `member` m
JOIN `_mig_member_residence` s ON s.`id` = m.`id`
SET m.`residence` = s.`residence`;

DROP TABLE IF EXISTS `_mig_member_residence`;
