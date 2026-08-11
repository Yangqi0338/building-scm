/*
 Navicat Premium Dump SQL

 Source Server         : dev
 Source Server Type    : MySQL
 Source Server Version : 80045 (8.0.45)
 Source Host           : 192.168.30.85:3306
 Source Schema         : platform_scm1

 Target Server Type    : MySQL
 Target Server Version : 80045 (8.0.45)
 File Encoding         : 65001

 Date: 10/08/2026 00:49:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `main_account_id` bigint NULL DEFAULT NULL COMMENT '主账号id',
  `state` int NOT NULL COMMENT '帐号状态（0正常 1停用） (查询)',
  `pid` bigint NOT NULL COMMENT '父ID (查询)',
  `pid_list` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父id列表',
  `p_role_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '父role列表',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称 (查询)',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名称(手机号) (查询)',
  `sub_user_type` int NULL DEFAULT NULL COMMENT '子用户类型',
  `realname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '密码',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '上次登录时间',
  `name_auth_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '实名认证信息',
  `name_auth_audit_state` int NULL DEFAULT NULL COMMENT '实名认证审批状态',
  `sub_account_count` int NOT NULL DEFAULT 0 COMMENT '子账号数量',
  `below_count` int NOT NULL DEFAULT 0 COMMENT '下级数量',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `invite_account_id` bigint NULL DEFAULT NULL COMMENT '邀请人账号ID, json格式, 每个角色都可能有邀请人账号ID',
  `role_id_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '子账号角色ID集合',
  `erole_id_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '子账号员工角色ID集合',
  `yqm` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邀请码',
  `account_ext_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_account` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账号(tencent用)',
  `head` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `im_sync_status` int NULL DEFAULT 0 COMMENT 'IM同步状态（0-未同步，1-已同步，2-同步失败）',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '注销时间',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `tripartite_account_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方账户id',
  `tripartite_account_permission` int NULL DEFAULT NULL COMMENT '三方账户权限',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni`(`username` ASC, `pid` ASC) USING BTREE,
  INDEX `idx_pidList`(`pid_list`(500) ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '账号' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for account_login_log
-- ----------------------------
DROP TABLE IF EXISTS `account_login_log`;
CREATE TABLE `account_login_log`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号ID (查询)',
  `login_time` timestamp NULL DEFAULT NULL COMMENT '登录时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `login_type` int NULL DEFAULT NULL COMMENT '登录方式',
  `login_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录IP',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '登录记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for account_purse
-- ----------------------------
DROP TABLE IF EXISTS `account_purse`;
CREATE TABLE `account_purse`  (
  `id` bigint NOT NULL,
  `account_id` bigint NOT NULL COMMENT '客户id',
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户名称',
  `purse_type` int NOT NULL COMMENT '账户类型',
  `account_type` int NOT NULL COMMENT '客户类型',
  `earnings` int NOT NULL DEFAULT 0 COMMENT '收益',
  `total_earnings` int NOT NULL DEFAULT 0 COMMENT '总收益',
  `tripartite_amount` int NOT NULL DEFAULT 0 COMMENT '三方余额',
  `create_time` timestamp NOT NULL COMMENT '开户时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_id`(`account_id` ASC, `account_type` ASC, `purse_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客户账户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for account_purse_alter_record
-- ----------------------------
DROP TABLE IF EXISTS `account_purse_alter_record`;
CREATE TABLE `account_purse_alter_record`  (
  `id` bigint NOT NULL,
  `account_id` bigint NOT NULL COMMENT '客户id',
  `account_type` int NOT NULL COMMENT '客户类型',
  `purse_type` int NOT NULL COMMENT '账户类型',
  `alter_type` int NOT NULL COMMENT '变动类型',
  `amount` int NOT NULL COMMENT '金额',
  `join_record_id` bigint NULL DEFAULT 0 COMMENT '关联记录id',
  `remark` int NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_id`(`account_id` ASC, `purse_type` ASC, `alter_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '账户变动记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for account_purse_roll_out
-- ----------------------------
DROP TABLE IF EXISTS `account_purse_roll_out`;
CREATE TABLE `account_purse_roll_out`  (
  `id` bigint NOT NULL,
  `account_id` bigint NOT NULL COMMENT '客户id',
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户名称',
  `account_type` int NOT NULL COMMENT '客户类型',
  `purse_type` int NOT NULL COMMENT '账户类型',
  `apply_amount` int NOT NULL COMMENT '申请金额',
  `audit_state` int NOT NULL DEFAULT 0 COMMENT '审核状态',
  `tripartite_trade_state` int NOT NULL DEFAULT 0 COMMENT '三方交易状态 0：未成功  1：成功',
  `tripartite_trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方交易单号',
  `audit_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核备注',
  `apply_time` timestamp NOT NULL COMMENT '申请时间',
  `audit_time` timestamp NULL DEFAULT NULL COMMENT '审核时间',
  `handling_fee` int NOT NULL DEFAULT 0 COMMENT '手续费',
  `tripartite_account_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方账户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_id`(`account_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '转出申请' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for account_tripartite_purse
-- ----------------------------
DROP TABLE IF EXISTS `account_tripartite_purse`;
CREATE TABLE `account_tripartite_purse`  (
  `account_id` bigint NOT NULL COMMENT '客户id',
  `oid_user_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方用户id',
  `user_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态',
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账户姓名',
  `amount` int NOT NULL DEFAULT 0 COMMENT '三方账户余额',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `account_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `account_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '等级',
  `bank_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '开户时间',
  `commit_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `oid_apply_seq_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方申请编号',
  `oid_apply_seq_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方申请id',
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '银行名称',
  PRIMARY KEY (`account_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '三方账户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for account_withdraw_record
-- ----------------------------
DROP TABLE IF EXISTS `account_withdraw_record`;
CREATE TABLE `account_withdraw_record`  (
  `id` bigint NOT NULL,
  `account_id` bigint NOT NULL COMMENT '客户id',
  `amount` int NOT NULL COMMENT '金额',
  `finish_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '提现时间',
  `tripartite_trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方交易单号',
  `state` int NOT NULL DEFAULT 0 COMMENT '状态',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_id`(`account_id` ASC, `create_time` DESC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '提现记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `id` bigint NOT NULL COMMENT 'id',
  `activity_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动id',
  `channel_id` bigint NULL DEFAULT NULL COMMENT '渠道商id',
  `activity_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动名称',
  `activity_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动描述',
  `strategy_id` bigint NOT NULL COMMENT '策略id',
  `condition_type` int NULL DEFAULT NULL COMMENT '门槛类型 0：贡献值  1：会员等级  2：会员卡等级',
  `condition_value` int NULL DEFAULT NULL COMMENT '门槛值',
  `repeat_type` int NULL DEFAULT NULL COMMENT '复类型 0：单次  1：周期',
  `repeat_value` bigint NULL DEFAULT NULL COMMENT '时间点或周期值',
  `state` enum('PENDING','ACTIVE','CANCELLED') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'PENDING' COMMENT '状态 0：关闭 1：开启',
  `other_config` bigint NOT NULL DEFAULT 0 COMMENT '其他配置',
  `creator` bigint NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `channel_id`(`channel_id` ASC, `activity_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '活动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for activity_other_config
-- ----------------------------
DROP TABLE IF EXISTS `activity_other_config`;
CREATE TABLE `activity_other_config`  (
  `id` bigint NOT NULL,
  `channel_id` bigint NOT NULL COMMENT '渠道商id',
  `show_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '显示配置',
  `config_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '具体配置',
  `create_time` date NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '活动其他配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for admin_account
-- ----------------------------
DROP TABLE IF EXISTS `admin_account`;
CREATE TABLE `admin_account`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `nickname` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称 (查询)',
  `face` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号 (查询)',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '登录名称 (查询)',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `state` int NULL DEFAULT NULL COMMENT '帐号状态（0正常 1冻结） (查询)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `arole_id_list` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '后台角色ID JSON',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE COMMENT 'username唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '平台账号' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for app_version
-- ----------------------------
DROP TABLE IF EXISTS `app_version`;
CREATE TABLE `app_version`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_code` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'app code',
  `app_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'app名称',
  `app_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'app版本',
  `update_config` int NOT NULL COMMENT '更新配置',
  `resource_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资源地址',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app_name`(`app_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 540619592192902 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'app版本管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章内容',
  `cover_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图URL',
  `poster_images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '海报轮播图URL列表（JSON数组）',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_visible` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示：0-不显示，1-显示',
  `creator_id` bigint NOT NULL COMMENT '创建人ID',
  `creator_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人姓名',
  `issuer_id` bigint NOT NULL COMMENT '发布人id',
  `issuer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布人名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序值（小于100，相同时按创建时间倒序）',
  `article_count` int NOT NULL DEFAULT 0 COMMENT '文章数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用（0-禁用，1-启用）',
  `recommend_groups` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '推荐人群（多个用逗号分隔）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_data_promise_flow
-- ----------------------------
DROP TABLE IF EXISTS `audit_data_promise_flow`;
CREATE TABLE `audit_data_promise_flow`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `flow_id` bigint NULL DEFAULT NULL COMMENT '审批流ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号ID',
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色ID',
  `promise_pay_type` int NULL DEFAULT NULL COMMENT '缴纳类型（0首次/1补缴）',
  `amount` int NULL DEFAULT NULL COMMENT '金额',
  `pay_type` int NULL DEFAULT NULL COMMENT '支付方式',
  `certificate_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '支付凭证',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `phone` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '注册手机号',
  `company_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  `legal_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '法人姓名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '保证金审批数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_data_spu
-- ----------------------------
DROP TABLE IF EXISTS `audit_data_spu`;
CREATE TABLE `audit_data_spu`  (
  `id` bigint NOT NULL COMMENT 'ID (查询)',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品URL',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称',
  `category_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品分类',
  `category_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品分类名称完整',
  `spu_create_info_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品创建信息',
  `flow_id` bigint NULL DEFAULT NULL COMMENT '审批流ID (查询)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `spu_id` bigint NULL DEFAULT NULL COMMENT '商品ID',
  `brand_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '品牌名称',
  `supply_price` int NULL DEFAULT NULL COMMENT '供货价',
  `sku_sale_price_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'sku销售价 json (Map格式)',
  `admin_user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'sku审批人值对象',
  `market_price` int NULL DEFAULT NULL COMMENT '市场价',
  `inventory` int NULL DEFAULT NULL COMMENT '库存',
  `unit_price` int NULL DEFAULT NULL COMMENT '推荐零售价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品上传审核数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_data_work_table
-- ----------------------------
DROP TABLE IF EXISTS `audit_data_work_table`;
CREATE TABLE `audit_data_work_table`  (
  `id` bigint NOT NULL COMMENT 'ID (查询)',
  `spu_id` bigint NULL DEFAULT NULL COMMENT '商品ID (查询)',
  `operate_type` int NULL DEFAULT NULL COMMENT '操作类型  1 修改  2 新增  3 删除',
  `operate_target` int NULL DEFAULT NULL COMMENT '操作目标  1 SPU基本信息  2 销售规格  3 属性规格   4 SKU信息',
  `spu_info_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '原商品信息',
  `spu_edit_info_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品修改信息',
  `flow_id` bigint NULL DEFAULT NULL COMMENT '审批流ID (查询)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `spu_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称 (查询)',
  `sku_sale_price_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'sku销售价 json (Map格式)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单审核数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_flow
-- ----------------------------
DROP TABLE IF EXISTS `audit_flow`;
CREATE TABLE `audit_flow`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `template_id` bigint NULL DEFAULT NULL COMMENT '模板ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号ID',
  `state` int NULL DEFAULT NULL COMMENT '审批状态 (0,\"待用户提交\";1,\"待审核\";2,\"通过\",3,\"未通过\")',
  `current_code` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '当前节点code',
  `current_audit_account_id` bigint NULL DEFAULT NULL COMMENT '当前审批人ID',
  `current_audit_role_id` bigint NULL DEFAULT NULL COMMENT '当前审批角色',
  `last_refuse_reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '最后拒绝原因: 状态变更未待用户提交前的最后一次拒绝原因',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `role_id` bigint NULL DEFAULT NULL COMMENT '申请人角色ID',
  `is_new` int NULL DEFAULT NULL COMMENT '是否是最新 1 是 0 不是',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '申请人账号',
  `context_params` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '上下文参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色申请审批数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_flow_log
-- ----------------------------
DROP TABLE IF EXISTS `audit_flow_log`;
CREATE TABLE `audit_flow_log`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `flow_id` bigint NULL DEFAULT NULL COMMENT '审批单号',
  `account_id` bigint NULL DEFAULT NULL COMMENT '审批人ID',
  `account_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '审批人名称',
  `audit_operate` int NULL DEFAULT NULL COMMENT '审批动作 (0 拒绝 1 通过',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '审批日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_template
-- ----------------------------
DROP TABLE IF EXISTS `audit_template`;
CREATE TABLE `audit_template`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '审批模板名称',
  `template_nodes_json` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '审批节点信息',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `edge` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '审批节点流转信息',
  `node` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '审批节点信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '审批模板' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for award_record
-- ----------------------------
DROP TABLE IF EXISTS `award_record`;
CREATE TABLE `award_record`  (
  `id` bigint NOT NULL COMMENT '记录id',
  `channel_id` bigint NOT NULL COMMENT '渠道商id',
  `activity_id` int NOT NULL COMMENT '活动id',
  `strategy_id` bigint NOT NULL COMMENT '策略id',
  `channel_activity_id` bigint NOT NULL COMMENT '渠道商活动id',
  `award_state` int NOT NULL COMMENT '奖品状态 0:待发放  1：已发放',
  `grant_type` int NOT NULL COMMENT '发放奖品方式「1:即时、2:定时、3:人工',
  `member_id` bigint NOT NULL COMMENT '会员id',
  `award_id` bigint NOT NULL COMMENT '奖品id',
  `award_type` int NOT NULL COMMENT '奖品类型',
  `ext_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扩展数据',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `grant_time` datetime NULL DEFAULT NULL COMMENT '发放时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `channel_id`(`channel_id` ASC, `activity_id` ASC, `award_state` ASC) USING BTREE,
  INDEX `channel_id_2`(`channel_id` ASC, `channel_activity_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '奖品发放记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `bank_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '银行编码',
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '银行名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniqueCode`(`bank_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 721363801632910 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '银行' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bank_branch
-- ----------------------------
DROP TABLE IF EXISTS `bank_branch`;
CREATE TABLE `bank_branch`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `bank_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '银行编码',
  `branch_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支行编码',
  `branch_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支行名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_key`(`branch_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 721363851186336 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '银行支行' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bill_order_award
-- ----------------------------
DROP TABLE IF EXISTS `bill_order_award`;
CREATE TABLE `bill_order_award`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `role` int NULL DEFAULT NULL COMMENT '角色id',
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账户id',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名称',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `realname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实名称',
  `purse_type` int NULL DEFAULT NULL COMMENT '账户类型',
  `account_type` int NULL DEFAULT NULL COMMENT '金额',
  `amount` int NULL DEFAULT 0 COMMENT '金额',
  `create_date` date NULL DEFAULT (curdate()) COMMENT '创建日期',
  `order_count` int NULL DEFAULT 0 COMMENT '订单数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bonus_pool_now
-- ----------------------------
DROP TABLE IF EXISTS `bonus_pool_now`;
CREATE TABLE `bonus_pool_now`  (
  `id` bigint NOT NULL COMMENT '本期奖金池id',
  `channel_id` bigint NOT NULL COMMENT '渠道商id',
  `activity_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动id',
  `bonus_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖金池活动描述',
  `strategy_id` bigint NOT NULL COMMENT '策略id',
  `other_config` bigint NULL DEFAULT NULL COMMENT '其他配置',
  `order_bonus` int NOT NULL DEFAULT 0 COMMENT '订单奖金',
  `custom_bonus` int NOT NULL DEFAULT 0 COMMENT '自定义奖金',
  `settle_bonus` int NOT NULL DEFAULT 0 COMMENT '最终结算奖金',
  `state` int NOT NULL DEFAULT 0 COMMENT '状态 0：进行中  1：已结算  2：已作废',
  `start_time` timestamp NOT NULL COMMENT '开始时间',
  `end_time` timestamp NOT NULL COMMENT '结束时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `end_time`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '当前奖金池表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bonus_pool_now_partake
-- ----------------------------
DROP TABLE IF EXISTS `bonus_pool_now_partake`;
CREATE TABLE `bonus_pool_now_partake`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `serial_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流水id',
  `channel_id` bigint NULL DEFAULT NULL COMMENT '渠道商id',
  `activity_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动id',
  `activity_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动名称',
  `settlement_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算id',
  `settlement_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算名称',
  `nick_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号id',
  `account_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户名称',
  `role` bigint NULL DEFAULT NULL COMMENT '角色id',
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色等级',
  `person_percent` int NULL DEFAULT NULL COMMENT '个人分红比例',
  `dividend_amount` int NULL DEFAULT NULL COMMENT '分红奖金',
  `dividend_cycle` enum('WEEKLY','MONTHLY') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'MONTHLY' COMMENT '结算周期',
  `bonus_pool_id` bigint NULL DEFAULT NULL COMMENT '奖金池id',
  `member_id` bigint NULL DEFAULT NULL COMMENT '会员id',
  `order_sn` char(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易单号',
  `sku_code` bigint NULL DEFAULT NULL COMMENT '参与sku',
  `buy_num` int NULL DEFAULT NULL COMMENT '购买数量',
  `bonus` int NULL DEFAULT NULL COMMENT '录入奖金',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 737724070294638 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '奖金池活动参与记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bonus_pool_partake
-- ----------------------------
DROP TABLE IF EXISTS `bonus_pool_partake`;
CREATE TABLE `bonus_pool_partake`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `serial_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流水id',
  `channel_id` bigint NULL DEFAULT NULL COMMENT '渠道商id',
  `activity_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '活动id',
  `activity_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动名称',
  `settlement_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算id',
  `settlement_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算名称',
  `nick_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号id',
  `account_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户名称',
  `role` bigint NULL DEFAULT NULL COMMENT '角色id',
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色等级',
  `person_percent` int NULL DEFAULT NULL COMMENT '个人分红比例',
  `dividend_amount` int NULL DEFAULT NULL COMMENT '分红奖金',
  `dividend_cycle` enum('WEEKLY','MONTHLY') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'MONTHLY' COMMENT '结算周期',
  `bonus_pool_id` bigint NULL DEFAULT NULL COMMENT '奖金池id',
  `member_id` bigint NULL DEFAULT NULL COMMENT '会员id',
  `order_sn` char(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易单号',
  `sku_code` bigint NULL DEFAULT NULL COMMENT '参与sku',
  `buy_num` int NULL DEFAULT NULL COMMENT '购买数量',
  `bonus` int NULL DEFAULT NULL COMMENT '录入奖金',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '录入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 738442412618299 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '奖金池活动参与记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称 查询',
  `logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图标',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `state` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING待审核, APPROVED已通过, REJECTED已拒绝',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_account_id`(`account_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '品牌' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称 查询',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `brand_id_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '品牌ID集合',
  `pid` bigint NULL DEFAULT NULL COMMENT '父ID',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `brand_name_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '品牌名称集合',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_pid`(`pid` ASC) USING BTREE,
  INDEX `actable_idx_account_id`(`account_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for channel
-- ----------------------------
DROP TABLE IF EXISTS `channel`;
CREATE TABLE `channel`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `up_dealer_id` bigint NULL DEFAULT NULL COMMENT '上级交易师ID',
  `up_operator_id` bigint NULL DEFAULT NULL COMMENT '上级运营商ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `body_type` int NULL DEFAULT NULL COMMENT '主体类型 (查询)',
  `state` int NOT NULL COMMENT '状态 (查询)',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名称(手机号) (查询)',
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '渠道商名称 (查询) channel_name',
  `head_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `company_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '企业信息',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `name_auth_info` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '实名认证信息',
  `audit_state` int NULL DEFAULT NULL COMMENT '审批状态 (0,\"待用户提交\";1,\"待审核\";2,\"通过\",3,\"未通过\")',
  `audit_refuse_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审批拒绝原因',
  `service_fee_config_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '服务费配置',
  `dealer_earnings` int NOT NULL DEFAULT 0 COMMENT '交易师收益',
  `market_count` int NOT NULL DEFAULT 0 COMMENT '市场数量',
  `wx_mp_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `store_permission` int NULL DEFAULT 0 COMMENT '数字门店权限',
  `license` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '营业执照',
  `ship_province_code` int NULL DEFAULT NULL,
  `ship_city_code` int NULL DEFAULT NULL,
  `ship_area_code` int NULL DEFAULT NULL,
  `contacts_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `store_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jf_license` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `total_order_number` int NOT NULL DEFAULT 0,
  `total_refund_number` int NOT NULL DEFAULT 0,
  `total_order_amount` int NOT NULL DEFAULT 0,
  `total_refund_amount` int NOT NULL DEFAULT 0,
  `jf_permission` int NOT NULL DEFAULT 0,
  `mk_permission` int NOT NULL DEFAULT 0,
  `contacts_way` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系方式',
  `channel_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '渠道商类型:DISTRIBUTION 分销,STORE 门店',
  `custom_count` int NULL DEFAULT 0 COMMENT '客户总数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '渠道商' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for config_channel
-- ----------------------------
DROP TABLE IF EXISTS `config_channel`;
CREATE TABLE `config_channel`  (
  `channel_id` bigint NOT NULL COMMENT '渠道商id',
  `platform_config` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '平台服务费',
  `operator_config` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '运营商服务费',
  `platform_now_value` double NULL DEFAULT NULL COMMENT '平台当前服务费',
  `operator_now_value` double NULL DEFAULT NULL COMMENT '运营商当前服务费',
  `alter_time` timestamp NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`channel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '渠道商服务费配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for config_operator_lever
-- ----------------------------
DROP TABLE IF EXISTS `config_operator_lever`;
CREATE TABLE `config_operator_lever`  (
  `account_id` bigint NOT NULL COMMENT '客户id',
  `lever` int NOT NULL COMMENT '杠杆倍数',
  `update_time` timestamp NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`account_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '运营商杠杆配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for count_sale
-- ----------------------------
DROP TABLE IF EXISTS `count_sale`;
CREATE TABLE `count_sale`  (
  `id` bigint NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `account_id` bigint NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `total_order_number` int NULL DEFAULT NULL,
  `total_order_amount` int NULL DEFAULT NULL,
  `total_refund_number` int NULL DEFAULT NULL,
  `total_refund_amount` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni`(`role` ASC, `account_id` ASC, `date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `course_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程编码',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程标题',
  `intro` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '课程简介',
  `lecturer_id` bigint NOT NULL COMMENT '讲师ID',
  `category_id` bigint NOT NULL COMMENT '课程分类ID',
  `original_price` bigint NULL DEFAULT 0 COMMENT '原价',
  `sell_price` bigint NULL DEFAULT 0 COMMENT '售价',
  `virtual_purchase_count` int NULL DEFAULT 0 COMMENT '虚拟购买次数',
  `purchase_count` int NULL DEFAULT 0 COMMENT '实际购买数量',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图URL',
  `carousel_images` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '轮播图URL，多个用逗号分隔',
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '视频介绍URL',
  `details` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '课程详情',
  `chapter_count` int NULL DEFAULT 0 COMMENT '章节总数（该课程下所有章节数量）',
  `total_duration_centisecond` bigint NULL DEFAULT 0 COMMENT '课程总时长（百分秒，所有章节时长之和）',
  `total_duration_desc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '课程总时长描述（如10分08秒、1小时05分50秒）',
  `is_enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用：1-启用，0-禁用',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识：1-已删除，0-未删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_course_id`(`course_num` ASC) USING BTREE COMMENT '课程编码唯一',
  INDEX `idx_lecturer_id`(`lecturer_id` ASC) USING BTREE COMMENT '讲师ID索引',
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE COMMENT '课程分类ID索引',
  INDEX `idx_is_enabled`(`is_enabled` ASC) USING BTREE COMMENT '是否启用索引'
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for course_category
-- ----------------------------
DROP TABLE IF EXISTS `course_category`;
CREATE TABLE `course_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类编码（格式：K+6位自编码，如K000001）',
  `category_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称（最多5个字）',
  `sub_title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '小标题（最多15个字）',
  `sort` int NULL DEFAULT 0 COMMENT '排序值（值越小越靠前）',
  `course_count` int NULL DEFAULT 0 COMMENT '课程数量（该分类下课程总数，不分课程状态）',
  `is_enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用：1-启用，0-禁用',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识：1-已删除，0-未删除（MyBatis-Plus自动处理）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间（精确到秒）',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_category_code`(`category_code` ASC) USING BTREE COMMENT '分类编码唯一',
  UNIQUE INDEX `uk_category_name`(`category_name` ASC) USING BTREE COMMENT '分类名称唯一',
  INDEX `idx_sort`(`sort` ASC) USING BTREE COMMENT '排序字段索引（优化列表排序查询）',
  INDEX `idx_is_enabled`(`is_enabled` ASC) USING BTREE COMMENT '启用状态索引（优化筛选查询）',
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE COMMENT '逻辑删除索引（优化查询过滤）'
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for course_chapter
-- ----------------------------
DROP TABLE IF EXISTS `course_chapter`;
CREATE TABLE `course_chapter`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `course_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属课程编号（关联课程表course_id）',
  `title` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '章节标题（最多10个字）',
  `chapter_num` int NOT NULL COMMENT '章节数（从1开始，同一课程下不重复）',
  `virtual_study_count` int NOT NULL DEFAULT 1 COMMENT '虚拟学习人数（大于等于1的整数）',
  `is_free` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否免费（1=是，0=否）',
  `self_media_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '自媒体上传视频URL（与外部链接二选一）',
  `external_media_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '外部自媒体链接（与自媒体URL二选一）',
  `publish_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `duration_centisecond` int NULL DEFAULT 0 COMMENT '章节视频时长（百分秒，秒×100）',
  `duration_desc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时长描述（如10秒08毫秒、1分05秒50毫秒）',
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用（1=启用，0=禁用）',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否逻辑删除（1=删除，0=未删除）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_course_chapter_num`(`course_id` ASC, `chapter_num` ASC) USING BTREE COMMENT '同一课程下章节数唯一',
  INDEX `idx_course_id`(`course_id` ASC) USING BTREE COMMENT '课程编号索引',
  INDEX `idx_is_enabled`(`is_enabled` ASC) USING BTREE COMMENT '启用状态索引',
  INDEX `idx_is_free`(`is_free` ASC) USING BTREE COMMENT '是否免费索引'
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程章节表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for course_chapter_watch_record
-- ----------------------------
DROP TABLE IF EXISTS `course_chapter_watch_record`;
CREATE TABLE `course_chapter_watch_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `course_id` bigint NOT NULL COMMENT '课程ID（关联course.id）',
  `course_chapter_id` bigint NOT NULL COMMENT '章节ID（关联course_chapter.id）',
  `course_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程编码（冗余，关联course.course_num）',
  `chapter_num` int NOT NULL COMMENT '章节数（冗余，关联course_chapter.chapter_num）',
  `is_watched` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否观看过：1-是（即完成），0-否（仅预留）',
  `watch_duration_centisecond` int NOT NULL DEFAULT 0 COMMENT '累计观看时长（百分秒，秒×100）',
  `last_watch_position_centisecond` int NOT NULL DEFAULT 0 COMMENT '上次观看位置（百分秒，断点续播用）',
  `watch_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次观看时间（即完成时间）',
  `total_watch_times` int NOT NULL DEFAULT 1 COMMENT '累计观看次数（重复观看计数）',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1-已删，0-未删',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_chapter`(`user_id` ASC, `course_chapter_id` ASC) USING BTREE COMMENT '唯一约束：同一用户+同一章节仅一条记录',
  INDEX `idx_user_course`(`user_id` ASC, `course_id` ASC) USING BTREE COMMENT '用户+课程索引（查用户某课程的观看记录）',
  INDEX `idx_is_watched`(`is_watched` ASC) USING BTREE COMMENT '观看状态索引（筛选已看/未看章节）',
  INDEX `idx_watch_time`(`watch_time` ASC) USING BTREE COMMENT '观看时间索引（按时间筛选观看记录）'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程章节观看记录表（看过即完成）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for course_purchase_record
-- ----------------------------
DROP TABLE IF EXISTS `course_purchase_record`;
CREATE TABLE `course_purchase_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号（唯一，如：时间戳+用户ID+随机数）',
  `course_id` bigint NOT NULL COMMENT '课程ID（关联course表id）',
  `course_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程编码（冗余，关联course表course_num）',
  `user_id` bigint NOT NULL COMMENT '购买用户ID',
  `original_price` bigint NOT NULL DEFAULT 0 COMMENT '课程原价（购买时快照，单位：分）',
  `pay_price` bigint NOT NULL DEFAULT 0 COMMENT '实际支付金额（单位：分，避免浮点精度问题）',
  `pay_state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '支付状态：0-待支付，1-支付成功，2-支付失败（关联PaymentEnum.PayState）',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付完成时间（成功/失败时填充）',
  `pay_type` tinyint(1) NULL DEFAULT NULL COMMENT '支付渠道：1-微信 2-支付宝',
  `pay_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '第三方支付流水号（如支付宝/微信交易号）',
  `pay_url` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '支付链接',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '订单过期时间（待支付状态下有效）',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '订单取消时间（待支付时取消）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注（如支付失败原因、取消原因）',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识：1-已删除，0-未删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间（下单时间）',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人（用户ID/系统）',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE COMMENT '订单编号唯一',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID索引（查询用户购买记录）',
  INDEX `idx_course_id`(`course_id` ASC) USING BTREE COMMENT '课程ID索引（统计课程购买量）',
  INDEX `idx_pay_state`(`pay_state` ASC) USING BTREE COMMENT '支付状态索引（筛选待支付/成功订单）',
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE COMMENT '创建时间索引（按时间筛选订单）'
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程购买记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dealer
-- ----------------------------
DROP TABLE IF EXISTS `dealer`;
CREATE TABLE `dealer`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `state` int NOT NULL DEFAULT 0,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称 (查询)',
  `head_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名称(手机号) (查询)',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '运营商ID',
  `service_rate` double(4, 2) NOT NULL DEFAULT 0.00 COMMENT '分润比例',
  `market_count` int NOT NULL DEFAULT 0 COMMENT '绑定的二级市场数量',
  `supplier_goods_count` int NULL DEFAULT NULL COMMENT '供应商商品数量',
  `invite_channel_number` int NOT NULL DEFAULT 0 COMMENT '下级渠道商数量',
  `service_fee` int NOT NULL DEFAULT 0 COMMENT '分润收益',
  `goods_points` int NULL DEFAULT NULL COMMENT '提货积分',
  `level_up_progress` double NULL DEFAULT NULL COMMENT '升级进度',
  `order_amount` int NULL DEFAULT NULL COMMENT '自身的订单流水',
  `order_total_amount` int NULL DEFAULT NULL COMMENT '总订单流水',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_operator_id`(`operator_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '交易师' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for deliver
-- ----------------------------
DROP TABLE IF EXISTS `deliver`;
CREATE TABLE `deliver`  (
  `id` bigint NOT NULL COMMENT '主键',
  `spu_order_id` bigint NOT NULL COMMENT 'SPU订单号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deliver_username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货人账号',
  `express_company_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `express_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
  `item` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '发货明细',
  `express_mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货手机号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_spu_order_id`(`spu_order_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '发货单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for developer
-- ----------------------------
DROP TABLE IF EXISTS `developer`;
CREATE TABLE `developer`  (
  `id` bigint NOT NULL COMMENT 'appId、开发者ID',
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开发者名称',
  `secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开发者密钥',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号ID',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `app_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'appId',
  `notify_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '通知地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_uni_app_id`(`app_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户账号' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'value',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for earning_contribute
-- ----------------------------
DROP TABLE IF EXISTS `earning_contribute`;
CREATE TABLE `earning_contribute`  (
  `id` bigint NOT NULL,
  `account_id` bigint NOT NULL COMMENT '客户id',
  `account_type` int NOT NULL COMMENT '客户类型',
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户姓名',
  `parent_id` bigint NOT NULL COMMENT '上级id',
  `total_consume` int NOT NULL DEFAULT 0 COMMENT '总消费',
  `earning_contribute` int NOT NULL DEFAULT 0 COMMENT '分润贡献',
  `service_change_contribute` int NOT NULL DEFAULT 0 COMMENT '服务费贡献',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account_id`(`account_id` ASC, `account_type` ASC) USING BTREE,
  INDEX `parent_id`(`parent_id` ASC, `account_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '个人贡献表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for earning_record
-- ----------------------------
DROP TABLE IF EXISTS `earning_record`;
CREATE TABLE `earning_record`  (
  `id` bigint NOT NULL,
  `consume_type` int NOT NULL COMMENT '消费类型',
  `amount` int NOT NULL COMMENT '分润金额',
  `earning_type` int NOT NULL COMMENT '分润类型',
  `account_id` bigint NOT NULL COMMENT '客户id',
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户名称',
  `contribute_id` bigint NULL DEFAULT NULL COMMENT '贡献ID',
  `role` bigint NOT NULL COMMENT '分润角色',
  `join_order_no` bigint NOT NULL COMMENT '关联订单',
  `join_trade_no` bigint NOT NULL COMMENT '关联交易单',
  `goods_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品信息',
  `earning_time` timestamp NOT NULL COMMENT '分润时间',
  `state` int NOT NULL DEFAULT 0 COMMENT '分润状态 1:已分润',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `join_order_no`(`join_order_no` ASC) USING BTREE,
  INDEX `account_id`(`account_id` ASC, `consume_type` ASC, `role` ASC, `state` ASC) USING BTREE,
  INDEX `consume_type`(`consume_type` ASC, `earning_type` ASC, `state` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分润记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`  (
  `id` bigint NOT NULL,
  `account_id` bigint NOT NULL COMMENT '父账号ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账号',
  `type` int NOT NULL DEFAULT 1 COMMENT '类型 0 管理员 1 普通',
  `company_role_id` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni`(`account_id` ASC, `username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for execute_log
-- ----------------------------
DROP TABLE IF EXISTS `execute_log`;
CREATE TABLE `execute_log`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `type` int NULL DEFAULT NULL COMMENT '操作类型',
  `target_id` bigint NULL DEFAULT NULL COMMENT '操作主键',
  `execute_user_id` bigint NULL DEFAULT NULL COMMENT '操作人ID',
  `execute_user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人名称',
  `old_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '原数据',
  `update_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '改动数据',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_target_id`(`target_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for freight_template
-- ----------------------------
DROP TABLE IF EXISTS `freight_template`;
CREATE TABLE `freight_template`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称 查询',
  `free_post` int NOT NULL DEFAULT 0 COMMENT '是否包邮 0：不包邮  1：包邮',
  `pricing_manner` int NULL DEFAULT NULL COMMENT '计价方式 1:按件数 2:按重量 3:按体积',
  `is_free_post_condition` int NULL DEFAULT NULL COMMENT '是否指定条件包邮 0:否 1:是',
  `is_default` int NULL DEFAULT NULL COMMENT '是否默认模板',
  `free_post_condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '包邮条件',
  `region_spec` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '地区运费规则',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号ID 查询',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_account_id`(`account_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '运费模板' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for good_package
-- ----------------------------
DROP TABLE IF EXISTS `good_package`;
CREATE TABLE `good_package`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `package_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品套餐ID',
  `package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `goods_num` bigint NULL DEFAULT NULL COMMENT '商品席位',
  `package_price` int NULL DEFAULT NULL COMMENT '套餐价格',
  `package_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐描述',
  `state` int NULL DEFAULT NULL COMMENT '启用状态',
  `create_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for goods_zone
-- ----------------------------
DROP TABLE IF EXISTS `goods_zone`;
CREATE TABLE `goods_zone`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分组名称（字符上限50，匹配产品设计）',
  `group_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分组描述',
  `background_img` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '背景图',
  `sort_type` tinyint NULL DEFAULT NULL COMMENT '排序类型：1-默认排序 2-销量从高到低 3-上架时间倒序',
  `search_box_status` tinyint NULL DEFAULT 1 COMMENT '搜索框显示状态：0-不显示 1-显示',
  `price_show_status` tinyint NULL DEFAULT 1 COMMENT '价格显示状态：0-不显示 1-显示',
  `store_show_status` tinyint NULL DEFAULT 1 COMMENT '门店显示状态：0-不显示 1-显示',
  `goods_num` int NULL DEFAULT 0 COMMENT '商品数量',
  `state` tinyint NULL DEFAULT 1 COMMENT '分组状态：0-禁用 1-启用',
  `create_id` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间（继承BaseDO）',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（继承BaseDO）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_group_name`(`group_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品分组表（原专区表）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for goods_zone_goods_rel
-- ----------------------------
DROP TABLE IF EXISTS `goods_zone_goods_rel`;
CREATE TABLE `goods_zone_goods_rel`  (
  `id` bigint NOT NULL COMMENT '主键',
  `group_id` bigint NOT NULL COMMENT '分组ID',
  `spu_id` bigint NOT NULL COMMENT '商品ID',
  `spu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品名称快照',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关联创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '关联修改时间',
  `is_deleted` int NULL DEFAULT 0 COMMENT '逻辑删除 0-未删 1-已删',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品分组-商品关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for im_group_info
-- ----------------------------
DROP TABLE IF EXISTS `im_group_info`;
CREATE TABLE `im_group_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '群组唯一标识（IM官方GroupId，格式前缀@TGS#，App内唯一）',
  `group_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '群组类型（IM官方Type：Work/Public/Meeting/AVChatRoom/Community）',
  `group_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '群组名称（IM官方Name，最长100字节）',
  `introduction` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '群组简介（IM官方Introduction，最长400字节）',
  `notification` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '群组公告（IM官方Notification，最长400字节）',
  `face_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '群组头像URL（IM官方FaceUrl，最长500字节）',
  `owner_account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '群主ID（IM官方Owner_Account）',
  `owner_nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '群主昵称（业务侧扩展字段）',
  `group_create_time` datetime NOT NULL COMMENT '群组创建时间（IM官方CreateTime，UTC秒级时间戳转换后）',
  `last_info_time` datetime NULL DEFAULT NULL COMMENT '最后一次群资料变更时间（IM官方LastInfoTime，UTC秒级时间戳转换后）',
  `last_msg_time` datetime NULL DEFAULT NULL COMMENT '群内最后发消息时间（IM官方LastMsgTime，UTC秒级时间戳转换后）',
  `info_seq` int NOT NULL DEFAULT 0 COMMENT '群资料变更序列号（IM官方InfoSeq，每次变更自增）',
  `next_msg_seq` int NULL DEFAULT NULL COMMENT '群内下一条消息Seq（IM官方NextMsgSeq，连续递增）',
  `member_num` int NOT NULL DEFAULT 0 COMMENT '当前成员数量（IM官方MemberNum）',
  `max_member_num` int NULL DEFAULT NULL COMMENT '最大成员数量（IM官方MaxMemberNum，默认值为套餐包上限）',
  `status` int NOT NULL DEFAULT 1 COMMENT '群组业务状态（1 正常 2 解散）',
  `pull_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '从IM拉取数据的时间（每次同步/拉取时更新）',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除标记（0-未删除，1-已删除）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id` ASC) USING BTREE COMMENT '群组ID唯一索引（IM官方唯一标识）',
  INDEX `idx_group_type`(`group_type` ASC) USING BTREE COMMENT '群组类型索引（按类型筛选）',
  INDEX `idx_owner_account`(`owner_account` ASC) USING BTREE COMMENT '群主ID索引（按群主查询）',
  INDEX `idx_status`(`status` ASC) USING BTREE COMMENT '业务状态索引（1正常/2解散筛选）',
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE COMMENT '创建时间索引（按创建时间筛选）',
  INDEX `idx_pull_time`(`pull_time` ASC) USING BTREE COMMENT '拉取时间索引（便于筛选最新拉取的数据）'
) ENGINE = InnoDB AUTO_INCREMENT = 199 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '群组信息表（对齐腾讯IM官方群基础资料字段）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for industry
-- ----------------------------
DROP TABLE IF EXISTS `industry`;
CREATE TABLE `industry`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称 查询',
  `desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `category_id_list` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '分类ID集合',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_account_id`(`account_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '行业' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for lecturer
-- ----------------------------
DROP TABLE IF EXISTS `lecturer`;
CREATE TABLE `lecturer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `lecturer_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '讲师名称',
  `main_account` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主体账号',
  `main_account_id` bigint NOT NULL COMMENT '主体账号ID',
  `lecturer_category_id` bigint NOT NULL COMMENT '讲师分类ID',
  `lecturer_category_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '讲师分类名称',
  `course_count` int NULL DEFAULT 0 COMMENT '课程数量',
  `follow_count` int NULL DEFAULT 0 COMMENT '被关注人数（API累计值）',
  `personal_intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '个人简介（最多200字）',
  `cover_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '封面图URL',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像URL',
  `is_enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用：1-启用，0-禁用',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识：1-已删除，0-未删除（MyBatis-Plus自动处理）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除：1-已删除，0-未删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_main_account_id`(`main_account_id` ASC) USING BTREE COMMENT '主体账号ID唯一（关联值）',
  INDEX `idx_lecturer_category_id`(`lecturer_category_id` ASC) USING BTREE COMMENT '讲师分类ID索引（优化关联查询）'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '讲师表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for lecturer_category
-- ----------------------------
DROP TABLE IF EXISTS `lecturer_category`;
CREATE TABLE `lecturer_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID（自增主键）',
  `category_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称（最多10个字）',
  `icon_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标URL（存储图标文件路径）',
  `is_enabled` tinyint NOT NULL DEFAULT 1 COMMENT '是否启用：1=启用，0=禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE COMMENT '按创建时间排序的索引',
  INDEX `idx_is_enabled`(`is_enabled` ASC) USING BTREE COMMENT '按启用状态查询的索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '讲师分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for level
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE `level`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `type` int NOT NULL COMMENT '业务类型 0 甄选师',
  `enable` int NOT NULL COMMENT '是否开启',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级名称',
  `permission` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级权限',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `value` int NOT NULL COMMENT '等级值',
  `condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '升级条件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '等级' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for local_message
-- ----------------------------
DROP TABLE IF EXISTS `local_message`;
CREATE TABLE `local_message`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `send_state` int NULL DEFAULT NULL COMMENT '发送状态: 0 待发送 1 发送中 2 发送成功 3 发送失败',
  `consume_state` int NULL DEFAULT NULL COMMENT '消费状态 0 未消费 1 消费成功 2 消费失败',
  `tag` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'tag',
  `message_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '消息体',
  `message_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息体class路径',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `topic` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主题',
  `message_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息ID',
  `send_count` int NULL DEFAULT NULL COMMENT '发送次数',
  `can_send_time` timestamp NULL DEFAULT NULL COMMENT '可发送时间',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `can_consume` int NULL DEFAULT NULL COMMENT '可消费状态',
  `consume_time` timestamp NULL DEFAULT NULL COMMENT '消费时间',
  `consume_error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `consume_error_count` int NULL DEFAULT NULL,
  `out_key` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外部key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '本地消息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for market
-- ----------------------------
DROP TABLE IF EXISTS `market`;
CREATE TABLE `market`  (
  `id` bigint NOT NULL,
  `market_level` int NOT NULL COMMENT '市场等级  1：一级 2：二级',
  `market_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '市场名称',
  `market_logo` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '市场logo',
  `market_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市场简介',
  `category_id` bigint NOT NULL DEFAULT 0 COMMENT '分类id',
  `goods_num` int NOT NULL DEFAULT 0 COMMENT '商品数量',
  `sub_bind_num` int NOT NULL DEFAULT 0 COMMENT '下级推广人数量',
  `sell_num` int NOT NULL DEFAULT 0 COMMENT '商品总销量',
  `sell_amount` int NOT NULL DEFAULT 0 COMMENT '总销售额',
  `client_id` bigint NOT NULL COMMENT '客户id  0：平台  >0：客户',
  `create_user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `market_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `market_level`(`market_level` ASC, `client_id` ASC) USING BTREE,
  INDEX `create_time`(`create_time` DESC) USING BTREE,
  INDEX `goods_num`(`goods_num` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '市场' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for market_bind
-- ----------------------------
DROP TABLE IF EXISTS `market_bind`;
CREATE TABLE `market_bind`  (
  `id` bigint NOT NULL,
  `market_id` bigint NOT NULL COMMENT '市场id',
  `bind_type` int NOT NULL COMMENT '绑定类型  1：运营商  2：交易师  3:渠道商',
  `user_id` bigint NOT NULL COMMENT '客户id',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户名称',
  `state` int NOT NULL DEFAULT 1 COMMENT '状态  0：删除  1：正常',
  `debind_time` timestamp NULL DEFAULT NULL COMMENT '解除绑定时间',
  `create_time` timestamp NOT NULL COMMENT '绑定时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `market_id`(`market_id` ASC, `bind_type` ASC, `user_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `create_time`(`create_time` DESC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '市场绑定' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for market_goods_relation
-- ----------------------------
DROP TABLE IF EXISTS `market_goods_relation`;
CREATE TABLE `market_goods_relation`  (
  `id` bigint NOT NULL,
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `market_id` bigint NOT NULL COMMENT '市场id',
  `relation_type` int NOT NULL COMMENT '关系类型：  1：一级市场商品  2：二级市场商品  3：市场选品商品',
  `user_id` bigint NOT NULL COMMENT '用户id   0：为平台   >0:为客户',
  `sell_num` int NOT NULL DEFAULT 0 COMMENT '销量',
  `sell_amount` int NOT NULL DEFAULT 0 COMMENT '销售额',
  `discount_rate` int NULL DEFAULT NULL COMMENT '让利比例',
  `state` int NOT NULL DEFAULT 1 COMMENT '状态  1：正常  0：删除',
  `de_bind_time` timestamp NULL DEFAULT NULL COMMENT '解绑时间',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `goods_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品信息',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC, `market_id` ASC, `goods_id` ASC, `relation_type` ASC) USING BTREE,
  INDEX `market_id`(`user_id` ASC, `relation_type` ASC, `market_id` ASC) USING BTREE,
  INDEX `market_id_2`(`market_id` ASC) USING BTREE,
  INDEX `relation_type`(`goods_id` ASC, `market_id` ASC, `relation_type` ASC, `state` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '市场商品关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` bigint NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `head` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `wx_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信ID',
  `count_deal_number` int NOT NULL DEFAULT 0 COMMENT '统计：成交笔数',
  `count_deal_amount` int NOT NULL DEFAULT 0 COMMENT '统计：成交金额',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `merchant_id` bigint NULL DEFAULT NULL,
  `open_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` int NULL DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `residence_province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '常住地-省份',
  `residence_city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '常住地-城市',
  `residence_district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '常住地-区县',
  `channel_id` bigint NULL DEFAULT NULL COMMENT '渠道商ID',
  `id_card` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `im_sync_status` int NOT NULL DEFAULT 0 COMMENT 'IM同步状态（0-未同步，1-已同步，2-同步失败）',
  `im_sync_error_msg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IM同步错误信息（同步失败时记录）',
  `account_id` bigint NULL DEFAULT NULL COMMENT 'account表主键 账号ID',
  `user_account` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账号(tencent用)',
  `state` int NULL DEFAULT 0 COMMENT '帐号状态（0正常 1停用）',
  `pid` bigint NULL DEFAULT NULL COMMENT '父id account.id',
  `background_img` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '背景图',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'c端客户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for member_task_record
-- ----------------------------
DROP TABLE IF EXISTS `member_task_record`;
CREATE TABLE `member_task_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `member_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会员ID',
  `member_nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员昵称',
  `task_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务编号（关联task_info表）',
  `task_config_id` bigint NOT NULL COMMENT '任务配置ID（关联任务配置表）',
  `task_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `task_type` tinyint NOT NULL COMMENT '任务类型：1-观看激励广告，2-购买商品',
  `task_status` tinyint NOT NULL COMMENT '任务状态：1-待完成，2-已完成，3-完成失败',
  `complete_condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '完成条件',
  `task_progress` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务进度',
  `count` int NULL DEFAULT 0 COMMENT '人数、金额等',
  `red_packet_reward` bigint NULL DEFAULT NULL COMMENT '红包奖励（单位：0.0001元，如1元存储为10000）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_task_num`(`task_num` ASC) USING BTREE,
  INDEX `idx_task_config_id`(`task_config_id` ASC) USING BTREE,
  INDEX `idx_member_id`(`member_id` ASC) USING BTREE,
  INDEX `idx_time_type_status`(`create_time` ASC, `task_type` ASC, `task_status` ASC) USING BTREE,
  INDEX `idx_member_task_del`(`member_id` ASC, `task_num` ASC, `is_delete` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员任务记录表（关联任务信息/任务配置/会员表）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for model_shop
-- ----------------------------
DROP TABLE IF EXISTS `model_shop`;
CREATE TABLE `model_shop`  (
  `id` bigint NOT NULL,
  `channel_id` bigint NOT NULL COMMENT '渠道商id',
  `model_shop_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样板店名称',
  `model_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样板店描述',
  `model_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'logo',
  `version_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1.0' COMMENT '版本号',
  `version_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '版本描述',
  `parent_model` bigint NOT NULL DEFAULT 0 COMMENT '父级样板店',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '运营商id',
  `version_num` int NOT NULL DEFAULT 0 COMMENT '版本数',
  `earning_config` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分润配置',
  `channel_earning` int NOT NULL DEFAULT 0 COMMENT '渠道商收益',
  `total_earning` int NOT NULL DEFAULT 0 COMMENT '总收益',
  `audit_state` int NOT NULL DEFAULT 1 COMMENT '审核状态',
  `audit_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核信息',
  `condition_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint NOT NULL COMMENT '创建人id',
  `create_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人名',
  `use_store_num` int NOT NULL DEFAULT 0 COMMENT '使用门店数',
  `style_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '样式code',
  `total_use_store_num` int NOT NULL DEFAULT 0 COMMENT '累计使用门店数',
  `total_order_amount` int NOT NULL DEFAULT 0 COMMENT '累计下单金额',
  `total_order_num` int NOT NULL DEFAULT 0 COMMENT '累计下单数',
  `total_pay_amount` int NOT NULL DEFAULT 0 COMMENT '累计支付金额',
  `total_pay_num` int NOT NULL DEFAULT 0 COMMENT '累计支付订单数',
  `is_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除',
  `state` int NOT NULL DEFAULT 1 COMMENT '状态：0 禁用,1 启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `channel_id`(`channel_id` ASC) USING BTREE,
  INDEX `operator_id`(`operator_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '样板店' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for model_shop_order_record
-- ----------------------------
DROP TABLE IF EXISTS `model_shop_order_record`;
CREATE TABLE `model_shop_order_record`  (
  `id` bigint NOT NULL COMMENT '主键',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `model_shop_id` bigint NULL DEFAULT NULL COMMENT '样板店ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单类型：ORDER 下单，PAY 支付',
  `amount` int NOT NULL DEFAULT 0 COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '样板店订单记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for model_shop_use_record
-- ----------------------------
DROP TABLE IF EXISTS `model_shop_use_record`;
CREATE TABLE `model_shop_use_record`  (
  `id` bigint NOT NULL COMMENT '主键',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `model_shop_id` bigint NULL DEFAULT NULL COMMENT '样板店ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '样板店使用记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for operator
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称 (查询)',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录名称(手机号) (查询)',
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色ID',
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `dealer_number` int NOT NULL DEFAULT 0 COMMENT '交易师数量',
  `one_market_number` int NOT NULL DEFAULT 0 COMMENT '一级市场数量',
  `two_market_number` int NOT NULL DEFAULT 0 COMMENT '二级市场数量',
  `invite_channel_number` int NOT NULL DEFAULT 0 COMMENT '邀请渠道商数量',
  `supplier_goods_count` int NULL DEFAULT NULL COMMENT '供应商商品数量',
  `order_amount` int NULL DEFAULT NULL COMMENT '自身的订单流水',
  `order_total_amount` int NULL DEFAULT NULL COMMENT '总订单流水',
  `service_fee_config_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '服务费配置',
  `service_amount` int NOT NULL DEFAULT 0 COMMENT '服务费',
  `proxy_province_code` int NULL DEFAULT NULL,
  `proxy_city_code` int NULL DEFAULT NULL,
  `proxy_area_code` int NULL DEFAULT NULL,
  `proxy_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `balance_type` int NOT NULL DEFAULT 0,
  `leverage_ratio` int NOT NULL DEFAULT 0,
  `info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `goods_points` int NULL DEFAULT NULL COMMENT '提货积分',
  `level_up_progress` double NULL DEFAULT NULL COMMENT '升级进度',
  `type` int NOT NULL DEFAULT 0 COMMENT '运营类型 0 机构 1 行业 2 区域',
  `type_foreign_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '行业id,区域地址编码 | (多选,拼接)',
  `type_foreign_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '行业名称 / 区域地址',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '运营商' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint NOT NULL COMMENT '交易单ID',
  `order_state` int NOT NULL COMMENT ' (0, \"新订单\"),(2,\"待付款\"),(4, \"派发中\"),(12,\"已完成\")',
  `order_type` int NOT NULL COMMENT '订单类型',
  `out_order_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '外部订单号',
  `ship_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货信息值对象',
  `goods_amount` int NOT NULL COMMENT '选品商品金额',
  `freight_amount` int NOT NULL COMMENT '运费金额',
  `custom_freight_amount` int NULL DEFAULT NULL COMMENT '自营运费',
  `discount_amount` int NOT NULL COMMENT '优惠金额',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `channel_id` bigint NOT NULL COMMENT '渠道商ID 查询',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '订单备注',
  `total_amount` int NOT NULL COMMENT '渠道商订单总金额',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `order_state_log` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单流转日志',
  `order_snap_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '订单其他快照信息',
  `store_id` bigint NULL DEFAULT NULL COMMENT '门店ID',
  `member_id` bigint NULL DEFAULT NULL COMMENT 'C端ID',
  `supplier_amount` int NOT NULL DEFAULT 0 COMMENT '供货商品金额',
  `store_amount` int NOT NULL DEFAULT 0 COMMENT '铺货商品金额',
  `member_amount` int NOT NULL DEFAULT 0 COMMENT 'C端订单总金额',
  `operator_id` bigint NULL DEFAULT NULL COMMENT 'operatorId',
  `pay_type` int NULL DEFAULT NULL COMMENT '支付方式 0 直接',
  `pay_flow` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付流水',
  `service_amount` int NOT NULL DEFAULT 0,
  `out_order_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外部供应链订单ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT 'account表主键 账号ID',
  `buy_mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '购买方式:ACTIVATE 激活,SELF_BUYING 自购',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账号',
  `benefitTripartiteId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收益三方账号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `out_order_no`(`out_order_no` ASC) USING BTREE,
  INDEX `channel_id`(`channel_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '交易单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_state_record
-- ----------------------------
DROP TABLE IF EXISTS `order_state_record`;
CREATE TABLE `order_state_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint NOT NULL COMMENT '订单主键ID（关联订单表）',
  `spu_order_id` bigint NULL DEFAULT NULL COMMENT 'SPU订单ID（关联SPU订单表）',
  `sku_order_id` bigint NULL DEFAULT NULL COMMENT 'SKU订单ID（关联SKU订单表）',
  `before_order_state` int NULL DEFAULT NULL COMMENT '变更前订单状态',
  `before_state_desc` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '变更前订单状态描述',
  `after_order_state` int NULL DEFAULT NULL COMMENT '变更后订单状态',
  `after_state_desc` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '变更后订单状态描述',
  `orderer_id` bigint NULL DEFAULT NULL COMMENT '下单人ID（关联用户表，匿名订单可为null）',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作人ID（关联用户表；系统自动操作时为null）',
  `operator_role_id` bigint NOT NULL COMMENT '操作人角色ID（对应角色枚举code：如1000=C端客户，1001=供应商，1002=渠道商，0=平台，-1=系统）',
  `role_desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色描述（如：C端客户、系统、平台管理员）',
  `operate_time` timestamp NOT NULL COMMENT '操作时间（订单状态变更的实际时间）',
  `ext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '拓展字段（JSON格式存储额外信息：如操作备注、客户端类型、操作IP等）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_order_id_state`(`order_id` ASC) USING BTREE,
  INDEX `idx_operate_time`(`operate_time` ASC) USING BTREE,
  INDEX `idx_operator_role_id`(`operator_role_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 836196911726918 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单状态记录表（记录订单全生命周期的状态变更）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pack_goods
-- ----------------------------
DROP TABLE IF EXISTS `pack_goods`;
CREATE TABLE `pack_goods`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `type` int NULL DEFAULT NULL COMMENT '礼包类型',
  `level` int NULL DEFAULT NULL COMMENT '礼包等级',
  `amount` int NULL DEFAULT NULL COMMENT '礼包价格',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片',
  `desc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '简介',
  `state` int NULL DEFAULT 0 COMMENT '状态 0 下架 1 上架',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '礼包商品' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pack_order
-- ----------------------------
DROP TABLE IF EXISTS `pack_order`;
CREATE TABLE `pack_order`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `ship_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '收货信息',
  `amount` int NOT NULL COMMENT '订单金额',
  `freight_company` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司',
  `freight_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
  `pack_order_item_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '订单明细; 结构: List<PackGoodsVO>',
  `deliver_time` timestamp NULL DEFAULT NULL COMMENT '发货时间',
  `state` int NOT NULL DEFAULT 0 COMMENT '订单状态 查询 (0,新订单),(2,待支付),(4,待发货),(6,已发货),(8,已收货),(10,已完成),(-1,已关闭)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `last_freight_api_use_time` timestamp NULL DEFAULT NULL COMMENT '上次物流API调用时间',
  `account_id` bigint NOT NULL COMMENT '下单账号id',
  `pack_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `pack_level` int NOT NULL COMMENT '礼包等级',
  `pack_type` int NULL DEFAULT NULL COMMENT '礼包类型',
  `level_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '礼包名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '礼包订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `trade_no` bigint NOT NULL COMMENT '交易单号',
  `order_no` bigint NOT NULL COMMENT '订单号',
  `account_id` bigint NOT NULL COMMENT '客户id',
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户名称',
  `pay_amount` int NOT NULL COMMENT '支付金额',
  `goods_amount` int NOT NULL COMMENT '商品金额',
  `consume_type` int NOT NULL COMMENT '消费类型',
  `pay_state` int NOT NULL DEFAULT 0 COMMENT '支付状态',
  `tripartite_trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三方交易单号',
  `order_info` json NULL,
  `payee_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '收款方信息',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`trade_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '简介',
  `province` int NOT NULL COMMENT '省',
  `city` int NOT NULL COMMENT '市',
  `area` int NULL DEFAULT NULL COMMENT '区',
  `basic_amount` int NOT NULL COMMENT '合作金额',
  `flags` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详情',
  `interest_num` int NULL DEFAULT 0 COMMENT '意向人数',
  `interest_person` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '意向人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 773049892430342 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '项目' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for project_video
-- ----------------------------
DROP TABLE IF EXISTS `project_video`;
CREATE TABLE `project_video`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint NOT NULL COMMENT '项目id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '视频地址',
  `index` int NOT NULL COMMENT '顺序',
  `extra` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '视频额外信息',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 773049892512263 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '项目视频' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for promise_flow
-- ----------------------------
DROP TABLE IF EXISTS `promise_flow`;
CREATE TABLE `promise_flow`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号ID (查询)',
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色ID',
  `promise_pay_type` int NULL DEFAULT NULL COMMENT '保证金类型（0首次/1补缴/2缓缴）',
  `amount` int NULL DEFAULT NULL COMMENT '金额',
  `pay_type` int NULL DEFAULT NULL COMMENT '支付方式',
  `certificate_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付凭证',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '保证金流水' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for purchase_record
-- ----------------------------
DROP TABLE IF EXISTS `purchase_record`;
CREATE TABLE `purchase_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `purchase_no` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '购买单号',
  `type` int NOT NULL COMMENT '购买类型',
  `trade_no` bigint NOT NULL COMMENT '交易单号',
  `order_no` bigint NOT NULL COMMENT '订单号',
  `account_id` bigint NOT NULL COMMENT '客户id',
  `account_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户名称',
  `pay_amount` int NOT NULL COMMENT '支付金额',
  `goods_amount` int NOT NULL COMMENT '商品金额',
  `pay_type` int NOT NULL COMMENT '支付方式',
  `pay_state` int NOT NULL COMMENT '支付状态',
  `tripartite_trade_no` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '三方交易单号',
  `order_info` json NOT NULL COMMENT '订单信息',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 772745287303558 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购买记录 #pay' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for refund
-- ----------------------------
DROP TABLE IF EXISTS `refund`;
CREATE TABLE `refund`  (
  `id` bigint NOT NULL COMMENT '主键',
  `refund_state` int NOT NULL COMMENT '售后单状态 (0,\"渠道商待审核\"),(2,\"供应商待审核\"),(4,\"退货中\"),(6,\"退货完成\"),,(10,\"已完成\"),(-2,\"已拒绝\"),(-4,\"已关闭\")',
  `refund_type` int NOT NULL COMMENT '售后类型 0仅退款 1退货退款',
  `order_type` int NULL DEFAULT NULL COMMENT '订单类型',
  `spu_channel_type` int NOT NULL COMMENT '商品渠道类型',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `supplier_id` bigint NOT NULL,
  `channel_id` bigint NOT NULL,
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `spu_order_id` bigint NOT NULL COMMENT 'SPU订单ID',
  `freight_amount` int NOT NULL COMMENT '售后运费金额',
  `refund_amount` int NOT NULL COMMENT '售后金额',
  `supplier_amount` int NOT NULL COMMENT '铺货商品金额',
  `goods_amount` int NOT NULL DEFAULT 0 COMMENT '选品商品金额',
  `store_amount` int NOT NULL DEFAULT 0 COMMENT '铺货商品金额',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '售后原因',
  `remark` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '申请说明',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '申请图片',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `freight_company_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `freight_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
  `take_delivery_state` int NULL DEFAULT NULL COMMENT '收货状态',
  `pay_state` int NULL DEFAULT NULL COMMENT '退款状态',
  `audit_time` timestamp NULL DEFAULT NULL COMMENT '审核完成时间',
  `refund_time` timestamp NULL DEFAULT NULL COMMENT '售后完成时间',
  `from_state` int NULL DEFAULT NULL,
  `item` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '售后明细',
  `from_order_state` int NULL DEFAULT 0,
  `refund_state_log` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `member_id` bigint NULL DEFAULT NULL COMMENT 'C端ID',
  `merchant_id` bigint NULL DEFAULT NULL COMMENT '商户ID',
  `store_id` bigint NULL DEFAULT NULL COMMENT '门店ID',
  `refuse_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '拒绝原因',
  `out_refund_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `state_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `freight_ext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '退货货流信息拓展',
  `store_auto_time` datetime NULL DEFAULT NULL COMMENT '商家自动确认截止时间',
  `receive_address` json NULL COMMENT '收货地址',
  `service_amount` int NOT NULL DEFAULT 0 COMMENT '渠道商服务费',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `actable_idx_spu_order_id`(`spu_order_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '售后单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for refund_operation_record
-- ----------------------------
DROP TABLE IF EXISTS `refund_operation_record`;
CREATE TABLE `refund_operation_record`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `spu_order_id` bigint NULL DEFAULT NULL COMMENT 'spu订单id',
  `refund_id` bigint NOT NULL COMMENT '售后单refund表的主键',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作人ID',
  `operator_role_code` bigint NOT NULL COMMENT '操作方角色编码（对应RoleEnum.CompanyRole的code：1000=C端客户，1001=供应商，1002=渠道商，0=平台等）',
  `operator_client` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作方客户端类型（对应CommonEnum.Client的code：user=用户端，supplier=供应商端，channel=渠道商端，admin=平台端等）',
  `operator_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作方名称',
  `before_state` int NULL DEFAULT NULL COMMENT '操作前售后单状态',
  `after_state` int NOT NULL COMMENT '操作后售后单状态',
  `operation_type` int NULL DEFAULT NULL COMMENT '操作类型（0=发起退款申请，1=审核通过，2=审核拒绝，3=提交物流信息，4=确认收货，5=退款完成，6=关闭售后，7=平台介入）',
  `operation_content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作内容描述',
  `refund_amount` int NULL DEFAULT NULL COMMENT '本次操作涉及的退款金额',
  `freight_company_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `freight_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作原因/备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `ext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '拓展字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_refund_operation_record_refund_id`(`refund_id` ASC) USING BTREE,
  INDEX `idx_refund_operation_record_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_refund_operation_record_operator_role_code`(`operator_role_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '售后操作记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '路径',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '报告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for report_category_relation
-- ----------------------------
DROP TABLE IF EXISTS `report_category_relation`;
CREATE TABLE `report_category_relation`  (
  `report_id` bigint NOT NULL COMMENT '报告ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  PRIMARY KEY (`report_id`, `category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '报告-分类关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for report_spu_relation
-- ----------------------------
DROP TABLE IF EXISTS `report_spu_relation`;
CREATE TABLE `report_spu_relation`  (
  `report_id` bigint NOT NULL COMMENT '报告ID',
  `spu_id` bigint NOT NULL COMMENT '商品ID',
  PRIMARY KEY (`report_id`, `spu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '报告-商品关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for seat_package
-- ----------------------------
DROP TABLE IF EXISTS `seat_package`;
CREATE TABLE `seat_package`  (
  `id` bigint NOT NULL COMMENT '主键',
  `seat_package_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '席位套餐code',
  `seat_package_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '席位套餐名称',
  `seat_num` int NOT NULL DEFAULT 0 COMMENT '席位个数',
  `package_price` int NOT NULL DEFAULT 0 COMMENT '套餐价格',
  `package_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `state` int NOT NULL DEFAULT 1 COMMENT '状态：0 禁用,1 启用',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '状态：0 正常,1 已删除',
  `create_id` bigint NOT NULL COMMENT '创建人id',
  `create_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '席位套餐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for selector
-- ----------------------------
DROP TABLE IF EXISTS `selector`;
CREATE TABLE `selector`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `state` int NOT NULL DEFAULT 0,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称 (查询)',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名称(手机号) (查询)',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `invite_id` bigint NULL DEFAULT NULL COMMENT '上级甄选师ID',
  `level` int NOT NULL DEFAULT 0 COMMENT '等级',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `team_count` int NOT NULL DEFAULT 0 COMMENT '团队人数:累加',
  `yesterday_invite` int NULL DEFAULT 0 COMMENT '昨日邀请人数:定时写',
  `today_invite` int NULL DEFAULT 0 COMMENT '今日邀请人数:定时写',
  `week_invite` int NULL DEFAULT 0 COMMENT '7日邀请人数:定时写',
  `month_invite` int NULL DEFAULT 0 COMMENT '30日邀请人数:定时写',
  `head_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `team_supplier_count` int NOT NULL DEFAULT 0 COMMENT '团队供应商人数:累加',
  `team_selector_count` int NOT NULL DEFAULT 0 COMMENT '团队甄选师人数:累加',
  `to_month_invite` int NULL DEFAULT 0 COMMENT '月邀请人数:定时写',
  `order_amount` int NULL DEFAULT NULL COMMENT '自身的订单流水',
  `order_total_amount` int NULL DEFAULT NULL COMMENT '总订单流水',
  `goods_points` int NULL DEFAULT NULL COMMENT '提货积分',
  `level_up_progress` double NULL DEFAULT NULL COMMENT '升级进度',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '甄选师' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for settle_goods
-- ----------------------------
DROP TABLE IF EXISTS `settle_goods`;
CREATE TABLE `settle_goods`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `supplier_id` bigint NOT NULL COMMENT '供应商ID',
  `spu_id` bigint NOT NULL COMMENT 'SPU_ID',
  `next_settle_time` timestamp NOT NULL COMMENT '下次结算时间',
  `settle_num` int NOT NULL DEFAULT 0 COMMENT '结算次数',
  `settle_money` int NOT NULL DEFAULT 0 COMMENT '结算金额',
  `settle_goods_num` int NOT NULL DEFAULT 0 COMMENT '结算商品数量',
  `up_num` int NOT NULL DEFAULT 0 COMMENT '账期修改次数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique`(`supplier_id` ASC, `spu_id` ASC) USING BTREE,
  INDEX `actable_idx_next_settle_time`(`next_settle_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '结算商品信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for settle_order_wait
-- ----------------------------
DROP TABLE IF EXISTS `settle_order_wait`;
CREATE TABLE `settle_order_wait`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `supplier_id` bigint NOT NULL COMMENT '供应商ID',
  `spu_order_id` bigint NOT NULL COMMENT 'spu订单ID',
  `sku_order_id` bigint NULL DEFAULT NULL COMMENT 'sku订单ID',
  `type` int NOT NULL COMMENT '0 商品 1运费',
  `order_money` int NOT NULL COMMENT '结算金额',
  `spu_id` bigint NULL DEFAULT NULL COMMENT 'SPU_ID',
  `sku_id` bigint NULL DEFAULT NULL COMMENT 'SKU_ID',
  `sku_count` int NULL DEFAULT NULL COMMENT 'sku数量',
  `settle_state` int NULL DEFAULT NULL COMMENT '结算状态',
  `settle_time` timestamp NULL DEFAULT NULL COMMENT '结算时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `refund_state` int NULL DEFAULT NULL,
  `refund_id` bigint NULL DEFAULT NULL,
  `settle_record_id` bigint NULL DEFAULT NULL,
  `settle_time_node` bigint NULL DEFAULT 0 COMMENT '结算时间节点',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_supplier_id`(`supplier_id` ASC) USING BTREE,
  INDEX `sku_order_id`(`sku_order_id` ASC) USING BTREE,
  INDEX `spu_order_id`(`spu_order_id` ASC) USING BTREE,
  INDEX `actable_idx_spu_id`(`spu_id` ASC, `settle_time_node` ASC) USING BTREE,
  INDEX `settle_time_node`(`settle_time_node` ASC, `settle_state` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '待结算订单信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for settle_record
-- ----------------------------
DROP TABLE IF EXISTS `settle_record`;
CREATE TABLE `settle_record`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商ID',
  `settle_time` timestamp NULL DEFAULT NULL COMMENT '结算时间(版本号)',
  `settle_money` int NULL DEFAULT NULL COMMENT '结算金额',
  `settle_goods_num` int NULL DEFAULT NULL COMMENT '结算商品数量',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `goods_amount` int NULL DEFAULT NULL,
  `freight_amount` int NULL DEFAULT NULL,
  `refund_amount` int NULL DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_supplier_id`(`supplier_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '结算记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for settle_record_item
-- ----------------------------
DROP TABLE IF EXISTS `settle_record_item`;
CREATE TABLE `settle_record_item`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `settle_record_id` bigint NULL DEFAULT NULL COMMENT '结算记录ID',
  `type` int NULL DEFAULT NULL COMMENT '类型 0商品 1运费',
  `spu_order_id` bigint NULL DEFAULT NULL COMMENT 'SPU_订单ID',
  `spu_id` bigint NULL DEFAULT NULL COMMENT 'SPU_ID',
  `spu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu名称',
  `spu_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu图片',
  `sku_settle_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'sku订单结算信息',
  `settle_money` int NULL DEFAULT NULL COMMENT '结算金额',
  `settle_goods_num` int NULL DEFAULT NULL COMMENT '结算商品数量',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `spu_freight` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_settle_record_id`(`settle_record_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '结算记录明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ship_address
-- ----------------------------
DROP TABLE IF EXISTS `ship_address`;
CREATE TABLE `ship_address`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `ship_area` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地区，例如:辽宁省,沈阳市,铁西区,XXX镇（三级与四级地址均可下单）',
  `ship_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货联系人姓名',
  `ship_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地址，如创业路东',
  `ship_phone` bigint NULL DEFAULT NULL COMMENT '联系方式',
  `ship_zip_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货邮编',
  `ship_province_code` int NULL DEFAULT NULL COMMENT '收货地址编码，省CODE, 6位',
  `ship_city_code` int NULL DEFAULT NULL COMMENT '收货地址编码，市CODE, 6位',
  `ship_area_code` int NULL DEFAULT NULL COMMENT '收货地址编码，区CODE, 6位',
  `is_default` int NULL DEFAULT NULL COMMENT '是否默认',
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色类型Id 查询',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `account_id` bigint NULL DEFAULT NULL COMMENT '账号ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收货地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for short_video
-- ----------------------------
DROP TABLE IF EXISTS `short_video`;
CREATE TABLE `short_video`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '视频路径',
  `cover_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面路径',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '短视频表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku`  (
  `id` bigint NOT NULL COMMENT 'ID (查询)',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `bar_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '条形码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `weight` double(8, 2) NULL DEFAULT 0.00 COMMENT '重量(千克)',
  `volume` double(8, 2) NULL DEFAULT 0.00 COMMENT '体积(m3)',
  `spu_id` bigint NOT NULL COMMENT 'spuId (查询)',
  `market_price` int NULL DEFAULT 0 COMMENT '市场价',
  `supply_price` int NOT NULL DEFAULT 0 COMMENT '供货价',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `inventory` int NULL DEFAULT NULL COMMENT '库存',
  `inventory_warning` int NULL DEFAULT NULL COMMENT '库存预警个数',
  `sale_attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品销售属性，json格式',
  `sale_price` int NULL DEFAULT 0 COMMENT '销售价',
  `out_sku_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'skuId',
  `sale_price_rate` float(5, 2) NOT NULL DEFAULT 0.00 COMMENT '加价比例',
  `buy_start_qty` int NULL DEFAULT 0 COMMENT '起购数量',
  `unit_price` int NOT NULL DEFAULT 0 COMMENT '冗余: 推荐零售价(to c)',
  `expand` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '拓展',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_spu_id`(`spu_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'sku' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sku_order
-- ----------------------------
DROP TABLE IF EXISTS `sku_order`;
CREATE TABLE `sku_order`  (
  `id` bigint NOT NULL COMMENT '订单ID',
  `order_state` int NOT NULL COMMENT '订单状态 (0,新订单),(2,待支付),(4,待发货),(5,发货中),(6,已发货),(8,已收货),(10,已完成),(-1,已关闭)',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `spu_order_id` bigint NOT NULL COMMENT 'SPU订单ID',
  `sku_id` bigint NOT NULL COMMENT 'SKU_ID',
  `goods_amount` int NOT NULL DEFAULT 0 COMMENT '商品金额',
  `freight_amount` int NOT NULL DEFAULT 0 COMMENT '运费金额',
  `discount_amount` int NOT NULL DEFAULT 0 COMMENT '优惠金额',
  `supplier_amount` int NOT NULL DEFAULT 0 COMMENT '货款金额',
  `store_amount` int NULL DEFAULT NULL COMMENT '铺货金额',
  `dealer_id` bigint NULL DEFAULT NULL COMMENT '交易师ID',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '运营商ID',
  `supplier_id` bigint NOT NULL COMMENT '供应商ID',
  `settlement_config_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '结算配置',
  `spu_id` bigint NOT NULL COMMENT 'SPU_ID',
  `count` int NOT NULL DEFAULT 0 COMMENT '购买数量',
  `sku_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'sku图片',
  `sku_sale_attribute` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'sku销售属性',
  `spu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu名称',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'sku名称',
  `sku_weight` double(4, 2) NULL DEFAULT NULL COMMENT 'sku重量(千克)',
  `sku_volume` double(4, 2) NULL DEFAULT NULL COMMENT 'sku体积(m3)',
  `sku_supplier_price` int NULL DEFAULT NULL COMMENT 'sku供货价',
  `sku_sale_price` int NULL DEFAULT NULL COMMENT 'sku销售价',
  `deliver_count` int NOT NULL DEFAULT 0 COMMENT '发货数量',
  `refunding_count` int NOT NULL DEFAULT 0 COMMENT '售后中数量',
  `refunded_count` int NOT NULL DEFAULT 0 COMMENT '已售后数量',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `order_state_log` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态流转记录',
  `delivered_time` timestamp NULL DEFAULT NULL COMMENT '发货完成时间',
  `receive_time` timestamp NULL DEFAULT NULL COMMENT '确认收货时间',
  `total_service_change` int NOT NULL DEFAULT 0 COMMENT '总服务费',
  `operator_service_change` int NOT NULL DEFAULT 0 COMMENT '运营商服务费',
  `operator_real_ratio` double(4, 2) NULL DEFAULT 0.00,
  `settle_send_state` int NOT NULL DEFAULT 0 COMMENT '结算发送状态',
  `sku_store_price` int NOT NULL DEFAULT 0 COMMENT 'sku采购价',
  `out_sku_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `settle_order_type` int NULL DEFAULT NULL,
  `member_id` bigint NULL DEFAULT NULL COMMENT '下单人id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  INDEX `spu_order_id`(`spu_order_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'SKU订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for spu
-- ----------------------------
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu`  (
  `id` bigint NOT NULL COMMENT 'ID (查询)',
  `deal_num` int NOT NULL DEFAULT 0 COMMENT '成交数量',
  `sale_num` int NOT NULL DEFAULT 0 COMMENT '总销量',
  `refund_num` int NOT NULL DEFAULT 0 COMMENT '售后数量',
  `selection_num` int NOT NULL DEFAULT 0 COMMENT '选品数量',
  `supplier_sale_amount` int NOT NULL DEFAULT 0,
  `channel_sale_amount` int NOT NULL DEFAULT 0 COMMENT '渠道商销售额',
  `admin_sale_amount` int NOT NULL DEFAULT 0 COMMENT '平台销售额',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称 (查询)',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题 (查询)',
  `scroll_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '轮播图',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '视频',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '详情',
  `goods_type` int NULL DEFAULT NULL COMMENT '商品类型 0:实物商品 1:课程 2:服务 (查询)',
  `account_id` bigint NOT NULL COMMENT '账号ID (查询)',
  `category_id` bigint NOT NULL COMMENT '所属平台分类 (查询)',
  `category_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '冗余: 所属平台分类名称完整',
  `brand_id` bigint NULL DEFAULT NULL COMMENT '品牌id (查询)',
  `brand_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '冗余: 品牌名称',
  `freight_template_id` bigint NULL DEFAULT NULL COMMENT '运费模板id (查询)',
  `deliver_time_type` int NULL DEFAULT NULL COMMENT '发货时效类型 0 三日内 1 大于三日 (查询)',
  `max_deliver_day` int NULL DEFAULT NULL COMMENT '最大发货天数',
  `state` int NOT NULL COMMENT '状态 0:仓库中 2:上架中 3:待上架 (查询)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编码 (查询)',
  `account_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '冗余: 账号名称',
  `market_price` int NOT NULL DEFAULT 0 COMMENT '冗余: 市场价',
  `supply_price` int NOT NULL DEFAULT 0 COMMENT '冗余: 供货价',
  `inventory` int NULL DEFAULT 0 COMMENT '冗余: 库存',
  `supplier_price_began` int NOT NULL DEFAULT 0 COMMENT '冗余: 供货价起始',
  `supplier_price_end` int NOT NULL DEFAULT 0 COMMENT '冗余: 供货价结束',
  `sale_price_began` int NULL DEFAULT 0 COMMENT '冗余: 销售价起始',
  `sale_price_end` int NULL DEFAULT 0 COMMENT '冗余: 销售价结束',
  `audit_state` int NULL DEFAULT NULL COMMENT '冗余:审批状态 (0,\"待用户提交\";1,\"待审核\";2,\"通过\",3,\"未通过\",4,\"终止\"',
  `last_refuse_reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '最后拒绝原因: 状态变更未待用户提交前的最后一次拒绝原因',
  `flow_id` bigint NULL DEFAULT NULL COMMENT '审批流ID (查询)',
  `channel_type` int NOT NULL COMMENT '渠道类型 0 供货商品 1 自营商品',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `max_profit` int NOT NULL DEFAULT 0,
  `market_price_began` int NOT NULL DEFAULT 0,
  `market_price_end` int NOT NULL DEFAULT 0,
  `out_spu_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `out_state` int NULL DEFAULT 0,
  `limit_area` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '销售区域ID(区域级) 如： [111,222，333]',
  `sale_price` int NOT NULL DEFAULT 0 COMMENT '冗余: 销售价(to channel)',
  `unit_price` int NOT NULL DEFAULT 0 COMMENT '冗余: 推荐零售价(to c)',
  `spec_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格类型:single 单，multiple 多',
  `min_pricing_num` double(8, 2) NULL DEFAULT NULL COMMENT '最小计价数',
  `virtual_sale_num` int NOT NULL DEFAULT 0 COMMENT '虚拟销量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `actable_idx_account_id`(`account_id` ASC) USING BTREE,
  INDEX `actable_idx_brand_id`(`brand_id` ASC) USING BTREE,
  INDEX `sale_price_began`(`sale_price_began` ASC) USING BTREE,
  INDEX `audit_state`(`audit_state` ASC, `create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'spu' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for spu_attribute
-- ----------------------------
DROP TABLE IF EXISTS `spu_attribute`;
CREATE TABLE `spu_attribute`  (
  `id` bigint NOT NULL COMMENT 'ID (查询)',
  `spu_id` bigint NULL DEFAULT NULL COMMENT 'spuId (查询)',
  `type` int NULL DEFAULT NULL COMMENT '类型 0:销售属性 1:参数属性 (查询)',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '手动添加规格或参数的值，参数单值',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'spu属性' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for spu_order
-- ----------------------------
DROP TABLE IF EXISTS `spu_order`;
CREATE TABLE `spu_order`  (
  `id` bigint NOT NULL COMMENT '订单ID',
  `order_state` int NOT NULL COMMENT '订单状态 (0,新订单),(2,待支付),(4,待发货),(5,发货中),(6,已发货),(8,已收货),(10,已完成),(-1,已关闭)',
  `order_type` int NOT NULL COMMENT '订单类型',
  `spu_channel_type` int NULL DEFAULT NULL,
  `out_order_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外部订单号',
  `goods_type` int NULL DEFAULT NULL COMMENT '商品类型',
  `sku_count` int NULL DEFAULT NULL COMMENT 'SKU总数',
  `channel_id` bigint NOT NULL,
  `supplier_id` bigint NOT NULL,
  `dealer_id` bigint NULL DEFAULT 0,
  `operator_id` bigint NULL DEFAULT 0,
  `spu_id` bigint NOT NULL,
  `spu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `spu_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_amount` int NOT NULL DEFAULT 0 COMMENT '商品金额',
  `store_amount` int NOT NULL DEFAULT 0 COMMENT '铺货金额',
  `freight_amount` int NOT NULL DEFAULT 0 COMMENT '运费金额',
  `discount_amount` int NOT NULL DEFAULT 0 COMMENT '优惠金额',
  `member_amount` int NULL DEFAULT 0 COMMENT 'c端支付金额',
  `supplier_amount` int NOT NULL DEFAULT 0 COMMENT '货款金额',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `ship_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '收货信息',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单备注',
  `order_state_log` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单状态流转日志,逗号隔开',
  `settle_send_state` int NOT NULL DEFAULT 0 COMMENT '运费结算发送状态',
  `store_id` bigint NULL DEFAULT NULL,
  `member_id` bigint NULL DEFAULT NULL,
  `merchant_id` bigint NULL DEFAULT NULL COMMENT '商户ID',
  `delivered_time` timestamp NULL DEFAULT NULL COMMENT '发货完成时间',
  `receive_time` timestamp NULL DEFAULT NULL COMMENT '确认收货时间',
  `close_time` timestamp NULL DEFAULT NULL COMMENT '关闭时间',
  `refunding_count` int NOT NULL DEFAULT 0 COMMENT '售后中数量',
  `service_amount` int NOT NULL DEFAULT 0,
  `ship_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `account_id` bigint NULL DEFAULT NULL COMMENT 'account表主键 账号ID',
  `store_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '门店名称',
  `store_head` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '门店头像',
  `spu_order_ext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '拓展信息',
  `refund` int NULL DEFAULT 0 COMMENT '是否发生售后 0 - 未发生 1 - 已经发生',
  `benefit_tripartite_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收益三方账号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `out_order_no`(`out_order_no` ASC) USING BTREE,
  INDEX `channel_id`(`channel_id` ASC) USING BTREE,
  INDEX `supplier_id`(`supplier_id` ASC) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'SPU订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '门店名称',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `longitude` double(16, 10) NULL DEFAULT NULL COMMENT '经度',
  `latitude` double(16, 10) NULL DEFAULT NULL COMMENT '纬度',
  `channel_id` bigint NOT NULL COMMENT '渠道商ID',
  `merchant_id` bigint NULL DEFAULT NULL COMMENT '商户ID',
  `manager_id` bigint NULL DEFAULT NULL COMMENT '管理员ID',
  `refund_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '售后地址',
  `selection_number` int NOT NULL DEFAULT 0 COMMENT '选品数量',
  `custom_number` int NOT NULL DEFAULT 0 COMMENT '自营商品数量',
  `dealer_number` int NOT NULL DEFAULT 0 COMMENT '成交笔数',
  `dealer_amount` int NOT NULL DEFAULT 0 COMMENT '成交金额',
  `is_model_shop` int NOT NULL DEFAULT 0 COMMENT '是否是样板店',
  `template_id` bigint NULL DEFAULT NULL COMMENT '模板ID',
  `model_shop_id` bigint NULL DEFAULT NULL COMMENT '样板店ID',
  `custom_count` int NULL DEFAULT 0 COMMENT '客户总数',
  `style_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '样式code',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `type` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_account
-- ----------------------------
DROP TABLE IF EXISTS `store_account`;
CREATE TABLE `store_account`  (
  `id` bigint NOT NULL COMMENT '主键',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `account_id` bigint NOT NULL COMMENT '客户id',
  `channel_id` bigint NOT NULL COMMENT '渠道商ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `count_pay_number` int NOT NULL DEFAULT 0 COMMENT '统计：支付笔数',
  `count_pay_amount` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付金额：元',
  `last_pay_time` timestamp NULL DEFAULT NULL COMMENT '最后支付时间',
  `last_pay_amount` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后支付金额：元',
  `relation_type` int NOT NULL DEFAULT 0 COMMENT '0:未拉黑，1已拉黑',
  `count_visit_number` int NOT NULL DEFAULT 0 COMMENT '进店总数',
  `last_view_time` timestamp NULL DEFAULT NULL COMMENT '最后进店时间',
  `defult` tinyint(1) NULL DEFAULT 0 COMMENT '是否默认：1 是',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_store_account`(`store_id` ASC, `account_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店客户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_category
-- ----------------------------
DROP TABLE IF EXISTS `store_category`;
CREATE TABLE `store_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '门店名称',
  `logo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图标',
  `index` int NOT NULL COMMENT '排序',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 773047494365318 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店分类 #store' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_distribution
-- ----------------------------
DROP TABLE IF EXISTS `store_distribution`;
CREATE TABLE `store_distribution`  (
  `id` bigint NOT NULL,
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `sku_id` bigint NOT NULL COMMENT 'skuId',
  `market_id` bigint NOT NULL COMMENT '市场id 0：自营  >0：市场id',
  `data_type` int NOT NULL COMMENT '数据类型 0：商品  1：sku',
  `sell_price` int NOT NULL COMMENT '销售价',
  `sell_num` int NOT NULL DEFAULT 0 COMMENT '销量',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `goods_state` int NOT NULL COMMENT '商品状态 1:下架  0：上架  -1：平台下架',
  `channel_id` bigint NOT NULL COMMENT '渠道商id',
  `del_state` int NOT NULL DEFAULT 0 COMMENT '删除状态 1为删除',
  `create_time` timestamp NOT NULL,
  `supplier_price` int NOT NULL DEFAULT 0 COMMENT '供货价',
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源',
  `unit_price` int NOT NULL DEFAULT 0 COMMENT '冗余: 推荐零售价(to c)',
  `goods_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品信息',
  `need_update` int NOT NULL DEFAULT 1 COMMENT '是否需要更新：0需要，1不需要',
  `up_time` timestamp NULL DEFAULT NULL COMMENT '上架时间',
  `recommendation_time` timestamp NULL DEFAULT NULL COMMENT '推荐时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `channel_id`(`channel_id` ASC, `store_id` ASC, `data_type` ASC, `del_state` ASC, `goods_state` ASC, `goods_id` ASC) USING BTREE,
  INDEX `channel_id_3`(`channel_id` ASC, `store_id` ASC, `goods_id` ASC) USING BTREE,
  INDEX `channel_id_2`(`channel_id` ASC, `store_id` ASC, `sku_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '铺货列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_style
-- ----------------------------
DROP TABLE IF EXISTS `store_style`;
CREATE TABLE `store_style`  (
  `id` bigint NOT NULL COMMENT '主键',
  `style_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '样式code',
  `style_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '样式名称',
  `essential_colour` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主色',
  `auxiliary_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '辅色',
  `use_store_num` int NOT NULL DEFAULT 0 COMMENT '使用门店数',
  `package_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `type` int NOT NULL DEFAULT 0 COMMENT '类型：1 默认',
  `state` int NOT NULL DEFAULT 1 COMMENT '状态：0 禁用,1 启用',
  `page_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'HOME_PAGE' COMMENT '页面类型：HOME_PAGE首页',
  `source_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源模板样式code',
  `source_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源模板样式名称',
  `style_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '样式内容',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '状态：0 正常,1 已删除',
  `create_id` bigint NOT NULL COMMENT '创建人id',
  `create_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mender_id` bigint NULL DEFAULT NULL COMMENT '修改人id',
  `mender_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改人名',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `goods_id_list_str` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品id集合',
  `preview_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预览图',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店样式表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_target_interaction_stat
-- ----------------------------
DROP TABLE IF EXISTS `store_target_interaction_stat`;
CREATE TABLE `store_target_interaction_stat`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `store_id` bigint NULL DEFAULT NULL COMMENT '门店ID（关联门店表主键）',
  `publisher_id` bigint NULL DEFAULT NULL COMMENT '被统计对象发布者ID（视频/商品的发布者，关联用户表）',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '被统计对象类型：PRODUCT（商品）、VIDEO（视频）',
  `target_id` bigint NOT NULL COMMENT '被统计对象ID（商品ID或视频ID）',
  `view_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量（默认0，非负）',
  `like_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞量（默认0，非负）',
  `share_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '转发量（默认0，非负）',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计记录创建时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '统计记录更新时间',
  `ext_json` json NULL COMMENT '扩展字段（JSON格式，如收藏量）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_store_target`(`target_type` ASC, `target_id` ASC) USING BTREE,
  INDEX `idx_store_target_type`(`store_id` ASC, `target_type` ASC) USING BTREE,
  INDEX `idx_target_type_id`(`target_type` ASC, `target_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店-商品/视频互动统计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_zone
-- ----------------------------
DROP TABLE IF EXISTS `store_zone`;
CREATE TABLE `store_zone`  (
  `id` bigint NOT NULL COMMENT '主键',
  `zone_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专区code',
  `zone_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专区名称',
  `zone_subtitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专区副标题',
  `goods_num` int NOT NULL DEFAULT 0 COMMENT '商品个数',
  `order_num` int NOT NULL DEFAULT 0 COMMENT '订单个数',
  `zone_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `state` int NOT NULL DEFAULT 1 COMMENT '状态：0 禁用,1 启用',
  `create_id` bigint NOT NULL COMMENT '创建人id',
  `create_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人名',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店专区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_zone_background_image
-- ----------------------------
DROP TABLE IF EXISTS `store_zone_background_image`;
CREATE TABLE `store_zone_background_image`  (
  `id` bigint NOT NULL COMMENT '主键',
  `zone_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专区code',
  `background_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片链接',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '状态：0 正常,1 已删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店专区背景图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for store_zone_goods_relation
-- ----------------------------
DROP TABLE IF EXISTS `store_zone_goods_relation`;
CREATE TABLE `store_zone_goods_relation`  (
  `id` bigint NOT NULL COMMENT '主键',
  `zone_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专区code',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `store_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '门店名称',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '状态：0 正常,1 已删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店专区商品关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for strategy
-- ----------------------------
DROP TABLE IF EXISTS `strategy`;
CREATE TABLE `strategy`  (
  `strategy_id` bigint NOT NULL COMMENT '策略id',
  `strategy_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '策略描述',
  `strategy_mode` int NOT NULL DEFAULT 0 COMMENT '策略方式 0：会员等级等总体占比  1：暂未其他',
  `grant_type` int NOT NULL DEFAULT 1 COMMENT '发放奖品方式「1:即时、2:定时、3:人工',
  `grant_date` bigint NULL DEFAULT NULL COMMENT '发放奖品时间',
  `ext_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扩展信息',
  `order_amounts_rate` int NULL DEFAULT NULL COMMENT '订单金额比例',
  `dividend_cycle` enum('WEEKLY','MONTHLY') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'MONTHLY' COMMENT '分红周期：周结算（WEEKLY）,月结算（MONTHLY）',
  `settlement_strategy` enum('CYCLE','ONCE') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'CYCLE' COMMENT '结算策略：周期循环（CYCLE）,单次结算后关闭（ONCE）',
  `dividend_method` enum('AVERAGE','WEIGHT') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'WEIGHT' COMMENT '分红方式：平均分红（AVERAGE），加权分红（WEIGHT）',
  `dividend_role` json NULL COMMENT '分红角色',
  `dividend_user` json NULL COMMENT '分红人',
  `creator` bigint NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`strategy_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '策略配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for strategy_detail
-- ----------------------------
DROP TABLE IF EXISTS `strategy_detail`;
CREATE TABLE `strategy_detail`  (
  `id` bigint NOT NULL COMMENT 'id',
  `strategy_id` bigint NOT NULL COMMENT '策略ID',
  `award_id` bigint NOT NULL COMMENT '奖品ID 0表示现金，不限量',
  `award_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖品名称',
  `award_count` int NOT NULL COMMENT '奖品库存',
  `award_surplus_count` int NOT NULL COMMENT '奖品剩余库存',
  `strategy_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '策略内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '策略详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `id` bigint NOT NULL COMMENT 'ID (查询)',
  `invite_id` bigint NULL DEFAULT NULL COMMENT '邀请人ID',
  `industry_id_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '行业ID集合',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `state` int NOT NULL COMMENT '状态 (查询)',
  `body_type` int NULL DEFAULT NULL COMMENT '主体类型 (查询)',
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账号名称 (查询)',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供应商名称 (查询)',
  `deposit` int NOT NULL DEFAULT 0 COMMENT '保证金',
  `max_sku_num` int NOT NULL DEFAULT 0 COMMENT '最大商品数',
  `audit_state` int NULL DEFAULT NULL COMMENT '审批状态 (查询) (0,\"待用户提交\";1,\"待审核\";2,\"通过\",3,\"未通过\")',
  `company_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '企业信息',
  `promise_pay_state` int NULL DEFAULT NULL COMMENT '是否缴纳保证金 (查询)',
  `promise_pay_amount` int NULL DEFAULT NULL COMMENT '保证金金额',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `promise_pay_audit_state` int NOT NULL COMMENT '保证金审批状态 (0,\"待用户提交\";1,\"待审核\";2,\"通过\",3,\"未通过\")',
  `period_set_state` int NULL DEFAULT NULL COMMENT '是否设置账期 (查询)',
  `period_set_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '账期配置JSON',
  `should_promise_pay_amount` int NULL DEFAULT NULL COMMENT '应付保证金金额',
  `promise_pay_config` int NULL DEFAULT NULL COMMENT '保证金缴纳方式配置',
  `audit_refuse_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审批拒绝原因',
  `goods_total_count` int NOT NULL DEFAULT 0 COMMENT '商品总数',
  `goods_on_sale_count` int NOT NULL DEFAULT 0 COMMENT '售卖中的商品',
  `goods_sale_amount` int NOT NULL DEFAULT 0 COMMENT '总金额',
  `goods_sale_count` int NOT NULL DEFAULT 0 COMMENT '总销量',
  `goods_deal_count` int NOT NULL DEFAULT 0 COMMENT '总成交销量',
  `goods_not_sale_count` int NOT NULL DEFAULT 0 COMMENT '待售卖的商品',
  `service_fee_config_v_o` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '服务费配置',
  `receive_address` json NULL COMMENT '收货地址',
  `in_time` timestamp NULL DEFAULT NULL COMMENT '入驻时间',
  `total_order_number` int NOT NULL DEFAULT 0,
  `total_refund_number` int NOT NULL DEFAULT 0,
  `total_order_amount` int NOT NULL DEFAULT 0,
  `total_refund_amount` int NOT NULL DEFAULT 0,
  `company_area_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '企业区域编码',
  `month_goods_sale_amount` int NOT NULL DEFAULT 0 COMMENT '月度销售额',
  `month_goods_sale_count` int NOT NULL DEFAULT 0 COMMENT '月度销量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '供应商' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `config_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置键（唯一标识，如\"system.title\"）',
  `config_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置分组（如\"system\"、\"security\"）',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '配置值（支持长文本，如JSON字符串）',
  `config_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '配置类型（如\"string\"、\"number\"、\"json\"）',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '配置描述',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用（1-启用，0-禁用）',
  `env` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '环境标识（如\"dev\"、\"test\"、\"prod\"）',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动更新）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_config_key_env`(`config_key` ASC, `env` ASC) USING BTREE COMMENT '按配置键+环境查询，确保环境内键唯一',
  INDEX `idx_config_group_env`(`config_group` ASC, `env` ASC) USING BTREE COMMENT '按配置分组+环境查询',
  INDEX `idx_enabled_env`(`enabled` ASC, `env` ASC) USING BTREE COMMENT '按启用状态+环境查询'
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统配置表（存储多环境的配置项）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_id_generator
-- ----------------------------
DROP TABLE IF EXISTS `sys_id_generator`;
CREATE TABLE `sys_id_generator`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `generator_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计数器标识（如\"user_id\"表示用户ID生成器）',
  `current_value` bigint NOT NULL DEFAULT 0 COMMENT '当前计数器值',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_generator_key`(`generator_key` ASC) USING BTREE COMMENT '确保计数器标识唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'ID生成器计数器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `user_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户类型',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户昵称',
  `head_img` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `role_id_list` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色列表',
  `real_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '真实姓名',
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '身份证号',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态（0-禁用，1-启用，查询常用条件）',
  `im_sync_status` tinyint NULL DEFAULT 0 COMMENT 'IM同步状态（0-未同步，1-已同步，2-同步失败）',
  `im_sync_error_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'IM同步错误信息（同步失败时记录）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_account`(`user_account` ASC) USING BTREE COMMENT '用户账号唯一',
  INDEX `idx_im_sync_status`(`im_sync_status` ASC) USING BTREE,
  INDEX `idx_status_phone`(`status` ASC, `phone` ASC) USING BTREE,
  INDEX `idx_status_user_account`(`status` ASC, `user_account` ASC) USING BTREE,
  INDEX `idx_user_type`(`user_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 865 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for task_config
-- ----------------------------
DROP TABLE IF EXISTS `task_config`;
CREATE TABLE `task_config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `task_type` int NOT NULL COMMENT '任务类型',
  `task_type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务类型名称',
  `task_group` int NOT NULL COMMENT '任务分组',
  `task_group_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务分组名称',
  `task_count` int NOT NULL DEFAULT 0 COMMENT '任务数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_enabled` tinyint NOT NULL DEFAULT 1 COMMENT '是否启用（1-是，0-否）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注信息（可选扩展）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_type_group`(`task_type` ASC, `task_group` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for task_info
-- ----------------------------
DROP TABLE IF EXISTS `task_info`;
CREATE TABLE `task_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `task_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务编号（如rw00001）',
  `task_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `task_id` bigint NOT NULL COMMENT '任务配置id',
  `task_type` int NOT NULL COMMENT '任务类型',
  `task_type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务类型名称',
  `start_time` datetime NOT NULL COMMENT '任务开始时间',
  `end_time` datetime NOT NULL COMMENT '任务结束时间',
  `task_intro` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务简介（最多200字）',
  `ad_count` int NULL DEFAULT 0 COMMENT '完整观看广告数（仅观看激励广告类型有效）',
  `goods_list` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品id',
  `complete_count` int NOT NULL DEFAULT 0 COMMENT '完成人数',
  `is_show` tinyint NOT NULL DEFAULT 1 COMMENT '是否显示：1-是，0-否',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除标记（0-未删除，1-已删除）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_task_id`(`task_num` ASC) USING BTREE,
  INDEX `idx_task_name`(`task_name` ASC) USING BTREE,
  INDEX `idx_type_is_show`(`task_type` ASC, `is_show` ASC) USING BTREE,
  INDEX `idx_time_range`(`start_time` ASC, `end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for third_party_order_request
-- ----------------------------
DROP TABLE IF EXISTS `third_party_order_request`;
CREATE TABLE `third_party_order_request`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平台类型(枚举值: YYT/HUI_DING_HUO等)',
  `biz_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务订单号(系统内部订单号)',
  `third_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第三方订单号(外部平台返回)',
  `interface_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接口名称(如: createOrder)',
  `request_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求参数(JSON字符串)',
  `response_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '响应结果(JSON字符串)',
  `request_status` tinyint NULL DEFAULT NULL COMMENT '请求状态(0:失败 1:成功 2:处理中)',
  `error_message` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '错误信息',
  `retry_count` tinyint NULL DEFAULT 0 COMMENT '重试次数',
  `next_retry_time` datetime NULL DEFAULT NULL COMMENT '下次重试时间',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_biz_order_no`(`biz_order_no` ASC) USING BTREE,
  INDEX `idx_platform_status_retry`(`platform_type` ASC, `request_status` ASC, `next_retry_time` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 300 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '第三方订单请求记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'increment id',
  `branch_id` bigint NOT NULL COMMENT 'branch transaction id',
  `xid` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'global transaction id',
  `context` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'undo_log context,such as serialization',
  `rollback_info` longblob NOT NULL COMMENT 'rollback info',
  `log_status` int NOT NULL COMMENT '0:normal status,1:defense status',
  `log_created` datetime NOT NULL COMMENT 'create datetime',
  `log_modified` datetime NOT NULL COMMENT 'modify datetime',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ux_undo_log`(`xid` ASC, `branch_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15290 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'AT transaction mode undo table' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_collection
-- ----------------------------
DROP TABLE IF EXISTS `user_collection`;
CREATE TABLE `user_collection`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID（关联用户表主键）',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名称（收藏时快照）',
  `store_id` bigint NULL DEFAULT NULL COMMENT '门店ID',
  `store_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '门店名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品价格（收藏时快照，单位：元）',
  `main_image` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品主图URL（收藏时快照）',
  `is_valid` tinyint NULL DEFAULT 1 COMMENT '是否有效：0-无效（商品下架等），1-有效',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除（逻辑删除）',
  `collection_time` datetime NULL DEFAULT NULL COMMENT '收藏时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `store_distribution_id` bigint NULL DEFAULT NULL COMMENT '铺货表ID',
  `spu_id` bigint NULL DEFAULT NULL COMMENT 'SPU ID',
  `spu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'SPU名称',
  `sku_id` bigint NULL DEFAULT NULL COMMENT 'SKU ID',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'SKU名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_product`(`user_id` ASC, `store_id` ASC) USING BTREE COMMENT '唯一索引：防止用户重复收藏同一商品',
  INDEX `idx_user_status`(`user_id` ASC, `store_id` ASC, `is_deleted` ASC, `is_valid` ASC) USING BTREE COMMENT '联合索引：优化用户收藏列表查询',
  INDEX `idx_collection_time`(`collection_time` ASC) USING BTREE COMMENT '索引：支持按收藏时间排序'
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'C端用户商品收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `follower_id` bigint NOT NULL COMMENT '关注者ID',
  `following_id` bigint NOT NULL COMMENT '被关注者ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户关注关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_interaction
-- ----------------------------
DROP TABLE IF EXISTS `user_interaction`;
CREATE TABLE `user_interaction`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '操作人ID（关联用户表）',
  `publisher_id` bigint NULL DEFAULT NULL COMMENT '被操作对象发布者ID（视频/商品的发布者，关联用户表）',
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '被操作对象类型：VIDEO（视频）、PRODUCT（商品）',
  `target_id` bigint NOT NULL COMMENT '被操作对象ID（视频ID或商品ID）',
  `action_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型：LIKE（点赞）、SHARE（转发）',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '状态更新时间',
  `store_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_target_action`(`user_id` ASC, `target_type` ASC, `target_id` ASC, `action_type` ASC) USING BTREE COMMENT '唯一约束：同一用户对同一对象的同一有效操作',
  INDEX `idx_user_action_status`(`user_id` ASC, `action_type` ASC) USING BTREE COMMENT '查询用户的操作记录',
  INDEX `idx_target_action_status`(`target_type` ASC, `target_id` ASC, `action_type` ASC) USING BTREE COMMENT '统计对象的操作数'
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户互动操作表（存储点赞、转发记录）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_invitation
-- ----------------------------
DROP TABLE IF EXISTS `user_invitation`;
CREATE TABLE `user_invitation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '被邀请用户ID（关联user表的主键）',
  `inviter_id` bigint NOT NULL COMMENT '邀请人ID（关联user表的主键）',
  `invitation_source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '邀请来源',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效（1-有效，0-无效）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE COMMENT '被邀请用户ID唯一（一个用户只能被一个人邀请）',
  INDEX `idx_inviter_id`(`inviter_id` ASC) USING BTREE COMMENT '邀请人ID索引（用于查询某用户邀请的所有人）'
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户邀请注册记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_lecturer_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_lecturer_follow`;
CREATE TABLE `user_lecturer_follow`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID（关联用户表主键）',
  `lecturer_id` bigint NOT NULL COMMENT '讲师ID（关联lecturer表id）',
  `follow_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除标识：1-已删除（取消关注），0-未删除（已关注）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人（系统/用户账号）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人（系统/用户账号）',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID索引（查询用户关注的所有讲师）',
  INDEX `idx_lecturer_id`(`lecturer_id` ASC) USING BTREE COMMENT '讲师ID索引（查询讲师的所有关注用户）',
  INDEX `idx_follow_time`(`follow_time` ASC) USING BTREE COMMENT '关注时间索引（按时间筛选关注记录）'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户关注讲师表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_task
-- ----------------------------
DROP TABLE IF EXISTS `user_task`;
CREATE TABLE `user_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` bigint NOT NULL COMMENT '用户id',
  `type` int NOT NULL COMMENT '任务类型',
  `seq` int NOT NULL COMMENT '序号',
  `ratio` int NOT NULL COMMENT '比例',
  `count` bigint NOT NULL COMMENT '完成次数',
  `foreign_id` bigint NOT NULL COMMENT '外键ID',
  `status` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户任务' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '视频名称',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator_id` bigint NOT NULL COMMENT '创建人ID',
  `creator_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人姓名',
  `shares_num` int NOT NULL DEFAULT 0 COMMENT '分享次数',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '视频地址',
  `video_cover_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '视频封面地址',
  `issuer_id` bigint NOT NULL COMMENT '发布人id',
  `issuer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布人名',
  `is_visible` tinyint NOT NULL DEFAULT 1 COMMENT '是否显示：0-不显示，1-显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 819823260074502 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '视频表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for video_category
-- ----------------------------
DROP TABLE IF EXISTS `video_category`;
CREATE TABLE `video_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序值（小于100）',
  `video_count` int NOT NULL DEFAULT 0 COMMENT '视频数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用：0-禁用，1-启用',
  `recommend_groups` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '推荐人群（多个用逗号分隔）',
  `weight` int NOT NULL DEFAULT 0 COMMENT '权重值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '视频分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for video_spu_relation
-- ----------------------------
DROP TABLE IF EXISTS `video_spu_relation`;
CREATE TABLE `video_spu_relation`  (
  `video_id` bigint NOT NULL COMMENT '视频Id',
  `spu_id` bigint NOT NULL COMMENT '商品Id',
  `type` tinyint NOT NULL COMMENT '视频类型 1 短视频 2 长视频',
  PRIMARY KEY (`video_id`, `spu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '视频商品关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for video_task_spu_relation
-- ----------------------------
DROP TABLE IF EXISTS `video_task_spu_relation`;
CREATE TABLE `video_task_spu_relation`  (
  `task_id` bigint NOT NULL COMMENT '任务Id',
  `spu_id` bigint NOT NULL COMMENT '商品Id',
  `type` tinyint NOT NULL COMMENT '视频类型 1 素人协同任务 2 达人创作任务',
  PRIMARY KEY (`task_id`, `spu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '视频任务商品关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for worker_video_task
-- ----------------------------
DROP TABLE IF EXISTS `worker_video_task`;
CREATE TABLE `worker_video_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务描述',
  `rate_type` tinyint NOT NULL COMMENT '佣金收取类型 1 按比例 2 按金额',
  `rate` decimal(10, 2) NOT NULL COMMENT '佣金',
  `demand_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '需求描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '视频任务表 - 素人' ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
