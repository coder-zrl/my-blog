/*
Navicat MySQL Data Transfer

Source Server         : 远程服务器
Source Server Version : 50732
Source Host           : 47.103.198.84:3306
Source Database       : lu_tale

Target Server Type    : MYSQL
Target Server Version : 50732
File Encoding         : 65001

Date: 2021-09-07 12:12:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_attach
-- ----------------------------
DROP TABLE IF EXISTS `t_attach`;
CREATE TABLE `t_attach` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) NOT NULL DEFAULT '',
  `ftype` varchar(50) DEFAULT '',
  `fkey` text NOT NULL,
  `authorId` int(10) DEFAULT NULL,
  `created` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_attach
-- ----------------------------
INSERT INTO `t_attach` VALUES ('19', '/upload/2021/09/snss0e75fuicvsnss0e75fuicv.png', 'image', 'qz0n6fgij.hn-bkt.clouddn.com/upload/2021/09/snss0e75fuicvsnss0e75fuicv.png', '1', '1630976614');
INSERT INTO `t_attach` VALUES ('20', 'upload/2021/09/178rg390oqhin178rg390oqhin.png', 'image', 'qz0n6fgij.hn-bkt.clouddn.com/upload/2021/09/178rg390oqhin178rg390oqhin.png', '1', '1630976714');
INSERT INTO `t_attach` VALUES ('21', '/upload/2021/09/oen6fi9sikhgkoen6fi9sikhgk.png', 'image', 'qz0n6fgij.hn-bkt.clouddn.com/upload/2021/09/oen6fi9sikhgkoen6fi9sikhgk.png', '1', '1630986951');

-- ----------------------------
-- Table structure for t_comments
-- ----------------------------
DROP TABLE IF EXISTS `t_comments`;
CREATE TABLE `t_comments` (
  `coid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned DEFAULT '0',
  `created` int(10) unsigned DEFAULT '0',
  `author` varchar(200) DEFAULT NULL,
  `authorId` int(10) unsigned DEFAULT '0',
  `ownerId` int(10) unsigned DEFAULT '0',
  `mail` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `agent` varchar(200) DEFAULT NULL,
  `content` text,
  `type` varchar(16) DEFAULT 'comment',
  `status` varchar(16) DEFAULT 'approved',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`coid`) USING BTREE,
  KEY `cid` (`cid`) USING BTREE,
  KEY `created` (`created`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_comments
-- ----------------------------
INSERT INTO `t_comments` VALUES ('4', '34', '1630936689', 'coder-zrl', null, null, '970586718@qq.com', '', '0:0:0:0:0:0:0:1', null, 'aaaaaa', null, 'approved', null);
INSERT INTO `t_comments` VALUES ('5', '34', '1630979009', 'ada', null, null, '970586718@qq.com', '', '127.0.0.1', null, 'dadadada', null, 'not_audit', null);

-- ----------------------------
-- Table structure for t_contents
-- ----------------------------
DROP TABLE IF EXISTS `t_contents`;
CREATE TABLE `t_contents` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `titlePic` varchar(55) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `modified` int(10) unsigned DEFAULT '0',
  `content` text COMMENT '内容文字',
  `authorId` int(10) unsigned DEFAULT '0',
  `type` varchar(16) DEFAULT 'post',
  `status` varchar(16) DEFAULT 'publish',
  `tags` varchar(200) DEFAULT NULL,
  `categories` varchar(200) DEFAULT NULL,
  `hits` int(10) unsigned DEFAULT '0',
  `commentsNum` int(10) unsigned DEFAULT '0',
  `allowComment` tinyint(1) DEFAULT '1',
  `allowPing` tinyint(1) DEFAULT '1',
  `allowFeed` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`cid`) USING BTREE,
  UNIQUE KEY `slug` (`slug`) USING BTREE,
  KEY `created` (`created`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_contents
-- ----------------------------
INSERT INTO `t_contents` VALUES ('34', 'Java多线程基础篇（完结）', null, null, '1630935827', '1630987591', '## Java线程间的通信\r\n\r\n### 锁与同步\r\n\r\n线程同步是线程之间按照一定的顺序执行，为了达到线程同步，我们可以使用锁来实现它，synchronized（同步代码块）是常用的手段。\r\n\r\n> 同一时间只有一个线程持有一个锁，那么线程B就会等线程A执行完成后释放`lock`，线程B才能获得锁`lock`。\r\n\r\n### 等待/通知机制\r\n\r\n上面一种基于“锁”的方式，线程需要不断地去尝试获得锁，如果失败了，再继续尝试，这可能会耗费服务器资源。而等待/通知机制是另一种方式。\r\n\r\nJava多线程的等待/通知机制是基于`Object`类的`wait()`方法和`notify()`, `notifyAll()`方法来实现的：\r\n\r\n- 锁.wait()释放锁（离婚），让自己进入等待状态\r\n- notify()方法会随机叫醒一个正在等待的线程\r\n- notifyAll()会叫醒所有正在等待的线程\r\n\r\n```java\r\npublic class WaitAndNotify {\r\n    private static Object lock = new Object();\r\n    static class ThreadA implements Runnable {\r\n        @Override\r\n        public void run() {\r\n            synchronized (lock) {\r\n                for (int i = 0; i < 5; i++) {\r\n                    try {\r\n                        System.out.println(\"ThreadA: \" + i);\r\n                        lock.notify();\r\n                        lock.wait();\r\n                    } catch (InterruptedException e) {\r\n                        e.printStackTrace();\r\n                    }\r\n                }\r\n                lock.notify();\r\n            }\r\n        }\r\n    }\r\n    static class ThreadB implements Runnable {\r\n        @Override\r\n        public void run() {\r\n            synchronized (lock) {\r\n                for (int i = 0; i < 5; i++) {\r\n                    try {\r\n                        System.out.println(\"ThreadB: \" + i);\r\n                        lock.notify();\r\n                        lock.wait();\r\n                    } catch (InterruptedException e) {\r\n                        e.printStackTrace();\r\n                    }\r\n                }\r\n                lock.notify();\r\n            }\r\n        }\r\n    }\r\n    public static void main(String[] args) throws InterruptedException {\r\n        new Thread(new ThreadA()).start();\r\n        Thread.sleep(1000);\r\n        new Thread(new ThreadB()).start();\r\n    }\r\n}\r\n```\r\n\r\n> 需要注意的是等待/通知机制使用的是使用同一个对象锁，如果你两个线程使用的是不同的对象锁，那它们之间是不能用等待/通知机制通信的。\r\n\r\n### 信号量\r\n\r\nJDK提供了一个类似于“信号量”功能的类`Semaphore`。但本文不是要介绍这个类，而是介绍一种基于`volatile`关键字的自己实现的信号量通信。\r\n\r\n`volatile关键字简单介绍`：volatile关键字能够保证内存的可见性，如果用volatile关键字声明了一个变量，在一个线程里面改变了这个变量的值，那其它线程是立马可见更改后的值的。\r\n\r\n```java\r\npublic class Signal {\r\n    private static volatile int signal = 0;\r\n    static class ThreadA implements Runnable {\r\n        @Override\r\n        public void run() {\r\n            while (signal < 5) {\r\n                if (signal % 2 == 0) {\r\n                    System.out.println(\"threadA: \" + signal);\r\n                    signal++;\r\n                }\r\n            }\r\n        }\r\n    }\r\n    static class ThreadB implements Runnable {\r\n        @Override\r\n        public void run() {\r\n            while (signal < 5) {\r\n                if (signal % 2 == 1) {\r\n                    System.out.println(\"threadB: \" + signal);\r\n                    signal = signal + 1;\r\n                }\r\n            }\r\n        }\r\n    }\r\n    public static void main(String[] args) throws InterruptedException {\r\n        new Thread(new ThreadA()).start();\r\n        Thread.sleep(1000);\r\n        new Thread(new ThreadB()).start();\r\n    }\r\n}\r\n```\r\n\r\n有以下需要注意的地方：\r\n\r\n- `volatile`变量需要进行原子操作\r\n- AtomicInteger原子操作类\r\n\r\n### 管道\r\n\r\n管道是基于“管道流”的通信方式。JDK提供了`PipedWriter`、 `PipedReader`、 `PipedOutputStream`、 `PipedInputStream`。其中，前面两个是基于字符的，后面两个是基于字节流的。\r\n\r\n### 其它通信相关\r\n\r\n#### join方法（插队）\r\n\r\njoin()方法是Thread类的一个实例方法。它的作用是让当前线程陷入“等待”状态，等join的这个线程执行完成后，再继续执行当前线程，join()方法有两个重载方法\r\n\r\n- join(long)\r\n- join(long, int)。\r\n\r\n有时候，主线程创建并启动了子线程，如果子线程中需要进行大量的耗时运算，主线程往往将早于子线程结束之前结束。如果主线程想等待子线程执行完毕后，获得子线程中的处理完的某个数据，子线程就要用到join方法了。\r\n\r\n```java\r\npublic class Join {\r\n    static class ThreadA implements Runnable {\r\n        @Override\r\n        public void run() {\r\n            try {\r\n                System.out.println(\"我是子线程，我先睡一秒\");\r\n                Thread.sleep(1000);\r\n                System.out.println(\"我是子线程，我睡完了一秒\");\r\n            } catch (InterruptedException e) {\r\n                e.printStackTrace();\r\n            }\r\n        }\r\n    }\r\n    public static void main(String[] args) throws InterruptedException {\r\n        Thread thread = new Thread(new ThreadA());\r\n        thread.start();\r\n        thread.join();\r\n        System.out.println(\"如果不加join方法，我会先被打出来，加了就不一样了\");\r\n    }\r\n}\r\n```\r\n\r\n#### sleep方法\r\n\r\nsleep方法是Thread类的一个静态方法，它的作用是让当前线程睡眠一段时间，它有这样两个方法：\r\n\r\n- Thread.sleep(long)\r\n- Thread.sleep(long, int)\r\n\r\n> sleep方法是不会释放当前的锁的，而wait方法会\r\n\r\n#### sleep与wait的区别\r\n\r\n- sleep方法是不会释放当前的锁的，而wait方法会\r\n- wait可以指定时间，也可以不指定；而sleep必须指定时间。\r\n- wait释放cpu资源，同时释放锁；sleep释放cpu资源，但是不释放锁，所以易死锁。\r\n- wait必须放在同步块或同步方法中，而sleep可以再任意位置\r\n\r\n#### ThreadLocal类\r\n\r\n有些朋友称ThreadLocal为`线程本地变量`或`线程本地存储`。严格来说，ThreadLocal类并不属于多线程间的通信，而是让每个线程有自己”独立“的变量，线程之间互不影响。它为每个线程都创建一个副本，每个线程可以访问自己内部的副本变量。\r\n\r\n那ThreadLocal有什么作用呢？\r\n\r\n如果开发者希望将类的某个静态变量（user ID或者transaction ID）与线程状态关联，则可以考虑使用ThreadLocal。最常见的ThreadLocal使用场景为用来解决数据库连接、Session管理等。数据库连接和Session管理涉及多个复杂对象的初始化和关闭。如果在每个线程中声明一些私有变量来进行操作，那这个线程就变得不那么“轻量”了，需要频繁的创建和关闭连接。\r\n\r\n#### InheritableThreadLocal\r\n\r\nInheritableThreadLocal类与ThreadLocal类稍有不同，Inheritable是继承的意思。它不仅仅是当前线程可以存取副本值，而且它的子线程也可以存取这个副本值。', null, 'post', 'publish', 'Java,多线程', 'Java', '1', '2', '1', null, null);
INSERT INTO `t_contents` VALUES ('35', 'Python基础知识总结（期末复习精简版）', null, null, '1567824398', '1630985950', '\r\n# 前言\r\n\r\n本文针对《Python语言程序设计基础 （第2版）》——嵩天 礼欣  黄天羽，此书进行简单知识总结。\r\n\r\n本文总结了华农python期末部分常见考点，对信息学院的同学帮助不大，适合其他学院同学参考。本人只是单纯的想进行分享，并没有炫耀自己的意思，如果让您心情不悦我感到很抱歉。\r\n\r\n**本文可能对编程编写有所帮助，但是理论知识还需要大家多刷题，多看定义。**\r\n\r\n因本人精力、能力有限，文章不足之处还请指正。大家可以将需求、遗漏的地方或疑问写在评论区，后期会及时进行补充，解答疑问。\r\n\r\n码字不易，大家如果本文感觉有帮助的话，不胜感激！\r\n\r\n# 推荐的学习资料\r\n建议参考B站小甲鱼视频辅助学习[点击这里跳转](https://www.bilibili.com/video/BV1xs411Q799?from=search&seid=10155701594589760776)跳转。\r\n\r\n书籍的话，其实觉得没必要，网上都有电子版的，很想买的话建议选购《疯狂Python讲义》，内容想详实，==不建议买《Python编程 从入门到实践》==，我觉得它不太适合新手学，虽然在京东销量第一（难道是刷上去的？），等学了一遍之后可以康康\r\n\r\n课程配套实验题[点击跳转](https://blog.csdn.net/m0_46521785/article/details/109253364)\r\n\r\n最后，欢迎将问题打在评论区，我看到会及时回复。\r\n# 复习要点\r\n***\r\n<font size=4>-缩进、注释、命名、变量、保留字</font>\r\n\r\n<font size=4>-数据类型、字符串、 整数、浮点数、列表、字典</font>\r\n\r\n<font size=4>-赋值语句、分支语句、函数</font>\r\n\r\n<font size=4>-input( )、print( )、eval( )、 print( )及其格式化</font>\r\n\r\n# 组合数据类型\r\n***\r\n**注：** 详细内容请看后面几段\r\n\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20200528221713642.png)\r\n\r\n## 序列类型通用操作符和函数\r\n***\r\n|     操作符     |                   描述                    |\r\n| :------------: | :---------------------------------------: |\r\n|     x in s     |  如果x是s的元素，返回True，否则返回False  |\r\n|   x not in s   | 如果x不是s的元素，返回True，否则返回False |\r\n|     s + t      |                连接 s 和 t                |\r\n| s * n 或 n * s |            将序列 s 复制 n 次             |\r\n|      s[i]      |       索引，返回序列第 i + 1个元素        |\r\n|    s[i : j]    |          切片，不包括第 j 位元素          |\r\n|  s[i : j : k]  |     步骤切片，k表示步长，不写默认为1      |\r\n|     len(s)     |               序列 s 的长度               |\r\n|     min(s)     |             序列 s 的最小元素             |\r\n|     max(s)     |             序列 s 的最大元素             |\r\n|     sum(s)     |             序列 s 的求和（列表只含数字）             |\r\n|   s.index(x)   |   序列 s 中从左往右第一次出现 x 的索引    |\r\n|  s.rindex(x)   |   序列 s 中从右往左第一次出现 x 的索引    |\r\n|   s.count(x)   |         序列 s 中出现 x 的总次数          |\r\n\r\n**注：** 序列类型是可迭代对象，可以直接使用for循环操作。\r\n\r\n```python\r\na=[1,2,3,4,5]\r\nfor i in a:\r\n    print(i,end=\'**\')  #end是可选参数，不写默认为换行符\'\\n\'\r\n#得到1**2**3**4**5**\r\n```\r\n\r\n## 集合类型\r\n***\r\n类似数学上的集合概念元素具有单一性，集合**并没有**自动升序排列的性质，可能是元素少的时候碰巧，可以使用sorted()函数来排序哦!\r\n（集合是具有确定性、互异性、无序性的，不要混淆了）\r\n\r\n**常用于：** 去除列表中的相同元素\r\n\r\n```python\r\nlist1=[5,1,3,7,9,9,2]\r\nlist1=list(set(list1))\r\nprint(list1)  #得到[1, 2, 3, 5, 7, 9]\r\n# 大家看呀，这个自动升序了，但仅仅是碰巧。\r\nprint(set([1,3,8,-2,99,98,77,1,5,3,77,12]))  # 得到{1, 98, 3, 99, 5, 8, 12, 77, -2}\r\n#  大家看这个，就不会自动给你升序了，一定要注意，集合并没有自动升序排列的性质\r\n```\r\n\r\n## 映射类型\r\n***\r\n**需要了解：**\r\n\r\n①怎样增删键值对\r\n\r\n②怎样得到字典中键，值，键值对应的元组\r\n\r\n③一个键只能对应一个值\r\n\r\n**注：** 键(key)就是冒号左侧的值。值(value)就是冒号右面的数值。\r\n\r\n# 数值操作\r\n***\r\n## 运算符\r\n***\r\n|算数运算符| 描述 |\r\n|--|--|\r\n| x%y | 求得商的余数。例如：5%2结果为1 |\r\n|x//y  | 求得x除y商的整数位，简称整除。例如x//y结果为2 |\r\n| x**y | 求得x的y次幂。例如4**(1/2)结果为2，3**2结果为9 |\r\n\r\n|比较运算符| 描述 |\r\n|--|--|\r\n| x==y、x!=y | 判断x是否相等或者不相等，符合条件返回True，否则返回False |\r\n| x>y、x<y | 判断x是否大于或小于y，符合条件返回True，否则返回False |\r\n| x<=y、x>=y | 判断x是否大于等于或小于等于y，同样返回布尔值 |\r\n\r\n|赋值运算符| 描述 |\r\n|--|--|\r\n| x=y | 将y的值赋值给x，注意：当y是复杂数据类型时要使用.copy()的方法 |\r\n|x+=1|等价于x=x+1|\r\n|x-=1|等价于x=x-1|\r\n|x*=2|等价于x=x*2|\r\n|x/=2|等价于x=x/2|\r\n\r\n\r\n|逻辑运算符| 描述 |\r\n|--|--|\r\n|and | 布尔运算“与” |\r\n|or|布尔运算“或”|\r\n|not|布尔运算“非”|\r\n即得到优先级关系：or<and<not，同一优先级默认从左往右计算。\r\n\r\n|成员运算符| 描述 |\r\n|--|--|\r\n| a in b | 如果a在b就返回True|\r\n|a not in b|如果a不在b就返回True|\r\n\r\n\r\n***\r\n# 字符串操作\r\n***\r\n## 字符串切片\r\n### 基本切片操作\r\n***\r\n格式：<需要处理的字符串>[M:N]。\r\nM缺失表示**至开头**，N缺失表示**至结尾**。\r\n注意：①两种索引方式可以混用；②切片得到的结果不包含N索引的值。\r\n\r\n```python\r\na=\'〇一二三四五六七八九\'\r\nprint(a[1:3])#得到  一二\r\nprint(a[1:-1])#得到  一二三四五六七八\r\nprint(a[-3:-1])#得到  七八\r\nprint(a[:3])#得到  〇一二\r\nprint(a[4:])#得到  四五六七八九\r\n```\r\n### 高级切片操作\r\n格式：<需要处理的字符串>[M:N:K]。\r\n根据步长K对字符串切片。不写K时默认为1，与[M:N]等价。\r\n```python\r\na=\'〇一二三四五六七八九\'\r\nprint(a[1:8:2])#得到  一三五七\r\n#分析过程：在一~七中，索引从1开始，依次加2，即a[1]，a[3]，a[5]，a[7]，将其拼接在一起得到一三五七\r\n\'\'\' —————————————————————————————————美丽的分隔线—————————————————————————————————————— \'\'\'\r\nprint(a[::-1])#得到  九八七六五四三二一〇\r\n#得到逆序字符串，格式固定。可简单理解为从右至左操作选定的字符串片段[M:N]。\r\n\'\'\' —————————————————————————————————美丽的分隔线—————————————————————————————————————— \'\'\'\r\n```\r\n\r\n## 操作、相关函数、相关使用方法\r\n***\r\n操作符|描述\r\n---|---\r\nx+y|连接两个字符串\r\nx*n|复制n次字符串x\r\nx in s|返回布尔值，如果字符串x在s内，则返回True，否则返回False\r\n\r\n相关函数|描述\r\n---|---\r\nlen(x)|返回字符串的长度。例如：len(\'我爱帅帅龙\')结果为5\r\nstr(x)|将任意类型数据转为字符串。例如：str(123)结果为字符串\"123\"，str([1,2])结果为字符串\"[1,2]\"\r\nchr(x)|返回Unicode编码的单字符。例如：chr(65)得到字母\"A\"\r\nord(x)|返回单字符对应的Unicode编码。例如：ord(\"a\")得到数字97\r\n\r\n|相关方法| 描述 |\r\n|--|--|\r\n|str.lower() 、str.upper() | 返回将字符串全部变成小写或大写的副本。<br/>例：\'abc\'.upper()的结果为:\'ABC\' |\r\n|str.isalpha() | 返回布尔值，判断字符串str是否全部为字母 |\r\n|str.islower()、str.isnumeruic()|返回布尔值，判断字符串str是否全部为小写或数字<br/>如果记不住函数名。建议用循环和比较大小的方式判断每个字符是否符合标准|\r\n|str.split(sep)|将字符串按sep进行分割，当sep不填的时候默认以空格分割。<br/>例：\'A,B,C\'.split(\',\')结果为:[\'A\',\'B\',\'C\']|\r\n|str.strip()|将字符串左右两边的空字符去掉，\\n,\\t,空格等。<br/>例：\' \\n我爱帅帅龙\'.strip()结果为:\'我爱帅帅龙\'|\r\n|str.replace(old,new)|返回副本，将字符串str中old字符替换为new字符。<br/> 例：详细讲解在下面|\r\n## 字符串格式化（不需要花费太多时间）\r\n***\r\n| 类型 |      格式规则      |\r\n| :--: | :----------------: |\r\n|  f   |   格式化为浮点数   |\r\n|  d   | 格式化为十进制整数 |\r\n|  s   |   格式化为字符串   |\r\n\r\n### format{}格式化\r\n订正：对齐方式默认为左对齐\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20200528221840985.png)\r\n\r\n```python\r\na=1.666\r\nprint(\'{0:-^20.1f}\'.format(a))  # 得到--------1.7---------\r\n```\r\n\r\n0表示索引\r\n\r\n:是引导符号\r\n\r\n-是填充字符\r\n\r\n^表示居中\r\n\r\n20是输出总长度\r\n\r\n.1表示保留一位小数\r\n\r\n### %格式化\r\n***\r\n**参考c语言格式化方法，书上使用的是format格式化方法，%格式化在此不做过多介绍**\r\n\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20200528221832922.png)\r\n```python\r\na=1.555\r\nprint(\'%10.2f\'%a)  # 得到      1.55\r\n```\r\n\r\n%表示引导符号\r\n\r\n10表示宽度\r\n\r\n.2表示保留两位小数\r\n\r\nf表示转为浮点型\r\n\r\n# 列表\r\n***\r\n**注：** 在文章开头已经介绍了通用函数了，大家记得爬楼。\r\n\r\n|       函数        |                   描述                   |\r\n| :---------------: | :--------------------------------------: |\r\n|      ls[i]=x      |      将列表索引为 i 的元素更新为 x       |\r\n|   ls.append(x)    |             在列表最后添加 x             |\r\n|  ls.insert(i,x)   |         在列表的第 i 位添加元素x         |\r\n|     del ls[i]     |         删除列表索引为 i 的元素          |\r\n|   ls.remove(x)    |   删除列表中从左到右第一次出现的元素 x   |\r\n|     ls.copy()     |  得到列表的副本，对其操作不会影响原数据  |\r\n|     ls.sort()     |            将列表从小到大排序            |\r\n|   ls.reverse()    |                将列表反转                |\r\n| mylist=sorted(ls) | 将列表的副本从小到大排序，不会影响原顺序 |\r\n\r\n## 一些要注意的地方\r\n***\r\n列表中可以存放任意数据类型，但是不建议将其它数据类型强转为列表，而应该使用ls.append()的方法\r\n\r\n```python\r\nprint(list(\'我爱阿龙\'))  # 得到[\'我\', \'爱\', \'阿\', \'龙\']\r\nls=[]\r\nls.append(\'我爱阿龙\')\r\nprint(ls)  # 得到[\'我爱阿龙\']\r\n```\r\n\r\n------\r\n\r\n将列表排序和反转，实际上是调用了sort()方法和reverse()方法，它是没有返回值的，如果输入会得到None。\r\n\r\n```python\r\na=[1,3,2,6]\r\nprint(a.sort())  # 得到None\r\na.sort()\r\nprint(a)  # 得到[1,2,3,6]\r\n# reverse同理\r\n```\r\n\r\n## 列表推导式：（有能力就掌握一下）\r\n***\r\n```python\r\nls=[i for i in range(11)]  # 得到[0,1,2,3,4,5,6,7,8,9,10]\r\nls=[i for i in range(11) if i%5==0]  # 得到[5,10]\r\nls=[(i , j) for i in range(3) for j in range(11,13)]\r\n# 得到[(0, 11), (0, 12), (1, 11), (1, 12), (2, 11), (2, 12)]\r\n```\r\n\r\n\r\n\r\n# 字典\r\n***\r\n```python\r\ndict1={\'张瑞龙\':\'帅\',\'刘浩\':\'丑\'}\r\n```\r\n\r\n如上所示，冒号左边的为键，冒号右边的是键所对应的值。例如，张瑞龙对应的是帅，刘浩对应丑。\r\n\r\n**注意：** ①键的存在是单一的，即一个字典一个键只能出现一次。\r\n\r\n②键和值的类型可以是任意类型，但通常为字符型\r\n\r\n③在字典中添加元素时，键与值出现是成对出现的。\r\n\r\n|          函数          |                       描述                        |\r\n| :--------------------: | :-----------------------------------------------: |\r\n|    dict1[key]=value    | 在字典中添加元素，如果key存在，则覆盖原来对应的值 |\r\n|   list(dict1.keys())   |               得到字典所有键的列表                |\r\n|  list(dict1.values())  |               得到字典所有值的列表                |\r\n|  list(dict1.items())   |         得到字典所有元组类型键，值的列表          |\r\n| dict1.get(key,default) |  如果键存在则返回对应的值，不存在则赋值为default  |\r\n|     del dict1[key]     |                  删除这个键值对                   |\r\n|      key in dict1      |       如果键在字典中则返回True，否则为False       |\r\n\r\n## 一些要注意的地方\r\n***\r\n字典作为可迭代对象，其实是它的键值\r\n\r\n```python\r\ndict1={\'张瑞龙\':\'帅\',\'刘浩\':\'丑\'}\r\nfor i in dict1:\r\n    print(i)\r\n# 得到：张瑞龙，刘浩\r\n```\r\n\r\n## 统计出现次数并从大到小输出\r\n***\r\n可以说是最经典的一种考题了，下面分块操作。\r\n\r\n### ①统计出现次数\r\n\r\n**法一**\r\n\r\n```python\r\nlist1=[1,1,1,2,5,3,3,10,5,6,8,9,9,11]\r\ndict1={}  #创建一个空字典\r\nfor i in list1:\r\n    dict1[i]=dict1.get(i,0)+1  # dict1.get(i,0)表示如果有键为i则返回对应的值，否则返回0\r\nprint(dict1)\r\n```\r\n\r\n法二\r\n\r\n```python\r\nlist1=[1,1,1,2,5,3,3,10,5,6,8,9,9,11]\r\ndict1={}  #创建一个空字典\r\nfor i in list1:\r\n    if i in dict1:  # 如果字典中有键为i\r\n        dict1[i]+=1  # 对应的值加一\r\n    else:  # 如果字典中没有键为i\r\n        dict1[i]=1  # 创建键值对，值为1，因为这是第一次出现\r\nprint(dict1)\r\n```\r\n\r\n### ②lambda表达式排序\r\n\r\n```python\r\nmylist=list(dict1.items())\r\nmylist.sort(key=lambda x:(-x[1],x[0]))\r\n# 当写成mylist.sort(key=lambda x:(x[1],x[0]))是根据值从小到大排序\r\n# 当写成mylist.sort()是根据键从小到大排序\r\nprint(mylist)  # 在此处可以直接根据需求进行其他操作，而不一定要转为字典\r\ndict1=dict(mylist)  # 将列表转为字典\r\nprint(dict1)\r\n```\r\n\r\n> mylist.sort(key=lambda x:(-x[1],x[0]))，这里为什么要加一个负号呢？\r\n> 因为sort函数是从小到大排序的，当最大的正数加了负号就会变成最小的负数，可以使用这个特性来达到我们的需求 \r\n\r\n其实，sort里面有个可选参数reverse，默认为Forse，可以尝试一下在sort里面添加参数reverse=True看看效果。\r\n当你写成mylist.sort(key=lambda x:(x[1],x[0]),reverse=True)这样也能达到根据次数从大到小输出的。\r\n因为介绍起来很繁琐，大家记住这个格式就好了，有问题建议直接连麦滴滴我，Q3181314768。\r\n\r\n### ③综上,代码汇总\r\n\r\n```python\r\nlist1=[1,1,1,2,5,3,3,10,5,6,8,9,9,11]\r\ndict1={}  #创建一个空字典\r\nfor i in list1:\r\n    dict1[i]=dict1.get(i,0)+1  # dict1.get(i,0)表示如果有键为i则返回对应的值，否则返回0\r\nmylist=list(dict1.items())\r\nmylist.sort(key=lambda x:(-x[1],x[0]))\r\ndict1=dict(mylist)  # 将列表转为字典\r\nprint(dict1)\r\n```\r\n\r\n# 元组、集合\r\n***\r\n不是重点，但是需要简单了解。\r\n\r\n**元组：** 可以被列表所代替，操作与列表操作相似，唯一不同的是元组不能修改，即不能增删元素，但可以使用切片和加法进行更新。\r\n\r\n**集合：** 常用于清除相同元素，但是不具备自动排序的功能。\r\n（但是集合是具有确定性、互异性、无序性的，不要混淆了）\r\n\r\n```python\r\nlist1=[5,1,3,7,9,9,2]\r\nlist1=list(set(list1))\r\nprint(list1)  #得到[1, 2, 3, 5, 7, 9]\r\n# 大家看呀，这个自动升序了，但仅仅是碰巧。\r\nprint(set([1,3,8,-2,99,98,77,1,5,3,77,12]))  # 得到{1, 98, 3, 99, 5, 8, 12, 77, -2}\r\n#  大家看这个，就不会自动给你升序了，一定要注意，集合并没有自动升序排列的性质\r\n```\r\n\r\n# 选择结构\r\n***\r\n## 运行过程\r\n***\r\n这个判断到底是怎么个流程呢？我来简单说一下。\r\n\r\n其实判断的标准是布尔值，即是False还是True，例如下面这个程序。\r\n\r\n```python\r\nif \'龙\' in \'帅帅龙\':\r\n    print(\'good\')\r\n#运行结果是good\r\nprint(\'龙\' in \'帅帅龙\')  # 输出的结果是True\r\n```\r\n\r\n程序执行过程中，会先判断后面的条件代表的是True还是False\r\n\r\n\'龙\' in \'帅帅龙\'会返回True，因此执行下面的程序\r\n\r\n在python中，一些其他的东西也可以等价为布尔值\r\n\r\n|    等价为True    |  等价为False   |\r\n| :--------------: | :------------: |\r\n|      数字 1      |     数字 0     |\r\n|    非空字符串    |    空字符串    |\r\n|     非空列表     |     空列表     |\r\n|     非空元组     |     空元组     |\r\n| 非空字典（集合） | 空字典（集合） |\r\n|                  |      None      |\r\n\r\n```python\r\nif 1:\r\n    print(\'帅帅龙\')\r\n#运行结果是帅帅龙\r\n```\r\n\r\n## if - elif - else分支\r\n***\r\n编译器从上往下寻找符合条件的分支，当进入此分支后便不会再进入其他分支。\r\n\r\n多个判断条件是，要写 if - elif - else分支语句，if 和 elif 后面要加条件，else后面不需要加条件。\r\n\r\n如果不写成多分支而写成多个if，有时会出错，如下：\r\n\r\n```python\r\na=1\r\nif a==1:\r\n    print(\'a是1\')\r\n    a+=1\r\nif a==2:\r\n    print(\'a是2\')\r\n# 运行结果是a是1 a是2\r\n\r\na=1\r\nif a==1:\r\n    print(\'a是1\')\r\n    a+=1\r\nelif a==2:\r\n    print(\'a是2\')\r\n# 运行结果是a是1\r\n```\r\n\r\n大家可以思考一下问题出在哪里\r\n\r\n## 逻辑运算符\r\n***\r\n|         |                                                  |\r\n| :-----: | :----------------------------------------------: |\r\n| a and b | 当 a 和 b 都为真，才返回真。任意一个为假就返回假 |\r\n| a or b  |  当 a 和 b 任意一个为真，就返回真。全为才返回假  |\r\n|  not a  |    返回和a相反的布尔值，如果a表示真，则返回假    |\r\n\r\n# 循环结构\r\n***\r\n## continue与break\r\n***\r\ncontinue：终止本层循环，继续下一层循环\r\n\r\nbreak：终止循环，直接退出\r\n\r\n```python\r\nfor i in range(3):\r\n    if i==1:\r\n        continue\r\n    print(i)\r\n# 结果为0 2\r\n###########################\r\nfor i in range(3):\r\n    if i==1:\r\n        break\r\n    print(i)\r\n# 结果为0\r\n```\r\n\r\n## for 循环：常用于已知循环次数\r\n***\r\n### ①for i in range(x):\r\n***\r\nfor 循环其实是while循环的简化形式，for循环可以做到的while也能做到。\r\n\r\nrange是一个迭代器，可以得到可迭代对象，大家可以输出这句话看看print(list ( range(10) ) )\r\n\r\n```python\r\nfor i in range(10):# 循环10次    \r\n    print(i)\r\n\r\nmylist=[0,1,2,3,4]\r\nfor i in range(len(mylist)):\r\n    print(mylist[i])\r\n```\r\n\r\n### ②for i in x:\r\n\r\n```python\r\nmystr=\'我爱帅帅龙\'\r\nfor i in mystr:\r\n    print(i)\r\n```\r\n\r\n## while循环：常用于满足某个条件\r\n***\r\n形式为while + 条件判断语句。当条件返回True，则继续循环，否则结束循环。与if语句判断过程相似。\r\n\r\nwhile 1:  和 while True:可以表示死循环，需要用 break 跳出循环\r\n\r\n```python\r\nx=0\r\nwhile x<=5:\r\n	print(x)\r\n    x+=1\r\n#结果为0 1 2 3 4 5\r\n```\r\n\r\n## while - else语句（了解一下就行）\r\n***\r\n当while语句执行完没有被中断，则会进入else语句。\r\n\r\n如果while语句中途被中断了，则不会进入else语句。\r\n\r\n```python\r\nx=0\r\nwhile x<=5:\r\n	print(x)\r\n    x+=1\r\nelse:\r\n    print(\'进入else啦\')\r\n# 输出结果为0 1 2 3 4 5 进入else啦\r\n###########################\r\nx=0\r\nwhile x<=5:\r\n	if x==1:\r\n        print(i)\r\n        break\r\n	print(x)\r\n    x+=1\r\nelse:\r\n    print(\'进入else啦\')\r\n# 输出结果为0 1\r\n```\r\n\r\n# 函数\r\n***\r\n函数就是把代码放在一起了，提高了代码可读性，让代码可以复用，其实很简单，不要有畏难情绪。\r\n\r\n函数一般定义在调用之前，通常放在程序头顶\r\n\r\n## return 与 print\r\n***\r\n函数常常将结果通过return返回，当执行到函数的return语句后，函数其他部分将不会再执行。\r\n\r\n但是函数可以没有return语句，可以直接执行输出语句，但如果想输出return的值需要用print，说的可能有点蒙了，看代码吧。\r\n\r\n```python\r\ndef test():\r\n    return \'我爱阿龙\'\r\nprint(test())  #会输出我爱阿龙\r\ntest()  #啥也不会输出\r\n###########################\r\ndef test():\r\n    print(\'我爱阿龙\')\r\nprint(test())  #会输出我爱阿龙 和 None #因为函数并没有传递值给函数外print，所以为None\r\ntest()  #会输出我爱阿龙\r\n```\r\n\r\n## 函数的参数\r\n***\r\n### 简单数据类型作为参数\r\n***\r\n```python\r\ndef test(x):\r\n    x=\'我爱帅帅龙\'\r\n    return x\r\na=\'富婆\'\r\na=test(a)\r\nprint(a)  # 输出为我爱帅帅龙\r\n```\r\n\r\n### 复杂数据类型作为参数\r\n***\r\n这里需要注意，因为复杂数据类型作为参数时是以地址进行传递的（就是C/C++的那个地址，没听说过没关系），对函数里的复杂数据类型进行操作，会直接影响原数据，应该使用ls.copy()方法（详情见下文）\r\n\r\n```python\r\ndef test(x):\r\n    x.append(\'帅哥\')\r\n    return x\r\na=[\'富婆\']\r\na=test(a)\r\nprint(a)  # 输出为[\'富婆\', \'帅哥\']\r\n###########################    也可以像下面一样\r\ndef test(x):\r\n    x.append(\'帅哥\')\r\na=[\'富婆\']\r\ntest(a)\r\nprint(a)  # 输出为[\'富婆\', \'帅哥\']\r\n```\r\n\r\n### 可缺省参数\r\n***\r\n参数分为形参与实参，形参就是在定义函数是括号内的参数，实参就是调用函数的参数。\r\n\r\n但有时候实参是不定长的，这是因为在定义函数的时候对应的形参有默认值，当你调用函数的时候省略该参数，则执行过程中该参数为默认值，这就是传说的可缺省参数。\r\n\r\nprint()中其实有end这个参数，当你不写则默认为\'\\n\'，即输出完之后会自动输出一个换行。\r\n\r\n```python\r\ndef test(x=\'帅哥\',y=\'富婆\'):\r\n    for i in [x,y]:\r\n        print(i,end=\'---\')\r\ntest()  # 得到结果为 帅哥---富婆---，因为你不写，他就有默认值\r\ntest(\'帅帅\')  # 得到结果为 帅帅---富婆---\r\ntest(\'帅帅\',\'美美\')  # 得到结果为 帅帅---美美---\r\ntest(y=\'帅帅\',x=\'美美\')  # 得到结果为 美美---帅帅---，可以指定对应参数\r\n```\r\n\r\n**注：** 可缺省参数应放在最右面，函数调用时，参数是从左往右调用的。\r\n\r\n### global语句（了解一下）\r\n***\r\n在函数中引入全局变量，可以直接对其进行修改。\r\n\r\n全局变量：在主程序中定义的变量，既能在一个函数中使用，也能在其他的函数中使用\r\n\r\n局部变量：只能在一部分代码中使用，例如for i in range(3)的 i 就是局部变量\r\n\r\n```python\r\ndef test():\r\n    global a\r\n    a=\'富婆\'  #将a变为\'富婆\'，这里的a，其实是主函数的a   \r\na=\'我爱\'  # 这里的a就是全局变量\r\ntest()\r\nprint(a)  # 输出为富婆\r\n###########################\r\ndef test():\r\n    a=\'富婆\'\r\na=\'我爱\'\r\ntest()\r\nprint(a)  # 输出为我爱\r\n```\r\n\r\n## 递归（了解一下）\r\n***\r\n递归其实就是重复调用函数的过程，递归需要可以设置结束递归的条件，有默认最大递归深度（自己可以重新设置），当你未设置时，超出最大深度会报错。递归的作用可以使用循环来达到。\r\n\r\n下面是一个求阶乘的递归\r\n\r\n```python\r\ndef jiecheng(n):\r\n    if n==1:\r\n        return 1\r\n    else:\r\n        return n*jiecheng(n-1)\r\nprint(jiecheng(5))  # 得到的结果为120\r\n```\r\n\r\n当你调用这个函数时，会进入这个函数，首先判断n的值是否为1，如果为1就返回1，\r\n\r\n不是则返回n*jiecheng(n-1)，即继续往下调用函数。\r\n\r\n\r\n\r\n本次调试中，n为5，即结果为5*jiecheng(4)，而jiecheng(4)代表的是4\\*jiecheng(3)，\r\n\r\n即此时返回的结果由5\\*jiecheng(4)变为5*4\\*jiecheng(3)，同理依次往下调用，直到结束递归，即n==1，\r\n\r\n最后结果为5\\*4\\*3\\*2\\*1\r\n\r\n# txt文件读写\r\n***\r\n文件操作我们没考编程题，大家还是最好弄清楚考试范围（虽然一般情况老师会说学的都考）\r\n\r\n这里其实并不难，只涉及文件的读和写，记得要用close()方法释放文件的使用权（忘了也没啥事）。\r\n\r\n| 打开模式 |                        描述                        |\r\n| :------: | :------------------------------------------------: |\r\n|    r     |              以只读的方式打开（常用）              |\r\n|    w     | 覆盖写，文件不存在则会创建，存在则直接覆盖（常用） |\r\n|   a   |  追加写，文件不存在会创建，存在则在文档末尾追加写  |\r\n\r\n| 读文件的方法  |                     描述                     |\r\n| :-----------: | :------------------------------------------: |\r\n|   f.read()    |      返回一个字符串，内容是文件全部内容      |\r\n| f.readlines() | 返回一个列表，每一行的内容为每个元素（常用） |\r\n\r\n| 写文件的方法 |                   描述                    |\r\n| :----------: | :---------------------------------------: |\r\n|  f.write(x)  | 将字符串x写入，\\n即为在文件中换行（常用） |\r\n\r\n**注：** 写入的只能是字符串\r\n\r\n## 写的示范\r\n\r\n```python\r\nf=open(\'data.txt\',\'w\')  # 别忘了写文件后缀名\r\n# 如果读入的数据和看到的数据不一样，那就这样写f=open(\'data.txt\',\'w\',encoding=\'utf-8\')\r\ndata=[\'春眠不觉晓，\',\'处处蚊子咬。\',\'夜来大狗熊，\',\'看你往哪跑。\']\r\nfor i in data:\r\n    f.write(i+\'\\n\')  #不加\\n就全都写在一行了\r\nf.close()\r\n```\r\n\r\n## 读的示范\r\n\r\n为了读取方便，我直接使用上方代码创建名为data.txt的文件\r\n\r\n```python\r\nf=open(\'data.txt\',\'r\')  # 别忘了写文件后缀名\r\n# 如果读入的数据和看到的数据不一样，那就这样写f=open(\'data.txt\',\'r\',encoding=\'utf-8\')\r\ndata=f.readlines()\r\ndata=[i.strip() for i in data]  #使用列表推导式更新data的内容，目的是为了去除换行符\r\nfor i in data:\r\n    print(i)\r\nf.close()\r\n# 不使用f.read()是因为返回的是一坨字符串，不方便操作\r\n```\r\n\r\n**注：** 文件读写主要是分析文本结构，记得把\\n和\\t放在写入的字符串内，否则可能不会达到你的预期效果。\r\n\r\n# 一些函数\r\n***\r\n后期可以根据大家需求再添加，大家可以私戳我或者评论区留言。\r\n\r\n## .copy()浅复制（可以不做了解）\r\n\r\n```python\r\ndef test(x):\r\n    y=x\r\n    y+=\'我爱帅帅龙\'\r\na=\'富婆\'\r\ntest(a)\r\nprint(a)  # a仍然为\'富婆\'\r\n```\r\n\r\n将a变为复杂数据类型（列表、字典...）的话，结果就不一样了。\r\n\r\n```python\r\ndef test(x):\r\n    y=x\r\n    y+=[\'我爱帅帅龙\']\r\na=[\'富婆\']\r\ntest(a)\r\nprint(a)  # a变成了[\'富婆\',\'我爱帅帅龙\']\r\n```\r\n\r\n这是为什么呢？\r\n\r\n原因是编译器为了节省内存，当简单数据类型传递时，只是传递的数值。但是复杂数据类型占用空间大，传递的是地址，这样节省了内存的使用，但是对复杂数据类型操作会直接改变原数据内容。\r\n\r\n问题的解决就需要使用.copy()函数。\r\n\r\n它会将复杂数据类型的数据复制一份给对应变量，从而达到不改变原数据的目的。\r\n\r\n```python\r\ndef test(x):\r\n    x=x.copy()\r\n    y=x\r\n    y+=[\'我爱帅帅龙\']\r\na=[\'富婆\']\r\ntest(a)\r\nprint(a)  # a仍为[\'富婆\']\r\n```\r\n\r\n<br></br>\r\n\r\n## 字符串的replace方法\r\n***\r\nstr.replace(old,new[,count])，返回副本，把old字符串替换为new字符串，count表示替换前几次，不写count默认为全部替换。\r\n\r\n\r\n\r\n```python\r\nmystr=\'112\'\r\nmystr.replace(\'1\',\'2\')\r\nprint(mysrt)  # 得到的结果仍为112\r\n```\r\n\r\n为什么失效了呢？其实只是我们的使用方法不对，因为replace返回的是原字符串副本，\r\n\r\n上面已经说过副本这个概念了，即不会对原数据造成影响，因此直接写mystr.replace并不会修改原字符串\r\n\r\n**修改后的代码如下：**\r\n\r\n```python\r\nmystr=\'112\'\r\nmystr=mystr.replace(\'1\',\'2\')\r\nprint(mysrt)  # 得到的结果为222\r\n```\r\n\r\n**题目要求：** 将字符串中字母替换为空格\r\n\r\n```python\r\na=\'df23A？45cde0@a\'  # 这个测试数据有没有感觉很熟悉？？  没有当我没说哈。\r\nfor i in a:\r\n    if not (\'a\'<=i<=\'z\' or \'A\'<=i<=\'Z\'):\r\n        a=a.replace(i,\' \')\r\nprint(a)  # 结果为df  A   cde  a\r\n```\r\n\r\n直接傻用replace会不会把数据弄脏呢，会也不会，来看代码。**（强烈建议大家不要看，记住万能公式就好了）**\r\n\r\n```python\r\n# 把2替换为1\r\na=\'21122\'\r\nfor i in a:  # 因为字符串是简单数据类型，其实这里等价于for i in \'21122\':\r\n    print(i)\r\n    if i==\'2\':\r\n        print(a)\r\n        a=a.replace(\'2\',\'1\')  #因为我没写count，因此，他会把所有的2都替换掉\r\n# i依次输出为2 1 1 2 2\r\n# a依次输出为21122 11111 11111\r\n# 因为循环的时候，其实程序已经确定好i依次代表什么了，因此更新a，不会影响程序\r\n```\r\n\r\n<br></br>\r\n## isinstance()判断数据格式\r\n\r\ntype判断一个变量是什么类型不太方便，于是就有了isinstance()这个函数，它会返回布尔值。\r\n\r\n```python\r\na=1\r\nprint(isinstance(a,int))  # 输出结果为True\r\n```\r\n注：也可以使用type(x) is xxx\r\n\r\n```python\r\na=1\r\nprint(type(a) is int)  #或者写成type(a)==int\r\n```\r\n\r\n# Python标准库\r\n***\r\n## 引入方式\r\n***\r\n### import math\r\n\r\n引入数学库，可以调用数学库的函数\r\n\r\n```python\r\nimport math\r\nprint(math.pow(2,3))  # 得到8.0\r\n```\r\n\r\n### from math import pow\r\n\r\n从数学库中引入pow函数，不引入其他函数\r\n\r\n```python\r\nfrom math import pow\r\nprint(pow(2,3))  # 得到8.0。注意，少了math.\r\n#但是使用其他函数会报错\r\nprint(abs(-3))  # 会报错\r\n```\r\n## import random as ra\r\n有的时候函数或库的名字太长，我们可以给它重新起个名字\r\n从数学库引入pow函数，并且改名为p，在使用的时候\r\n\r\n```python\r\nimport random as ra\r\nprint(ra.randint(10,100))  # 产生10到100的随机整数\r\n```\r\n类似的写法还有from random import randint as rant\r\n即，引入randint函数，名且重命名为rant....\r\n### from math import *\r\n\r\n从数学库中引入所有函数\r\n\r\n```python\r\nimport math\r\nprint(pow(2,3))  # 得到8.0。注意，少了math.\r\nprint(abs(-3))  # 得到3\r\n```\r\n\r\n\r\n## math库\r\n***\r\n首先要在程序开头引入数学库。使用方法：import math\r\n|常用函数| 描述 |\r\n|:-:|:-:|\r\n| abs(x) | 得到x的绝对值 |\r\n| pow(x,y) | 得到x的y次幂，返回浮点型 |\r\n| sqrt(x) | 将x开平方，也可以直接x**(1/2) |\r\n| pi、e | 得到精确数值π、e |\r\n\r\n## random库\r\n***\r\n|   常用函数   |                     描述                      |\r\n| :----------: | :-------------------------------------------: |\r\n|   seed(x)    |   当x确定时，产生随机数的顺序其实已经确定了   |\r\n| randint(a,b) | 生成[a,b]之间的随机整数（这里是两个闭区间！） |\r\n| choice(seq)  |        从序列类型seq中随机选取一个元素        |\r\n| shuffle(seq) |             将序列类型seq随机打乱             |\r\n|   random()   |          生成[0.0,1.0)之间的随机小数          |\r\n| uniform(a,b) | 生成[a,b]之间的随机小数（这里是两个闭区间！） |\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20200530104410785.png)\r\n\r\n```python\r\nfrom random import *\r\nseed(10)  #当seed一定时，产生随机数的顺序就一定了！\r\na=int(input(\'n:\'))\r\nmylist=[]\r\nfor i in range(a):\r\n    mylist.append(randint(100,200))\r\nmylist.sort()\r\nfor i in mylist:\r\n    print(i)\r\n```\r\n\r\n> 关于seed，大家有兴趣可以去百度详细了解一下编程语言中seed到底是个啥子东西。\r\n可以简单理解为：每个人的长相不同，就比如我，可能就有几分姿色，但是有个叫刘浩的就可能不如我有魅力，即不同的人颜值不同，但是只要你选定了这个人，它的颜值就是一定的。\r\n在随机数中，当seed确定了，随机数的顺序也就随之确定了，就像你选中一个人时，他的颜值就已经确定了。严谨点来说：计算机的随机数都是由伪随机数(即不是严格意义上的随机)，是由小M多项式序列生成的，其中产生每个小序列都有一个初始值，即随机种子:小M多项式序列，当初始值确定了，生成的序列就确定了!\r\n\r\n\r\n## jieba库（不作重点）\r\n***\r\n|           常用函数           |                  描述                  |\r\n| :--------------------------: | :------------------------------------: |\r\n|        jieba.lcut(s)         |       将字符串分词，返回一个列表       |\r\n| jieba.lcut(s , cut_all=True) | 全模式，返回字符串中字可能组成的所有词 |\r\n|         jieba.add(s)         |           在词库中添加词语 s           |\r\n\r\n## time库\r\n***\r\n| 常用函数 |           描述            |\r\n| :------: | :-----------------------: |\r\n| sleep(x) | 程序暂停x秒，常用在循环里 |\r\n\r\n## \r\n\r\n# 一些编程技巧\r\n***\r\n## IDE的选择\r\n***\r\n好的IDE是成功的一半，大部分下载的IDE都有代码自动补全的功能、错误警告、会自动联想对应的函数和变量的功能，十分方便。\r\n\r\n大家如果还在使用python自带的IDE，不妨输入\'pr\'再按一下键盘的Tab键，你可能会有新发现哦。\r\n\r\n**建议一：使用spyder编译器。**\r\n\r\n理由一：下载方便，直接百度搜索Anaconda进入官网即可下载。\r\n\r\n理由二：不需要配置自己编译器\r\n\r\n理由三：许多第三方库都是Anaconda自带的，不需要额外安装\r\n\r\n**建议二：使用pycharm编译器。**\r\n\r\n理由一：长的好看\r\n\r\n理由二：无\r\n\r\n理由三：无\r\n\r\n**注：** 如果只是为了考试，可以去官网下载社区版，这个足够用了。如果想体验专业版何以去官网用学生邮箱注册，还可以去微信公众号：软件安装管家处白嫖破解版。\r\n\r\n## 判断一个字符串中有几个小写字母\r\n***\r\n有的时候记不住字符串那么多判断方法怎么办？没关系，其实可以直接进行比较。\r\n\r\n```python\r\na=\'aAfSSaDhQoTn\'\r\ncount=0\r\nfor i in a:\r\n    if \'a\'<=i<=\'z\':  # 因为比较的时候比较的是ASCII码（小写字母比大写字母大，可以输入ord(\'a\')查看）\r\n        count+=1\r\nprint(count)  # 结果为6\r\n```\r\n\r\n## 判断一个数是不是素数\r\n***\r\n```python\r\ndef sushu(n):\r\n    for i in range(2,n):  # 这是无脑的写法，大家也可写成for i in range(2,int(n**(1/2))+1):\r\n        if n%i==0:\r\n            return False\r\n	return True\r\na=int(input(\'输入一个数:\'))\r\nprint(sushu(a))\r\n```\r\n\r\n\r\n\r\n## flag的小应用\r\n***\r\n有时候，通过可以设置flag来达到条件判断的目的。\r\n\r\n**问题描述：** 判断一个字符串中有没有数字\r\n\r\n```python\r\nflag=False\r\nmystr=\'fahu57486sge\'\r\nfor i in mystr:\r\n    if \'0\'<=i<=\'9\':\r\n        flag=True\r\nif flag:\r\n    print(\'有\')\r\nelse:\r\n    print(\'没有\')\r\n```\r\n还可以通过设置多个flag来达到判断密码强度的作用。\r\n广阔天地，大有作为，我在这里抛砖引玉，快发动你的小脑筋吧。\r\n\r\n# 两套编程考试题\r\n[点击这里](https://wwx.lanzoui.com/iroiWe6wo5g) 下载，压缩包的内容包括：\r\n2019冬python期末考试（非信院）------>三道编程题，一道程序填空（本来考试是两道的，但我找不到另外一个了）\r\n2020春python期末考试（非信院）------>五道编程题，附加参考代码\r\n\r\n', null, 'post', 'publish', 'Python', 'Python', '1', '0', '1', null, null);

-- ----------------------------
-- Table structure for t_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_logs`;
CREATE TABLE `t_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `action` varchar(100) DEFAULT NULL COMMENT '事件',
  `data` varchar(2000) DEFAULT NULL COMMENT '数据',
  `authorId` int(10) DEFAULT NULL COMMENT '作者编号',
  `ip` varchar(20) DEFAULT NULL COMMENT 'ip地址',
  `created` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_logs
-- ----------------------------
INSERT INTO `t_logs` VALUES ('184', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630935613');
INSERT INTO `t_logs` VALUES ('185', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630936849');
INSERT INTO `t_logs` VALUES ('186', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630938044');
INSERT INTO `t_logs` VALUES ('187', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630938254');
INSERT INTO `t_logs` VALUES ('188', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630938327');
INSERT INTO `t_logs` VALUES ('189', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630938438');
INSERT INTO `t_logs` VALUES ('190', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630938543');
INSERT INTO `t_logs` VALUES ('191', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630938720');
INSERT INTO `t_logs` VALUES ('192', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630939175');
INSERT INTO `t_logs` VALUES ('193', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975241');
INSERT INTO `t_logs` VALUES ('194', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975532');
INSERT INTO `t_logs` VALUES ('195', '删除附件', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975662');
INSERT INTO `t_logs` VALUES ('196', '删除附件', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975666');
INSERT INTO `t_logs` VALUES ('197', '删除附件', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975669');
INSERT INTO `t_logs` VALUES ('198', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975800');
INSERT INTO `t_logs` VALUES ('199', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975870');
INSERT INTO `t_logs` VALUES ('200', '删除附件', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975885');
INSERT INTO `t_logs` VALUES ('201', '删除附件', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975890');
INSERT INTO `t_logs` VALUES ('202', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630975964');
INSERT INTO `t_logs` VALUES ('203', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630976220');
INSERT INTO `t_logs` VALUES ('204', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630976357');
INSERT INTO `t_logs` VALUES ('205', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630976458');
INSERT INTO `t_logs` VALUES ('206', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630976602');
INSERT INTO `t_logs` VALUES ('207', '登录后台', 'admin用户', '1', '0:0:0:0:0:0:0:1', '1630976705');
INSERT INTO `t_logs` VALUES ('208', '登录后台', 'admin用户', '1', '127.0.0.1', '1630977441');
INSERT INTO `t_logs` VALUES ('209', '登录后台', 'admin用户', '1', '127.0.0.1', '1630977879');
INSERT INTO `t_logs` VALUES ('210', '登录后台', 'admin用户', '1', '127.0.0.1', '1630978931');
INSERT INTO `t_logs` VALUES ('211', '登录后台', 'admin用户', '1', '127.0.0.1', '1630985862');
INSERT INTO `t_logs` VALUES ('212', '登录后台', 'admin用户', '1', '127.0.0.1', '1630986711');
INSERT INTO `t_logs` VALUES ('213', '登录后台', 'admin用户', '1', '127.0.0.1', '1630987325');

-- ----------------------------
-- Table structure for t_metas
-- ----------------------------
DROP TABLE IF EXISTS `t_metas`;
CREATE TABLE `t_metas` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `type` varchar(32) NOT NULL DEFAULT '',
  `contentType` varchar(32) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `sort` int(10) unsigned DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`mid`) USING BTREE,
  KEY `slug` (`slug`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_metas
-- ----------------------------
INSERT INTO `t_metas` VALUES ('49', 'Java', null, 'category', null, null, null, null);
INSERT INTO `t_metas` VALUES ('50', 'Java', 'Java', 'tag', null, null, null, null);
INSERT INTO `t_metas` VALUES ('51', '多线程', '多线程', 'tag', null, null, null, null);
INSERT INTO `t_metas` VALUES ('52', '笼中小夜莺-CSDN主页', 'https://blog.csdn.net/m0_46521785', 'link', null, 'https://csdnimg.cn/release/blogv2/dist/pc/img/monkeyWhite.png', '0', null);
INSERT INTO `t_metas` VALUES ('53', 'Python', null, 'category', null, null, null, null);
INSERT INTO `t_metas` VALUES ('54', 'Python', 'Python', 'tag', null, null, null, null);
INSERT INTO `t_metas` VALUES ('55', '是张老师不是蟑老师-B站主页', 'https://space.bilibili.com/351897298', 'link', null, '', '0', null);
INSERT INTO `t_metas` VALUES ('56', 'GitHub主页', 'https://github.com/coder-zrl', 'link', null, '', '0', null);

-- ----------------------------
-- Table structure for t_options
-- ----------------------------
DROP TABLE IF EXISTS `t_options`;
CREATE TABLE `t_options` (
  `name` varchar(32) NOT NULL DEFAULT '',
  `value` varchar(1000) DEFAULT '',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_options
-- ----------------------------

-- ----------------------------
-- Table structure for t_relationships
-- ----------------------------
DROP TABLE IF EXISTS `t_relationships`;
CREATE TABLE `t_relationships` (
  `cid` int(10) unsigned NOT NULL,
  `mid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cid`,`mid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_relationships
-- ----------------------------
INSERT INTO `t_relationships` VALUES ('27', '41');
INSERT INTO `t_relationships` VALUES ('27', '42');
INSERT INTO `t_relationships` VALUES ('27', '43');
INSERT INTO `t_relationships` VALUES ('27', '46');
INSERT INTO `t_relationships` VALUES ('28', '41');
INSERT INTO `t_relationships` VALUES ('28', '43');
INSERT INTO `t_relationships` VALUES ('29', '41');
INSERT INTO `t_relationships` VALUES ('29', '42');
INSERT INTO `t_relationships` VALUES ('29', '43');
INSERT INTO `t_relationships` VALUES ('30', '48');
INSERT INTO `t_relationships` VALUES ('31', '48');
INSERT INTO `t_relationships` VALUES ('32', '41');
INSERT INTO `t_relationships` VALUES ('32', '43');
INSERT INTO `t_relationships` VALUES ('33', '48');
INSERT INTO `t_relationships` VALUES ('34', '49');
INSERT INTO `t_relationships` VALUES ('34', '50');
INSERT INTO `t_relationships` VALUES ('34', '51');
INSERT INTO `t_relationships` VALUES ('35', '53');
INSERT INTO `t_relationships` VALUES ('35', '54');

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `homeUrl` varchar(200) DEFAULT NULL,
  `screenName` varchar(32) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `activated` int(10) unsigned DEFAULT '0',
  `logged` int(10) unsigned DEFAULT '0',
  `groupName` varchar(16) DEFAULT 'visitor',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `name` (`username`) USING BTREE,
  UNIQUE KEY `mail` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'e2848f860b67e77458bc91595b4c54fd', '970586718@qq.com', null, 'admin', '1490756162', '0', '0', 'visitor');
