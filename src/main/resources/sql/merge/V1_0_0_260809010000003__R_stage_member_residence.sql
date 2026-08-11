-- ============================================================
-- member 常住地折叠暂存 (flyway-pre, autotable ALTER 前)
-- 背景: 旧 member 有 residence_province/city/district 三列; 新 MemberDO 折叠为单列 residence。
--       autotable 对 same-name 表原地 ALTER, pre 之后会 DROP 这三列 + ADD 空 residence,
--       故 pre 先把三列拼接值按 id 暂存, post 回填。
-- 实测: 384 行中 12 行有常住地数据。拼接用 ', ' (对齐 residence 注释 "省份, 城市, 区县"),
--       CONCAT_WS 跳 NULL, 配 NULLIF 再跳空串。
-- ============================================================

CREATE TABLE IF NOT EXISTS `_mig_member_residence` (
  `id`        bigint NOT NULL PRIMARY KEY,
  `residence` varchar(160) NULL
);

INSERT INTO `_mig_member_residence` (`id`,`residence`)
SELECT `id`,
       CONCAT_WS(', ',
         NULLIF(`residence_province`,''),
         NULLIF(`residence_city`,''),
         NULLIF(`residence_district`,''))
FROM `member`
WHERE COALESCE(NULLIF(`residence_province`,''),
               NULLIF(`residence_city`,''),
               NULLIF(`residence_district`,'')) IS NOT NULL
ON DUPLICATE KEY UPDATE `residence`=VALUES(`residence`);
