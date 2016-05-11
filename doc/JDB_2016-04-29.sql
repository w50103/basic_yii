# ************************************************************
# Sequel Pro SQL dump
# Version 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 119.254.111.25 (MySQL 5.6.23-log)
# Database: JDB
# Generation Time: 2016-04-29 07:12:30 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table credit_info
# ------------------------------------------------------------

CREATE TABLE `credit_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `uuid` varchar(36) NOT NULL COMMENT 'Primary Key（jdk）',
  `entry_uuid` varchar(36) NOT NULL COMMENT '用户id',
  `user_name` varchar(36) NOT NULL COMMENT '持卡人姓名',
  `pay_id` varchar(32) NOT NULL COMMENT '本张信用卡对应支付系统的ID',
  `credit_card_no` varchar(32) NOT NULL COMMENT '信用卡卡号',
  `credit_card_tag` varchar(30) NOT NULL COMMENT '信用卡银行标签',
  `alert_date` tinyint(2) NOT NULL COMMENT '还款时间',
  `alert_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '提醒状态 0不提醒 1提醒',
  `credit_card_no_md5` varchar(32) NOT NULL COMMENT '信用卡卡号的md5值',
  `enable` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否可用 0:不可用 1:可用',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信用卡表';



# Dump of table credit_repay
# ------------------------------------------------------------

CREATE TABLE `credit_repay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `uuid` varchar(24) NOT NULL COMMENT '还款ID,交易系统生成',
  `entry_uuid` varchar(24) NOT NULL COMMENT '用户uuid',
  `credit_uuid` varchar(45) DEFAULT NULL COMMENT '信用卡id,参照credit_info表uuid',
  `credit_bank_tag` varchar(30) NOT NULL COMMENT '信用卡银行标签',
  `pay_id` varchar(36) NOT NULL COMMENT '本条还款记录对应支付系统的ID',
  `status` tinyint(2) NOT NULL COMMENT '还款状态 0:交易成功, 1:银行处理中, 2:还款成功, 3:还款失败',
  `repay_type` tinyint(2) NOT NULL COMMENT '还款类型 0:余额还款,  1:银行卡还款 ',
  `bank_card_no` varchar(32) DEFAULT '' COMMENT '如果是银行卡还款,银行卡卡号',
  `amount` varchar(50) NOT NULL COMMENT '还款总额',
  `commit_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '提交时间',
  `bank_processing_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '银行处理时间',
  `finish_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '完成时间',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_uuid` (`uuid`),
  KEY `index_entry_uuid` (`entry_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信用卡还款表';



# Dump of table credit_visit
# ------------------------------------------------------------

CREATE TABLE `credit_visit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applyId` varchar(32) DEFAULT NULL,
  `custType` varchar(8) DEFAULT NULL,
  `custCertType` varchar(8) DEFAULT NULL,
  `custCertCode` varchar(32) DEFAULT NULL,
  `visit_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table entry_device
# ------------------------------------------------------------

CREATE TABLE `entry_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `entry_device_no` varchar(36) NOT NULL COMMENT '登入态NO',
  `entry_no` varchar(36) NOT NULL COMMENT '用户No',
  `status` tinyint(2) NOT NULL COMMENT '0 登入,1 登出',
  `device_udid` varchar(50) NOT NULL COMMENT '设备标识符',
  `device_type` varchar(50) NOT NULL DEFAULT '' COMMENT '设备类型',
  `platform` varchar(20) NOT NULL DEFAULT '' COMMENT '系统类型',
  `sys_version` varchar(10) NOT NULL DEFAULT '' COMMENT '系统版本',
  `app_channel` varchar(50) NOT NULL DEFAULT '' COMMENT '客户端获取渠道',
  `client_version` varchar(10) NOT NULL DEFAULT '' COMMENT '客户端版本',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '时间',
  `last_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_entry_no_device_udid` (`entry_no`,`device_udid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户设备';



# Dump of table entry_imgs_info
# ------------------------------------------------------------

CREATE TABLE `entry_imgs_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entryUuid` varchar(36) NOT NULL COMMENT '户用ID',
  `url` varchar(100) NOT NULL COMMENT '访问URL',
  `remark` varchar(20) NOT NULL COMMENT '备注',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `status` tinyint(2) DEFAULT '1' COMMENT '图片审核状态',
  PRIMARY KEY (`id`),
  KEY `index_entryUuid` (`entryUuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户上传图片';



# Dump of table entry_payee
# ------------------------------------------------------------

CREATE TABLE `entry_payee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `uuid` varchar(24) NOT NULL COMMENT 'uuid',
  `entry_uuid` varchar(24) NOT NULL COMMENT '用户uuid',
  `payee_name` varchar(36) NOT NULL COMMENT '收款人姓名',
  `payee_bank_no` varchar(24) NOT NULL COMMENT '银行缩写',
  `payee_card_hash` varchar(64) NOT NULL COMMENT '银行卡号sha-1 hash值',
  `payee_card_mask_number` varchar(24) NOT NULL COMMENT '银行卡号码掩码,只保存卡号后4位',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '收款人状态 1正常、99已删除',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_uuid` (`uuid`),
  KEY `index_entry_uuid` (`entry_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户的收款人表';



# Dump of table excess_counter_fee
# ------------------------------------------------------------

CREATE TABLE `excess_counter_fee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `uuid` varchar(36) NOT NULL COMMENT 'Primary Key（jdk）',
  `entry_uuid` varchar(24) NOT NULL COMMENT '用户ID',
  `tf_uuid` varchar(36) NOT NULL COMMENT '用户',
  `link_uuid` varchar(36) NOT NULL COMMENT '链条ID',
  `laundry_uuid` varchar(36) NOT NULL COMMENT '流水ID',
  `amount` varchar(20) NOT NULL COMMENT '需要支付手续费的金额',
  `rate` varchar(20) NOT NULL COMMENT '利率',
  `counter_fee` varchar(20) NOT NULL COMMENT '手续费',
  `pay_id` varchar(30) NOT NULL COMMENT '支付系统ID',
  `status` int(10) unsigned NOT NULL COMMENT '状态位，用于扩展，32位，可以表示4294967295',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_uuid` (`uuid`),
  KEY `index_entry_uuid` (`entry_uuid`),
  KEY `index_tf_uuid` (`tf_uuid`),
  KEY `index_laundry_uuid` (`laundry_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='超额手续费';



# Dump of table friend_circle
# ------------------------------------------------------------

CREATE TABLE `friend_circle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `UUID` varchar(36) NOT NULL COMMENT 'JDK自动生成',
  `entryUuid` varchar(36) NOT NULL COMMENT '用户ID',
  `friendCircleName` varchar(36) NOT NULL COMMENT '朋友圈名称',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `loseTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '失效时间',
  `validateFlag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '否是失效',
  PRIMARY KEY (`id`),
  KEY `index_UUID` (`UUID`),
  KEY `index_entryUuid` (`entryUuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='朋友圈关系表';



# Dump of table friend_circle_detail
# ------------------------------------------------------------

CREATE TABLE `friend_circle_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `UUID` varchar(36) NOT NULL COMMENT 'UUID',
  `friendCircleUuid` varchar(36) DEFAULT NULL COMMENT '朋友圈ID',
  `entryUuid` varchar(36) DEFAULT NULL COMMENT '用户ID',
  `friendCircleInfo` varchar(255) DEFAULT NULL COMMENT '朋友圈详细说明',
  `insertTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '入库时间',
  `loseTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '失效时间',
  `validateFlag` tinyint(2) NOT NULL COMMENT '否是失效',
  PRIMARY KEY (`id`),
  KEY `index_UUID` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='朋友圈表';



# Dump of table friend_tag_bak
# ------------------------------------------------------------

CREATE TABLE `friend_tag_bak` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `uuid` varchar(36) NOT NULL COMMENT 'Primary Key（jdk）',
  `entry_uuid` varchar(24) NOT NULL COMMENT '用户ID',
  `tag_name` varchar(36) NOT NULL COMMENT '标签名称',
  `friend_count` int(5) NOT NULL COMMENT '好友,总数',
  `status` int(10) unsigned NOT NULL COMMENT '状态位，用于扩展，32位，可以表示4294967295',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_tag` tinyint(2) DEFAULT '0' COMMENT '0,未删除 1,已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_entryUuid_tagName` (`entry_uuid`,`tag_name`),
  KEY `index_entryuuid_uuid` (`entry_uuid`,`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友标签表';



# Dump of table import_index
# ------------------------------------------------------------

CREATE TABLE `import_index` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tbl_id` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '表名ID',
  `ctime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开始执行时间',
  `mtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '执行结束时间',
  `start_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '开始ID',
  `end_id` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '结束ID',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0:未开始；1：进行中；2：已完成',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table jbs_order_seq
# ------------------------------------------------------------

CREATE TABLE `jbs_order_seq` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `entry_uuid` varchar(24) NOT NULL COMMENT '用户uuid',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `action` tinyint(4) NOT NULL DEFAULT '0' COMMENT '人脸识别的原因 0:活动奖励1:提现',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1成功 2返回成功，阈值校验失败 3 返回失败',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '人脸识别的厂家 0:face++1:linkface',
  `uuid` varchar(36) DEFAULT '' COMMENT 'uuid',
  `device_udid` varchar(64) DEFAULT '' COMMENT '设备标识符',
  `confidence` varchar(8) DEFAULT '' COMMENT '相似度值',
  `fail_message` varchar(64) DEFAULT '' COMMENT '错误的消息代码',
  PRIMARY KEY (`id`),
  KEY `index_entryUuid_action` (`entry_uuid`,`action`),
  KEY `index_jbs_create_time` (`create_time`),
  KEY `index_uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table laundry
# ------------------------------------------------------------

CREATE TABLE `laundry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `UUID` varchar(36) NOT NULL COMMENT 'UUID',
  `payStatus` tinyint(2) NOT NULL COMMENT '支付状态（0.待支付  1.已支付）',
  `payUserId` varchar(36) NOT NULL COMMENT '购买用户的id',
  `laundryNum` varchar(255) NOT NULL COMMENT '流水号',
  `amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '金额',
  `rate` varchar(20) NOT NULL COMMENT '利率',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间（时间戳）',
  `effectiveDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '锁定时间：创建时间加30分钟（时间戳） ',
  `interestAmount` varchar(20) DEFAULT '' COMMENT '利息金额',
  `validateFlag` tinyint(2) NOT NULL COMMENT '是否有效',
  `productId` varchar(36) DEFAULT NULL COMMENT '产品Id',
  `status` tinyint(2) DEFAULT NULL COMMENT '流水状态',
  `payId` varchar(36) DEFAULT '' COMMENT 'pay_flow表的pay_id',
  `resale_amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '还可转售金额',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '贷出的产品类型',
  `resale_principal` varchar(20) DEFAULT NULL COMMENT '转售本金',
  `resale_root_productID` varchar(25) NOT NULL DEFAULT '' COMMENT '转售贷出的转售根产品的uuid',
  `resellType` tinyint(2) NOT NULL DEFAULT '1' COMMENT '贷出的产品类型',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间（时间戳）',
  `available_resale_principal` varchar(16) DEFAULT '0' COMMENT '可用来转售的本金',
  `resale_status` tinyint(4) DEFAULT '0' COMMENT '转售状态',
  `parent_uuid` varchar(36) NOT NULL DEFAULT '' COMMENT '父流水uuid',
  `root_uuid` varchar(36) NOT NULL DEFAULT '' COMMENT '根流水uuid',
  `achievement_amount` varchar(16) DEFAULT '0' COMMENT '已变现收益',
  `principal` varchar(36) NOT NULL DEFAULT '0' COMMENT '贷出金额对应本金',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `credit_uuid` varchar(36) DEFAULT '' COMMENT '秒借授信表uuid',
  `lend_out_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1:客户端发出的,2:秒借,3:委托代理',
  PRIMARY KEY (`id`),
  KEY `index_UUID` (`UUID`),
  KEY `index_productId` (`productId`),
  KEY `index_laundryNum` (`laundryNum`),
  KEY `index_parent_uuid` (`parent_uuid`),
  KEY `index_root_uuid` (`root_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table law_fees_order
# ------------------------------------------------------------

CREATE TABLE `law_fees_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `uuid` varchar(20) NOT NULL COMMENT '主键',
  `package_tf_uuid` char(24) NOT NULL COMMENT '发起打包的原始还款链结ID',
  `package_tr_uuid` char(24) NOT NULL COMMENT '发起打包的原始还款链条ID',
  `package_type` tinyint(2) DEFAULT '1' COMMENT '诉讼费垫付类别 1:提前诉讼，2:打包诉讼',
  `pay_status` tinyint(2) DEFAULT '1' COMMENT '垫付诉讼费的支付状态 2:支付中，4:支付成功，5:支付失败',
  `pay_id` char(20) NOT NULL DEFAULT '' COMMENT '垫付的支付ID',
  `pay_user_uuid` varchar(20) NOT NULL DEFAULT '' COMMENT '垫付用户的uuid',
  `law_pay_type` tinyint(2) DEFAULT '1' COMMENT '垫付诉讼费的类别：1:个人，2:人人行公司',
  `repay_user_uuid` char(20) NOT NULL COMMENT '还款用户的uuid',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`id`),
  KEY `uuid` (`uuid`),
  KEY `index_pay_id` (`pay_id`),
  KEY `index_package_tf_uuid_pay_status` (`package_tf_uuid`,`pay_status`),
  KEY `index_payor_user_uuid` (`pay_user_uuid`),
  KEY `index_repay_user_uuid` (`repay_user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托诉讼的订单表';



# Dump of table law_fees_order_item
# ------------------------------------------------------------

CREATE TABLE `law_fees_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `uuid` varchar(20) NOT NULL COMMENT '主键',
  `law_fees_order_uuid` varchar(20) NOT NULL COMMENT '参照law_fees_order.uuid',
  `pay_status` tinyint(2) DEFAULT '1' COMMENT '垫付诉讼费的支付状态 2:支付中，4:支付成功，5:支付失败',
  `tf_uuid` char(24) NOT NULL COMMENT '原始的还款链节ID,参照transaction_flow.uuid',
  `tr_uuid` char(24) NOT NULL COMMENT '原始的还款链条ID,参照transaction_flow.tr_uuid',
  `bid_uuid` char(24) NOT NULL COMMENT '标的UUID，参考product.uuid',
  `agreement_type` tinyint(2) DEFAULT '1' COMMENT '协议类别 1:逾期8天的协议，2:逾期76天的协议，3:逾期151天的协议',
  `overdue_day` int(6) NOT NULL DEFAULT '0' COMMENT '提起诉讼时的逾期天数',
  `principal` decimal(16,2) NOT NULL COMMENT '本金',
  `repay_principal` decimal(16,2) DEFAULT '0.00',
  `total_amount` decimal(16,2) NOT NULL COMMENT '提起诉讼时，应还的本息罚的金额之和',
  `repay_amount` decimal(16,2) NOT NULL COMMENT '提起诉讼时，已还的金额',
  `pay_user_uuid` varchar(20) NOT NULL DEFAULT '' COMMENT '垫付用户的uuid',
  `law_pay_type` tinyint(2) DEFAULT '1' COMMENT '垫付诉讼费的类别：1:个人，2:人人行公司',
  `law_fees_user` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '个人垫付的诉讼费用',
  `law_fees_company` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '公司垫付的诉讼费用',
  `repay_user_uuid` char(20) NOT NULL COMMENT '还款用户的uuid',
  `repaied_law_fees_user` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '被诉讼者已经返还给诉讼者的诉讼费用',
  `repaied_law_fees_company` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '被诉讼者已经返还给公司的诉讼费用',
  `repay_status` tinyint(2) DEFAULT '1' COMMENT '还款诉讼费的支付状态 1:需要支付,10:部分支付，4:支付完成',
  `notice_status` tinyint(2) DEFAULT '0' COMMENT '通知还款系统的状态：0:尚未同步，1:同步成功，2:同步失败',
  `notice_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '通知还款系统的时间',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`id`),
  KEY `uuid` (`uuid`),
  KEY `index_tf_uuid` (`tf_uuid`),
  KEY `index_tr_uuid` (`tr_uuid`),
  KEY `index_create_time` (`create_time`),
  KEY `index_payor_user_uuid` (`pay_user_uuid`),
  KEY `index_repay_user_uuid` (`repay_user_uuid`),
  KEY `index_law_fees_order_uuid` (`law_fees_order_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托诉讼订单的债务信息表';



# Dump of table law_repay_info
# ------------------------------------------------------------

CREATE TABLE `law_repay_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `uuid` varchar(20) NOT NULL COMMENT '主键',
  `law_fees_order_item_uuid` varchar(20) NOT NULL COMMENT '参照law_fees_order_item.uuid',
  `pay_id` char(20) NOT NULL DEFAULT '' COMMENT '还款的支付ID,还款系统生成',
  `repaied_law_fees_user` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '被诉讼者已经返还给诉讼者的诉讼费用',
  `repaied_law_fees_company` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '被诉讼者已经返还给公司的诉讼费用',
  `repay_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '还款时间',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_pay_id` (`pay_id`),
  KEY `uuid` (`uuid`),
  KEY `index_create_time` (`create_time`),
  KEY `index_law_fees_order_uuid` (`law_fees_order_item_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托诉讼的还款流水表';



# Dump of table login_laundry_bak
# ------------------------------------------------------------

CREATE TABLE `login_laundry_bak` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `login_laundry_no` varchar(36) NOT NULL COMMENT '登入流水NO',
  `entry_no` varchar(36) NOT NULL COMMENT '用户No',
  `device_udid` varchar(50) NOT NULL COMMENT '设备标识符',
  `status` tinyint(2) NOT NULL COMMENT '0 登入 1 登出',
  `ipv4` varchar(15) NOT NULL DEFAULT '' COMMENT '客户端IP',
  `city` varchar(50) NOT NULL DEFAULT '' COMMENT '城市',
  `network` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0 未知,2 2G,3 3G,4 4G,5 WIFI',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `jdbid` varchar(50) DEFAULT '' COMMENT '标示idfa',
  `device_id` varchar(50) DEFAULT '' COMMENT '标示idfa-2',
  PRIMARY KEY (`id`),
  KEY `index_entry_no` (`entry_no`),
  KEY `index_login_laundry_no` (`login_laundry_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登入流水';



# Dump of table manual_repayment_flow
# ------------------------------------------------------------

CREATE TABLE `manual_repayment_flow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `flow_uuids` text NOT NULL COMMENT 'transaction_flow的UUID集合，用,隔开',
  `need_repay_amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '需要还款金额',
  `need_overdue_fees` varchar(20) NOT NULL DEFAULT '0' COMMENT '需要还的逾期管理费',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT '0为初始化，1为成功，2为失败，3为充值工单状态',
  `err_message` varchar(255) DEFAULT '' COMMENT '出错原因',
  `need_law_fees` varchar(20) NOT NULL DEFAULT '0' COMMENT '需要还的委托诉讼费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手动还款流水记录表';



# Dump of table message
# ------------------------------------------------------------

CREATE TABLE `message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `UUID` varchar(36) NOT NULL COMMENT 'UUID',
  `productId` varchar(36) DEFAULT NULL COMMENT '产品id',
  `laundryUuid` varchar(36) DEFAULT NULL COMMENT '流水号',
  `createId` varchar(36) NOT NULL COMMENT '创建人id',
  `attributionId` varchar(36) NOT NULL COMMENT '归属人id',
  `messageContent` varchar(255) DEFAULT NULL COMMENT '消息内容',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `productType` tinyint(2) NOT NULL COMMENT '产品类型（0：赚，1：借款，3：转售）',
  `messageStatus` tinyint(2) NOT NULL DEFAULT '0' COMMENT '消息状态    (0：未读  , 1： 已读)',
  `validateFlag` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `messageType` tinyint(2) NOT NULL COMMENT '消息类型 (0：系统消息)',
  PRIMARY KEY (`id`),
  KEY `index_UUID` (`UUID`),
  KEY `index_attributionId` (`attributionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息表';



# Dump of table message_center
# ------------------------------------------------------------

CREATE TABLE `message_center` (
  `id` bigint(64) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) NOT NULL DEFAULT ' ' COMMENT '用户id',
  `push_message` varchar(255) NOT NULL DEFAULT ' ' COMMENT '推送消息',
  `show_title` varchar(255) DEFAULT ' ' COMMENT '显示消息标题',
  `show_content` varchar(255) DEFAULT ' ' COMMENT '显示内容',
  `type` smallint(4) NOT NULL DEFAULT '1' COMMENT '类型：1交易相关 2运营相关 3 朋友相关',
  `trade_type` smallint(4) DEFAULT NULL COMMENT '交易类型：0赚利差 1借入 2 借出',
  `product_id` varchar(36) DEFAULT NULL COMMENT '产品id',
  `order_id` varchar(36) DEFAULT NULL COMMENT '流水id',
  `ext_data` varchar(255) NOT NULL DEFAULT ' ' COMMENT '推送扩展数据',
  `status` smallint(4) NOT NULL DEFAULT '1' COMMENT '推送状态：0不推送 1待推送 2已推送',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_user` (`user_id`),
  KEY `index_type_status` (`type`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息中心';



# Dump of table overdue_fees
# ------------------------------------------------------------

CREATE TABLE `overdue_fees` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL COMMENT '唯一ID',
  `link_uuid` varchar(36) NOT NULL COMMENT '流水ID',
  `from_user` varchar(36) NOT NULL DEFAULT '发送方',
  `pay_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态（1，需要支付，2 ：支付中，3：支付返回已接收，4：支付成功，5：支付失败）',
  `overdue_amount` varchar(20) NOT NULL COMMENT '逾期金额',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tbid_uuid` varchar(36) DEFAULT NULL COMMENT '投标',
  `bid_uuid` varchar(36) DEFAULT NULL COMMENT '标的',
  `overdue_day` smallint(4) DEFAULT NULL COMMENT '逾期天数',
  `fees` varchar(20) NOT NULL COMMENT '累加的基础管理费',
  `special_fees` varchar(20) NOT NULL COMMENT '累加的特别管理费',
  `sum_fees` varchar(20) NOT NULL COMMENT '总管理费',
  `fees_rate` varchar(20) NOT NULL COMMENT '基础管理费费率',
  `special_fees_rate` varchar(20) NOT NULL COMMENT '特别管理费费率',
  `repay_fees` varchar(20) NOT NULL COMMENT '已还的基础逾期管理费',
  `repay_special_fees` varchar(20) NOT NULL COMMENT '已还的特别逾期管理费',
  `repay_sum_fees` varchar(20) NOT NULL COMMENT '已还的总管理费',
  `pay_id` varchar(60) NOT NULL DEFAULT '' COMMENT '支付ID',
  PRIMARY KEY (`id`),
  KEY `index_uuid` (`uuid`),
  KEY `index_bid_from_user` (`bid_uuid`,`from_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table overdue_fees_track
# ------------------------------------------------------------

CREATE TABLE `overdue_fees_track` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL COMMENT '唯一ID',
  `link_uuid` varchar(36) NOT NULL COMMENT '流水ID',
  `from_user` varchar(36) NOT NULL DEFAULT '发送方',
  `pay_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态（1，需要支付，2 ：支付中，3：支付返回已接收，4：支付成功，5：支付失败, 6:已经生成逾期数据）',
  `overdue_amount` varchar(20) NOT NULL COMMENT '逾期金额',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tbid_uuid` varchar(36) DEFAULT NULL COMMENT '投标',
  `bid_uuid` varchar(36) DEFAULT NULL COMMENT '标的',
  `overdue_day` smallint(4) DEFAULT NULL COMMENT '逾期天数',
  `fees` varchar(20) NOT NULL COMMENT '当天的基础逾期管理费',
  `special_fees` varchar(20) NOT NULL COMMENT '当天的特别管理费',
  `total_fees` varchar(20) NOT NULL COMMENT '累加的基础逾期管理费',
  `total_special_fees` varchar(20) NOT NULL COMMENT '累加的特别管理费',
  `fees_rate` varchar(20) NOT NULL COMMENT '管理费费率',
  `special_fees_rate` varchar(20) NOT NULL COMMENT '当天的特别管理费费率',
  `repay_fees` varchar(20) NOT NULL COMMENT '当天还款的基础逾期管理费',
  `repay_total_fees` varchar(20) NOT NULL COMMENT '累加的还款基础逾期管理费',
  `repay_special_fees` varchar(20) NOT NULL COMMENT '当天还款的特别逾期管理费',
  `repay_total_special_fees` varchar(20) NOT NULL COMMENT '累加的还款特别逾期管理费',
  `original_uuid` varchar(20) NOT NULL COMMENT '原始ID',
  `pay_id` varchar(60) NOT NULL DEFAULT '' COMMENT '支付ID',
  `notice_status` varchar(100) DEFAULT '' COMMENT '支付返回信息编码',
  `notice_msg` varchar(1024) DEFAULT NULL COMMENT '支付返回信息内容',
  `overdue_date` varchar(20) DEFAULT NULL COMMENT '逾期天',
  PRIMARY KEY (`id`),
  KEY `index_original_uuid` (`original_uuid`),
  KEY `index_create_time` (`create_time`),
  KEY `index_uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pay_flow
# ------------------------------------------------------------

CREATE TABLE `pay_flow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL COMMENT '唯一ID',
  `flow_type` tinyint(4) NOT NULL COMMENT '类型(1:收入；2：支出)',
  `amount` varchar(20) NOT NULL COMMENT '金额',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `operation_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `pay_id` varchar(60) NOT NULL COMMENT '支付系统的唯一ID',
  `flow_status` tinyint(4) NOT NULL COMMENT '状态（(1:充值，2：借入，3：收回，4，利息；5：转出，6：借出，7：还款,8:利息）',
  `pay_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0:成功，1:进行中，2:失败',
  `user_uuid` varchar(36) DEFAULT NULL COMMENT '用户ID',
  `tf_uuid` varchar(20) NOT NULL DEFAULT ' ' COMMENT '交易明细ID',
  `ti_uuid` varchar(20) NOT NULL DEFAULT ' ' COMMENT '还款明细ID',
  `original_tf_uuid` varchar(35) NOT NULL DEFAULT '0' COMMENT '原始的链条ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_user_payid_status` (`user_uuid`,`pay_id`,`flow_status`),
  KEY `index_original_tf_uuid` (`original_tf_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对账流水表';



# Dump of table pay_flow_sync
# ------------------------------------------------------------

CREATE TABLE `pay_flow_sync` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL COMMENT '唯一ID refer payFlow.uuid',
  `flow_status` tinyint(4) NOT NULL COMMENT '状态 refer PayFlowStatus',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sync_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '同步状态：0:尚未同步，1:同步成功，2:同步失败，3:需要再次同步成功',
  `sync_content` varchar(2048) NOT NULL COMMENT '同步内容json字符串',
  `sync_result` varchar(36) DEFAULT NULL COMMENT '同步返回的结果',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uuid_flow_status` (`uuid`,`flow_status`),
  KEY `index_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收支明细同步记录表';



# Dump of table phone_list_1
# ------------------------------------------------------------

CREATE TABLE `phone_list_1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `UUID` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'UUID',
  `entryUuid` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户Id',
  `entryMobile` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `syncStatus` tinyint(2) DEFAULT '0' COMMENT '同步到通讯录服务器状态 0:未同步, 1:成功',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `entryUserName` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户姓名',
  PRIMARY KEY (`id`),
  KEY `index_entryUuid_entryMobile` (`entryUuid`,`entryMobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='手机号码收集表';



# Dump of table phone_list_index
# ------------------------------------------------------------

CREATE TABLE `phone_list_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `entryUuid` varchar(36) NOT NULL COMMENT 'UUID',
  `phoneListEntryUuids` mediumtext COMMENT '通讯录中包含entryUUid电话的用户',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_entryUuid` (`entryUuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通讯录索引表';



# Dump of table product
# ------------------------------------------------------------

CREATE TABLE `product_0000` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `UUID` varchar(36) NOT NULL DEFAULT '',
  `entryUuid` varchar(36) NOT NULL DEFAULT '' COMMENT '用户id',
  `productName` varchar(20) NOT NULL DEFAULT '' COMMENT '产品名称',
  `productCode` varchar(255) NOT NULL DEFAULT '' COMMENT '产品编码',
  `amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '金额',
  `freeze` varchar(20) DEFAULT '0' COMMENT '冻结金额',
  `avaliable` varchar(20) NOT NULL DEFAULT '0' COMMENT '剩余可借出金额',
  `rate` varchar(20) NOT NULL DEFAULT '' COMMENT '利率',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  `term` int(4) NOT NULL DEFAULT '0' COMMENT '限期',
  `endTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间（时间戳）',
  `Iftransfer` tinyint(2) DEFAULT '0' COMMENT '是否转让',
  `releaseType` tinyint(2) NOT NULL DEFAULT '1' COMMENT '发布类型（1：公共，2：私人）',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `effectivetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '有效期（时间戳）',
  `dayRate` varchar(20) NOT NULL DEFAULT '' COMMENT '天利率',
  `productType` tinyint(2) NOT NULL DEFAULT '1' COMMENT '产品类型（0：赚，1：借款，  3：转售）',
  `validateFlag` tinyint(2) NOT NULL DEFAULT '2' COMMENT '是否有效(1代表已取消  2代表没有取消,3已代表提前还款)',
  `pCode` varchar(255) DEFAULT '' COMMENT '父产品ID',
  `packAmount` varchar(20) DEFAULT '0' COMMENT '打包价',
  `agreementID` varchar(36) NOT NULL DEFAULT '' COMMENT '协议id',
  `earnings` varchar(20) NOT NULL DEFAULT '0' COMMENT '预期收益',
  `debtorUuid` varchar(36) NOT NULL DEFAULT '' COMMENT '债权人Uuid 冗余字段',
  `images` varchar(255) DEFAULT NULL COMMENT '产品图片，多个图片用逗号分割，仅保存图片名字，如图片url为http://jdbserver.b0.upaiyun.com/images/0f821423040918080，仅保存0f821423040918080',
  `currentAmount` varchar(20) DEFAULT NULL COMMENT '当前金额',
  `status` tinyint(2) DEFAULT NULL COMMENT '产品状态',
  `subStatus` tinyint(2) DEFAULT NULL COMMENT '产品子状态',
  `toAll` tinyint(2) DEFAULT '0' COMMENT '是否发送给所有好友 0:否，1:是',
  `toFriendNum` int(11) DEFAULT '0' COMMENT '发送好友数',
  `resale_type` tinyint(2) DEFAULT '0' COMMENT '被转让债权的产品类型',
  `early_repay_amount` varchar(32) DEFAULT '0' COMMENT '提前还金额',
  `early_repay_principal` varchar(32) DEFAULT '0' COMMENT '提前还本金',
  `original_debtor_uuid` varchar(36) NOT NULL DEFAULT '' COMMENT '转让标原始债务人',
  `original_rate` varchar(20) NOT NULL DEFAULT '' COMMENT '转让标原始利率',
  `gurantee_uuid` varchar(36) NOT NULL DEFAULT '' COMMENT '担保人uuid',
  `product_source` tinyint(2) NOT NULL DEFAULT '0' COMMENT '产品源 (0:普通用户  1:企业用户)',
  PRIMARY KEY (`id`),
  KEY `index_UUID` (`UUID`),
  KEY `index_productCode` (`productCode`),
  KEY `index_create_time` (`createTime`),
  KEY `index_entryUuid` (`entryUuid`),
  KEY `index_effectivetime` (`effectivetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_backup
# ------------------------------------------------------------

CREATE TABLE `product_backup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `UUID` varchar(36) NOT NULL DEFAULT '',
  `entryUuid` varchar(36) NOT NULL DEFAULT '' COMMENT '用户id',
  `productName` varchar(20) NOT NULL DEFAULT '' COMMENT '产品名称',
  `productCode` varchar(255) NOT NULL DEFAULT '' COMMENT '产品编码',
  `amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '金额',
  `freeze` varchar(20) DEFAULT '0' COMMENT '冻结金额',
  `avaliable` varchar(20) NOT NULL DEFAULT '0' COMMENT '剩余可借出金额',
  `rate` varchar(20) NOT NULL DEFAULT '' COMMENT '利率',
  `createTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `term` int(4) NOT NULL DEFAULT '0' COMMENT '限期',
  `endTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间（时间戳）',
  `Iftransfer` tinyint(2) DEFAULT '0' COMMENT '是否转让',
  `releaseType` tinyint(2) NOT NULL DEFAULT '1' COMMENT '发布类型（1：公共，2：私人）',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `effectivetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '有效期（时间戳）',
  `dayRate` varchar(20) NOT NULL DEFAULT '' COMMENT '天利率',
  `productType` tinyint(2) NOT NULL DEFAULT '1' COMMENT '产品类型（0：赚，1：借款，  3：转售）',
  `validateFlag` tinyint(2) NOT NULL DEFAULT '2' COMMENT '是否有效(1代表已取消  2代表没有取消,3已代表提前还款)',
  `pCode` varchar(255) DEFAULT '' COMMENT '父产品ID',
  `packAmount` varchar(20) DEFAULT '0' COMMENT '打包价',
  `agreementID` varchar(36) NOT NULL DEFAULT '' COMMENT '协议id',
  `earnings` varchar(20) NOT NULL DEFAULT '0' COMMENT '预期收益',
  `debtorUuid` varchar(36) NOT NULL DEFAULT '' COMMENT '债权人Uuid 冗余字段',
  `images` varchar(255) DEFAULT NULL COMMENT '产品图片，多个图片用逗号分割，仅保存图片名字，如图片url为http://jdbserver.b0.upaiyun.com/images/0f821423040918080，仅保存0f821423040918080',
  `currentAmount` varchar(20) DEFAULT NULL COMMENT '当前金额',
  `status` tinyint(2) DEFAULT NULL COMMENT '产品状态',
  `subStatus` tinyint(2) DEFAULT NULL COMMENT '产品子状态',
  `toNewFriend` tinyint(2) DEFAULT '0' COMMENT '是否对新好友可见',
  PRIMARY KEY (`id`),
  KEY `index_UUID` (`UUID`),
  KEY `index_entryUuid_productCode` (`entryUuid`,`productCode`),
  KEY `index_productCode` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品表';



# Dump of table product_index
# ------------------------------------------------------------

CREATE TABLE `product_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `root_product_code` varchar(32) NOT NULL,
  `product_tree` mediumtext NOT NULL COMMENT '产品树',
  PRIMARY KEY (`id`),
  KEY `index_root` (`root_product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品索引表';



# Dump of table product_pool_index
# ------------------------------------------------------------

CREATE TABLE `product_pool_index_0000` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entry_uuid` varchar(36) NOT NULL COMMENT '用户ID',
  `product_ids` mediumtext NOT NULL COMMENT '产品对应的ID集合',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `ppi_type` tinyint(2) NOT NULL COMMENT '类型：0：有效 ，1：所有',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_entryUuid` (`entry_uuid`,`ppi_type`),
  KEY `update_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_reason
# ------------------------------------------------------------

CREATE TABLE `product_reason` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT,
  `entry_uuid` varchar(36) NOT NULL COMMENT '发布产品人ID',
  `product_id` varchar(36) NOT NULL COMMENT '产品ID',
  `product_code` varchar(255) NOT NULL COMMENT '产品代码',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `reason_context` varchar(255) DEFAULT NULL COMMENT '借款理由文本',
  `images` varchar(255) DEFAULT NULL COMMENT '借款理由图片',
  `validate_flag` varchar(8) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品借款原因表';



# Dump of table product_users_mapping
# ------------------------------------------------------------

CREATE TABLE `product_users_mapping` (
  `id` bigint(64) unsigned NOT NULL AUTO_INCREMENT,
  `p_id` bigint(64) unsigned NOT NULL COMMENT 'äº§å“ID',
  `user_uuids` longtext NOT NULL COMMENT 'ç›¸å…³ç”¨æˆ·UUID',
  `exclude_flag` tinyint(4) DEFAULT '0' COMMENT '发标选择好友时的反选状态 0:未反选 1:反选',
  PRIMARY KEY (`id`),
  UNIQUE KEY `p_id` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='äº§å“ç”¨æˆ·æ˜ å°„è¡¨';



# Dump of table region
# ------------------------------------------------------------

CREATE TABLE `region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(100) NOT NULL COMMENT '行政区名称',
  `fid` int(11) NOT NULL DEFAULT '0' COMMENT '父级地域id',
  `level` tinyint(4) NOT NULL COMMENT '行政区级别',
  `full_name` char(255) NOT NULL COMMENT '行政区全名',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行政区划表';



# Dump of table repay_flow
# ------------------------------------------------------------

CREATE TABLE `repay_flow` (
  `id` bigint(64) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(20) NOT NULL DEFAULT ' ',
  `link_uuid` varchar(20) NOT NULL DEFAULT ' ' COMMENT '链条ID',
  `laundry_uuid` varchar(20) NOT NULL DEFAULT ' ' COMMENT '流水ID',
  `from_user` varchar(20) NOT NULL DEFAULT ' ' COMMENT '还款方',
  `to_user` varchar(20) NOT NULL DEFAULT ' ' COMMENT '接收方',
  `total_amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '还款总金额＝金额＋逾期利息',
  `amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '金额',
  `principal` varchar(20) NOT NULL DEFAULT '0' COMMENT '本金',
  `interest` varchar(20) NOT NULL DEFAULT '0' COMMENT '利息',
  `overdue_interest` varchar(20) NOT NULL DEFAULT '0' COMMENT '逾期利息',
  `rate` varchar(20) NOT NULL DEFAULT '0' COMMENT '利率',
  `overdue_day` smallint(6) DEFAULT NULL,
  `parent_repayed_amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '上级以还金额',
  `parent_repay_amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '上级应还金额',
  `sequence` tinyint(4) NOT NULL DEFAULT '1' COMMENT '序列',
  `pay_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '支付状态',
  `product_code` varchar(255) NOT NULL DEFAULT ' ' COMMENT '产品CODE',
  `bid_uuid` varchar(36) DEFAULT NULL,
  `tbid_uuid` varchar(36) DEFAULT NULL,
  `interest_day` smallint(6) DEFAULT NULL,
  `repay_amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '还款金额',
  `link_count` tinyint(4) NOT NULL DEFAULT '1' COMMENT '链条数量',
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '起始时间',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `parent_repay_user` varchar(20) NOT NULL DEFAULT '0' COMMENT '上级还款用户',
  `delay_interest` varchar(20) NOT NULL DEFAULT '0' COMMENT '延期利息',
  `delay_day` tinyint(4) NOT NULL DEFAULT '0' COMMENT '延期天数',
  `overdue_rate` varchar(20) DEFAULT NULL,
  `parent_uuid` varchar(35) NOT NULL DEFAULT '0' COMMENT 'ä¸Šçº§èŠ‚ç‚¹',
  `product_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '产品发布时间',
  `law_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '诉讼状态 (0:无  1:有)',
  `law_time` timestamp NOT NULL DEFAULT '2015-01-01 00:00:00' COMMENT '用户发起诉讼的时间',
  `call_version` varchar(15) DEFAULT ' ' COMMENT '还款版本号',
  `original_principal` varchar(25) DEFAULT '0' COMMENT '原始本金',
  `type` tinyint(4) DEFAULT '0' COMMENT 'ç±»åž‹',
  `gurantee_uuid` varchar(36) DEFAULT '' COMMENT '担保人uuid',
  `original_interest` varchar(36) DEFAULT '0' COMMENT '原始利息',
  `source_bid_uuid` varchar(32) DEFAULT '' COMMENT '原产品uuid',
  PRIMARY KEY (`id`),
  KEY `index_from_user` (`from_user`),
  KEY `index_to_user` (`to_user`),
  KEY `index_link_uuid` (`link_uuid`),
  KEY `index_uuid` (`uuid`),
  KEY `index_update_time` (`update_time`),
  KEY `index_bid_uuid` (`bid_uuid`),
  KEY `index_source_bid_uuid` (`source_bid_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='还款流水';



# Dump of table rrx_config
# ------------------------------------------------------------

CREATE TABLE `rrx_config` (
  `id` bigint(64) unsigned NOT NULL AUTO_INCREMENT,
  `conf_key` varchar(255) NOT NULL DEFAULT ' ',
  `conf_value` varchar(255) NOT NULL DEFAULT ' ',
  `create_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `conf_desc` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_configKey` (`conf_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置';



# Dump of table transaction_flow
# ------------------------------------------------------------

CREATE TABLE `transaction_flow` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL COMMENT '唯一ID',
  `tr_uuid` varchar(36) NOT NULL COMMENT '流水ID',
  `laundryUuid` varchar(255) NOT NULL,
  `from_user` varchar(36) NOT NULL DEFAULT '发送方',
  `to_user` varchar(36) NOT NULL COMMENT '接收方',
  `amount` varchar(20) NOT NULL COMMENT '转账金额',
  `principal` varchar(20) NOT NULL COMMENT '本金',
  `interest` varchar(20) NOT NULL COMMENT '利息',
  `sequence` int(3) NOT NULL DEFAULT '1' COMMENT '顺序',
  `pay_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态（1，需要支付，2 ：支付中，3：支付返回已接收，4：支付成功，5：支付失败）',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tr_type` tinyint(4) NOT NULL COMMENT '1 本金 2 利息 3 本金和利息',
  `op_type` tinyint(4) NOT NULL COMMENT '操作类型: 准备冻结，冻结成功(银行，汇付，冻结)，准备转账，转账成功(汇付转账，银行)',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user_no` varchar(36) NOT NULL DEFAULT '' COMMENT '创建用户',
  `product_code` varchar(255) DEFAULT '' COMMENT '产品编码',
  `expire_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '有效时间',
  `execution_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '执行时间',
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '起息日',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结息日',
  `rate` varchar(20) NOT NULL COMMENT '利率',
  `pay_type` tinyint(4) NOT NULL COMMENT '1:实时支付，2：定时支付',
  `parent_uuid` varchar(36) DEFAULT NULL COMMENT '父节点',
  `tbid_uuid` varchar(36) DEFAULT NULL COMMENT '投标',
  `interestDay` smallint(6) DEFAULT NULL,
  `bid_uuid` varchar(36) DEFAULT NULL COMMENT '标的',
  `re_message` varchar(100) DEFAULT NULL COMMENT '支付返回信息',
  `overdue_day` smallint(6) DEFAULT NULL,
  `overdue_date` date DEFAULT NULL COMMENT '逾期日',
  `balance` varchar(20) DEFAULT NULL COMMENT '账户余额',
  `repay_amount` varchar(20) DEFAULT NULL COMMENT '还款金额',
  `overdue_interest` varchar(20) NOT NULL DEFAULT ' ' COMMENT '逾期利息',
  `link_count` tinyint(4) NOT NULL DEFAULT '1' COMMENT '链条长度',
  `delay_interest` varchar(20) NOT NULL DEFAULT '0' COMMENT '延期利息',
  `delay_day` tinyint(4) NOT NULL DEFAULT '0' COMMENT '延期天数',
  `overdue_rate` varchar(20) DEFAULT NULL,
  `not_yet_interest` varchar(20) NOT NULL DEFAULT '0' COMMENT '未还利息（利息＋逾期利息）',
  `not_yet_principal` varchar(20) DEFAULT '0' COMMENT '未还本金',
  `original_amount` varchar(20) DEFAULT '0' COMMENT '原始还款金额',
  `sub_type` tinyint(4) DEFAULT '0' COMMENT '子状态，0默认，1：转售购买，2:转售回购',
  `original_uuid` varchar(20) DEFAULT '0' COMMENT '原始链节ID，用于转售使用',
  `product_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '产品发布时间',
  `resale_handle_status` tinyint(2) DEFAULT '3' COMMENT '转让处理状态',
  `credit_uuid` varchar(36) DEFAULT '' COMMENT '秒借授信表uuid',
  `gurantee_uuid` varchar(36) DEFAULT '' COMMENT '担保人uuid',
  `tid` varchar(40) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `index_UUID` (`uuid`),
  KEY `index_tr_uuid` (`tr_uuid`),
  KEY `index_from_user` (`from_user`),
  KEY `index_overdue_date` (`overdue_date`),
  KEY `index_endTime` (`end_time`),
  KEY `index_parentUuid` (`parent_uuid`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table transaction_info
# ------------------------------------------------------------

CREATE TABLE `transaction_info` (
  `id` bigint(64) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(20) NOT NULL DEFAULT ' ',
  `tf_uuid` varchar(20) NOT NULL DEFAULT ' ',
  `repay_amount` varchar(20) NOT NULL DEFAULT '还款金额',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `pay_id` varchar(60) NOT NULL DEFAULT '' COMMENT '支付ID',
  `ti_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付类型，0还款，1逾期还款',
  `principal` varchar(20) NOT NULL DEFAULT ' ' COMMENT '还款本金',
  `amount` varchar(20) NOT NULL DEFAULT '0' COMMENT '应还金额',
  `from_user` varchar(20) NOT NULL DEFAULT '0' COMMENT '还款方',
  `to_user` varchar(20) NOT NULL DEFAULT '0' COMMENT '收款方',
  `repay_total` varchar(20) NOT NULL DEFAULT '0' COMMENT '还款总额',
  `link_count` tinyint(4) NOT NULL DEFAULT '1' COMMENT '链条数量',
  `sequence` tinyint(4) NOT NULL DEFAULT '1' COMMENT '序列',
  `original_tf_uuid` varchar(35) NOT NULL DEFAULT '0' COMMENT '原始的链条ID',
  `repay_overdue_fees` varchar(20) DEFAULT '0' COMMENT '支付的基础预期管理费',
  `repay_special_overdue_fees` varchar(20) DEFAULT '0' COMMENT '支付的特别预期管理费',
  `not_yet_principal` varchar(20) DEFAULT '0' COMMENT '未还本金',
  `repay_principal` varchar(20) DEFAULT '0' COMMENT '还款本金',
  `repay_interest` varchar(20) DEFAULT '0' COMMENT '还款利息',
  `call_version` varchar(15) DEFAULT ' ' COMMENT '还款版本号',
  `payment_type` tinyint(4) DEFAULT '0' COMMENT '支付类型，0:还款、1:收回、2:垫付、3:垫付收回，4:逾期管理费，5:特殊逾期管理费',
  `sub_type` tinyint(4) DEFAULT '0' COMMENT '支付类型，1:还款、2:垫付、0：默认',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_pay_id` (`pay_id`),
  KEY `index_uuid` (`uuid`),
  KEY `index_link_uuid` (`tf_uuid`),
  KEY `index_original_tf_uuid` (`original_tf_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table transfer
# ------------------------------------------------------------

CREATE TABLE `transfer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `uuid` varchar(24) NOT NULL COMMENT '转账ID,交易系统生成',
  `from_user` varchar(24) NOT NULL COMMENT '用户uuid',
  `to_user` varchar(24) NOT NULL COMMENT '用户uuid',
  `card_id` varchar(24) NOT NULL COMMENT '转账卡ID',
  `charge_pay_id` varchar(36) NOT NULL COMMENT '充值的PAY_ID',
  `pay_id` varchar(36) NOT NULL COMMENT '本条还款记录对应支付系统的ID',
  `status` tinyint(2) NOT NULL COMMENT '还款状态 0提交成功、1银行处理中、2、转账成功 3、转账失败',
  `repay_type` tinyint(2) NOT NULL COMMENT '还款类型 0:余额还款,  1:银行卡还款 ',
  `amount` varchar(50) NOT NULL COMMENT '还款总额',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `ip` varchar(20) NOT NULL COMMENT 'IP',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tid` varchar(20) NOT NULL DEFAULT '0' COMMENT '对应的安全ID',
  `transfer_type` tinyint(2) DEFAULT '1' COMMENT '转账类型 1：普通转账 2：面对面付钱  3：转账到银行卡',
  `payee_uuid` varchar(24) DEFAULT NULL COMMENT '收款人uuid',
  PRIMARY KEY (`id`),
  KEY `index_uuid` (`uuid`),
  KEY `index_from` (`from_user`),
  KEY `index_pay_id` (`pay_id`),
  KEY `index_to_user` (`to_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账表';



# Dump of table transfer_user
# ------------------------------------------------------------

CREATE TABLE `transfer_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `uuid` varchar(24) NOT NULL COMMENT '转账ID,交易系统生成',
  `entry_uuid` varchar(24) NOT NULL COMMENT '用户uuid',
  `to_user` varchar(24) NOT NULL COMMENT '用户uuid',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `transfer_type` tinyint(2) DEFAULT '1' COMMENT '转账类型 1：普通转账 2：面对面付钱',
  PRIMARY KEY (`id`),
  KEY `index_uuid` (`uuid`),
  KEY `index_entry_uuid` (`entry_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账用户表';



# Dump of table user_phone_history
# ------------------------------------------------------------

CREATE TABLE `user_phone_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增ID主键',
  `user_id` varchar(36) NOT NULL COMMENT 'user_id',
  `new_phone_num` varchar(15) NOT NULL COMMENT '新手机号',
  `old_phone_num` varchar(15) NOT NULL COMMENT '老手机号',
  `create_time` int(10) NOT NULL COMMENT '创建记录时间',
  `update_time` int(10) NOT NULL COMMENT '更新记录时间',
  `change_status` int(10) NOT NULL COMMENT '更改状态',
  `create_ip` int(11) NOT NULL COMMENT '创建记录的client_ip地址',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`user_id`),
  KEY `idx_new_phone` (`new_phone_num`),
  KEY `idx_old_phone` (`old_phone_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户手机号更改历史表';



# Dump of table white_list
# ------------------------------------------------------------

CREATE TABLE `white_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `type` smallint(6) NOT NULL DEFAULT '0' COMMENT '白名单类型 1短信语音验证码白名单 2 悬赏白名单 3 理财白名单 4 债权转让白名单 5 首页banner白名单',
  `mobiles` mediumtext COMMENT '白名单手机号 忽略大小写字符串ALL表示全所有人都在白名单',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='白名单';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
