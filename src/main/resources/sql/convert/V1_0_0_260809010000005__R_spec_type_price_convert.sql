-- ============================================================
-- spu.spec_type varchar→int + user_collection.price decimal→bigint 值转换 (flyway-pre)
-- 背景: 两表均同名表, autotable 原地 ALTER 会 MODIFY 列类型, 但旧字符串/小数值无法自动转 → pre 先转。
--
-- K) spu.spec_type: 旧 varchar 'single'/'multiple' → 新 SpuEnum.SpecType int code
--    SpuEnum.SpecType: MULTIPLE(0), SINGLE(1)  ← 用户定 single=1/multiple=0, 与枚举一致
--    实测 spu: single 531 / multiple 148, 无其他值
--    先把字符串就地改成数字串, autotable MODIFY int 时可隐式转
--
-- L) user_collection.price decimal(10,2)→bigint: 用户定"直接去小数"
--    实测 5 行。TRUNCATE 小数(非四舍五入), 保留整数元。autotable MODIFY bigint 前先规整。
-- ============================================================

-- K: spec_type 字符串 → 数字串 (autotable 随后 MODIFY int)
UPDATE `spu` SET `spec_type` = '1' WHERE `spec_type` = 'single';
UPDATE `spu` SET `spec_type` = '0' WHERE `spec_type` = 'multiple';

-- L: price 去小数 (decimal→整数值, autotable 随后 MODIFY bigint)
UPDATE `user_collection` SET `price` = FLOOR(`price`) WHERE `price` IS NOT NULL;
