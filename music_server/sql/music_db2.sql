/*
 Navicat Premium Data Transfer

 Source Server         : localhost_1521_ORCL
 Source Server Type    : Oracle
 Source Server Version : 110200
 Source Host           : localhost:1521
 Source Schema         : MUSIC_DB

 Target Server Type    : Oracle
 Target Server Version : 110200
 File Encoding         : 65001

 Date: 27/04/2025 16:35:34
*/


-- ----------------------------
-- Table structure for ADMIN
-- ----------------------------
DROP TABLE "ADMIN";
CREATE TABLE "ADMIN" (
  "ID" NUMBER(10,0) NOT NULL,
  "NAME" VARCHAR2(45 BYTE) NOT NULL,
  "PASSWORD" VARCHAR2(45 BYTE) NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of ADMIN
-- ----------------------------
INSERT INTO "ADMIN" ("ID", "NAME", "PASSWORD") VALUES ('1', 'admin', '123');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for COLLECT
-- ----------------------------
DROP TABLE "COLLECT";
CREATE TABLE "COLLECT" (
  "ID" NUMBER(10,0) NOT NULL,
  "USER_ID" NUMBER(10,0) NOT NULL,
  "TYPE" NUMBER(1,0) NOT NULL,
  "SONG_ID" NUMBER(10,0) NOT NULL,
  "CREATE_TIME" TIMESTAMP(6) NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of COLLECT
-- ----------------------------
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('3', '1', '0', '13', TO_TIMESTAMP('2025-04-19 13:31:10.068000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('21', '2', '0', '20', TO_TIMESTAMP('2025-04-19 21:33:58.395000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('26', '21', '0', '39', TO_TIMESTAMP('2025-04-24 16:08:15.128000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('4', '1', '0', '16', TO_TIMESTAMP('2025-04-19 13:46:32.644000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('23', '1', '0', '12', TO_TIMESTAMP('2025-04-24 16:03:04.756000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('29', '2', '0', '54', TO_TIMESTAMP('2025-04-24 16:09:44.776000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('31', '2', '0', '44', TO_TIMESTAMP('2025-04-24 16:13:46.095000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('32', '2', '0', '23', TO_TIMESTAMP('2025-04-24 16:13:53.344000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('30', '2', '0', '13', TO_TIMESTAMP('2025-04-24 16:09:49.361000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('27', '2', '0', '53', TO_TIMESTAMP('2025-04-24 16:09:40.639000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('28', '2', '0', '38', TO_TIMESTAMP('2025-04-24 16:09:43.123000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('33', '2', '0', '51', TO_TIMESTAMP('2025-04-24 16:13:57.742000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('22', '1', '0', '19', TO_TIMESTAMP('2025-04-24 16:02:59.936000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('24', '1', '0', '43', TO_TIMESTAMP('2025-04-24 16:03:06.896000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "COLLECT" ("ID", "USER_ID", "TYPE", "SONG_ID", "CREATE_TIME") VALUES ('25', '1', '0', '33', TO_TIMESTAMP('2025-04-24 16:03:20.441000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for CONSUMER
-- ----------------------------
DROP TABLE "CONSUMER";
CREATE TABLE "CONSUMER" (
  "ID" NUMBER(10,0) NOT NULL,
  "USERNAME" VARCHAR2(255 BYTE) NOT NULL,
  "PASSWORD" VARCHAR2(100 BYTE) NOT NULL,
  "SEX" NUMBER(1,0),
  "PHONE_NUM" VARCHAR2(15 BYTE),
  "EMAIL" VARCHAR2(30 BYTE),
  "BIRTH" DATE,
  "INTRODUCTION" VARCHAR2(255 BYTE),
  "LOCATION" VARCHAR2(45 BYTE),
  "AVATOR" VARCHAR2(255 BYTE),
  "CREATE_TIME" TIMESTAMP(6) NOT NULL,
  "UPDATE_TIME" TIMESTAMP(6) NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of CONSUMER
-- ----------------------------
INSERT INTO "CONSUMER" ("ID", "USERNAME", "PASSWORD", "SEX", "PHONE_NUM", "EMAIL", "BIRTH", "INTRODUCTION", "LOCATION", "AVATOR", "CREATE_TIME", "UPDATE_TIME") VALUES ('21', 'Mart', '123', '0', NULL, NULL, TO_DATE('2025-04-24 16:04:24', 'SYYYY-MM-DD HH24:MI:SS'), 'i''m a red robot', '辽宁', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/avatorImages/807d8b5f-f4ee-4e50-bf54-f04c5f688867.png', TO_TIMESTAMP('2025-04-24 16:06:56.743000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-27 14:19:08.118000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CONSUMER" ("ID", "USERNAME", "PASSWORD", "SEX", "PHONE_NUM", "EMAIL", "BIRTH", "INTRODUCTION", "LOCATION", "AVATOR", "CREATE_TIME", "UPDATE_TIME") VALUES ('43', '123', '123', '0', NULL, NULL, TO_DATE('2025-04-27 15:47:30', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, 'img/avatorImages/user.jpg', TO_TIMESTAMP('2025-04-27 15:47:37.454000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-27 15:47:37.454000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CONSUMER" ("ID", "USERNAME", "PASSWORD", "SEX", "PHONE_NUM", "EMAIL", "BIRTH", "INTRODUCTION", "LOCATION", "AVATOR", "CREATE_TIME", "UPDATE_TIME") VALUES ('1', 'Llj', '123', '1', NULL, '169452268@qq.com', TO_DATE('2025-04-18 16:14:36', 'SYYYY-MM-DD HH24:MI:SS'), 'i''m a robot', '广东', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/avatorImages/0e5e1700-5a18-442a-b8fc-ab405b6823f9.png', TO_TIMESTAMP('2025-04-18 17:07:37.609000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-18 17:41:13.533000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "CONSUMER" ("ID", "USERNAME", "PASSWORD", "SEX", "PHONE_NUM", "EMAIL", "BIRTH", "INTRODUCTION", "LOCATION", "AVATOR", "CREATE_TIME", "UPDATE_TIME") VALUES ('2', 'sora', '123', '1', NULL, '1294058688@qq.com', TO_DATE('2025-04-18 17:41:27', 'SYYYY-MM-DD HH24:MI:SS'), 'i''m not a robot', '安徽', 'img/avatorImages/user.jpg', TO_TIMESTAMP('2025-04-18 17:43:13.277000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-18 17:43:13.277000', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for LIST_SONG
-- ----------------------------
DROP TABLE "LIST_SONG";
CREATE TABLE "LIST_SONG" (
  "ID" NUMBER(10,0) NOT NULL,
  "SONG_ID" NUMBER(10,0) NOT NULL,
  "SONG_LIST_ID" NUMBER(10,0) NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of LIST_SONG
-- ----------------------------
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('27', '42', '21');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('29', '54', '25');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('35', '36', '22');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('36', '49', '22');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('46', '34', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('53', '43', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('71', '12', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('83', '46', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('101', '62', '41');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('1', '16', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('2', '13', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('21', '22', '23');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('22', '20', '23');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('23', '22', '26');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('24', '54', '21');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('25', '18', '21');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('26', '16', '21');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('28', '53', '21');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('30', '53', '25');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('31', '50', '22');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('32', '51', '22');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('33', '23', '22');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('37', '29', '22');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('38', '30', '22');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('40', '52', '24');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('41', '21', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('43', '46', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('44', '39', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('47', '25', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('49', '49', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('50', '54', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('54', '41', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('56', '50', '28');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('57', '37', '28');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('59', '47', '28');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('61', '17', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('62', '18', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('64', '19', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('68', '53', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('69', '13', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('70', '9', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('73', '33', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('75', '33', '21');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('76', '32', '21');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('77', '25', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('79', '49', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('80', '3', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('81', '21', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('82', '45', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('84', '39', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('85', '34', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('86', '48', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('87', '52', '1');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('3', '9', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('39', '21', '24');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('42', '13', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('45', '45', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('48', '35', '27');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('51', '53', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('52', '42', '2');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('55', '51', '28');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('58', '38', '28');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('63', '20', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('65', '14', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('66', '15', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('67', '16', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('72', '32', '29');
INSERT INTO "LIST_SONG" ("ID", "SONG_ID", "SONG_LIST_ID") VALUES ('74', '31', '29');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for MUS_COMMENT
-- ----------------------------
DROP TABLE "MUS_COMMENT";
CREATE TABLE "MUS_COMMENT" (
  "ID" NUMBER(10,0) NOT NULL,
  "USER_ID" NUMBER(10,0) NOT NULL,
  "SONG_ID" NUMBER(10,0),
  "SONG_LIST_ID" NUMBER(10,0),
  "CONTENT" VARCHAR2(255 BYTE),
  "CREATE_TIME" TIMESTAMP(6),
  "TYPE" NUMBER(1,0) NOT NULL,
  "UP" NUMBER(10,0) DEFAULT 0
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of MUS_COMMENT
-- ----------------------------
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('31', '21', NULL, '22', '浓度过高', TO_TIMESTAMP('2025-04-24 16:08:37.845000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '0');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('32', '21', NULL, '27', 'zzz~', TO_TIMESTAMP('2025-04-24 16:08:45.275000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('35', '2', NULL, '22', '浓度过低', TO_TIMESTAMP('2025-04-24 16:14:25.267000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '0');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('22', '1', NULL, '24', 'bravo!', TO_TIMESTAMP('2025-04-24 16:01:21.799000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '2');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('25', '1', NULL, '21', '并非流行', TO_TIMESTAMP('2025-04-24 16:02:31.060000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '2');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('26', '1', '33', NULL, 'you''ll be alright', TO_TIMESTAMP('2025-04-24 16:03:45.380000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '0', '0');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('28', '1', '42', NULL, 'Relax', TO_TIMESTAMP('2025-04-24 16:04:19.018000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '0', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('30', '21', '39', NULL, 'Where Are You', TO_TIMESTAMP('2025-04-24 16:08:19.837000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '0', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('34', '2', '13', NULL, 'ghost', TO_TIMESTAMP('2025-04-24 16:09:58.042000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '0', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('36', '1', NULL, '2', 'hello world~', TO_TIMESTAMP('2025-04-24 23:11:03.642000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('33', '2', NULL, '27', 'zzz~', TO_TIMESTAMP('2025-04-24 16:09:05.319000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('23', '1', NULL, '27', 'zzz~', TO_TIMESTAMP('2025-04-24 16:01:31.590000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '3');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('21', '1', '14', NULL, '豪庭！', TO_TIMESTAMP('2025-04-23 20:58:20.457000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '0', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('24', '1', NULL, '1', '好听：—）', TO_TIMESTAMP('2025-04-24 16:02:13.073000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '1');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('27', '1', '45', NULL, 'To the Moon', TO_TIMESTAMP('2025-04-24 16:03:57.058000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '0', '0');
INSERT INTO "MUS_COMMENT" ("ID", "USER_ID", "SONG_ID", "SONG_LIST_ID", "CONTENT", "CREATE_TIME", "TYPE", "UP") VALUES ('29', '21', NULL, '25', 'not bad bro', TO_TIMESTAMP('2025-04-24 16:07:47.441000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '1', '1');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for RANK_LIST
-- ----------------------------
DROP TABLE "RANK_LIST";
CREATE TABLE "RANK_LIST" (
  "ID" NUMBER(10,0) NOT NULL,
  "SONG_LIST_ID" NUMBER(10,0) NOT NULL,
  "CONSUMER_ID" NUMBER(10,0) NOT NULL,
  "SCORE" NUMBER(10,0) DEFAULT 0
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of RANK_LIST
-- ----------------------------
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('25', '22', '1', '7');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('29', '27', '1', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('38', '29', '21', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('42', '23', '2', '7');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('43', '1', '2', '10');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('4', '2', '1', '6');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('23', '23', '1', '8');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('28', '26', '1', '6');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('30', '21', '1', '8');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('32', '25', '21', '8');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('35', '26', '21', '8');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('45', '29', '2', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('3', '1', '1', '10');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('39', '22', '21', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('40', '27', '2', '10');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('41', '26', '2', '8');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('44', '22', '2', '10');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('21', '2', '2', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('22', '29', '1', '8');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('24', '28', '1', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('26', '25', '1', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('27', '24', '1', '10');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('31', '21', '21', '7');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('33', '28', '21', '8');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('34', '2', '21', '7');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('36', '24', '21', '9');
INSERT INTO "RANK_LIST" ("ID", "SONG_LIST_ID", "CONSUMER_ID", "SCORE") VALUES ('37', '1', '21', '8');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for SINGER
-- ----------------------------
DROP TABLE "SINGER";
CREATE TABLE "SINGER" (
  "ID" NUMBER(10,0) NOT NULL,
  "NAME" VARCHAR2(45 BYTE) NOT NULL,
  "SEX" NUMBER(1,0),
  "PIC" VARCHAR2(255 BYTE),
  "BIRTH" DATE,
  "LOCATION" VARCHAR2(45 BYTE),
  "INTRODUCTION" VARCHAR2(1024 BYTE)
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of SINGER
-- ----------------------------
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('22', '杜德伟', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/90f79b28-88d2-4b2e-bd05-427595b133b5.jpg', TO_DATE('1962-02-10 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '中国香港', '杜德伟（Alex To），1962年2月10日出生于香港，拥有中国、西班牙和菲律宾血统，毕业于多伦多科技学院商业设计科 。华语流行乐男歌手、音乐人、演员');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('24', 'aioi(镰田纯子)', '0', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/b5d061b9-228e-4718-b419-34037db107d0.jpg', TO_DATE('1979-10-04 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '日本', '镰田纯子（kamata junko、1979年10月4日天秤座～ ），创作型J-POP歌手，出身于日本兵库县尼崎。2002年从大阪的音乐专校毕业，开始了音乐活动。2008年夏上京。在2002年到2008间，她参与过歌曲的合声，也担当过舞台剧的声出演。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('26', '久石让', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/a727f437-6bf3-493b-bb32-97443c0e75b1.jpg', TO_DATE('1950-12-06 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '日本', '久石让（ひさいし じょう；Joe Hisaishi），1950年12月6日出生于日本中野市，日本音乐人、作曲家、钢琴家。毕业于日本国立音乐大学');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('29', 'LISA', '0', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/cd7371cf-3c4b-4043-888a-1f01de7d3948.jpg', TO_DATE('1987-06-24 09:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '日本', 'LiSA，本名织部里沙，1987年6月24日出生于日本岐阜县，日本女歌手');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('30', 'Tchaikovsky', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/0783dc99-f90c-4966-a281-e75370f97876.jpg', TO_DATE('1840-05-07 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '俄罗斯', '彼得·伊里奇·柴可夫斯基（Peter Ilyich Tchaikovsky，1840年5月7日—1893年11月6日），出生于伏特金斯克市，俄罗斯浪漫乐派作曲家 [1]。
1864年，从圣彼得堡音乐学院毕业。1867年，《第一交响曲》在莫斯科首次演出。1870年，幻想序曲《罗密欧与朱丽叶》在莫斯科初次演出。1876年，与梅克夫人开始通信。1877年，芭蕾舞剧《天鹅湖》首演。1879年，歌剧《叶甫盖尼·奥涅金》首演。1880年，《意大利随想曲》首演。1888年，《第五交响曲》在圣彼得堡首演。1885年，完成了作品《曼弗雷德》。1890年，创作歌剧《黑桃皇后》。1892年，芭蕾舞剧《胡桃夹子》在圣彼得堡首演。1893年，创作《第六交响曲》；1893年11月6日，逝世');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('41', 'test', '1', 'img/avatorImages/singer.jpg', TO_DATE('2025-04-16 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '中国', '123');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('1', 'test_singer', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/ec09a371-df9d-44f3-92ce-c82038a9d127.png', TO_DATE('2025-04-10 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '吉林长春', 'test');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('5', 'Big Thief', '2', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/62b80d89-eeb2-43fc-9d61-8d42d3228a1b.jpg', TO_DATE('2015-04-18 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '美国', 'Big Thief是一支美国独立民谣乐队，2015 年成立于纽约布鲁克林。乐队成员包括Adrianne Lenker（主唱、吉他）、Buck Meek（吉他、伴唱）和James Krivchenia（鼓）。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('21', 'Erik Satie (埃里克·萨蒂)', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/62d5ef58-9479-442d-ba48-2bd4fe4d1a8f.jpg', TO_DATE('1866-05-17 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '法国', '埃里克·阿尔弗雷德·莱斯利·萨蒂（法文名Eric Alfred Leslie Satie 1866年5月17日-1925年7月1日），后来自己改名为Erik Satie，法国作曲家。代表作品有钢琴曲《玄秘曲3首》和《3首萨拉班德》，交响戏剧《苏格拉底》，舞剧《游行》《炫技表演》和《松弛》。
埃里克·萨蒂以率直质朴的音乐风格著称，其音乐观点对现代音乐有举足轻重的影响，是新古典主义的先驱。他的全部创作以钢琴作品所占的比例最高，并多为小品。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('23', 'V.K克', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/b670775f-eae5-48db-923a-679563deab05.jpg', TO_DATE('1982-11-18 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '中国台湾', 'V.K克，1982年11月18日生于中国台湾省基隆市，配乐作曲家、流行钢琴家。音乐风格：新世纪、POP、交响乐。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('25', 'mellow fellow', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/2d160f61-6a4f-4f90-8782-04b2f8531b7c.jpg', TO_DATE('2025-04-24 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '菲律宾', '菲律宾独立音乐人 在Mellow Fellow Studios 担任 CEO, Producer, Musician 曾在 De La Salle University 学习');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('4', 'Megumi Acorda', '2', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/3ca8421f-a9a4-4787-9da4-dfe0ba702b6f.jpg', TO_DATE('2025-04-19 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '菲律宾', 'Megumi Acorda（此人）一直在与几个乐队一起表演和创作音乐，同时也在创作和录制自己的音乐。几年来，一些版本和演示在网上零星地发布，最终吸引了大量的音乐听众。 Megumi Acorda（乐队）现在是一个五人乐队，演奏的音乐风格为梦幻流行音乐，或者任何能够捕捉旋律、模糊和个人同步的声音。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('6', '落日飞车', '2', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/324e7dd2-4440-4276-b9b2-29f41c323771.jpg', TO_DATE('2025-04-19 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '中国台湾', '浪漫流行樂團「落日飛車」由曾國宏 (主唱、吉他)、陳弘禮 (貝斯)、羅尊龍 (鼓)、王少軒 (鍵盤) 及 黃浩庭 (薩克斯風) 組成。生活地方濕潤又鬆弛的空氣瀰漫在他們的音樂中，在樂曲裡合成出亞熱帶海岸線的繁茂元素，從美式靈魂樂、R&B、搖滾，到日式 City Pop 霓光四射的爵士放客本色，再吸取華語流行樂餘音繞樑久久不散的哀傷情懷。長年在獨立音樂沃土上合作音樂的歷練，更將 DIY 精神及車庫搖滾的精力深植在飛車靈魂裡。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('27', 'Kan Gao', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/8aa03051-947a-423e-aa49-8118b6b7ab1f.jpg', TO_DATE('2025-04-24 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '加拿大', '高瞰(Kan Gao 网名Reives)是加拿大独立游戏设计师，原籍山东东营。成立了独立游戏工作室自由鸟（Freebird games）。加拿大西安大略大学（韦仕敦大学）毕业生。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('28', 'MIKA', '1', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/3920a9e2-b592-4cd3-8818-b0fffbf34a7e.jpg', TO_DATE('1983-08-13 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '黎巴嫩', '米卡（英文名：Mika，全名：Mika Penniman），全名米卡·彭尼曼，1983年8月18日出生于黎巴嫩，英国男歌手、词曲作者。
隶属环球唱片旗下的卡萨布兰卡唱片公司，他于2006年尾至2007年头间开始走红。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('31', 'Queen', '2', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/088bfc27-d7e3-42a9-8cc9-fc7feb403cf1.jpg', TO_DATE('2025-04-24 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '英国', '皇后乐队（Queen），英国摇滚乐队，1971年在英国伦敦成立，由佛莱迪·摩克瑞、布赖恩·梅、罗杰？泰勒、约翰·迪肯组成。');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('32', 'Lana Del Rey', '0', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/singer/a1235d23-9925-4595-afc0-056d7c6078d2.jpg', TO_DATE('1985-06-21 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '美国', '拉娜·德雷（Lana Del Rey），原名伊丽莎白·伍里奇·格兰特（Elizabeth Woolridge Grant），1985年6月21日出生于美国纽约曼哈顿区，美国女歌手、词曲作者、模特');
INSERT INTO "SINGER" ("ID", "NAME", "SEX", "PIC", "BIRTH", "LOCATION", "INTRODUCTION") VALUES ('35', '123', '1', 'img/avatorImages/singer.jpg', TO_DATE('2025-04-25 08:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for SONG
-- ----------------------------
DROP TABLE "SONG";
CREATE TABLE "SONG" (
  "ID" NUMBER(10,0) NOT NULL,
  "SINGER_ID" NUMBER(10,0) NOT NULL,
  "NAME" VARCHAR2(100 BYTE) NOT NULL,
  "INTRODUCTION" VARCHAR2(255 BYTE),
  "CREATE_TIME" TIMESTAMP(6) NOT NULL,
  "UPDATE_TIME" TIMESTAMP(6) NOT NULL,
  "PIC" VARCHAR2(255 BYTE),
  "LYRIC" CLOB,
  "URL" VARCHAR2(255 BYTE) NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of SONG
-- ----------------------------
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('21', '21', 'Gymnopédie No. 1', 'Gymnopédies', TO_TIMESTAMP('2025-04-24 11:16:09.294000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:16:09.294000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/82fcdd60-eede-4a36-a26a-c5ea59ac32af.jpeg', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/d282f41a-de4f-4752-a11c-59b213c8002e.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('22', '22', '情人', '滚石30周年精选珍藏集', TO_TIMESTAMP('2025-04-24 11:20:12.352000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:20:21.548000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/9f3c3008-3681-4249-8011-83b9081f7efa.jpeg', '？[00:00.00]作词 : 于光中
[00:00.38]作曲 : 林健华
[00:00.76]编曲 : 王继康
[00:01.15]Girl 每当我开始沉默的时候
[00:05.02]你比我更难过 好像你的错
[00:11.29]Girl 每当我梦想未来的时候
[00:15.83]你兴奋的感受 比我还要多
[00:21.66]轻柔 像阵微风 吹过 我的心中
[00:32.25]一切都会不同 透过了你的眼
[00:38.41]情人 爱却更多 虚情假意的话不说
[00:48.68]只用一颗真心 默默爱我
[00:52.68]最珍贵的感动 尽在不言中
[01:05.76]Girl 我不是故意对你冷落
[01:10.44]大部份的时候 我不够温柔
[01:16.56]Girl 我强烈感到时间不够
[01:21.29]想牵着你的手 对抗寂寞
[01:27.09]轻柔 像阵微风 让我 从容不迫
[01:37.73]一切 都会不同 有了你在身边
[01:44.18]情人 爱却更多 虚情假意的话不说
[01:54.50]只用一颗真心 默默爱我
[01:58.91]最珍贵的感动 尽在不言中
[02:27.80]我唯一的情人 爱却更多
[02:31.56]虚情假意的话不说
[02:38.49]只用一颗真心 默默爱我
[02:42.57]最珍贵的感动 My love
[02:50.04]情人 爱却更多 开始就要爱到最后
[03:00.39]於是你我真心 越来越浓
[03:05.02]最珍贵的感动 藏在我心中
[03:12.72]情人 爱却更多 开始就要爱到最后
[03:22.87]於是你我真心 越来越浓
[03:26.85]最珍贵的感动 藏在我心中
[03:33.97]', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/da7fc7e5-f38c-423b-a923-4817bb7b3f5d.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('23', '1', 'Sakura Iro No Yume', 'Deemo', TO_TIMESTAMP('2025-04-24 11:23:23.935000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:23:23.936000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/3d5c852a-286f-453d-88a2-e9c40c0e94cb.jpeg', '？[00:27.74]忘れられない　人の面影 无法忘怀的人的身影
[00:41.39]遠い空に返したら 回到远方的天空时
[00:48.00]さくら舞い散る 樱花将凋谢飘落
[00:55.93]川沿いの道を二人で 两人沿着小河
[00:58.33]歩いたあの日 漫步的那天
[01:02.55]雪解けの水が 溶解的冰水
[01:04.35]川面に煌めいて 在河面闪闪发光
[01:09.40]満開の桜の下で 在樱花盛开的树下
[01:11.95]君と未来を 与你
[01:15.62]語り合ったのに 互相说着未来
[01:23.19]忘れられない人 无法忘怀的人
[01:29.90]の面影 的身影
[01:36.25]遠い空に返したら 回到远方的天空时
[01:42.81]さくら舞い散る 樱花将凋谢飘落
[02:18.44]古い街並みを一人で 这个春天
[02:20.76]歩くこの春 一个人走在熟悉的街道上
[02:24.61]山から吹き降ろす 从山头吹来的风
[02:26.76]風は冷たくて 如此刺骨
[02:31.56]未だ癒えていない傷を 伤口未愈的我
[02:34.46]抱えた僕を 抱着的我
[02:38.27]包む　陽球に 和煦的阳光照射着
[02:44.83]忘れられない　人の面影 无法忘怀的人的身影
[02:58.38]遠い空に返したら 回到远方的天空时
[03:05.04]さくら舞い散る 樱花将凋谢飘落
[03:11.99]忘れられない　人の面影 无法忘怀的人的身影
[03:25.79]遠い空に返したら 回到远方的天空时
[03:32.35]さくら舞い散る 樱花将凋谢飘落', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/34a63d37-3bf4-4df6-bf33-12c651169620.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('24', '1', 'Fluquor (feat. Rin)', 'Testimony Cytus / Deemo', TO_TIMESTAMP('2025-04-24 11:24:56.079000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:24:56.079000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/541a3ea7-d337-41f7-8951-6a30b5e9ddb4.jpeg', '[00:00.00]Fluquor (feat. Rin) - onoken/Rin
[00:14.44]詞：onoken
[00:28.88]曲：onoken
[00:43.32]悲しみは何を呼ぶだろう 悲伤会带来什么呢
[00:54.16]遠ざかる空は 渐行远去的天空
[00:57.29]僕をそっと拒んでく 悄悄地拒绝着我
[01:05.28]幼い君の指先が 你稚嫩的手指
[01:09.00]拾いあげる 将丢失的碎片
[01:10.71]なくした欠片 捡起来
[01:14.35]心を重ねて 将心重叠
[01:17.16]生まれた景色は 产生的景色
[01:21.36]泣きたいくらいに 让人想哭出来一般
[01:25.02]儚くふわり積もる 缥缈地轻轻堆积
[01:30.53]想いはいつまでも 思念永远
[01:35.51]果てなく遠い世界で 在无边无际的世界里
[01:41.11]君を探している 寻找着你
[02:05.81]行かないでと君は言うけど 虽然你挽留说请不要走
[02:16.68]ひとりでいられないのは 其实无法孤独一人生活的
[02:21.10]きっと僕の方 一定是我
[02:27.33]君の為できるのは 为了你我能做到的是
[02:31.15]ここで奏で続けること 在这里一直弹奏下去
[02:36.32]だからもうお帰り 所以请你回去吧
[02:39.03]この手を離して 趁着我还能
[02:43.44]あげられるうちに 放开这双手的时候
[02:47.06]きらめく記憶の中で 在闪耀的记忆中
[02:52.63]微笑む君を見た 看到了笑容满面的你
[02:57.73]歪な祈りの歌に 在扭曲的祈祷的歌声里
[03:03.08]夢の終わりを知る 我知道了梦将要结束
[03:05.95]いつかこの想いは 总有一天 这份思念
[03:11.14]君の手舞い降りて 会飞舞飘落在你的手中
[03:16.24]触れては溶けてゆくよ 如果触摸它就会消融掉的哦
[03:21.70]命の優しさで 因为生命的温柔', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/4d2656e0-fcd3-4680-9d33-9ea4ad19d5b6.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('42', '28', 'Relax, Take It Easy', 'Relax, Take It Easy', TO_TIMESTAMP('2025-04-24 12:24:02.509000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:24:02.509000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/59ec5afa-abed-44cb-b76f-e76dc7a59c8f.jpeg', '[ti:Relax]
[ar:Mika]
[al:Elegant Lounge]
[00:00.00]Relax, Take It Easy (Album Version) - MIKA (米卡)
[00:15.51]Took a ride to the end of the line 驾着车去到世界的尽头
[00:19.39]
[00:19.90]Where no one ever goes 那个没有人去过的地方
[00:22.12]
[00:23.20]Ended up on a broken train with nobody I know 结果却上了这个塞满陌生人的破火车
[00:30.15]
[00:31.11]But the pain and the longing''s the same 但是伤痛和渴望依旧相伴
[00:35.07]Where the dying 在这个毫无生气的地方
[00:36.62]
[00:39.06]Now I''m lost and I''m screaming for help alone 现在我迷失了方向 渴望帮助
[00:43.65]Relax take it easy 放松点 别紧张
[00:47.91]
[00:48.71]For there is nothing that we can do 因为我们现在无能为力
[00:51.88]Relax take it easy 别紧张
[00:55.79]
[00:56.72]Blame it on me or blame it on you 归咎于我或归咎于你都无济于事
[00:59.43]
[01:06.64]It''s as if I''m scared 好像我也感到很恐惧
[01:07.77]
[01:08.57]It''s as if I''m terrified 好像我也受到了惊吓
[01:10.84]It''s as if I scared 好像我也感到很恐惧
[01:11.85]
[01:12.57]It''s as if I''m playing with fire 好像我在玩火
[01:14.81]Scared 恐惧
[01:15.48]
[01:16.26]It''s as if I''m terrified 好像我也受到了惊吓
[01:17.68]Are you scared 你害怕吗
[01:18.67]
[01:20.59]Are we playing with fire 我们真的在玩火吗
[01:22.76]Relax 别紧张
[01:23.16]
[01:25.08]There is an answer to the darkest times 在这最暗淡的年代 答案只有一个
[01:29.24]
[01:30.05]It''s clear we don''t understand but the last thing on my mind 很显然 我们也许不明白
[01:37.19]
[01:37.95]Is to leave you 但我想的最后一件事 就是离开你
[01:39.98]I believe that we''re in this together 我相信我们还会相聚
[01:42.91]
[01:45.98]Don''t scream there are so many roads left 不要害怕 人生依旧有很多路可以走
[01:50.59]Relax take it easy 放松点 别紧张
[01:54.57]
[01:55.58]For there is nothing that we can do 因为我们现在无能为力
[01:58.47]Relax take it easy 别紧张
[02:02.16]
[02:03.56]Blame it on me or blame it on you 归咎于我或归咎于你都无济于事
[02:06.71]Relax take it easy 放松点 别紧张
[02:10.24]
[02:11.28]For there is nothing that we can do 因为我们现在无能为力
[02:13.80]Relax take it easy 别紧张
[02:17.50]
[02:19.29]Blame it on me or blame it on you 归咎于我或归咎于你都无济于事
[02:22.33]
[02:37.66]Relax take it easy 放松点 别紧张
[02:42.01]
[02:42.81]For there is nothing that we can do 因为我们现在无能为力
[02:45.36]Relax take it easy 放松点 别紧张
[02:49.28]
[02:50.68]Blame it on me or blame it on you 归咎于我或归咎于你都无济于事
[02:53.33]Relax take it easy 放松点 别紧张
[02:57.69]
[02:58.49]For there is nothing that we can do 因为我们现在无能为力
[03:01.18]Relax take it easy 放松点 别紧张
[03:06.11]Blame it on me or blame it on you 归咎于我或归咎于你都无济于事
[03:08.73]Relax 别紧张
[03:10.58]It''s as if I''m terrified 好像我也受到了惊吓
[03:12.78]Are you scared 好像我也感到很恐惧
[03:13.50]
[03:14.28]Are we playing with fire 好像我在玩火
[03:16.17]
[03:16.73]Relax 放轻松
[03:17.45]It''s as if I''m terrified 好像我也受到了惊吓
[03:19.54]Are you scared 好像我也感到很恐惧
[03:20.35]
[03:22.52]Are we playing with fire 好像我在玩火
[03:24.72]
[03:25.28]Relax 放轻松
[03:25.83]
[03:32.88]Relax 放轻松', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/8e0beeef-7b52-424f-9dbd-0f9377627b6e.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('44', '1', 'Beneath the Mask', '「ペルソナ5」オリジナル？サウンドトラック', TO_TIMESTAMP('2025-04-24 12:27:05.758000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:27:05.758000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/93e401b3-06ef-4d19-8aa2-ec95cba08d1e.jpeg', '[00:05.00]纯音乐，请欣赏', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/d2dbd5a8-de88-47d3-b4d5-d9f491e3b3e2.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('43', '28', 'Happy Ending', 'Heartbreak Hits', TO_TIMESTAMP('2025-04-24 12:25:42.312000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:25:42.312000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/037e6e0a-e26a-47d6-9920-1e72cbae8b2d.png', '[ti:Happy Ending]
[ar:Mika]
[al:Power Hits 3(冠军全击3)]
[00:00.00]Happy Ending - MIKA (米卡)
[00:00.83]This is the way you left me 你就这样的离开了我
[00:02.50]
[00:03.28]I''m not pretending 我真的没有在伪装
[00:04.69]
[00:05.71]No hope no love no glory 失去希望 爱情不再 光辉遁迹
[00:07.45]
[00:08.19]No happy ending 没有美好结局
[00:09.69]
[00:10.67]This is the way that we love 我们那样相爱
[00:12.56]
[00:13.20]Like it''s forever 就像能够永恒
[00:14.65]
[00:15.69]Then live the rest of our life 然后度过余生
[00:17.52]
[00:18.21]But not together 我们却分手了
[00:19.73]
[00:21.11]Wake up in the morning 早晨醒来
[00:21.95]
[00:22.93]Stumble on my life 无意间发现
[00:24.14]
[00:25.67]Can''t get no love 我的人生无法
[00:26.70]
[00:27.64]Without sacrifice 不作出牺牲就得到爱
[00:28.49]
[00:30.80]If anything should happen 如果要发生什么
[00:31.97]
[00:32.77]I guess I wish you well 我想我会祝福你
[00:34.38]
[00:35.84]A little bit of heaven 点点极乐
[00:36.81]
[00:37.60]But a little bit of hell 点点痛苦
[00:38.81]
[00:41.37]This is the hardest story 这是我所讲过的
[00:42.45]
[00:43.86]That I''ve ever told 最痛苦的故事
[00:44.84]
[00:46.26]No hope or love or glory 失去希望 爱情不再 光辉遁迹
[00:47.81]Happy endings gone forever more 美好结局永远消失
[00:50.42]
[00:51.36]I feel as if I''m wastin'' 觉得自己在挥霍
[00:56.10]
[01:00.08]And I''m wastin'' everyday 浪费掉每一天
[01:05.27]
[01:10.92]This is the way you left me 你就这样的离开了我
[01:12.55]
[01:13.19]I''m not pretending 我真的没有在伪装
[01:14.70]
[01:15.71]No hope no love no glory 失去希望 爱情不再 光辉遁迹
[01:17.49]
[01:18.17]No happy ending 没有美好结局
[01:19.75]
[01:20.67]This is the way that we love 我们那样相爱
[01:22.50]
[01:23.16]Like it''s forever 就像能够永恒
[01:24.80]
[01:25.70]Then live the rest of our life 然后度过余生
[01:27.54]
[01:28.24]But not together 我们却分手了
[01:29.59]
[01:30.80]2 o''clock in the morning 凌晨两点
[01:31.86]
[01:32.88]Something''s on my mind 思绪万千
[01:34.13]
[01:35.73]Can''t get no rest 无心休息
[01:36.76]
[01:37.69]Keep walkin'' around 走来走去
[01:38.80]
[01:40.67]If I pretend that nothin'' 如果我装的
[01:42.42]
[01:43.03]Ever went wrong 像什么都没错
[01:43.92]
[01:45.60]I can get to my sleep 我想我会入睡
[01:47.00]I can think that we just carried on 我想我会继续自己的生活
[01:48.95]
[01:51.39]This is the hardest story 这是我所讲过的
[01:52.39]
[01:53.76]That I''ve ever told 最痛苦的故事
[01:54.67]
[01:56.25]No hope or love or glory 失去希望 爱情不再 光辉遁迹
[01:57.38]
[01:57.96]Happy endings gone forever more 美好结局永远消失
[02:00.06]
[02:01.01]I feel as if I''m wastin'' 觉得自己在挥霍
[02:06.27]
[02:10.08]And I''m wastin'' everyday 浪费掉每一天
[02:15.27]
[02:21.13]This is the way you left me 你就这样的离开了我
[02:22.59]
[02:23.19]I''m not pretending 我真的没有在伪装
[02:24.69]
[02:25.76]No hope no love no glory 失去希望 爱情不再 光辉遁迹
[02:27.45]
[02:28.21]No happy ending 没有美好结局
[02:29.72]
[02:30.72]This is the way that we love 我们那样相爱
[02:32.56]
[02:33.21]Like it''s forever 就像能够永恒
[02:34.64]
[02:35.73]Then live the rest of our life 然后度过余生
[02:37.52]
[02:38.17]But not together 我们却分手了
[02:39.83]
[02:49.72]Little bit of love 点滴的爱
[02:50.39]
[02:51.04]Little bit of love 点滴的爱
[02:52.19]Little bit of love 点滴的爱
[02:53.37]Little bit of love 点滴的爱
[02:54.57]Little bit of love 点滴的爱
[02:55.42]
[02:55.92]Little bit of love 点滴的爱
[02:56.64]
[02:57.17]Little bit of love 点滴的爱
[02:58.38]Little bit of love 点滴的爱
[02:59.63]Little bit of love 点滴的爱
[03:00.93]Little bit of love 点滴的爱
[03:02.09]Little bit of love 点滴的爱
[03:03.37]Little bit of love 点滴的爱
[03:04.14]
[03:04.81]Little bit of love 点滴的爱
[03:05.48]
[03:06.05]Little bit of love 点滴的爱
[03:07.10]Little bit of love 点滴的爱
[03:08.38]Little bit of love 点滴的爱
[03:09.62]Little bit of love 点滴的爱
[03:10.94]Little bit of love 点滴的爱
[03:12.14]Little bit of love 点滴的爱
[03:12.93]
[03:13.43]Little bit of love 点滴的爱
[03:14.65]Little bit of love 点滴的爱
[03:15.39]
[03:16.00]Little bit of love 点滴的爱
[03:17.13]Little bit of love 点滴的爱
[03:18.42]Little bit of love 点滴的爱
[03:19.61]Little bit of love 点滴的爱
[03:20.77]Little bit of love 点滴的爱
[03:21.38]
[03:22.13]Little bit of love 点滴的爱
[03:23.00]
[03:23.57]Little bit of love 点滴的爱
[03:24.28]I feel as if I''m wastin'' 觉得自己在挥霍浪费掉每一天
[03:26.47]
[03:27.35]Little bit of love 点滴的爱
[03:28.39]Little bit of love 点滴的爱
[03:29.67]Little bit of love 点滴的爱
[03:30.56]And I''m wastin'' everyday 觉得自己在挥霍浪费掉每一天
[03:35.18]
[03:37.57]Hey hey hey hey
[03:39.43]
[03:41.06]This is the way you left me 你就这样的离开了我
[03:42.50]
[03:43.23]I''m not pretending 我真的没有在伪装
[03:44.71]
[03:45.63]No hope no love no glory 失去希望 爱情不再 光辉遁迹
[03:47.47]
[03:48.21]No happy ending 没有美好结局
[03:49.74]
[03:50.70]This is the way that we love 我们那样相爱
[03:52.57]
[03:53.21]Like it''s forever 就像能够永恒
[03:54.68]
[03:55.73]Then live the rest of our life 然后度过余生
[03:58.04]But not together 我们却分手了
[03:59.67]
[04:00.73]This is the way you left me 你就这样的离开了我
[04:02.59]
[04:03.18]I''m not pretending 我真的没有在伪装
[04:04.77]
[04:05.62]No hope no love no glory 失去希望 爱情不再 光辉遁迹
[04:07.49]
[04:08.21]No happy ending 没有美好结局
[04:09.71]
[04:10.66]This is the way that we love 我们那样相爱
[04:12.51]
[04:13.24]Like it''s forever 就像能够永恒
[04:14.72]
[04:15.71]Then live the rest of our life 然后度过余生
[04:17.56]
[04:18.20]But not together 我们却分手了
[04:19.66]
[04:20.68]This is the way you left me 你就这样的离开了我
[04:22.54]
[04:23.17]I''m not pretending 我真的没有在伪装
[04:24.63]
[04:25.65]No hope no love no glory 失去希望 爱情不再 光辉遁迹
[04:27.35]
[04:28.07]No happy ending 没有美好结局', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/7b058f58-492a-4920-9d67-b6a78dd9c69a.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('11', '4', 'Aftershow', 'Unexpectedly', TO_TIMESTAMP('2025-04-19 13:26:06.018000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:26:06.018000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/a310bdbb-b653-42f6-bc22-8a264567785f.jpeg', '[00:00.07]Megumi Acorda - Aftershow
[00:49.54]We''ve got nowhere else to be 我们无处可去
[00:59.29]And it''s getting kind of cold 天气变得愈发寒冷
[01:08.61]I''m warmest when you''re close to me 当你在我身边的时候 我才会感觉到温暖
[01:18.19]And I would like to take you home 我想要带你回家
[01:26.29]If loneliness comes crashing in 如果孤独慢慢将我吞没
[01:35.36]You can hold me it''s okay 你可以将我拥入怀中 没关系
[01:45.13]If she makes you feel so empty 如果她让你感觉到空虚
[01:54.73]You can hurt me it''s okay 你可以伤害我 没关系
[02:04.25]And if maybe she decides to stay 如果她决定留下来
[02:13.93]We can dance to songs that she will play 我们可以跟随着她的播放列表 翩翩起舞
[02:24.47]All these walls heard me before 所有的墙壁都听到了
[02:35.38]Wrap my lips around your name 我在睡梦中呼唤着你的名字
[02:44.88]Leave this memory on my floor 将这些回忆全都忘记吧
[02:54.36]Coffee cups with lipstick stains 咖啡杯上还留着唇印
[03:02.36]If loneliness comes crashing in 如果孤独慢慢将我吞没
[03:11.38]You can hold me it''s okay 你可以将我拥入怀中 没关系
[03:21.11]If she makes you feel so empty you 如果她让你感觉到空虚
[03:31.00]Can hurt me it''s okay 你可以伤害我 没关系
[03:40.31]And if maybe she decides to stay 如果她决定留下来
[03:49.95]We can dance to songs that she will play 我们可以跟随着她的播放列表 翩翩起舞
[04:38.01]And if maybe you decide to stay 如果你决定留下来
[04:47.50]I can show you things that I can''t say 我会告诉你 那些埋藏在我心底的话语', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/cbe8a123-abb4-4005-87f9-ad42088ff51c.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('3', '1', 'It''s Raining Somewhere Else', 'UNDERTALE Soundtrack', TO_TIMESTAMP('2025-04-10 07:11:22.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-10 07:11:22.000000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/1fe4f7f3-1ea7-419b-a9f8-021cf36c2bf1.jpeg', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/166e7d8a-d4a3-4aa1-8fd7-1246b3fbc1f0.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('13', '4', 'Ghost', 'Unexpectedly', TO_TIMESTAMP('2025-04-19 13:29:25.586000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:29:25.586000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/4973a29a-62fb-4b06-a92b-e76202acd6e5.jpeg', '[00:00.08]Megumi Acorda - ghost
[00:32.59]There is so much I can do 我有很多事情要做
[00:47.12]None can take me back to you 没有人能把我带回你的身边
[00:58.64]Lately why is nothing as exciting 最近一段时间 为什么我总是提不起精神来
[01:07.87]I could use a second helping 我需要有人来拉我一把
[01:15.07]Of the things my soul fed on before 让我的灵魂有枝可栖
[01:30.73]Dancing in my head last night 昨晚 我浮想联翩
[01:45.25]Dreams of different ways to die 梦见很多种不同的死法
[01:56.80]If a ghost is what I am to many 如果对很多人来说 我就像鬼魅一般
[02:05.98]No one knows me like you know me 没有人像你一样了解我
[02:13.18]I exist to nobody but you 除了你 任何人我都视为空气
[02:54.97]If a ghost is what I am to many 如果对很多人来说 我就像鬼魅一般
[03:04.05]No one knows me like you know me 没有人像你一样了解我
[03:11.24]I exist to nobody but you 除了你 任何人我都视为空气
[03:22.54]I I exist for nobody but you 除了你 任何人我都视为空气', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/fddcb7eb-d50b-4733-8f51-5972163d8715.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('10', '4', 'Songs of the Sea', 'Silver Fairy', TO_TIMESTAMP('2025-04-19 13:20:29.465000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:20:29.465000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/4f25eb84-e57e-4248-86ab-8448ae30b835.jpeg', '锘？[00:00.00]浣？？？ : Megumi Acorda
[00:18.99]I wonder what it''ll feel like
[00:26.72]When it''s finally my turn
[00:35.34]Will I hear all the songs of the sea
[00:42.24]Will I feel her arms wrapped around me
[00:52.75]Am I finally forgiven
[01:01.91]Or still denied for having
[01:10.52]A love that refuses to die
[01:17.41]The one thing that''s kept me alive
[02:03.21]In the final hour
[02:11.47]I''ll happily surrender
[02:19.70]Long as I hear the songs of the sea
[02:26.45]Long as I feel her arms around me
[02:36.83]When you listen to the songs of the sea
[02:44.03]I hope that you''ll think about me
[02:54.12]Oh I hope that you''ll think about me', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/bcab1516-16ac-4d47-9d28-2102f645df71.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('14', '5', 'Mythological Beauty', 'Mythological Beauty', TO_TIMESTAMP('2025-04-19 13:44:50.542000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-22 16:00:55.347000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/c30f348f-687f-44ce-95e2-e4506122afaa.jpeg', '？[00:00.08]Big Thief - Mythological Beauty
[00:18.67]You have a mythological beauty
[00:18.67]你拥有着神话般的美丽
[00:23.05]You have the eye of someone I have seen
[00:23.05]我仿佛见过你迷人的眼睛
[00:27.39]Outside of ordinary situations
[00:27.39]超越世间凡俗
[00:31.90]Even outside of dreams
[00:31.90]甚至超越梦境
[00:36.44]You lie in bed at night and watch the lines of headlights through your screen
[00:36.44]夜晚你躺在床上 看着车灯缓缓穿过你的银幕
[00:45.49]There is a child inside you who''s trying to raise a child in me
[00:45.49]你的心里住着一个孩子 想要和我心里的孩子一同成长
[00:55.59]If you wanna leave
[00:55.59]如果你想逃离
[01:00.04]You just have to say
[01:00.04]你只需说出来
[01:02.84]You''re all caught up inside
[01:02.84]你已深陷其中
[01:07.30]But you know the way
[01:07.30]但你心知肚明
[01:12.46]You cut the flesh of your left thumb
[01:12.46]你用你男朋友的刀
[01:16.97]Using your boyfriend''s knife
[01:16.97]割下了左手拇指的肉
[01:21.55]Seventeen you took his cum
[01:21.55]十七岁时 你和他在一起
[01:26.01]And you gave birth to your first life
[01:26.01]创造出你人生中的第一个小生命
[01:30.44]You gave Andrew a family who you thought would love and take better care
[01:30.44]你给了安德鲁一个家 你觉得可以给他充分的爱与照顾
[01:39.32]I have an older brother I don''t know
[01:39.32]我有一个哥哥 但我从未了解过他
[01:43.78]He could be anywhere
[01:43.78]他到处流浪 四海为家
[01:49.23]If you wanna leave
[01:49.23]如果你想逃离
[01:53.69]You just have to say
[01:53.69]你只需说出来
[01:56.67]You''re all caught up inside
[01:56.67]你已深陷其中
[02:00.96]But you know the way
[02:00.96]但你心知肚明
[02:05.46]You''re all caught up inside
[02:05.46]你已深陷其中
[02:09.72]But you know the way
[02:09.72]但你心知肚明
[02:15.04]Rented a house in Nisswa Minnesota
[02:15.04]曾在明尼苏达的尼斯瓦租了一栋房子
[02:19.57]Shrapnel and oil cans rhubarb in the yard
[02:19.57]碎片和油罐堆积成山 后院里喧喧嚷嚷
[02:24.04]I built a ladder out of metal pieces
[02:24.04]我用金属片造了一个梯子
[02:28.55]Father was working hard
[02:28.55]爸爸当时正在努力工作
[02:32.99]Standing beneath the oak tree by the front door
[02:32.99]站在前门的橡树下
[02:37.48]You were inside baking bread
[02:37.48]你在里面烤面包
[02:42.01]Sister came out and put her arms around me
[02:42.01]姐姐出来抱紧了我
[02:46.49]Blood gushing from my head
[02:46.49]鲜血从我的头上涌出
[02:50.84]You held me in the backseat with a dishrag soaking up blood with your eyes
[02:50.84]你用抹布包住我的头 血溅在了你的眼睛上
[02:59.89]I was just five and you were twenty seven
[02:59.89]那时我只有五岁 而你已经二十七岁
[03:04.14]Praying don''t let my baby die
[03:04.14]你祈祷着 别让我的宝贝死去
[03:09.67]If you wanna leave
[03:09.67]如果你想逃离
[03:14.20]You just have to say
[03:14.20]你只需说出来
[03:17.09]You''re all caught up inside
[03:17.09]你已深陷其中
[03:21.39]But you know the way
[03:21.39]但你心知肚明
[03:26.17]You''re all caught up inside
[03:26.17]你已深陷其中
[03:30.57]But you know the way
[03:30.57]但你心知肚明
[03:37.87]So much more to live your life
[03:37.87]生活远远不止这些
[03:46.47]To walk the floor
[03:46.47]继续向前
[03:50.94]To say goodnight
[03:50.94]说声晚安
[03:55.61]Do you leave your light on
[03:55.61]你把灯打开了吗
[04:00.15]Do you leave your light on
[04:00.15]你把灯打开了吗
[04:11.70]You''re all caught up inside
[04:11.70]你已深陷其中
[04:15.93]But you know the way
[04:15.93]但你心知肚明
[04:20.72]You''re all caught up inside
[04:20.72]你已深陷其中
[04:25.29]But you know the way
[04:25.29]但你心知肚明
[04:30.01]You''re all caught up inside
[04:30.01]你已深陷其中
[04:34.25]But you know the way
[04:34.25]但你心知肚明
[04:39.04]You''re all caught up inside
[04:39.04]你已深陷其中
[04:43.22]But you know the way
[04:43.22]但你心知肚明', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/c3155c46-7598-4ee2-9168-c339c2964162.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('35', '1', 'Soul & Mind', NULL, TO_TIMESTAMP('2025-04-24 11:46:27.277000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:46:27.277000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), '/img/songPic/tubiao.jpg', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/48568865-32db-4f63-adec-2c3cfc05d185.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('15', '5', 'Coma', 'Capacity', TO_TIMESTAMP('2025-04-19 13:45:43.391000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:45:43.391000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/682208cf-2e57-4607-88b0-b64a1c67fa00.jpeg', '[00:00.00]Coma (昏迷) - Big Thief
[00:30.59]He put her in 他让她失去意识
[00:32.35]To get out 轻易逃脱
[00:33.78]To get out 轻易逃脱
[00:44.33]He kissed her skin 他亲吻着她的肌肤
[00:46.00]To get off 逃过惩罚
[00:47.40]To get off 逃过惩罚
[00:49.39]Off 离开
[01:00.34]You can wake up now momma 现在你可以清醒过来 妈妈
[01:05.57]From your protective coma 从你保护性质的昏迷中苏醒
[01:14.08]When you wake up 当你清醒来时
[01:16.70]You wake up 你清醒过来
[01:36.02]You won''t recognize your house 你连你的房子都认不出来
[01:41.84]You won''t recognize your house 你连你的房子都认不出来
[01:47.86]Will you recognize the 你能否认出
[01:55.80]Iris of the body 眼睛虹膜的颜色
[02:01.85]Iris of the body 眼睛虹膜的颜色
[02:07.78]You won''t recognize your house 你连你的房子都认不出来
[02:13.62]You won''t recognize your house 你连你的房子都认不出来
[02:19.57]Will you recognize the 你能否认出
[02:26.99]Iris of the body 眼睛虹膜的颜色
[02:33.23]Iris of the body 眼睛虹膜的颜色
[02:38.91]You won''t recognize your house 你连你的房子都认不出来
[02:44.70]You won''t recognize your house 你连你的房子都认不出来
[02:50.47]Will you recognize the 你能否认出
[02:58.12]Iris of the body 眼睛虹膜的颜色
[03:03.94]Iris of the body 眼睛虹膜的颜色
[03:09.78]You won''t recognize your house 你连你的房子都认不出来
[03:15.50]You won''t recognize your house 你连你的房子都认不出来
[03:21.28]You won''t recognize your house 你连你的房子都认不出来
[03:26.96]You won''t recognize your house 你连你的房子都认不出来
[03:32.68]You won''t recognize your house 你连你的房子都认不出来', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/77ef7271-4b06-4de9-a17a-e5c190bce87a.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('16', '5', 'Paul (Explicit)', 'Masterpiece', TO_TIMESTAMP('2025-04-19 13:46:17.382000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:46:17.382000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/64e0eaa1-4b4b-461f-a3c5-764dd506227a.jpeg', '[00:00.00]Paul (Explicit) - Big Thief
[00:00.69]Oh the last time I saw paul 最后一次遇见保罗
[00:04.08]I was horrible and almost let him in 我情绪低落 差点对他放下防备
[00:11.22]But I stopped and caught the wall 但我悬崖勒马
[00:15.19]And my mouth got dry so all I did was take him for a spin 我已无话可说 我只能带他出去兜风
[00:24.40]Yeah we hopped inside my car 我们跳进我的汽车
[00:28.69]And I drove in circles ''round the freight train yard 绕着货运火车站转了一圈又一圈
[00:36.29]And he turned the headlights off 他关掉了车灯
[00:40.25]Then he pulled the bottle out 拔开了酒瓶塞
[00:43.91]Then he showed me what was love 让我知道了什么是爱
[00:50.02]I''ll be your morning bright goodnight shadow machine 我会成为你的晨光 你的晚安吻 你的投影仪
[00:54.17]I''ll be your record player baby if you know what I mean 我会成为你的点唱机 宝贝 如果你能明白我的心意
[00:58.04]I''ll be your real tough cookie with the whiskey breath 我会是你小酌一杯时的小点心
[01:01.87]I''ll be a killer and a thriller and the cause of our death 我也可以成为可怕杀手 让我们一起死去
[01:07.36]In the blossom of the months 在花开的季节
[01:11.15]I was sure that I''d get driven off with thought 我确定 我会带着乱七八糟的想法离开
[01:18.66]So I swallowed all of it 所以 我将一切埋在心底
[01:22.55]As I realized there was no one who could kiss away my s**t 因为我明白 没有人可以让我的生活美好如初
[01:32.59]I''ll be your morning bright goodnight shadow machine 我会成为你的晨光 你的晚安吻 你的投影仪
[01:36.68]I''ll be your record player baby if you know what I mean 我会成为你的点唱机 宝贝 如果你能明白我的心意
[01:40.66]I''ll be your real tough cookie with the whiskey breath 我会是你小酌一杯时的小点心
[01:44.58]I''ll be a killer and a thriller and the cause of our death 我也可以成为可怕杀手 让我们一起死去
[02:15.85]Paul I know you said that you''d take me any way I came or went 保罗 我知道你说过 无论我何去何从 你都会如影随形
[02:26.38]But I''ll push you from my brain 但我要将你从我的脑海里抹去
[02:30.12]See you''re gentle baby 宝贝 你如此温柔迷人
[02:33.54]I couldn''t stay I''d only bring you pain 我只能让你伤痕累累 所以我无法留在你身旁
[02:40.70]I was your starry-eyed lover and the one that you saw 我曾是你幻想中的完美恋人
[02:44.67]I was your hurricane rider and the woman you''d call 曾在你需要时像飓风骑士一样飞奔而至
[02:48.69]We were just two moonshiners on the cusp of a breath 我们不过是在呼吸交汇中偷偷品尝了烈酒的气息
[02:52.86]And I''ve been burning for you baby since the minute I left 从我离你而去的那一刻起 我就开始为你燃烧自己', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/9d209f91-7901-407c-b8e7-9bbd6e5b6bdf.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('29', '24', 'Cream Stew', 'Aioi 2', TO_TIMESTAMP('2025-04-24 11:36:04.662000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:36:04.662000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/b049756e-d1bb-4c75-bd38-05c0ed3f68f6.jpeg', '[by:质量和]
[00:00.00]作曲 : Shun Imagawa
[00:20.00]落ち着かない 手につかない 私の隣にはあなたがいない 魂不守舍 心不在焉 你不在的日子度日如年
[00:25.00]久しぶり実家に帰ると家を出たのが三日前で 说是回趟老家也用不了三天这么久吧？
[00:30.00]行ってすぐは電話？メール ずっとやりとりしてたのに 明明才出门就给我打电话发短信
[00:35.00]そうやって私困らすつもりなんでしょ！？ 你这么做就是想气死我吗！？
[00:38.00]大好きなあなたのクリームシチュー作って欲しいよ 还想吃你做的奶油炖菜呢
[00:47.00]だいたいあなたの味には 再说 你的人生没有我的话
[00:51.00]私のスパイスが必要だと 也是不完整的
[00:56.00]わかっているかい？ 你懂的吧？
[00:58.00]
[01:07.00]さっきからずっとずっと探しているのに見つからないの 明明找了很久却还是找不到
[01:12.00]この部屋のことならだいたい あなたの方が知っているから 毕竟这个房间的犄角旮旯只有你最清楚
[01:16.00]"あれ"っていうだけでわかる あなたのことだから 要是你的话肯定一下就能想起
[01:21.00]そう 今の私の気持ち　わかるはずでしょ！ 所以你知道我现在有多困扰了吧！
[01:25.00]大好きなあなたのクリームシチュー作って欲しいよ 还想吃你做的奶油炖菜呢
[01:33.00]だいたい私のわがままは 再说 我的调皮任性
[01:37.00]あなたの前だけで有効だと 也只是给你一个人看的
[01:42.00]わかっているかい？ 你懂我意思吧？
[01:44.00]
[01:47.00]さんざん困らす私が言えることじゃないけど 也许不太像是个麻烦鬼说出来的话
[01:57.00]あなたの気持ちは 你的喜怒哀乐
[02:02.00]痛いぐらい沁みました 都深深感染着我
[02:06.00]だから今夜は私の 所以今晚呀
[02:12.00]作るクリームシチューを食べにおいでよ 就尝尝我给你做的奶油炖菜吧
[02:21.00]あなた仕込みの... 虽然也是你教我的
[02:26.00]
[02:46.00]浮き出たアクをすくって 穏やかに見せかけて 假装娴熟地打掉浮起来的泡泡
[02:50.00]少なくなったもんを補って 補い合って 缺什么味道就加什么调料
[02:55.00]足して 引いて 割って 掛けてってだけでもないから 当然做菜也不是简单得像加减乘除
[02:59.00]"わかんないやぁ"ってこともあるよね “ 下一步咋办！” 之类慌张的时候还是有的
[03:04.00]浮き出たアクをすくって 穏やかに見せかけて 假装娴熟地打掉浮起来的泡泡
[03:09.00]少なくなったもんを補って 補い合って 缺什么味道就加什么调料
[03:13.00]足して 引いて 割って 掛けてってだけでもないから 当然做菜也不是简单得像加减乘除
[03:18.00]"わかんないやぁ"ってこともあるよね “ 下一步咋办！” 之类慌张的时候还是有的
[03:23.00]..
[03:36.00]"わかんないやぁ"ってこともあるよね “ 下一步咋办！” 之类慌张的时候还是有的
[03:41.00]
[03:49.00]さんざん困らす私が言えることじゃないけど 也许不太像是个麻烦鬼说出来的话
[03:59.00]あなたの気持ちは 你的喜怒哀乐
[04:04.00]痛いぐらい沁みました 都深深感染着我
[04:08.00]だから今夜は私の 所以今晚呀
[04:13.00]作るクリームシチューを食べにおいでよ 就尝尝我给你做的奶油炖菜吧
[04:24.00]あなた仕込みの... 虽然也是你教我的
[04:30.00]
[04:35.00]そろそろ帰るだろう あたためなおしてあげよう 快快回家吧  别等菜凉了
[04:41.00]
[04:44.00]そろそろ帰るだろう あたためなおしてあげよう 快快回家吧  别等菜凉了
[04:51.00]', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/45fabc63-ba8d-4cc4-b156-ccafc07dd6a3.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('8', '4', 'Dream Sequence', 'Silver Fairy', TO_TIMESTAMP('2025-04-19 13:06:45.959000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:06:45.959000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/9117709b-bb99-41e8-af50-ec497d64034b.jpeg', '纯音乐', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/68fa20b5-2a70-4f38-81d9-dd1ce57025d0.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('9', '4', 'Unexpectedly', 'Unexpectedly', TO_TIMESTAMP('2025-04-19 13:13:23.127000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:13:23.127000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/e5687275-fdb5-47e6-83c8-adde97d36ce9.jpeg', '[00:00.56]Megumi Acorda - Unexpectedly
[00:42.87]We''re meant to lose 命中注定
[00:46.88]The most precious things we have 我们会弄丢生命中珍贵的东西
[00:59.10]So I''ve kept myself 所以我一直逃避
[01:03.36]Miles away from things like love 那些名为爱情的东西
[01:14.52]You don''t unexpectedly 但不期而遇的你
[01:22.85]You mean so much to me 对我而言有着非凡的意义
[01:34.43]You''re always on my mind 你总在我的心上
[01:42.38]You''re always on my mind 你总在我的心上
[01:49.30]You never talk 你从未多话
[01:53.00]But your eyes give you away 但你的眼神出卖了你
[02:00.71]Please keep me in mind 请让我走入你的心中
[02:09.59]For another time another place 换个时间 换个地方
[02:20.77]Cause unexpectedly 因为不期而遇
[02:29.02]You mean so much to me 对我而言有着非凡的意义
[02:40.20]You''re always on my mind 你总在我的心上
[02:48.33]You''re always on my mind 你总在我的心上
[02:53.91]You find unexpectedly 不期而遇的你
[03:02.23]You find your way to me 你找到了通向我的道路
[03:13.41]I''ll take your hand in mine 我会将你的手握紧
[03:21.48]I''ll take your hand in mine 我会将你的手握紧', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/bb063be0-7d85-4de7-b5a1-69ab918c551f.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('17', '6', 'I Know You Know I Love You (Audiotree Live Version)', '落日飛車 Sunset Rollercoaster on Audiotree Live', TO_TIMESTAMP('2025-04-19 14:41:38.176000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 14:41:38.176000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/74394c4b-4043-4164-99fb-c835df599e8c.jpeg', '[by:橘子酱小兮]
[00:00.00]作词 : Kuo-Hung Tseng/Hung-Li Chen/Shao-Hsuan Wang/Tsun-Lung Lo/Shih-Wei Huang/Hao-Ting Huang
[00:01.00]作曲 : Kuo-Hung Tseng/Shao-Hsuan Wang/Tsun-Lung Lo/Hao-Ting Huang/Hung-Li Chen/Shih-Wei Huang
[00:06.80]编曲：落日飞车Sunset Rollercoaster
[00:10.75]曾国宏Tseng, Kuo Hung
[00:17.46]李柏澔Kevin Lee
[00:19.28]罗尊龙 Lo, Tsun Lung
[00:49.55]
[00:52.98]Watch the sky,
[00:52.98]当你看着天空的时候
[00:54.06]You know I, like a star shining in your eyes.
[00:54.06]你知道我对你眼中星辰的迷恋
[01:06.56]Sometimes I,
[01:06.56]有的时候我
[01:07.82]Wonder why, just wanna hold your hands
[01:07.82]想知道为什么，只想牵着你的手
[01:11.98]And walk with you side by side.
[01:11.98]和你一起走
[01:20.36]I know you know,
[01:20.36]我知道你知道
[01:23.74]I love you babe.
[01:23.74]我爱你
[01:27.17]I know you know,
[01:27.17]我知道你知道
[01:30.66]I love you babe.
[01:30.66]我爱你
[01:33.53]I just wanna you to know,
[01:33.53]我就想让你知道
[01:37.70]I love you, I love you, I love you…
[01:37.70]我爱你
[01:46.87]I just wanna love you baby.
[01:46.87]只想爱你宝贝
[01:51.10]
[02:02.54]I know you know,
[02:02.54]我知道你知道
[02:05.55]I love you babe.
[02:05.55]我爱你
[02:08.98]I know you know,
[02:08.98]我知道你知道
[02:12.44]I love your babe.
[02:12.44]我爱你
[02:15.46]I just want you to know,
[02:15.46]我只想让你知道
[02:19.39]you’re my sunshine in the sky.
[02:19.39]你是我的阳光
[02:26.52]I will be waiting for you babe.
[02:26.52]我会一直等你的宝贝
[02:40.68]', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/c6f52b0d-5b56-4b37-9e9c-51f60d2b4bc5.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('18', '6', 'My Jinji (Audiotree Live Version)', '落日飛車 Sunset Rollercoaster on Audiotree Live', TO_TIMESTAMP('2025-04-19 14:43:16.884000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 14:43:16.884000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/c4566c5b-6d2f-4f50-8b45-2575efbf74c2.jpeg', '[00:00.04]落日飛車 - My Jinji (Audiotree Live Version)
[00:00.26]Lyrics by：Tsun-Lung Lo/Hung-Li Chen/Shao-Hsuan Wang/Hao-Ting Huang/Shih-Wei Huang/Kuo-Hung Tseng
[00:00.37]Every time you lie in my place 每当你躺在我身旁
[00:04.88]I do want to say 我都想
[00:08.40]It''s you 对你说
[00:09.80]You my babe 宝贝
[00:12.04]I won''t be too late 我不会让你久等的
[00:28.05]My Jinji don''t you cry 我的金桔 不要哭泣
[00:31.15]This world out of time 在这被时间摒弃的世界
[00:34.53]Of time out of mind 旧日时光终会消散
[00:37.97]My Jinji please don''t mind 我的金桔 请你不要哭泣
[00:41.27]In this world out of time 在这被时间摒弃的世界
[00:44.80]Time out of mind 时光荏苒
[00:49.78]Out of time 一切终将被遗忘
[00:52.21]Every time you lie in my place 每当你躺在我身旁
[00:56.94]I do want to say 我都想
[01:00.36]It''s you you my babe 对你说 宝贝
[01:03.98]I''m down into your drain 我愿为你倾尽所有
[01:19.55]Oh
[01:20.05]Jinji don''t you cry 我的金桔 不要哭泣
[01:23.00]This world out of time 在这被时间摒弃的世界
[01:26.46]Old time out of mind 旧日时光终会消散
[01:29.88]My Jinji please don''t mind 我的金桔 请你不要哭泣
[01:33.23]In this world out of time 在这被时间摒弃的世界
[01:36.79]Time out of mind 时光荏苒
[01:41.84]Out of time 一切终将被遗忘
[01:44.25]Every time you lie in my place 每当你躺在我身旁
[01:49.02]I do want to say 我都想
[01:52.46]It''s you 对你说
[01:53.80]You my babe 宝贝
[01:56.00]It won''t be too late 我很快就会回到你身边
[02:02.29]Oh don''t leave me behind 请不要将我忘怀
[02:06.66]Without you I would cry 失去你 我会伤心欲绝
[02:10.59]''Cause only you my baby 因为你是我唯一的挚爱
[02:13.37]Only you can conquer time 唯有你能陪我战胜这孤寂漫长的时光
[02:17.33]Only you can conquer time 唯有你能陪我战胜这孤寂漫长的时光
[02:20.58]Oh sometimes I 有时我
[02:23.55]Without you 失去你
[02:24.21]I would cry 我会伤心欲绝
[02:27.47]''Cause only you my baby 因为你是我唯一的挚爱
[02:30.30]Only you can conquer time 唯有你能陪我战胜这孤寂漫长的时光
[02:36.05]Oh don''t leave me behind 请不要将我忘怀
[02:40.52]Without you 失去你
[02:41.20]I would cry 我会伤心欲绝
[02:44.44]''Cause only you my baby 因为你是我唯一的挚爱
[02:47.21]Only you can conquer time 唯有你能陪我战胜这孤寂漫长的时光
[02:51.07]Only you can conquer time 唯有你能陪我战胜这孤寂漫长的时光
[02:54.54]Oh sometimes I 有时我
[02:57.36]Without you 失去你
[02:58.06]I will cry 我会伤心欲绝
[03:01.37]''Cause only you my baby 因为你是我唯一的挚爱
[03:04.18]Only you can conquer time 唯有你能陪我战胜这孤寂漫长的时光', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/6b592bc8-0bbb-4ea5-9c11-dc6e1bf19dd3.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('20', '6', '景美', '十万小时·EP02：90后', TO_TIMESTAMP('2025-04-19 14:44:11.467000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 14:44:11.467000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/7f452786-0676-4e9d-80f7-e53dae517e98.jpeg', '[00:00.00]宋柏纬、落日飞车 - 景美
[00:00.47]作词：宋柏纬
[00:00.73]作曲：宋柏纬/ 曾国宏
[00:04.20]一样在看向窗外的时候
[00:08.75]屏住呼吸背对着疑惑
[00:13.80]先暂时不去想
[00:18.77]让思绪跃过身影慢慢拉长
[00:24.76]找点话对自己说
[00:28.34]帮沉默填空
[00:32.64]也暂时不去做
[00:37.69]让时间拼凑出一个结果
[00:44.44]我转过身看着
[00:49.09]光总会有遗落的部分
[00:55.94]越向后也只会陷的越深
[01:02.97]那里雨一直下着
[01:07.72]没说的也被凝结成水分
[01:14.64]悬在心里等降落的可能
[01:37.36]还是在看向窗外的时候
[01:41.79]又回到这里面对着疑惑
[01:47.06]看夕阳拉长逐渐浮现轮廓
[01:51.69]我还是一如既往试着不去想
[01:57.75]说的话也都一样
[02:01.51]只是在习惯
[02:04.55]没了眼神交换
[02:08.06]才忽然
[02:10.63]意识到时间经过的不安
[02:17.51]我转过身看着
[02:22.33]光总会有遗落的部分
[02:29.25]越向后也只会陷的越深
[02:36.29]那里雨一直下着
[02:40.88]没说的也被凝结成水分
[02:47.87]悬在心里等降落的可能', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/ff2a27ee-ca6c-4469-a544-bf64922a5c65.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('12', '4', 'I''ll Get By', 'Unexpectedly', TO_TIMESTAMP('2025-04-19 13:26:57.177000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 13:26:57.177000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/e2c4a419-c310-44c4-b012-a80b483fa71c.jpeg', '[00:00.03]Megumi Acorda - I''ll Get By
[00:51.92]Shall I come with you 我能与你同行吗
[01:01.95]You''re a sweet elusive dream 你就像一个甜蜜而无法琢磨的美梦
[01:12.12]And the more I run 无论我逃得多远
[01:22.52]The farther you would seem 我都无法挥去你的身影
[01:30.48]I''ll survive but it wouldn''t be a beautiful life without you 我能挺过去 但没有你 我的人生就不再美丽
[01:40.23]I''ll get by but it wouldn''t be a beautiful life 我能挺过去 但我的人生就不再美丽
[02:11.97]Shall I dance with you 我能与你共舞一曲吗
[02:21.96]To the rhythm of uncertainties 跟着随机播放的歌曲
[02:32.03]All the things we said 我们曾说过的那些话语
[02:42.08]And the things we didn''t will stay with me 我们的那些遗憾将会永远如影随形
[02:50.50]I''ll survive but it wouldn''t be a beautiful life without you 我能挺过去 但没有你 我的人生就不再美丽
[03:00.14]I''ll get by but it wouldn''t be a beautiful life 我能挺过去 但我的人生就不再美丽
[03:10.15]Without you 没有你
[03:20.33]Without you 没有你
[03:35.13]It wouldn''t be a beautiful life 我的人生就不再美丽
[03:45.19]It wouldn''t be a beautiful life 我的人生就不再美丽
[03:51.69]Shall I love you 我能爱你吗
[03:56.54]Shall I love you 我能爱你吗
[04:01.53]Shall I love you 我能爱你吗', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/d4017273-6609-4238-92d2-35b04695badc.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('19', '6', 'Greedy (Audiotree Live Version)', '落日飛車 Sunset Rollercoaster on Audiotree Live', TO_TIMESTAMP('2025-04-19 14:43:46.292000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-19 14:43:46.292000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/4be25a2e-e345-4596-a760-b9d1fcb68e38.jpeg', '[01:10.57]I''m greedy it''s such a pity
[01:17.39]There''re loads of love
[01:20.33]I would never ever get enough
[01:24.28]I''m losing losing are my feelings
[01:31.19]Roses in my heart
[01:34.23]I would never ever get too much
[01:38.22]Oh oh oh yeah yeah yeah
[01:41.80]I would never ever get enough
[01:45.13]Oh oh oh yeah yeah yeah
[01:48.64]I would never ever get too much
[02:45.23]Oh it''s such a sinking mind
[02:50.37]Oh am I doing fine
[02:58.95]All the lies just need a reason why
[03:04.09]Why I couldn''t make you mine
[03:41.92]I''m greedy it''s such a pity
[03:48.62]There''re loads of love
[03:51.51]I would never ever get enough
[03:55.45]I''m losing losing are my feelings
[04:02.34]Roses in my heart
[04:05.33]I would never ever get too much
[04:09.05]Oh oh oh yeah yeah yeah
[04:12.67]I would never ever get enough
[04:16.09]Oh oh oh yeah yeah yeah
[04:19.63]I would never ever get too much
[05:10.86]I''m greedy it''s such a pity
[05:17.97]There''re loads of love
[05:21.14]I would never ever get enough
[05:25.17]I''m losing losing are my feelings
[05:32.14]Roses in my heart
[05:35.43]I would never ever get too much', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/d9308c0f-1cd3-4506-98e3-d45122d35650.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('25', '23', 'Yawning Lion', 'Deemo Collection: Game Soundtrack (树境琴声 游戏原声精选集)', TO_TIMESTAMP('2025-04-24 11:29:05.630000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:29:05.630000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/44352340-2ac4-44a1-b858-0f6dba149f78.jpeg', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/83920a8f-9935-4944-8f3a-883ecd8b9055.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('32', '25', 'new year''s eve', 'new year''s eve', TO_TIMESTAMP('2025-04-24 11:42:13.643000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:42:13.643000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/b55b9440-3499-45d2-a484-b3034242ba64.jpeg', '[ti:new year''s eve]
[ar:mellow fellow]
[al:new year''s eve]
[00:00.00]new year''s eve - mellow fellow 以下歌词翻译由文曲大模型提供
[00:27.67]I''m still at home 我依然在家
[00:31.71]It''s new year''s eve ''cause I know 这是新年前夜 因为我知道
[00:37.65]That she just stops knockin'' on the door 她不再敲门
[00:43.61]It''s new year''s eve and she begins to leave 这是新年前夜 她开始离开
[00:53.21]Even though I want you to be mine 尽管我希望你属于我
[00:58.82]I only let it show from time to time 我只是偶尔表露心迹
[01:05.18]It''s alright we''ll figure this one out 没关系 我们会找到解决办法
[01:11.29]But for now 但现在
[01:39.89]It''s gettin'' late 天色已晚
[01:44.02]On new year''s eve and I know 在这新年前夜，我深知
[01:49.89]I shouldn''t come knockin'' on the door 我不该来敲你的门
[01:55.88]It''s new year''s eve you hold the heart in me 新年前夜，你依然占据我的心
[02:05.30]Even though I want you to be mine 尽管我希望你属于我
[02:10.91]I only let it show from time to time 我只是偶尔表露心迹
[02:17.13]It''s alright we''ll figure this one out 没关系 我们会找到解决办法
[02:23.10]But for now 但现在
[02:27.89]I''m still at home 我依然在家
[02:32.12]It''s new year''s eve ''cause I know 这是新年前夜 因为我知道
[02:38.15]That she just stops knockin'' on the door 她不再敲门
[02:44.00]It''s new year''s eve and she begins to leave 这是新年前夜 她开始离开
[02:51.98]I''m still at home 我依然在家
[02:56.01]It''s new year''s eve ''cause I know 这是新年前夜 因为我知道
[03:02.14]That she just stops knockin'' on the door 她不再敲门
[03:08.15]It''s new year''s eve and she''s about to leave 新年夜，她即将离去
[03:16.03]I''m still at home 我依然在家
[03:20.21]It''s new year''s eve ''cause I know 这是新年前夜 因为我知道
[03:26.26]That she just stops knockin'' on the door 她不再敲门
[03:32.23]It''s new year''s eve and she begins to leave 这是新年前夜 她开始离开', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/7e5792a0-21e2-44b2-a8c0-d7b328a305d8.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('33', '25', 'you''ll be alright', 'youll be alright', TO_TIMESTAMP('2025-04-24 11:42:58.831000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:42:58.831000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/b2f24238-50df-4f50-8889-3094bea8bfc1.jpeg', '[00:05.19]Mellow Fellow： 以下歌词翻译由微信翻译+文曲大模型提供
[00:26.67]Oh
[00:27.93]I know it''s not your time 我知道你还不到时候
[00:30.60]But you''ll be just fine 但你会安然无恙
[00:32.58]Life can be cruel 生活可能很残酷
[00:35.91]But you don''t have to play the fool 但你不必装傻
[00:38.43]To win this game 赢得这场游戏
[00:41.07]Things won''t be the same 一切都不一样了
[00:43.29]You only fail when you stop trying 只有你不再努力你才会失败
[01:23.13]Oh
[01:23.91]I know you''re not mine 我知道你不属于我
[01:26.37]But you''ll be just fine 但你会安然无恙
[01:28.59]Our love was cruel 我们的爱残酷无情
[01:31.86]But you just keep playing the fool 可你总是装傻充愣
[01:34.56]And now all is done 现在一切都结束了
[01:37.05]We had a good run 我们度过了美好时光
[01:39.30]You only fail when you stop 只有你止步不前你才会失败
[01:53.94]You''ll be alright 你会没事的
[01:57.66]My love 亲爱的
[01:59.97]Or so you were 至少你曾经如此
[02:05.76]You''ll be alright 你会没事的
[02:09.50]My love 亲爱的
[02:12.09]Or so you were 至少你曾经如此
[02:17.58]You''ll be alright 你会没事的
[02:21.24]My love 亲爱的
[02:23.64]Or so you were 至少你曾经如此
[02:29.40]You''ll be alright 你会没事的
[02:33.21]My love 亲爱的
[02:35.61]Or so you were 至少你曾经如此', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/ef9f05af-f2fe-4a25-8f8e-a551b2e0a307.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('45', '27', 'Born a Stranger (生而陌路)', 'To the Moon (Original Soundtrack)', TO_TIMESTAMP('2025-04-24 12:28:26.629000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:28:26.629000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/c35c3558-9a39-484d-a740-b58737083c9a.jpeg', '[00:01.58]纯音乐，请欣赏', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/56755def-b62a-4462-8af0-91347fc42e34.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('46', '27', ' Having Lived', 'To the Moon (Original Soundtrack)', TO_TIMESTAMP('2025-04-24 12:29:47.260000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:29:47.260000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/284993e6-248b-40ae-b934-8ea3ff6ec06f.jpeg', '[00:01.58]纯音乐，请欣赏', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/ee1ff60d-7064-4a6b-9fae-1c012c0ad03b.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('47', '27', 'Everything''s Alright', 'To the Moon (Original Soundtrack)', TO_TIMESTAMP('2025-04-24 12:30:08.364000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:30:18.494000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/8c8fe713-13f5-40c0-bec0-2e7acd7b391a.jpeg', '[ti:Everything''s Alright(From "To The Moon")(Arranged Version)]
[ar:Laura Shigihara]
[al:Everything''s Alright (From "To The Moon") (Arranged Version)]
[00:00.29]Everything''s Alright - Laura Shigihara 以下歌词翻译由文曲大模型提供
[00:00.42]Lyrics by：Laura Shigihara
[00:00.55]Composed by：Laura Shigihara
[00:22.40]Short steps deep breath 小步轻移 深呼吸
[00:27.00]Everything is alright 一切都会好起来
[00:31.58]Chin up I can''t 抬起头 我却不能
[00:35.96]Step into the spotlight 走进聚光灯下
[00:40.54]She said I''m sad 她说我很悲伤
[00:45.13]Somehow without any words 莫名无言以对
[00:49.73]I just stood there 我只能呆立原地
[00:54.19]Searching for an answer 寻找着答案
[01:00.17]When this world is no more 当这世界不复存在
[01:04.39]The moon is all we''ll see 我们眼中只剩月光
[01:10.16]I''ll ask you to fly away with me 我想邀你一同远走高飞
[01:18.29]Until the stars all fall down 直到星辰陨落
[01:22.59]They empty from the sky 天空变得空荡
[01:25.99]But I don''t mind 但我并不在意
[01:28.58]If you''re with me then everything''s alright 只要有你在身旁 一切都会安然无恙
[01:43.66]Why do my words 为何我的言语
[01:48.05]Always lose their meaning 总失去原本意义
[01:52.36]What I feel what I say 我所感 我所言
[01:56.85]There''s such a rift between them 竟如此难以相连
[02:01.65]He said I can''t 他说他无法
[02:06.38]Really seem to read you 真正读懂我的心
[02:10.85]I just stood there 我只能呆立原地
[02:15.22]Never know what I should do 茫然不知该如何回应
[02:21.27]When this world is no more 当这世界不复存在
[02:25.51]The moon is all we''ll see 我们眼中只剩月光
[02:31.24]I''ll ask you to fly away with me 我想邀你一同远走高飞
[02:39.34]Until the stars all fall down 直到星辰陨落
[02:43.96]They empty from the sky 天空变得空荡
[02:47.18]But I don''t mind 但我并不在意
[02:52.71]If you''re with me then everything''s alright 只要有你在身旁 一切都会安然无恙
[03:01.99]If you''re with me then everything''s alright 只要有你在身旁 一切都会安然无恙', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/4133d0a1-19da-4677-b854-bb7f5804b1ee.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('48', '1', 'aruarian dance', 'samurai champloo music record departure', TO_TIMESTAMP('2025-04-24 12:36:35.759000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:36:35.759000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/ce1f2c5d-4c5b-42c1-b767-016b1ae2ef7a.png', '[00:05.00]纯音乐，请欣赏', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/740dc1cc-29c1-4fa4-86b5-917683bfe168.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('49', '1', '美春の告白', 'brillante', TO_TIMESTAMP('2025-04-24 12:37:37.388000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:37:37.388000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/3cb1b38c-4fce-41a3-87e7-b0e10ab2dbb1.jpeg', '[00:01.58]纯音乐，请欣赏', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/30569e7c-f9ba-4a4b-bce5-59e61a3928a4.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('50', '29', 'シルシ', 'シルシ', TO_TIMESTAMP('2025-04-24 12:41:23.605000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:43:52.052000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/02813e6e-49df-4107-ad5f-caeee9e8b344.jpeg', '[00:00.00]作词 : LiSA
[00:01.00]作曲 : 草野華余子
[00:02.00]编曲 : 堀江晶太
[00:18.92]街明かり照らした 在灯光明亮的街道里
[00:22.28]賑やかな笑い声と 此起彼落的笑声与
[00:25.38]路地裏の足跡 巷子里的足迹
[00:30.93]伝えたい想いは 想传达的想念
[00:33.83]どれだけ届いたんだろう 究竟传达了有几分呢
[00:37.02]いつも振り向いて確かめる 总忍不住回首确认
[00:44.42]いつだって迷わず 无论何时都毫不犹豫
[00:47.32]キミはきっとどんなボクも 你总是毫无迷惘
[00:51.46]追いかけてくれるから 一路追寻
[00:58.15]じっと見つめた 仔细凝视
[00:59.92]キミの瞳に映った 你的双瞳 映照的正是
[01:06.35]ボクが生きたシルシ 我生存的印记
[01:11.43]何度も途切れそうな鼓動 无数次强有力的叩响
[01:18.06]強く強く鳴らした 我快要停止的心跳声
[01:22.31]今日を越えてみたいんだ 让我想要努力跨越今天
[01:39.60]手にした幸せを 与其害怕失去
[01:42.56]失うことを恐れて 拥有的幸福而
[01:46.18]立ち止まっているより 停驻在原地
[01:51.29]一つ一つ大きな 不如尽可能的
[01:54.53]出来るだけ多くの 让更多的笑容
[01:57.50]笑顔咲かせようと たくらむ 一个个绽放
[02:03.43]思い出す ボクらの 突然回想起
[02:07.98]通り過ぎた日々が 我们一路走过的时光
[02:10.63]いつも輝いて見える様に 看起来总是散发着光芒
[02:18.31]ぎゅっと握った キミの温もりで 因紧握着的你的温度
[02:25.49]感じた ボクら繋いだ証 而感受到 我们紧紧相依的证明
[02:31.25]キミと今同じ速さで 如今正和你以相同的速度
[02:38.64]あの日描いた未来を 歩いている 漫步在当初描绘的未来
[02:45.49]いくつ願い叶えてもキミと 无论实现了多少愿望
[02:49.43]過ごしたい新しい明日をすぐに 还是想立刻和你度过崭新的明天
[02:53.67]次々にボクは 我肯定又会
[02:55.75]きっとまた願ってしまうから 不断的许下新的心愿
[03:18.42]流れてく時間は容赦無く 流逝的光阴
[03:24.84]いつかボクらをさらってくから 终会将我们也无情夺走
[03:31.40]瞬きした一瞬の隙に 只愿转瞬的间隙
[03:37.35]キミの見せる全てを 绝不会丢失
[03:42.24]見落とさないように 你给我看的一切
[03:44.47]じっと見つめた 仔细凝视
[03:46.77]キミの瞳に映った 你的双瞳 映照的正是
[03:52.43]ボクが生きたシルシ 我生存的印记
[03:58.12]何度も途切れそうな鼓動 无数次强有力的叩响
[04:04.14]強く強く鳴らした 我快要停止的心跳声
[04:08.52]今日を越えていけなくても 即便今天注定走不完
[04:11.96]キミと生きた 我也绝不会忘记
[04:15.14]今日をボクは忘れない 和你共同活着的今天', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/6eecd43d-b356-4b7f-99cc-87a58f291cd1.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('51', '29', 'Unlasting', 'Unlasting', TO_TIMESTAMP('2025-04-24 12:44:32.196000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:44:32.196000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/43caed07-93e3-4ae9-a7cf-f0e07eaecdc5.jpeg', '[ti:unlasting (《刀剑神域 Ⅲ》TV动画片尾曲)]
[ar:LiSA (織部里沙)]
[al:unlasting]
[00:00.87]unlasting - LiSA (織部里沙) QQ音乐享有本翻译作品的著作权
[00:03.66]词：LiSA
[00:04.65]曲：草野華余子
[00:08.54]编曲：堀江晶太
[00:17.31]一人きりでも平気 我一个人也没关系
[00:23.83]と零れ落ちた強がり 脱口而出的又是逞强的话语
[00:31.61]
[00:34.11]二人の眩しすぎた日が 和你共度的那段时光太耀眼
[00:41.67]こんなに悲しい 如今只剩下无尽的哀伤
[00:46.73]ヒトリで生きられるなら 如果可以一个人活下去
[00:53.37]
[00:54.79]誰かを愛したりしないから 也就不会爱上某个人了吧
[01:02.63]貴方の香り 貴方の話し方 你散发的气息 你说话的方式
[01:11.77]今も身体中に 至今仍在我的全身
[01:14.65]“愛のカケラ”が残ってるよ 留下些微爱的碎片
[01:19.56]私の願い 私の願いはただ 我的愿望 我唯一的愿望
[01:28.79]どうか貴方もどこかで 仅仅是希望你也同样正在某处
[01:35.62]
[01:36.44]泣いていますように 潸然落泪
[01:54.96]いつも新しい一歩は 斩断过去踏出新的一步
[02:02.21]重くて寂しい 总是沉重而寂寞
[02:07.01]もし生まれ変わっても 若可以转世重生
[02:14.89]もう一度貴方に出逢いたい 我还想再次和你相遇
[02:22.06]
[02:23.05]真夏の日差し 真冬の白い雪 盛夏的炽阳 隆冬的白雪
[02:32.19]巡る季節中に 四季不停轮转更替
[02:35.15]“愛のカケラ”が舞い落ちて 爱的碎片飘落而下
[02:39.92]幸せなのに どこかで寂しいのは 明明如此幸福却又感到一丝落寞
[02:49.09]貴方よりも大きな 私の愛のせい 一定是因为我所付出的爱 远胜于你
[03:15.01]鍵は貴方が持ったまま 那把钥匙依旧握于你的手中
[03:19.25]歌う意味を失くしたカナリア 失去了歌唱的意义的金丝雀
[03:23.46]暗い鳥かごの中で 困在这昏暗无光的鸟笼之中
[03:30.88]貴方の香り 貴方の話し方 你散发的气息 你说话的方式
[03:39.35]
[03:39.94]今も身体中に 至今仍在我的全身
[03:42.84]“愛のカケラ”が残ってるよ 留下些微爱的碎片
[03:47.84]私の願い 私の願いはただ 我的愿望 我唯一的愿望
[03:57.06]どうか貴方が 仅仅是希望你
[04:00.67]幸せでありますように 一定要幸福
[04:11.59]
[04:25.29]Unlasting world 稍纵即逝的世界
[04:29.15]The course of love 爱的旅程
[04:34.40]From everything think of you 回想你的点点滴滴', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/f925329f-2c82-4af5-b5ce-a240b27ac90a.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('52', '30', 'I. Adagio - Allegro non troppo (B小调第6号交响曲，作品74“悲怆” - 第一乐章 柔板，不太快的快板)', 'Tchaikovsky: Symphony No.6 "Pathétique"', TO_TIMESTAMP('2025-04-24 12:47:09.971000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:47:09.971000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/576af9a2-5d5b-4f7a-b625-50e96b7c24d2.png', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/bcdf74ec-4920-40f1-9d86-047ec77bb6b9.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('53', '31', 'Bohemian Rhapsody', 'Bohemian Rhapsody (The Original Soundtrack)', TO_TIMESTAMP('2025-04-24 12:50:05.676000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:50:05.676000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/6091ccdb-c354-4998-bc4d-ac0f74eeefd7.jpeg', '[00:00.00]作词 : Freddie Mercury
[00:00.50]作曲 : Freddie Mercury
[00:01.00]Is this the real life -
[00:03.00]Is this just fantasy -
[00:07.00]Caught in a landslide -
[00:10.00]No escape from reality -
[00:14.00]Open your eyes
[00:17.00]Look up to the skies and see -
[00:24.00]I''m just a poor boy, I need no sympathy -
[00:31.00]Because I''m easy come, easy go,
[00:35.00]A little high, little low,
[00:38.00]Anyway the wind blows, doesn''t really matter to me,
[00:47.00]- to me -,
[00:55.00]Mama, just killed a man,
[01:01.00]Put a gun against his head,
[01:04.00]Pulled my trigger, now he''s dead,
[01:08.00]Mama, life had just begun,
[01:15.00]But now I''ve gone and thrown it all away -
[01:22.00]Mama, ooo,
[01:29.00]Didn''t mean to make you cry -
[01:32.00]If I''m not back again this time tomorrow -
[01:37.00]Carry on, carry on, as if nothing really matters -
[01:54.00]Too late, my time has come,
[02:01.00]Sends shivers down my spine,
[02:04.00]Body''s aching all the time,
[02:08.00]Goodbye everybody - I''ve got to go -
[02:14.00]Gotta leave you all behind and face the truth -
[02:21.00]Mama, ooo -
[02:28.00]I don''t want to die,
[02:32.00]I sometimes wish I''d never been born at all -
[03:05.00]I see a little silhouetto of a man,
[03:08.00]Scaramouche, scaramouche will you do the Fandango -
[03:12.00]Thunderbolt and lightning - very very frightening me -
[03:15.00]Galileo, Galileo,
[03:17.00]Galileo, Galileo
[03:19.00]Galileo figaro - Magnifico -
[03:22.00]But I''m just a poor boy and nobody loves me -
[03:25.00]He''s just a poor boy from a poor family -
[03:28.00]Spare him his life from this monstrosity -
[03:33.00]Easy come easy go -, will you let me go -
[03:36.00]Bismillah! No -, we will not let you go - let him go -
[03:40.00]Bismillah! We will not let you go - let him go
[03:43.00]Bismillah! We will not let you go - let me go
[03:46.00]Will not let you go - let me go
[03:48.00]Will not let you go - let me go
[03:51.00]No, no, no, no, no, no, no -
[03:53.00]Mama mia, mama mia, mama mia let me go -
[03:57.00]Beelzebub has a devil put aside for me, for me -
[04:03.00]for me -
[04:15.00]So you think you can stone me and spit in my eye -
[04:21.00]So you think you can love me and leave me to die -
[04:26.00]Oh Baby - Can''t do this to me baby -
[04:33.00]Just gotta get out - just gotta get right outta here -
[05:11.00]Nothing really matters,
[05:15.00]Anyone can see,
[05:18.00]Nothing really matters -, nothing really matters to me
[05:43.00]Any way the wind blows...', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/93bf4d73-4cf8-45b0-84b0-54b480440b5f.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('62', '25', 'Best Friend', 'Jazzie Robinson', TO_TIMESTAMP('2025-04-27 14:40:00.978000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-27 14:40:00.978000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/25796568-78ab-4159-8aaf-e536dbc7011b.jpeg', '？[00:00.00]Best Friend - mellow fellow 以下歌词翻译由微信翻译提供
[00:00.52]Hey 嘿
[00:37.75]3 million ways 百万种方式
[00:41.38]To let you down 让你失望
[00:44.58]And I don''t even know 我不知道
[00:49.66]Where to start 从何说起
[00:53.74]Count my fingers 数着手指
[00:58.63]And not the thumbs 而不是大拇指
[01:00.78]Just like Claire Cottrill would say 就像克莱尔·科特瑞尔会说的那样
[01:05.53]And how you''d start your day 你会怎样开始新的一天
[01:09.82]You''re not 你没有
[01:12.91]Just some lover 只是一个情人
[01:18.07]You''re more 你比
[01:21.04]Than I''d ever ask for 比我想要的都多
[01:27.93]Though we may live far away 虽然我们可能住得很远
[01:33.02]You''re in my thoughts every single day 你每天都在我的脑海里
[01:40.86]In every way 不管怎样
[01:44.20]You''re not 你没有
[01:47.23]Just some lover 只是一个情人
[01:52.16]You''re more 你比
[01:55.25]Then I''d ever ask for 那我会要求
[02:06.37]You''re my best friend 你是我最好的朋友
[02:14.31]You''re my best friend 你是我最好的朋友
[02:25.27]My best friend Caitlin 我最好的朋友凯特琳
[02:33.19]My best friend Caitlin 我最好的朋友凯特琳
[02:41.49]My best friend Caitlin 我最好的朋友凯特琳
[02:49.58]My best friend Caitlin 我最好的朋友凯特琳
[02:59.60]''Lil solo for you 为你独唱
[03:40.02]Grinding on a 9 to 5 scene seen dreams 朝九晚五日夜奔波我看到了梦想
[03:42.99]Get rich quick schemes but nothings guaranteed 快速致富的计划没有保证
[03:45.70]So I''m puffing on the w**d hoping to sprout some green 所以我抽着那种东西希望能长出一些新绿
[03:48.41]Money''s a disease got me trying to "gangrene" 金钱是一种疾病让我想要变成坏血病
[03:50.73]Can you blame me for situations I face 你能否因为我面临的困境责备我
[03:53.14]Trying to escape ''till the day I get a taste of my fate 试图逃脱直到我尝到命运的滋味
[03:56.23]If I could erase mistakes correct those I''ve yet to make 如果我能抹去我犯下的错误纠正我犯的错误
[03:59.11]I solemnly swear to stay sharp like razor blades 我庄严发誓我会像刀片一样锋利', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/b19e72bf-c622-4d97-b8f9-91ab3d2c637a.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('54', '32', 'Black beauty', 'Ultraviolence (Deluxe) [Explicit]', TO_TIMESTAMP('2025-04-24 12:55:08.296000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:55:08.296000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/81f11e86-67f7-4a51-a288-7f34ae058ffd.jpeg', '[00:00.00]Black Beauty - Lana Del Rey (拉娜·德雷)
[00:15.70]I paint my nails black 我把指甲涂成黑色
[00:19.16]I dye my hair a darker shade 我将头发染成
[00:23.27]Of brown 深棕色
[00:27.39]Because you like your women Spanish 因为 你希望自己的女人拥有西班牙风情
[00:29.92]Dark strong and proud 黝黑丰腴 自信满满
[00:31.98]I paint the sky black 我将天空染成一片漆黑
[00:35.55]You said if you could have your way 你说过 如果你能闯出自己的天地
[00:39.47]You''d make a night time all today 你会让一整天都笼罩在夜色之中
[00:43.23]So it suits the mood of your soul 所以 这与你阴暗的灵魂十分相衬
[00:48.44]Ohhh what can I do 我还能做什么
[00:55.27]Nothing my sparrow blue 什么也做不了 连我的麻雀也满心忧伤
[01:04.20]Ohhhhh what can I do 我还能做什么
[01:11.28]Life is beautiful 生活如此美好
[01:13.99]But you don''t have a clue 但你却找不到快乐的线索
[01:20.28]Sun and ocean blue 灿烂的阳光 深蓝的大海
[01:27.32]They''re magnificent 这些景象都十分壮丽
[01:30.01]It don''t make sense to you 但你却无动于衷
[01:34.88]Black beauty 黑美人
[01:39.74]Ohhh oh oh
[01:42.81]Black beauty 黑美人
[01:47.73]Ohhh oh
[01:51.75]I paint the house black 我将房子刷成黑色
[01:55.60]My wedding dress black leather too 我的婚纱也是黑色的
[02:00.07]You have no room for light 你所有的房间都没有一丝光亮
[02:03.42]Love is lost on you 爱就是 为你迷失自己
[02:07.66]I keep my lips red 我始终涂着红唇
[02:11.67]They seem like cherries in the spring 看起来就像春天鲜红的樱桃
[02:15.35]Darling 亲爱的
[02:16.27]You can''t let everything seem so dark blue 你不能让一切都看起来如此灰暗
[02:24.11]But ohhh 但是
[02:26.80]What can I do 我能做些什么
[02:31.07]To turn you on 才能令你心动
[02:34.81]Or get through you 或者彻底将你放下
[02:40.42]Ohhh what can I do 我能做些什么
[02:47.32]Life is beautiful 生活如此美好
[02:50.03]But you don''t have a clue 但你却找不到快乐的线索
[02:56.27]Sun and ocean blue 灿烂的阳光 深蓝的大海
[03:03.27]They''re magnificent 这些景象都十分壮丽
[03:05.98]It don''t make sense to you 但你却无动于衷
[03:10.94]Black beauty 黑美人
[03:15.81]Ohhhh
[03:18.76]Black beauty 黑美人
[03:23.73]Ohhhh
[03:26.78]Black beauty 黑美人
[03:31.60]Ohhhh
[03:34.87]Black beauty 黑美人
[03:39.32]Ohhhh
[03:42.73]Black bea-u-uty 黑美人
[03:51.28]Black beauty baby 宝贝 你就是黑美人
[03:55.31]Black beauty baby 宝贝 你就是黑美人
[04:00.40]Ohhhh what can I do 我能做些什么
[04:07.30]Life is beautiful 生活如此美好
[04:10.05]But you don''t have a clue 但你却找不到快乐的线索
[04:16.26]Sun and ocean blue 灿烂的阳光 深蓝的大海
[04:23.27]They''re magnificent 这些景象都十分壮丽
[04:26.01]It don''t make sense to you 但你却无动于衷
[04:30.92]Black beauty 黑美人
[04:35.82]Ohhhh
[04:38.76]Black beauty 黑美人
[04:43.78]Ohhhh
[04:46.92]Black beauty 黑美人
[04:51.85]Ohhhh
[04:54.74]Black beauty 黑美人
[04:59.75]Ohhhh', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/a2f3a70b-7557-41fe-afd0-a23e738dab87.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('36', '1', 'Stay with Me', 'City Poppin''', TO_TIMESTAMP('2025-04-24 11:54:39.486000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:54:39.486000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/53b143f1-5623-4903-8250-89f605dddb22.jpeg', '[00:00.00]Stay with Me - Caitlin Myers/Un3h
[00:00.22]Lyrics by：Tetsuji Hayashi and Yoshiko Takahara
[00:00.54]Composed by：Tetsuji Hayashi and Yoshiko Takahara
[00:00.88]To you
[00:03.44]Yes my love
[00:05.11]To you
[00:07.87]Yes my love
[00:09.51]To you
[00:12.28]You to you
[00:23.71]I''m who I am
[00:24.91]As I am
[00:25.96]You''re who you are
[00:27.13]As who you are
[00:32.60]The final words
[00:33.80]You whispered
[00:34.80]Before you left
[00:35.95]Me with a scar
[00:41.35]On your familiar
[00:42.80]Silver jacket
[00:45.03]Splattered coffee''s
[00:46.23]Left a stain
[00:47.31]Destined always to remain
[00:50.41]And still we''re lost
[00:51.53]Inside the habit
[00:53.91]Tears reflecting
[00:55.12]In the pane
[00:56.06]Show our pitiful refrain
[01:01.49]Stay with me
[01:03.95]In the dead of night
[01:05.38]I''m banging on your door
[01:08.61]I''m begging you
[01:09.81]Without you I''m done for
[01:14.87]Now the winter arrived
[01:17.17]Like the tears
[01:18.12]In our eyes
[01:19.22]Stay with me
[01:21.62]While your voice remains
[01:23.10]An echo of the past
[01:26.32]I''m holding on to moments
[01:28.65]That won''t last
[01:32.67]I will never forget
[01:34.92]I will never
[01:36.03]Regret our love
[01:46.77]Confusing love and lovin''
[01:49.01]There is a difference
[01:50.51]Though bizarre
[01:55.67]The final words
[01:56.91]You whispered
[01:57.90]Before you left me
[01:59.30]With a scar
[02:04.54]Another winter is arriving
[02:08.18]Like a bird you went away
[02:10.35]Migrate back to me and stay
[02:13.47]But still I''m lost
[02:14.59]Inside the habit
[02:17.06]Here I''m yearning
[02:18.15]For your touch
[02:19.27]Will it ever matter much
[02:24.60]Stay with me
[02:27.03]In the dead of night
[02:28.49]I''m banging on your door
[02:31.71]This heart of mine
[02:32.91]Is breaking once more
[02:38.01]Now the winter arrived
[02:40.33]Like the tears in my eyes
[02:42.39]Stay with me
[02:44.72]For your company
[02:46.12]My pride I gave away
[02:49.43]The needle on my record
[02:51.47]As it plays
[02:55.77]Bittersweet melodies
[02:58.12]On an endless
[02:59.18]Repeat it seems
[03:22.23]Stay with me
[03:24.68]In the dead of night
[03:26.13]I''m banging on your door
[03:29.36]I''m begging you
[03:30.56]Without you I''m done for
[03:35.62]Now the winter arrived
[03:37.91]Like the tears in our eyes
[03:39.97]Stay with me
[03:42.36]While your voice remains
[03:43.85]An echo of the past
[03:47.07]I''m holding on to moments
[03:49.40]That won''t last
[03:53.43]I will never forget
[03:55.65]I will never regret
[03:57.77]Stay with me
[04:00.14]In the dead of night
[04:01.59]I''m banging on your door
[04:04.82]I''m begging you
[04:06.02]Without you I''m done for
[04:11.10]Now the winter arrived
[04:13.37]Like the tears in our eyes
[04:15.44]Stay with me
[04:17.83]While your voice remains
[04:19.31]An echo of the past
[04:22.56]I''m holding on to moments
[04:24.88]That won''t last
[04:27.57]Oooh
[04:28.91]I will never forget
[04:31.14]I will never regret
[04:33.22]Stay with me
[04:35.63]In the dead of night
[04:37.05]I''m banging on your door
[04:40.30]I''m begging you
[04:41.48]Without you I''m done for
[04:46.57]Now the winter arrived
[04:48.89]Like the tears in our eyes
[04:50.87]Stay with me', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/7daeda5b-be9d-454d-97c9-7f5f94b53f8b.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('37', '27', 'Lullaby from a Star (Credit Theme feat. Pealeaf)', 'Impostor Factory (Original Game Soundtrack)', TO_TIMESTAMP('2025-04-24 12:00:05.579000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:00:05.579000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/2bf3c2d7-1e73-453e-9d01-73aabbc3cccf.jpeg', '[00:00.00]作曲 : Kan R. Gao
[00:05.00]纯音乐，请欣赏', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/ce515c45-fcfc-49eb-a2b6-2ef1d807c256.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('38', '27', 'Wish My Life Away', 'Finding Paradise (Original Game Soundtrack)', TO_TIMESTAMP('2025-04-24 12:00:22.302000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:00:22.302000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/dd2dd307-86d6-40b7-87fc-7dc4bdd94bd1.jpeg', '[00:00.03]Kan R. Gao、Laura Shigihara - Wish My Life Away
[00:16.71]I never stood up very tall 我从未昂首挺胸过
[00:23.58]I think my voice was fairly small 我觉得我的声音太过微小
[00:30.53]But there were times I''d want to shout 但有些时候 我真的想大声呼喊
[00:34.32]Though my thoughts weren''t sorted out 但我的思绪还未整理清晰
[00:38.12]So I''d stumble and I''d fall 所以我踌躇着 就要跌倒
[00:44.65]I learned to fly because of you 为了你 我学着飞翔
[00:51.43]So if you left I could go too 所以 如果你走了 我也会随你而去
[00:58.60]And everything you saw in me 你在我身上看到的一切
[01:02.19]That''s what I wanted to be 就是我曾经渴望的模样
[01:06.19]Did I make it after all 但我究竟做到了吗
[01:11.25]All the grass on the other side 在我眼中别人总是
[01:18.13]Is it only greener in my mind 比我更幸福快乐
[01:25.11]I''d still want it the same 我也想拥有同样的人生
[01:28.94]Because trading my yesterday 因为 我放下过往
[01:37.89]Is to wish my life away 只祈祷未来顺利一些
[01:55.15]As we dream and as we grow 我们一边梦想 一边成长
[02:01.76]We have to learn to let things go 我们不得不学着释怀
[02:08.68]But let the wonder never fade 但那些疑问却从未远走
[02:12.35]Though we''ve turned 10000 pages 尽管我们阅历不少
[02:16.33]Flying high or stuck below 曾翱翔天际 也曾深陷困境
[02:22.75]I''ve searched for meaning amidst doubt 我还是一直在疑惑中寻找生命奥义
[02:29.67]I''ve finally figured that part out 我终于彻底明了
[02:36.71]And all the stories inside me 心中堆满了故事
[02:40.11]Feels like I''m bursting at the seams 感觉自己就要坚持不住
[02:44.24]And you''re here after all 不过还好有你在
[02:49.08]All the grass on the other side 在我看来别人总是
[02:56.11]Is it only greener in my mind 比我更幸福快乐
[03:03.12]I''d still want it the same 我也想拥有同样的人生
[03:07.03]Because trading my yesterday 因为 我放下过往
[03:16.27]Is to wish my life away 只祈祷未来顺利一些', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/0efc0280-a7be-4b17-b425-c6879f7e92de.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('39', '27', 'Where Are You (Duet Version)', 'Finding Paradise (Original Game Soundtrack)', TO_TIMESTAMP('2025-04-24 12:00:35.897000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:00:35.897000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/85ae043d-be0f-43d8-bdbc-45997442ff54.jpeg', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/69c8140e-3a09-4108-b77a-fa17da0eaa0f.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('41', '28', 'Grace Kelly', 'Grace Kelly', TO_TIMESTAMP('2025-04-24 12:21:38.739000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 12:21:38.739000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/a21c4f68-5d83-4c8f-9973-c1e7033fd1f7.jpeg', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/f959f623-14e7-4865-b634-d7539c0135ea.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('30', '24', 'Kireigoto', 'Aioi 2', TO_TIMESTAMP('2025-04-24 11:36:27.837000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:36:27.837000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/1ed57086-7a8b-420b-8a15-f881adbb41fe.jpeg', '[by:质量和]
[00:00.00]作曲 : Shun Imagawa
[00:20.00]落ち着かない 手につかない 私の隣にはあなたがいない 魂不守舍 心不在焉 你不在的日子度日如年
[00:25.00]久しぶり実家に帰ると家を出たのが三日前で 说是回趟老家也用不了三天这么久吧？
[00:30.00]行ってすぐは電話？メール ずっとやりとりしてたのに 明明才出门就给我打电话发短信
[00:35.00]そうやって私困らすつもりなんでしょ！？ 你这么做就是想气死我吗！？
[00:38.00]大好きなあなたのクリームシチュー作って欲しいよ 还想吃你做的奶油炖菜呢
[00:47.00]だいたいあなたの味には 再说 你的人生没有我的话
[00:51.00]私のスパイスが必要だと 也是不完整的
[00:56.00]わかっているかい？ 你懂的吧？
[00:58.00]
[01:07.00]さっきからずっとずっと探しているのに見つからないの 明明找了很久却还是找不到
[01:12.00]この部屋のことならだいたい あなたの方が知っているから 毕竟这个房间的犄角旮旯只有你最清楚
[01:16.00]"あれ"っていうだけでわかる あなたのことだから 要是你的话肯定一下就能想起
[01:21.00]そう 今の私の気持ち　わかるはずでしょ！ 所以你知道我现在有多困扰了吧！
[01:25.00]大好きなあなたのクリームシチュー作って欲しいよ 还想吃你做的奶油炖菜呢
[01:33.00]だいたい私のわがままは 再说 我的调皮任性
[01:37.00]あなたの前だけで有効だと 也只是给你一个人看的
[01:42.00]わかっているかい？ 你懂我意思吧？
[01:44.00]
[01:47.00]さんざん困らす私が言えることじゃないけど 也许不太像是个麻烦鬼说出来的话
[01:57.00]あなたの気持ちは 你的喜怒哀乐
[02:02.00]痛いぐらい沁みました 都深深感染着我
[02:06.00]だから今夜は私の 所以今晚呀
[02:12.00]作るクリームシチューを食べにおいでよ 就尝尝我给你做的奶油炖菜吧
[02:21.00]あなた仕込みの... 虽然也是你教我的
[02:26.00]
[02:46.00]浮き出たアクをすくって 穏やかに見せかけて 假装娴熟地打掉浮起来的泡泡
[02:50.00]少なくなったもんを補って 補い合って 缺什么味道就加什么调料
[02:55.00]足して 引いて 割って 掛けてってだけでもないから 当然做菜也不是简单得像加减乘除
[02:59.00]"わかんないやぁ"ってこともあるよね “ 下一步咋办！” 之类慌张的时候还是有的
[03:04.00]浮き出たアクをすくって 穏やかに見せかけて 假装娴熟地打掉浮起来的泡泡
[03:09.00]少なくなったもんを補って 補い合って 缺什么味道就加什么调料
[03:13.00]足して 引いて 割って 掛けてってだけでもないから 当然做菜也不是简单得像加减乘除
[03:18.00]"わかんないやぁ"ってこともあるよね “ 下一步咋办！” 之类慌张的时候还是有的
[03:23.00]..
[03:36.00]"わかんないやぁ"ってこともあるよね “ 下一步咋办！” 之类慌张的时候还是有的
[03:41.00]
[03:49.00]さんざん困らす私が言えることじゃないけど 也许不太像是个麻烦鬼说出来的话
[03:59.00]あなたの気持ちは 你的喜怒哀乐
[04:04.00]痛いぐらい沁みました 都深深感染着我
[04:08.00]だから今夜は私の 所以今晚呀
[04:13.00]作るクリームシチューを食べにおいでよ 就尝尝我给你做的奶油炖菜吧
[04:24.00]あなた仕込みの... 虽然也是你教我的
[04:30.00]
[04:35.00]そろそろ帰るだろう あたためなおしてあげよう 快快回家吧  别等菜凉了
[04:41.00]
[04:44.00]そろそろ帰るだろう あたためなおしてあげよう 快快回家吧  别等菜凉了
[04:51.00]', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/38a5733c-b49c-439d-b979-e91743a9fcc3.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('31', '25', 'Dancing', 'dancing', TO_TIMESTAMP('2025-04-24 11:40:19.559000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:41:29.769000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/d22cc117-294e-4e75-b8d4-7a1ffe5764d0.jpeg', '[by:奶酪味芝士条]
[00:00.00]作词 : Mellow Fellow 作曲 : Mellow Fellow  
[00:04.54]Years ago,When I had a chance 几年前，我拥有一个机会
[00:11.04]I could''ve held your hand 让我可以牵着你的手
[00:20.97]But I was young and then I blew every circumstance 但我那时太幼稚 我把每一种情况都搞砸了
[00:30.35]Yet I still think 但我仍然想
[00:34.84]I dream of dancing, dancing with you, with you 我梦想和你摇摆跳舞 跳舞啊
[00:48.14]And maybe even share a drink or two 甚至我们还可以喝一两杯小酒
[00:52.66]While I tell you the truth 但我告诉你真相的时候
[00:57.57]That I don''t even care what this is for 我甚至不在乎这是什么
[01:02.09]As long as I get to share the floor 只要我能和你共舞
[01:07.18]With you, with you... With you 和你，和你，就是你
[01:17.97]In my thoughts and dreams I do a little swayin'' away 我想的念的，就是小小的摇曳
[01:43.15]Swayin'' away with you 和你一起摇曳
[01:46.39]Even if I know it''ll never realize 即使我知道它永远不会实现
[01:52.74]Maybe one day I''ll wake up 也许某天我会清醒
[01:58.90]Maybe some day it''ll be true 也许某天我会梦想成真
[02:03.89]Maybe that day I''ll be 也许那天我会
[02:09.27]I''ll be 我会
[02:14.03]dancing dancing with you, with you 和你共舞啊和你，和你
[02:22.34]And maybe even love you a little more 甚至爱可爱的你更多一些
[02:27.40]While we tango across the floor 当我们跳着探戈滑曳过地板
[02:31.74]And I don''t even know when I''ll see you again 我甚至不知道什么时候能再见到你
[02:36.39]I''ll just keep living this dream ''till the end 我会在这个梦里不愿清醒直到结束
[02:41.61]With you, with you... With you 和你，和你，就是你', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/73d95ebf-ea7a-4502-b002-2ccaed0d2f13.mp3');
INSERT INTO "SONG" ("ID", "SINGER_ID", "NAME", "INTRODUCTION", "CREATE_TIME", "UPDATE_TIME", "PIC", "LYRIC", "URL") VALUES ('34', '26', 'Nostalgia (乡愁)', 'NOSTALGIA ～PIANO STORIES III～', TO_TIMESTAMP('2025-04-24 11:46:02.383000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), TO_TIMESTAMP('2025-04-24 11:46:02.383000', 'SYYYY-MM-DD HH24:MI:SS:FF6'), 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/img/302b0766-1e4a-4812-bc1a-39a8d774612c.jpeg', '[00:00:00]暂无歌词', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/song/c3aeb257-d14b-43dd-a76e-a34de2c3311d.mp3');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for SONG_LIST
-- ----------------------------
DROP TABLE "SONG_LIST";
CREATE TABLE "SONG_LIST" (
  "ID" NUMBER(10,0) NOT NULL,
  "TITLE" VARCHAR2(255 BYTE) NOT NULL,
  "PIC" VARCHAR2(255 BYTE),
  "INTRODUCTION" CLOB,
  "STYLE" VARCHAR2(100 BYTE) DEFAULT '无'
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of SONG_LIST
-- ----------------------------
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('41', 'test', 'img/songListPic/songList.jpg', '123', '华语-粤语');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('23', '国语经典歌曲', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/26270630-782f-41f9-a22b-568527cff122.png', 'yep', '粤语-华语');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('25', '欧美流行', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/d66822cd-62de-49b6-ad8e-f23f14076b91.png', NULL, '欧美-流行');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('26', '粤语老歌', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/7df2af3e-f9f8-410a-9d83-69c0b6546d88.png', '吼不吼哇', '粤语');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('21', '当下流行', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/21e30299-2815-43ce-9e0f-9fc670b637d6.png', 'popular', '流行');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('22', '检测二刺螈浓度', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/90d0c369-73bf-4c92-8ca1-73e4b311aa38.png', '~', 'ACG-日语');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('24', '古典乐曲', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/89b6b8f0-188a-42a0-a417-e588611942f7.png', 'classic', '纯音乐');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('27', '有助于睡眠的一个歌单', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/84f31a16-3115-4cf9-96dc-70555f86a27d.png', 'zzz~', '纯音乐');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('2', '欧美流行', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/6e659a88-32ca-4f99-9f25-639e3af97d7c.jpg', NULL, '欧美');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('29', '乐队', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/7cc5d574-660b-4e88-94f6-1603a8cc8dec.png', '乐队歌曲', '流行-欧美');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('1', 'BGM', 'https://music-web-oss-jlu.oss-cn-beijing.aliyuncs.com/songlist/7c32b022-2d5c-4d7f-993d-1478969d5cde.png', '背景音乐', '纯音乐');
INSERT INTO "SONG_LIST" ("ID", "TITLE", "PIC", "INTRODUCTION", "STYLE") VALUES ('28', '影视作品歌曲', 'img/songListPic/songList.jpg', NULL, '欧美');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for USER_SUPPORT
-- ----------------------------
DROP TABLE "USER_SUPPORT";
CREATE TABLE "USER_SUPPORT" (
  "ID" NUMBER(10,0) NOT NULL,
  "COMMENT_ID" NUMBER(10,0) NOT NULL,
  "USER_ID" NUMBER(10,0) NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of USER_SUPPORT
-- ----------------------------
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('48', '24', '21');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('57', '36', '1');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('41', '21', '1');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('42', '25', '1');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('43', '23', '1');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('44', '22', '1');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('54', '34', '2');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('51', '23', '2');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('49', '30', '21');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('50', '23', '21');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('52', '33', '2');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('53', '32', '2');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('55', '25', '2');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('46', '22', '21');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('45', '28', '1');
INSERT INTO "USER_SUPPORT" ("ID", "COMMENT_ID", "USER_ID") VALUES ('47', '29', '21');
COMMIT;
COMMIT;

-- ----------------------------
-- View structure for SONG_LIST_AVG_SCORES
-- ----------------------------
CREATE OR REPLACE VIEW "SONG_LIST_AVG_SCORES" AS SELECT 
    song_list_id,
    NVL(AVG(score), 0.0) as avg_score,
    COUNT(*) as total_ranks
FROM rank_list
GROUP BY song_list_id;

-- ----------------------------
-- Sequence structure for ADMIN_SEQ
-- ----------------------------
DROP SEQUENCE "ADMIN_SEQ";
CREATE SEQUENCE "ADMIN_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for BANNER_SEQ
-- ----------------------------
DROP SEQUENCE "BANNER_SEQ";
CREATE SEQUENCE "BANNER_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for COLLECT_SEQ
-- ----------------------------
DROP SEQUENCE "COLLECT_SEQ";
CREATE SEQUENCE "COLLECT_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for COMMENT_SEQ
-- ----------------------------
DROP SEQUENCE "COMMENT_SEQ";
CREATE SEQUENCE "COMMENT_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for COMMENT_SONG_LIST_SEQ
-- ----------------------------
DROP SEQUENCE "COMMENT_SONG_LIST_SEQ";
CREATE SEQUENCE "COMMENT_SONG_LIST_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for COMMENT_SONG_SEQ
-- ----------------------------
DROP SEQUENCE "COMMENT_SONG_SEQ";
CREATE SEQUENCE "COMMENT_SONG_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for CONSUMER_SEQ
-- ----------------------------
DROP SEQUENCE "CONSUMER_SEQ";
CREATE SEQUENCE "CONSUMER_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for LIST_SONG_SEQ
-- ----------------------------
DROP SEQUENCE "LIST_SONG_SEQ";
CREATE SEQUENCE "LIST_SONG_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for RANK_LIST_SEQ
-- ----------------------------
DROP SEQUENCE "RANK_LIST_SEQ";
CREATE SEQUENCE "RANK_LIST_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for SINGER_SEQ
-- ----------------------------
DROP SEQUENCE "SINGER_SEQ";
CREATE SEQUENCE "SINGER_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for SONG_LIST_SEQ
-- ----------------------------
DROP SEQUENCE "SONG_LIST_SEQ";
CREATE SEQUENCE "SONG_LIST_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for SONG_SEQ
-- ----------------------------
DROP SEQUENCE "SONG_SEQ";
CREATE SEQUENCE "SONG_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for USER_SUPPORT_SEQ
-- ----------------------------
DROP SEQUENCE "USER_SUPPORT_SEQ";
CREATE SEQUENCE "USER_SUPPORT_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Primary Key structure for table ADMIN
-- ----------------------------
ALTER TABLE "ADMIN" ADD CONSTRAINT "SYS_C0011615" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table ADMIN
-- ----------------------------
ALTER TABLE "ADMIN" ADD CONSTRAINT "SYS_C0011616" UNIQUE ("NAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table ADMIN
-- ----------------------------
ALTER TABLE "ADMIN" ADD CONSTRAINT "SYS_C0011613" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "ADMIN" ADD CONSTRAINT "SYS_C0011614" CHECK ("PASSWORD" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table ADMIN
-- ----------------------------
CREATE TRIGGER "ADMIN_TRIGGER" BEFORE INSERT ON "ADMIN" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT admin_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table COLLECT
-- ----------------------------
ALTER TABLE "COLLECT" ADD CONSTRAINT "SYS_C0011642" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table COLLECT
-- ----------------------------
ALTER TABLE "COLLECT" ADD CONSTRAINT "SYS_C0011638" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COLLECT" ADD CONSTRAINT "SYS_C0011639" CHECK ("TYPE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COLLECT" ADD CONSTRAINT "SYS_C0011640" CHECK ("SONG_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COLLECT" ADD CONSTRAINT "SYS_C0011641" CHECK ("CREATE_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table COLLECT
-- ----------------------------
CREATE TRIGGER "COLLECT_TRIGGER" BEFORE INSERT ON "COLLECT" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT collect_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table CONSUMER
-- ----------------------------
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011623" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table CONSUMER
-- ----------------------------
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011624" UNIQUE ("USERNAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011625" UNIQUE ("PHONE_NUM") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011626" UNIQUE ("EMAIL") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table CONSUMER
-- ----------------------------
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011619" CHECK ("USERNAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011620" CHECK ("PASSWORD" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011621" CHECK ("CREATE_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CONSUMER" ADD CONSTRAINT "SYS_C0011622" CHECK ("UPDATE_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table CONSUMER
-- ----------------------------
CREATE TRIGGER "CONSUMER_TRIGGER" BEFORE INSERT ON "CONSUMER" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT consumer_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table LIST_SONG
-- ----------------------------
ALTER TABLE "LIST_SONG" ADD CONSTRAINT "SYS_C0011661" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table LIST_SONG
-- ----------------------------
ALTER TABLE "LIST_SONG" ADD CONSTRAINT "SYS_C0011659" CHECK ("SONG_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LIST_SONG" ADD CONSTRAINT "SYS_C0011660" CHECK ("SONG_LIST_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table LIST_SONG
-- ----------------------------
CREATE TRIGGER "LIST_SONG_TRIGGER" BEFORE INSERT ON "LIST_SONG" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT list_song_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table MUS_COMMENT
-- ----------------------------
ALTER TABLE "MUS_COMMENT" ADD CONSTRAINT "SYS_C0011647" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table MUS_COMMENT
-- ----------------------------
ALTER TABLE "MUS_COMMENT" ADD CONSTRAINT "SYS_C0011645" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MUS_COMMENT" ADD CONSTRAINT "SYS_C0011646" CHECK ("TYPE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table MUS_COMMENT
-- ----------------------------
CREATE TRIGGER "COMMENT_TRIGGER" BEFORE INSERT ON "MUS_COMMENT" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT comment_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table RANK_LIST
-- ----------------------------
ALTER TABLE "RANK_LIST" ADD CONSTRAINT "SYS_C0011666" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table RANK_LIST
-- ----------------------------
ALTER TABLE "RANK_LIST" ADD CONSTRAINT "UK_CONSUMER_SONGLIST" UNIQUE ("CONSUMER_ID", "SONG_LIST_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table RANK_LIST
-- ----------------------------
ALTER TABLE "RANK_LIST" ADD CONSTRAINT "SYS_C0011664" CHECK ("SONG_LIST_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "RANK_LIST" ADD CONSTRAINT "SYS_C0011665" CHECK ("CONSUMER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table RANK_LIST
-- ----------------------------
CREATE TRIGGER "RANK_LIST_TRIGGER" BEFORE INSERT ON "RANK_LIST" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT rank_list_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table SINGER
-- ----------------------------
ALTER TABLE "SINGER" ADD CONSTRAINT "SYS_C0011628" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table SINGER
-- ----------------------------
ALTER TABLE "SINGER" ADD CONSTRAINT "SYS_C0011627" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table SINGER
-- ----------------------------
CREATE TRIGGER "SINGER_TRIGGER" BEFORE INSERT ON "SINGER" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT singer_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table SONG
-- ----------------------------
ALTER TABLE "SONG" ADD CONSTRAINT "SYS_C0011636" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table SONG
-- ----------------------------
ALTER TABLE "SONG" ADD CONSTRAINT "SYS_C0011631" CHECK ("SINGER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "SONG" ADD CONSTRAINT "SYS_C0011632" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "SONG" ADD CONSTRAINT "SYS_C0011633" CHECK ("CREATE_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "SONG" ADD CONSTRAINT "SYS_C0011634" CHECK ("UPDATE_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "SONG" ADD CONSTRAINT "SYS_C0011635" CHECK ("URL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table SONG
-- ----------------------------
CREATE TRIGGER "SONG_TRIGGER" BEFORE INSERT ON "SONG" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT song_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table SONG_LIST
-- ----------------------------
ALTER TABLE "SONG_LIST" ADD CONSTRAINT "SYS_C0011630" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table SONG_LIST
-- ----------------------------
ALTER TABLE "SONG_LIST" ADD CONSTRAINT "SYS_C0011629" CHECK ("TITLE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table SONG_LIST
-- ----------------------------
CREATE TRIGGER "SONG_LIST_TRIGGER" BEFORE INSERT ON "SONG_LIST" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT song_list_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Primary Key structure for table USER_SUPPORT
-- ----------------------------
ALTER TABLE "USER_SUPPORT" ADD CONSTRAINT "SYS_C0011672" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table USER_SUPPORT
-- ----------------------------
ALTER TABLE "USER_SUPPORT" ADD CONSTRAINT "SYS_C0011670" CHECK ("COMMENT_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "USER_SUPPORT" ADD CONSTRAINT "SYS_C0011671" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table USER_SUPPORT
-- ----------------------------
CREATE TRIGGER "USER_SUPPORT_TRIGGER" BEFORE INSERT ON "USER_SUPPORT" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
    SELECT user_support_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- ----------------------------
-- Foreign Keys structure for table COLLECT
-- ----------------------------
ALTER TABLE "COLLECT" ADD CONSTRAINT "FK_COLLECT_SONG" FOREIGN KEY ("SONG_ID") REFERENCES "SONG" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COLLECT" ADD CONSTRAINT "FK_COLLECT_USER" FOREIGN KEY ("USER_ID") REFERENCES "CONSUMER" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table LIST_SONG
-- ----------------------------
ALTER TABLE "LIST_SONG" ADD CONSTRAINT "FK_LISTSONG_SONG" FOREIGN KEY ("SONG_ID") REFERENCES "SONG" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LIST_SONG" ADD CONSTRAINT "FK_LISTSONG_SONGLIST" FOREIGN KEY ("SONG_LIST_ID") REFERENCES "SONG_LIST" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MUS_COMMENT
-- ----------------------------
ALTER TABLE "MUS_COMMENT" ADD CONSTRAINT "FK_COMMENT_SONG" FOREIGN KEY ("SONG_ID") REFERENCES "SONG" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MUS_COMMENT" ADD CONSTRAINT "FK_COMMENT_SONGLIST" FOREIGN KEY ("SONG_LIST_ID") REFERENCES "SONG_LIST" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MUS_COMMENT" ADD CONSTRAINT "FK_COMMENT_USER" FOREIGN KEY ("USER_ID") REFERENCES "CONSUMER" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table RANK_LIST
-- ----------------------------
ALTER TABLE "RANK_LIST" ADD CONSTRAINT "FK_RANKLIST_CONSUMER" FOREIGN KEY ("CONSUMER_ID") REFERENCES "CONSUMER" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "RANK_LIST" ADD CONSTRAINT "FK_RANKLIST_SONGLIST" FOREIGN KEY ("SONG_LIST_ID") REFERENCES "SONG_LIST" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table SONG
-- ----------------------------
ALTER TABLE "SONG" ADD CONSTRAINT "FK_SONG_SINGER" FOREIGN KEY ("SINGER_ID") REFERENCES "SINGER" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table USER_SUPPORT
-- ----------------------------
ALTER TABLE "USER_SUPPORT" ADD CONSTRAINT "FK_SUPPORT_COMMENT" FOREIGN KEY ("COMMENT_ID") REFERENCES "MUS_COMMENT" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "USER_SUPPORT" ADD CONSTRAINT "FK_SUPPORT_USER" FOREIGN KEY ("USER_ID") REFERENCES "CONSUMER" ("ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
