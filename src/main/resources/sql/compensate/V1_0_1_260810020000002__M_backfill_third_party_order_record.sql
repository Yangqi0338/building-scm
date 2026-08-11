-- ============================================================
-- third_party_order_request → third_party_order_record 数据回填 (flyway-post)
-- 前置: autotable 已 CREATE 空 third_party_order_record (见 __C_260810101400288: CREATE 非 ALTER)
--       旧 third_party_order_request 表仍在
-- 依据: ThirdPartyOrderRecordDO extends BaseDO; REPORT §1.2 字段完全一致仅审计列改名
-- 目标列: id,platform_type,biz_order_no,third_order_no,interface_name,request_json,
--         response_json,request_status,error_message,retry_count,next_retry_time,
--         executor,creator_id,create_time,update_time,del_flag
-- 旧列:   id,platform_type,biz_order_no,third_order_no,interface_name,request_json,
--         response_json,request_status,error_message,retry_count,next_retry_time,
--         created_at,updated_at
-- 列改名: created_at→create_time, updated_at→update_time
-- 补默认: del_flag=0, executor/creator_id NULL
-- 旧 298 行, id 直迁 (AUTO_INCREMENT 值, 新表 ASSIGN_ID 但回填保留旧 id)
-- ============================================================
-- 幂等: 插入或更新 (ON DUPLICATE KEY UPDATE)。前提 third_party_order_request 存在(存量升级)。
INSERT INTO `third_party_order_record`
  (`id`,`platform_type`,`biz_order_no`,`third_order_no`,`interface_name`,`request_json`,
   `response_json`,`request_status`,`error_message`,`retry_count`,`next_retry_time`,
   `create_time`,`update_time`,`del_flag`)
SELECT
  `id`,`platform_type`,`biz_order_no`,`third_order_no`,`interface_name`,`request_json`,
  `response_json`,`request_status`,`error_message`,`retry_count`,`next_retry_time`,
  `created_at`,`updated_at`,0
FROM `third_party_order_request`
ON DUPLICATE KEY UPDATE
  `platform_type`=VALUES(`platform_type`),`biz_order_no`=VALUES(`biz_order_no`),
  `third_order_no`=VALUES(`third_order_no`),`interface_name`=VALUES(`interface_name`),
  `request_json`=VALUES(`request_json`),`response_json`=VALUES(`response_json`),
  `request_status`=VALUES(`request_status`),`error_message`=VALUES(`error_message`),
  `retry_count`=VALUES(`retry_count`),`next_retry_time`=VALUES(`next_retry_time`),
  `create_time`=VALUES(`create_time`),`update_time`=VALUES(`update_time`),`del_flag`=VALUES(`del_flag`);

DROP TABLE IF EXISTS `third_party_order_request`;
