/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost
 Source Database       : Tickets

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : utf-8

 Date: 05/15/2018 12:35:17 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `alipay`
-- ----------------------------
DROP TABLE IF EXISTS `alipay`;
CREATE TABLE `alipay` (
  `alipayid` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`alipayid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `alipay`
-- ----------------------------
BEGIN;
INSERT INTO `alipay` VALUES ('15050582771', '123', '502.33'), ('1512500', '123', '192.00'), ('18277563751', '123', '9827.80'), ('dahua', '123', '0.00'), ('managerAlipay', '123', '477.87'), ('theater', '123', '0.00');
COMMIT;

-- ----------------------------
--  Table structure for `balance`
-- ----------------------------
DROP TABLE IF EXISTS `balance`;
CREATE TABLE `balance` (
  `showid` int(11) NOT NULL,
  `time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `totalincome` decimal(10,2) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL COMMENT '0为未结算，1为已结算',
  PRIMARY KEY (`showid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `balance`
-- ----------------------------
BEGIN;
INSERT INTO `balance` VALUES ('7', '2018-03-17 17:00:38', '240.00', '1'), ('8', '2018-03-22 15:27:05', '166.50', '1'), ('9', '2018-05-04 16:42:49', '0.00', '0'), ('11', '2018-03-31 20:47:13', '202.40', '0'), ('16', '2018-03-31 20:47:13', '0.00', '0'), ('17', '2018-03-21 14:43:15', '0.00', '1'), ('18', '2018-03-31 20:47:13', '0.00', '0'), ('19', '2018-05-15 11:28:57', '0.00', '0');
COMMIT;

-- ----------------------------
--  Table structure for `manager`
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `managerid` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `alipayid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`managerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `manager`
-- ----------------------------
BEGIN;
INSERT INTO `manager` VALUES ('manager', '123', 'managerAlipay');
COMMIT;

-- ----------------------------
--  Table structure for `member`
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `memberid` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL COMMENT '0代表男，1代表女',
  `age` int(3) DEFAULT NULL,
  `image` varchar(255) DEFAULT '',
  `consumption` decimal(63,2) DEFAULT NULL COMMENT '用消费金额来计算会员等级',
  `points` int(255) DEFAULT NULL,
  `coupon1` int(255) DEFAULT '0' COMMENT '第1种优惠劵的数量',
  `coupon2` int(255) DEFAULT '0' COMMENT '第2种优惠劵的数量',
  `coupon3` int(255) DEFAULT '0' COMMENT '第3种优惠劵的数量',
  `isvalid` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `member`
-- ----------------------------
BEGIN;
INSERT INTO `member` VALUES ('1216832052@qq.com', 'ml', '123', '0', '0', '/resources/images/not-head.png', '0.00', '0', '0', '0', '0', '0'), ('151250008@smail.nju.edu.cn', 'zhs123', '123', '1', '18', '/resources/images/not-head.png', '0.00', '0', '0', '0', '0', '1'), ('18277563751@163.com', 'zenghs', '123', '1', '18', '/resources/images/upload/portrait/18277563751@163.com.png', '166.50', '1515', '0', '0', '0', '1'), ('member@qq.com', 'member', '123', '1', '18', '/resources/images/upload/portrait/member@qq.com.png', '442.40', '3874', '3', '2', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderid` varchar(255) NOT NULL,
  `memberid` varchar(255) DEFAULT NULL,
  `showtimeid` varchar(255) DEFAULT NULL,
  `alipayid` varchar(255) DEFAULT NULL,
  `ordertype` tinyint(1) DEFAULT NULL COMMENT '选座购买(1)或立即购买(0)',
  `number` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL COMMENT '订单状态分为待支付0，已支付（待检票1，已观看2），已失效（已取消3，已退订4）',
  `time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `discount` decimal(3,2) DEFAULT NULL,
  `coupontype` tinyint(1) DEFAULT NULL COMMENT '0为未使用，1-3表示优惠劵类型',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `order`
-- ----------------------------
BEGIN;
INSERT INTO `order` VALUES ('182775637518201803211700201803202241', '18277563751@163.com', '8201803211700', '18277563751', '0', '4', '114.00', '4', '2018-03-20 22:41:21', '0.95', '0'), ('182775637518201803211700201803202250', '18277563751@163.com', '8201803211700', '18277563751', '1', '2', '58.50', '2', '2018-03-20 23:14:15', '0.85', '1'), ('182775637518201803211700201803210015', '18277563751@163.com', '8201803211700', null, '1', '2', '90.00', '3', '2018-03-21 00:15:42', '0.90', '0'), ('182775637518201803211700201803210034', '18277563751@163.com', '8201803211700', '18277563751', '0', '4', '108.00', '2', '2018-03-21 00:34:38', '0.90', '0'), ('member11201803221300201803201351', 'member@qq.com', '11201803221300', '15050582771', '1', '2', '70.40', '1', '2018-03-20 13:51:43', '0.80', '0'), ('member11201803231400201803221520', 'member@qq.com', '11201803231400', '15050582771', '0', '5', '132.00', '2', '2018-03-22 15:20:56', '0.80', '0'), ('member16201803231500201803221521', 'member@qq.com', '16201803231500', null, '1', '3', '62.50', '3', '2018-03-22 15:21:27', '0.75', '2'), ('member18201803231500201803221520', 'member@qq.com', '18201803231500', '15050582771', '1', '3', '157.40', '4', '2018-03-22 15:20:16', '0.80', '1'), ('member19201805071645201805041651', 'member@qq.com', '19201805071645', null, '1', '2', '63.00', '3', '2018-05-04 16:51:39', '0.80', '1'), ('member7201803141539201803142054', 'member@qq.com', '7201803141539', '15050582771', '1', '1', '474.00', '4', '2018-03-15 19:43:26', '0.95', '1'), ('member7201803141539201803142154', 'member@qq.com', '7201803141539', '15050582771', '0', '1', '240.00', '2', '2018-03-16 00:30:12', '0.80', '0'), ('member8201803201700201803201140', 'member@qq.com', '8201803201700', null, '1', '3', '120.00', '3', '2018-03-20 11:40:31', '0.80', '0');
COMMIT;

-- ----------------------------
--  Table structure for `orderrefund`
-- ----------------------------
DROP TABLE IF EXISTS `orderrefund`;
CREATE TABLE `orderrefund` (
  `orderid` varchar(255) NOT NULL,
  `time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fee` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `orderrefund`
-- ----------------------------
BEGIN;
INSERT INTO `orderrefund` VALUES ('182775637518201803211700201803202241', '2018-03-20 22:54:01', '5.70'), ('member18201803231500201803221520', '2018-03-22 15:22:07', '7.87'), ('member7201803141539201803142054', '2018-03-15 19:45:16', '47.40');
COMMIT;

-- ----------------------------
--  Table structure for `orderseat`
-- ----------------------------
DROP TABLE IF EXISTS `orderseat`;
CREATE TABLE `orderseat` (
  `orderseatid` int(255) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(255) NOT NULL,
  `seatRow` int(11) NOT NULL,
  `seatColumn` int(11) NOT NULL,
  `seattype` tinyint(1) DEFAULT NULL COMMENT '1为前排，2为中间，3为靠后，0为不选座购买',
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`orderseatid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `orderseat`
-- ----------------------------
BEGIN;
INSERT INTO `orderseat` VALUES ('1', 'member7201803141539201803142054', '1', '7', '1', '500.00'), ('5', 'member7201803141539201803142154', '2', '1', '0', '300.00'), ('12', 'member8201803201700201803201140', '2', '4', '1', '50.00'), ('13', 'member8201803201700201803201140', '2', '5', '1', '50.00'), ('14', 'member8201803201700201803201140', '2', '6', '1', '50.00'), ('15', 'member11201803221300201803201351', '4', '3', '2', '44.00'), ('16', 'member11201803221300201803201351', '4', '2', '2', '44.00'), ('17', '182775637518201803211700201803202250', '4', '8', '2', '40.00'), ('18', '182775637518201803211700201803202250', '8', '6', '3', '30.00'), ('19', '182775637518201803211700201803210015', '1', '2', '1', '50.00'), ('20', '182775637518201803211700201803210015', '1', '3', '1', '50.00'), ('21', '182775637518201803211700201803210034', '1', '1', '0', '30.00'), ('22', '182775637518201803211700201803210034', '1', '2', '0', '30.00'), ('23', '182775637518201803211700201803210034', '1', '3', '0', '30.00'), ('24', '182775637518201803211700201803210034', '1', '6', '0', '30.00'), ('25', 'member18201803231500201803221520', '1', '3', '1', '66.00'), ('26', 'member18201803231500201803221520', '1', '4', '1', '66.00'), ('27', 'member18201803231500201803221520', '1', '5', '1', '66.00'), ('28', 'member16201803231500201803221521', '1', '3', '1', '30.00'), ('29', 'member16201803231500201803221521', '1', '4', '1', '30.00'), ('30', 'member16201803231500201803221521', '1', '5', '1', '30.00'), ('31', 'member11201803231400201803221520', '1', '1', '0', '33.00'), ('32', 'member11201803231400201803221520', '1', '2', '0', '33.00'), ('33', 'member11201803231400201803221520', '1', '3', '0', '33.00'), ('34', 'member11201803231400201803221520', '1', '4', '0', '33.00'), ('35', 'member11201803231400201803221520', '1', '5', '0', '33.00'), ('36', 'member19201805071645201805041651', '2', '4', '1', '40.00'), ('37', 'member19201805071645201805041651', '2', '5', '1', '40.00');
COMMIT;

-- ----------------------------
--  Table structure for `show`
-- ----------------------------
DROP TABLE IF EXISTS `show`;
CREATE TABLE `show` (
  `showid` int(255) NOT NULL AUTO_INCREMENT,
  `theaterid` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `actor` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT '/resources/images/defaultMovie.jpg',
  `price1` decimal(10,2) DEFAULT NULL,
  `price2` decimal(10,2) DEFAULT NULL,
  `price3` decimal(10,2) DEFAULT NULL,
  `isopen` tinyint(1) DEFAULT '0' COMMENT '0是未开票，1是已开票',
  PRIMARY KEY (`showid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='可以由theaterid，type, title 唯一确定一个show';

-- ----------------------------
--  Records of `show`
-- ----------------------------
BEGIN;
INSERT INTO `show` VALUES ('7', '1512500', 'got7回归', '5', 'JB，金有谦', '开不开心', '/resources/images/upload/theater/1512500/Concert/got7回归.jpg', '500.00', '400.00', '300.00', '1'), ('8', 'theater', '红海行动', '0', '张译,黄景瑜,海清,杜江,蒋璐霞', '索马里海域外，中国的商船遭遇劫持，船员全数沦为阶下囚。蛟龙突击队沉着应对，潜入商船进行突袭，成功解救全部人质。 返航途中，非洲北部伊维亚共和国发生政变，恐怖组织连同叛军攻入...', '/resources/images/upload/theater/theater/Movie/红海行动.jpg_160x160', '50.00', '40.00', '30.00', '1'), ('9', 'theater', '水形物语', '0', '莎莉·霍金斯,迈克尔·珊农', '故事发生在1963年，时值冷战期间，哑女艾丽莎（莎莉·霍金斯 Sally Hawkins 饰）在政府实验室里工作，是那里的一名清洁女工。年幼时，一场大病夺走了艾丽莎的声音...', '/resources/images/upload/theater/theater/Movie/水形物语.jpg_160x160', '42.00', '35.00', '31.00', '1'), ('11', '1512500', '三块广告牌', '0', '弗兰西斯·麦克多蒙德,伍迪·哈里森', '米尔德雷德（弗兰西斯·麦克多蒙德 Frances McDormand 饰）的女儿在外出时惨遭奸杀，米尔德雷德和丈夫查理（约翰·哈克斯 John Hawkes 饰）之间的婚姻因此走到了尽头', '/resources/images/upload/theater/1512500/Movie/三块广告牌.jpg_300x300', '55.00', '44.00', '33.00', '1'), ('16', '1512500', '比得兔', '0', '詹姆斯·柯登,多姆纳尔·格里森', '电影《比得兔》是一部由英国百年经典IP改编的真人动画电影，影片讲述了田园冒险大王“比得兔” 带领一众伙伴，与麦格雷戈叔侄二人，为争夺菜园主权和隔壁美丽女主人贝伊的喜爱而斗智斗勇、各显神通的爆笑故事。', '/resources/images/upload/theater/1512500/Movie/比得兔.jpg_300x300', '30.00', '20.00', '15.00', '1'), ('17', 'theater', '厉害了我的国', '0', '卫铁', '本片以习近平新时代中国特色社会主义思想为内在逻辑，展示了在创新、协调、绿色、开放和共享的新发展理念下中国这五年的伟大成就，展现了中国人民在全面建设小康征程上的伟大奋斗', '/resources/images/upload/theater/theater/Movie/厉害了我的国.jpg', '45.00', '35.00', '25.00', '1'), ('18', 'j2ee025', '虎皮萌企鹅', '0', 'Paul Borne,Philippe Bozo', '虎企鹅Maurice从天而降到丛林中，它到底是一只企鹅，还是一只老虎？它的妈妈为什么是一只老虎？而它的孩子为什么是一条鱼？滑稽的无厘头的设计', '/resources/images/upload/theater/j2ee025/Movie/虎皮萌企鹅.jpg', '66.00', '55.00', '44.00', '1'), ('19', 'theater', '后来的我们', '0', '刘若英，井柏然,周冬雨,田壮壮', '这是一个爱情故事，关于一对异乡漂泊的年轻人。十年前，见清和小晓偶然地相识在归乡过年的火车上。两人怀揣着共同的梦想，一起在北京打拼，并开始了一段相聚相离的情感之路。', '/resources/images/upload/theater/theater/Movie/后来的我们.jpg', '40.00', '30.00', '20.00', '1'), ('20', 'theater', '复仇者联盟3', '0', '安东尼·罗素,小罗伯特·唐尼,克里斯·海姆斯沃斯', '漫威影业为您倾力呈现万众期待的终极力作《复仇者联盟3：无限战争》！复仇者联盟的一众超级英雄，必须抱着牺牲一切的信念，与史上最强大反派灭霸(Thanos)殊死一搏', '/resources/images/upload/theater/theater/Movie/复仇者联盟3.jpg', '60.00', '50.00', '40.00', '1'), ('21', 'theater', '超时空同居', '0', '苏伦，雷佳音，佟丽娅', '来自2018年谷小焦（佟丽娅 饰）与1999年陆鸣（雷佳音 饰），两人时空重叠意外住在同一个房间。从互相嫌弃到试图“共谋大业”，阴差阳错发生了一系列好笑的事情。', '/resources/images/upload/theater/theater/Movie/超时空同居.jpg', '45.00', '35.00', '25.00', '1'), ('22', 'theater', '完美陌生人', '0', '保罗·格诺维瑟，马可 ·吉亚历尼，卡西娅·史穆特妮亚克', '三对处于各个婚姻阶段的伴侣和一个宅男，七人聚在一起吃晚餐。女主人提议下拍板决定当夜所有人分享每一个电话、每一条短信、邮件的内容，由此许多秘密开始不再是秘密，他们之间的关系...', '/resources/images/upload/theater/theater/Movie/完美陌生人.jpg', '55.00', '50.00', '45.00', '0'), ('23', 'j2ee025', '我是你妈', '0', '张骁,闫妮,邹元清', '影片讲述了一对形同姐妹又骨肉情深的别样母女，不按套路出牌的单身辣妈秦美丽（闫妮饰）与正处于叛逆期的女儿赵小艺（邹元清饰）之间相“碍”相亲、陪伴成长，一系列欢脱又不失温情的...', '/resources/images/upload/theater/j2ee025/Movie/我是你妈.jpg', '50.00', '45.00', '40.00', '1'), ('24', 'j2ee025', '幕后玩家', '0', '任鹏远,徐峥,王丽坤', '坐拥数亿财产的钟小年(徐峥 饰)意外遭人绑架，不得不在一位神秘人的操控下完 成一道道令人两难的选择题。在选择的过程中，钟小年落入陷阱，不仅巨额财产被盗取、 濒临身败名裂的...', '/resources/images/upload/theater/j2ee025/Movie/幕后玩家.jpg', '80.00', '70.00', '65.00', '1'), ('25', 'j2ee025', '沉默的证人', '0', '雷尼·哈林,张家辉,杨紫,任贤齐', '由好莱坞一线动作导演雷尼·哈林执导的警匪犯罪动作片。三名手持武器的狂躁匪徒在平安夜杀入香港法医中心抢夺证物，枪杀了楼中保安，并挟持和暴虐对待两位法医。在此期间，法医对匪徒...', '/resources/images/upload/theater/j2ee025/Movie/沉默的证人.jpg', '100.00', '90.00', '80.00', '0');
COMMIT;

-- ----------------------------
--  Table structure for `showtime`
-- ----------------------------
DROP TABLE IF EXISTS `showtime`;
CREATE TABLE `showtime` (
  `showtimeid` varchar(255) NOT NULL COMMENT 'showid+演出日期',
  `showid` int(255) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time DEFAULT NULL,
  `seatCondition` varchar(255) DEFAULT NULL COMMENT '存储当前座位的情况，无座位用0表示，可选座位用1表示，已选座位用2表示',
  `remainNum` int(255) DEFAULT NULL,
  PRIMARY KEY (`showtimeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `showtime`
-- ----------------------------
BEGIN;
INSERT INTO `showtime` VALUES ('11201803221300', '11', '2018-03-22', '13:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1221111100\r\n1111111111\r\n1111111111\r\n1100110011', '52'), ('11201803231400', '11', '2018-03-23', '14:00:00', '2222211111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '49'), ('16201803231500', '16', '2018-03-23', '15:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('17201803211439', '17', '2018-03-21', '14:39:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('18201803231500', '18', '2018-03-23', '15:00:00', '2211111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '52'), ('18201803241000', '18', '2018-03-24', '10:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('19201805071645', '19', '2018-05-07', '16:45:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('19201805081647', '19', '2018-05-08', '16:47:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('20201805281130', '20', '2018-05-28', '11:30:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('20201805290000', '20', '2018-05-29', '00:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('21201805291600', '21', '2018-05-29', '16:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('21201805301840', '21', '2018-05-30', '18:40:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('22201806150030', '22', '2018-06-15', '00:30:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('22201806161700', '22', '2018-06-16', '17:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('23201805271100', '23', '2018-05-27', '11:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('23201805281500', '23', '2018-05-28', '15:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('24201805270900', '24', '2018-05-27', '09:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('24201805281930', '24', '2018-05-28', '19:30:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('25201806291030', '25', '2018-06-29', '10:30:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('25201806302000', '25', '2018-06-30', '20:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('7201803141539', '7', '2018-03-15', '21:00:00', '2222222222\n2111111111\n0000000000\n1100111111\n1111111111\n1111111111\n1100110011', '43'), ('7201803160900', '7', '2018-03-16', '09:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '54'), ('8201803201700', '8', '2018-03-20', '17:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('8201803211700', '8', '2018-03-21', '17:00:00', '2222221111\r\n1111111111\r\n0000000000\r\n1111111200\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100120011', '56'), ('9201804172100', '9', '2018-04-17', '21:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64'), ('9201804182100', '9', '2018-04-18', '21:00:00', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '64');
COMMIT;

-- ----------------------------
--  Table structure for `theater`
-- ----------------------------
DROP TABLE IF EXISTS `theater`;
CREATE TABLE `theater` (
  `theaterid` varchar(7) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `passCheck` tinyint(1) DEFAULT NULL COMMENT '是否审核通过',
  `verified` tinyint(1) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `phonenum` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT '/resources/images/not-head.png',
  `alipayid` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `seat` varchar(255) DEFAULT NULL,
  `rowdivide1` int(255) DEFAULT NULL,
  `rowdivide2` int(255) DEFAULT NULL,
  PRIMARY KEY (`theaterid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `theater`
-- ----------------------------
BEGIN;
INSERT INTO `theater` VALUES ('1512500', '中央影城', '123', '1', '1', '汉口路21号', '15050582771', '/resources/images/upload/theaterImage/1512500.png', '1512500', '151250008@smail.nju.edu.cn', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '3', '6'), ('dahua02', '南京大华大戏院', '123', '1', '1', '白下区新街口中山南路67号', '02584715020', '/resources/images/not-head.png', 'dahua', 'dahua@qq.com', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '2', '6'), ('j2ee025', '春天国际影城', '123', '1', '1', '大厂区大厂新华路123号', '02551887333', '/resources/images/not-head.png', 'theater3', 'j2ee@qq.com', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '3', '6'), ('theater', '金陵工人影城', '123', '1', '1', '白下区新街口洪武路26号', '02584706729', '/resources/images/upload/theaterImage/theater.png', 'theater2', 'theater2@qq.com', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1111111111\r\n1100110011', '3', '7');
COMMIT;

-- ----------------------------
--  Table structure for `theatermodify`
-- ----------------------------
DROP TABLE IF EXISTS `theatermodify`;
CREATE TABLE `theatermodify` (
  `theaterid` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `phonenum` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `alipayid` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `seat` varchar(255) DEFAULT NULL,
  `rowdivide1` int(255) DEFAULT NULL,
  `rowdivide2` int(255) DEFAULT NULL,
  PRIMARY KEY (`theaterid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='和theater表的区别是没有state，如果经理通过修改，会直接把记录删掉';

-- ----------------------------
--  Records of `theatermodify`
-- ----------------------------
BEGIN;
INSERT INTO `theatermodify` VALUES ('1512500', '中央影城', '123', '汉口路22号', '15050582771', '/resources/images/upload/theaterImage/1512500.png', '15050582771', '151250008@smail.nju.edu.cn', '1111111111\r\n1111111111\r\n0000000000\r\n1111111100\r\n1111111111\r\n1111111111\r\n1100110011', '2', '5');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
