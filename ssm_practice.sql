/*
 Navicat Premium Data Transfer

 Source Server         : cms
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : ssm_practice

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 07/03/2021 09:51:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of authority
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `categoryDesc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'normal', '日常');
INSERT INTO `category` VALUES (2, 'working', '工作');
INSERT INTO `category` VALUES (3, 'learning', '学习');
INSERT INTO `category` VALUES (4, 'entertainment', '娱乐');
INSERT INTO `category` VALUES (5, 'trivia', '琐事');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mid` int(11) NULL DEFAULT NULL,
  `pubTime` datetime(0) NULL DEFAULT NULL,
  `favorNum` int(11) NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `masterpiece_comment_fk`(`mid`) USING BTREE,
  INDEX `user_comment_fk`(`uid`) USING BTREE,
  CONSTRAINT `masterpiece_comment_fk` FOREIGN KEY (`mid`) REFERENCES `masterpiece` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_comment_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, '真美，东极真好看', 5, '2020-12-07 00:00:00', 0, 2);
INSERT INTO `comments` VALUES (26, '大萨达撒', 5, '2020-12-07 15:42:07', 0, 1);
INSERT INTO `comments` VALUES (28, '你好呀', 5, '2020-12-08 09:23:28', 0, 1);
INSERT INTO `comments` VALUES (29, '你好呀 第二次放松呀', 5, '2020-12-08 09:28:37', 0, 1);
INSERT INTO `comments` VALUES (30, '123', 5, '2020-12-08 09:30:18', 0, 1);
INSERT INTO `comments` VALUES (31, '能成功吗', 5, '2020-12-08 09:46:15', 0, 1);
INSERT INTO `comments` VALUES (32, '应该可以了吧', 5, '2020-12-08 10:00:37', 0, 1);
INSERT INTO `comments` VALUES (33, '终于成功了', 5, '2020-12-08 10:17:42', 0, 1);
INSERT INTO `comments` VALUES (34, '作品管理页面几乎实现成功，还差一个发布作品以及删除作品', 5, '2020-12-14 07:25:50', 0, 1);
INSERT INTO `comments` VALUES (35, '你好呀  今天功能正常嘛', 5, '2020-12-16 06:53:01', 0, 1);
INSERT INTO `comments` VALUES (36, '你好 今天怎么页面出问题了', 5, '2020-12-17 06:45:13', 0, 1);
INSERT INTO `comments` VALUES (37, 'fdsfsd', 5, '2020-12-17 07:01:49', 0, 2);
INSERT INTO `comments` VALUES (38, '今天可以吗2020-12-18', 5, '2020-12-18 06:18:36', 0, 1);

-- ----------------------------
-- Table structure for masterpiece
-- ----------------------------
DROP TABLE IF EXISTS `masterpiece`;
CREATE TABLE `masterpiece`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `cid` int(11) NULL DEFAULT NULL,
  `commentNum` int(11) NULL DEFAULT NULL,
  `viewNum` int(11) NULL DEFAULT NULL,
  `favorNum` int(11) NULL DEFAULT NULL,
  `pubTime` datetime(0) NULL DEFAULT NULL,
  `masterpieceDesc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `masterpieceContent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `coverUrl` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_m_fk`(`uid`) USING BTREE,
  INDEX `category_m_fk`(`cid`) USING BTREE,
  CONSTRAINT `category_m_fk` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_m_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of masterpiece
-- ----------------------------
INSERT INTO `masterpiece` VALUES (5, 1, 4, 256, 132, 67, '2020-12-04 00:00:00', '舟山行', '东极很美，生活很慢，可惜没看到日出，吃海鲜被坑', 'img/masterpiece/dongjiCover.jpg');
INSERT INTO `masterpiece` VALUES (6, 1, 4, 256, 5, 95, '2020-12-04 15:08:12', '武汉行', '热干面好吃、欢乐谷挑战了自己玩了跳楼机', 'img/masterpiece/wuhanCover.jpg');
INSERT INTO `masterpiece` VALUES (7, 1, 4, 256, 3, 102, '2020-12-04 15:08:33', '宁波行', '东钱湖、月湖公园、老外滩等等都让人愉快，就是风真的很大', 'img/masterpiece/ningboCover.jpg');

-- ----------------------------
-- Table structure for picture
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `masterpiece_p_fk`(`mid`) USING BTREE,
  CONSTRAINT `masterpiece_p_fk` FOREIGN KEY (`mid`) REFERENCES `masterpiece` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of picture
-- ----------------------------
INSERT INTO `picture` VALUES (1, 'img/masterpiece/shaoxingCover.jpg', 5);
INSERT INTO `picture` VALUES (2, 'img/masterpiece/ningboCover.jpg', 6);
INSERT INTO `picture` VALUES (3, 'img/masterpiece/wuhanCover.jpg', 7);

-- ----------------------------
-- Table structure for privatemsg
-- ----------------------------
DROP TABLE IF EXISTS `privatemsg`;
CREATE TABLE `privatemsg`  (
  `uid` int(11) NOT NULL,
  `masterpieceUid` int(11) NOT NULL,
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sendTime` datetime(0) NULL DEFAULT NULL,
  INDEX `user_user_id_fk`(`uid`) USING BTREE,
  INDEX `user_authord_id_fk`(`masterpieceUid`) USING BTREE,
  CONSTRAINT `user_authord_id_fk` FOREIGN KEY (`masterpieceUid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_user_id_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of privatemsg
-- ----------------------------
INSERT INTO `privatemsg` VALUES (2, 1, '你好呀 测试时间', '2020-12-18 15:20:10');
INSERT INTO `privatemsg` VALUES (1, 3, 'hello world', '2020-12-20 10:29:00');
INSERT INTO `privatemsg` VALUES (3, 1, 'reverse msg', '2020-12-20 10:39:51');
INSERT INTO `privatemsg` VALUES (2, 3, 'hello java', '2020-12-20 11:42:53');
INSERT INTO `privatemsg` VALUES (2, 1, 'hello java', '2020-12-20 11:44:13');
INSERT INTO `privatemsg` VALUES (1, 2, '试一下 看看能不能成功', '2020-12-22 15:25:48');
INSERT INTO `privatemsg` VALUES (1, 3, 'hello 21927088', '2020-12-22 15:26:15');
INSERT INTO `privatemsg` VALUES (1, 3, 'js测试', '2020-12-22 15:31:27');
INSERT INTO `privatemsg` VALUES (1, 2, '你好  是不是能清空输入框的内容', '2020-12-22 15:34:21');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `roleDesc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_USER', '普通用户');
INSERT INTO `role` VALUES (2, 'ROLE_ADMIN', '管理员');
INSERT INTO `role` VALUES (4, 'ROLE_EMPLOYEE', '企业员工');

-- ----------------------------
-- Table structure for role_authority
-- ----------------------------
DROP TABLE IF EXISTS `role_authority`;
CREATE TABLE `role_authority`  (
  `rid` int(11) NULL DEFAULT NULL,
  `aid` int(11) NULL DEFAULT NULL,
  INDEX `role_fk2`(`rid`) USING BTREE,
  INDEX `authority_fk`(`aid`) USING BTREE,
  CONSTRAINT `authority_fk` FOREIGN KEY (`aid`) REFERENCES `authority` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_fk2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_authority
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phoneNum` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '418314316@qq.com', 'djh', '19883115832', 1, '123456');
INSERT INTO `user` VALUES (2, '418314316@qq.com', 'ly', '18883185832', 0, '123456');
INSERT INTO `user` VALUES (3, '418314316@qq.com', '21927088', '18888888888', 0, '$2a$10$ikorh7ve9bRi8Te4PI49d.N2rD5k9xK33AI5scxupq1lGRi3oy.W2');
INSERT INTO `user` VALUES (4, '418314316@qq.com', 'yzcgqz', '19883115832', 0, '$2a$10$5BLfhqXCSXuj5Y8laTZpT.aePyeIX2o9CTC1YIIo7vKxcdTnqQT22');
INSERT INTO `user` VALUES (6, '418314316@qq.com', '代佳豪', '19883115832', 1, '$2a$10$6b2RU76RLoUCspfS6W.y8.4Oogaq4Kr5GFsRecf/Fxwu14t9Ltxdq');
INSERT INTO `user` VALUES (7, '418314316@qq.com', 'hello world', '19883115832', 0, '$2a$10$/hz.QxxwGtI5d53EZfK3LOszfvSVwzp39rdImg/gsh.GVxYUhvOn.');
INSERT INTO `user` VALUES (8, '418314316@qq.com', 'hello', '19883115832', 1, '$2a$10$Ongqtc0s/F6p.oQlx7gAFOL2coRIUboRv7tWH8zzmhg.9dgqp5Y3u');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `uid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL,
  INDEX `user_fk`(`uid`) USING BTREE,
  INDEX `role_fk`(`rid`) USING BTREE,
  CONSTRAINT `role_fk` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1);
INSERT INTO `user_role` VALUES (1, 2);
INSERT INTO `user_role` VALUES (2, 1);
INSERT INTO `user_role` VALUES (3, 1);
INSERT INTO `user_role` VALUES (4, 1);
INSERT INTO `user_role` VALUES (6, 4);
INSERT INTO `user_role` VALUES (6, 1);
INSERT INTO `user_role` VALUES (7, 1);
INSERT INTO `user_role` VALUES (6, 2);
INSERT INTO `user_role` VALUES (1, 4);
INSERT INTO `user_role` VALUES (8, 4);
INSERT INTO `user_role` VALUES (8, 1);

-- ----------------------------
-- Table structure for usertouser
-- ----------------------------
DROP TABLE IF EXISTS `usertouser`;
CREATE TABLE `usertouser`  (
  `uid` int(11) NOT NULL,
  `conuid` int(11) NOT NULL,
  INDEX `userinfo_fk`(`uid`) USING BTREE,
  INDEX `userinfo_con_fk`(`conuid`) USING BTREE,
  CONSTRAINT `userinfo_con_fk` FOREIGN KEY (`conuid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `userinfo_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usertouser
-- ----------------------------
INSERT INTO `usertouser` VALUES (3, 1);
INSERT INTO `usertouser` VALUES (4, 1);
INSERT INTO `usertouser` VALUES (1, 2);
INSERT INTO `usertouser` VALUES (1, 3);
INSERT INTO `usertouser` VALUES (2, 1);

SET FOREIGN_KEY_CHECKS = 1;
