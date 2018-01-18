alter table TB_POST add constraint `FK_TB_CATEGORY_TO_TB_POST` foreign key (`category`) references `TB_CATEGORY`(`transport_id`);

CREATE TABLE `TB_POST` (
	`idx` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'idx',
	`userId` VARCHAR(50) NULL DEFAULT NULL COMMENT 'userId',
	`postDateTime` DATETIME NOT NULL COMMENT 'postDate',
	`tripDateTime` DATETIME NOT NULL COMMENT 'tripDate',
	`photo` VARCHAR(2000) NOT NULL COMMENT 'PHOTO',
	`content` VARCHAR(500) NOT NULL COMMENT 'CONTENT',
	`location` VARCHAR(100) NULL DEFAULT NULL COMMENT '여행위치',
	`locale` VARCHAR(5) NULL DEFAULT NULL COMMENT '국가',
	`lat` VARCHAR(15) NULL DEFAULT NULL COMMENT 'LAT',
	`lot` VARCHAR(15) NULL DEFAULT NULL COMMENT 'LOT',
	`tourIdx` BIGINT(20) NULL DEFAULT NULL COMMENT 'TOUR_IDX',
	`category` CHAR(2) NULL DEFAULT NULL COMMENT 'CATEGORY',
	`price` FLOAT NULL DEFAULT NULL COMMENT 'PRICE',
	`score` FLOAT NULL DEFAULT NULL COMMENT 'SCORE',
	`favorite` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '좋아요수',
	PRIMARY KEY (`idx`),
	CONSTRAINT `FK_TB_USER_TO_TB_POST` FOREIGN KEY (`userId`) REFERENCES `TB_USER` (`id`),
	constraint `FK_TB_CATEGORY_TO_TB_POST` foreign key (`category`) references `TB_CATEGORY`(`transport_id`),
	constraint `FK_TB_COUNTRY_TO_TB_POST` foreign key (`locale`) references `TB_COUNTRY`(`code`),
	constraint `FK_TB_TOUR_TO_TB_POST` foreign key (`tourIdx`) references `TB_TOUR`(`idx`),
	INDEX `FK_TB_USER_TO_TB_POST` (`userId`)
)
COMMENT='포스트'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

drop table TB_POST





CREATE TABLE `TB_CATEGORY` (
	`idx` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'idx',
	`transport` VARCHAR(25) NOT NULL COMMENT '이동 수단',
	`transport_id` CHAR(2) NOT NULL COMMENT 'id',
	PRIMARY KEY (`idx`),
	INDEX `idx` (`idx`),
	CONSTRAINT `FK_TB_POST_TO_TB_CATEGORY` FOREIGN KEY (`transport_id`) REFERENCES `TB_POST` (`category`)
)
COMMENT='카테고리'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

insert into TB_CATEGORY values (idx, '자동차', '01');
insert into TB_CATEGORY values (idx, '택시', '02');
insert into TB_CATEGORY values (idx, '기차', '03');
insert into TB_CATEGORY values (idx, '트램', '04');
insert into TB_CATEGORY values (idx, '버스', '05');
insert into TB_CATEGORY values (idx, '지하철', '06');
insert into TB_CATEGORY values (idx, '비행기', '07');
insert into TB_CATEGORY values (idx, '배', '08');
insert into TB_CATEGORY values (idx, '도보', '09');
insert into TB_CATEGORY values (idx, '자전거', '10');
insert into TB_CATEGORY values (idx, '오토바이', '11');
insert into TB_CATEGORY values (idx, '기타', '12');



CREATE TABLE `TB_COUNTRY` (
	`idx` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'idx',
	`name` VARCHAR(20) NOT NULL COMMENT '국가명',
	`code` CHAR(2) NOT NULL COMMENT '국가코드',
	PRIMARY KEY (`idx`),
	INDEX `idx` (`idx`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;



insert into TB_COUNTRY values (idx, '대한민국', 'KR');
insert into TB_COUNTRY values (idx, '일본', 'JP');
insert into TB_COUNTRY values (idx, '미국', 'US');







/* TOUR */
select *
  from TB_TOUR
 where userId = 'HailFederer'
   and idx = 1;
   
   
delete from TB_TOUR where idx = 281;


insert into TB_TOUR values (idx, 'HailFederer', 0, 'Sample Data_USA', '2018-01-01', '2018-01-08', 0, 'imagePath', 0, 0, 0);
insert into TB_TOUR values (idx, 'HailFederer', 0, 'Sample Data_Jap', '2018-01-10', '2018-01-13', 0, 'imagePath', 0, 0, 0);
insert into TB_TOUR values (idx, 'HailFederer', 0, 'Sample Data_Kor', '2018-01-14', '2018-01-15', 0, 'imagePath', 0, 0, 0);



/* POST */
select * 
  from TB_POST
 where userId = 'HailFederer'
   and tourIdx = 1;


delete
  from TB_POST
 where userId = 'HailFederer';


insert into TB_POST values (idx, 'HailFederer', SYSDATE(), SYSDATE(), 'C:', '시카고 미술관을 방문하였다. 우왕ㅋ굳ㅋ!', '시카고 미술관:111 S Michigan Ave, Chicago, IL 60603 미국', 'US', 41.880148, -87.623669, 282, '07', 50000, 4.0, 0);
insert into TB_POST values (idx, 'HailFederer', SYSDATE(), SYSDATE(), 'C:', '분위기 쩌는 윌리스 타워! 같이 가실분 급구!', '윌리스 타워:233 S Wacker Dr, Chicago, IL 60606 미국', 'US', 41.878951, -87.635982, 282, '01', 3000, 2.0, 0);
insert into TB_POST values (idx, 'HailFederer', SYSDATE(), SYSDATE(), 'C:', '금강산도 식후경! 밥은 먹고 다니냐??', '부일 갈비:3346 W Bryn Mawr Ave, Chicago, IL 60659 미국', 'US', 41.983244, -87.713173, 282, '01', 80000, 4.0, 0);
insert into TB_POST values (idx, 'HailFederer', SYSDATE(), SYSDATE(), 'C:', '29분을 운전해 온 커피집.. 그 맛은?!?! 빠밤!!', 'Intelligentsia Coffee Millennium Park Coffeebar:53 E Randolph St, Chicago, IL 60601 미국', 'US', 41.884359, -87.625790, 282, '01', 10000, 1.5, 0);


insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), SYSDATE(), 'C:', 'content5', 'location5', 'CHN', '5.5', '5.5', 1, '5', 50000, 5, 5);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), SYSDATE(), 'C:', 'content6', 'location6', 'CHN', '6.6', '6.6', 1, '6', 60000, 6, 6);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), SYSDATE(), 'C:', 'content7', 'location7', 'CHN', '7.7', '7.7', 1, '7', 70000, 7, 7);

insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), SYSDATE(), 'C:', 'content8', 'location8', 'CHN', '8.8', '8.8', 1, '8', 80000, 8, 8);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), SYSDATE(), 'C:', 'content9', 'location9', 'CHN', '9.9', '9.9', 1, '9', 90000, 9, 9);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), SYSDATE(), 'C:', 'content10', 'location10', 'CHN', '10.10', '10.10', 1, '10', 100000, 10, 10);
	
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), '2018-01-11 12:13:40', 'C:', 'content11', 'location11', 'CHN', '11.11', '11.11', 1, '11', 110000, 11, 11);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), '2018-01-11 12:13:40', 'C:', 'content12', 'location12', 'CHN', '12.12', '12.12', 1, '12', 120000, 12, 12);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), '2018-01-11 12:13:40', 'C:', 'content13', 'location13', 'CHN', '13.13', '13.13', 1, '13', 130000, 13, 13);
	
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), '2018-01-13 12:13:40', 'C:', 'content14', 'location14', 'CHN', '14.14', '14.14', 1, '14', 140000, 14, 14);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), '2018-01-13 12:13:40', 'C:', 'content15', 'location15', 'CHN', '15.15', '15.15', 1, '15', 150000, 15, 15);
insert into TB_POST (userId, postDateTime, tripDateTime, photo, content, location, locale, lat, lot, tourIdx, category, price, score, hit)
	values ('HailFederer', SYSDATE(), '2018-01-13 12:13:40', 'C:', 'content16', 'location16', 'CHN', '16.16', '16.16', 1, '16', 160000, 16, 16);



update TB_POST set tripDateTime = '2018-01-16 10:36:36' where idx = 59;





	
  select ifnull(G.dateGap, '') dateGap, P.*
    from TB_POST P left join (select DATEDIFF(DATE_FORMAT(P.tripDateTime, '%Y-%m-%d'), T.startDate)+1 dateGap, min(P.idx) idx
										  from TB_POST P left join TB_TOUR T
										    on P.tourIdx = T.idx
									    where P.userId = 'HailFederer'
										   and P.tourIdx = 1
								    group by dateGap) G
	   on P.idx = G.idx
   where P.userId = 'HailFederer'
	  and P.tourIdx = 1
order by tripDateTime, postDateTime;


















