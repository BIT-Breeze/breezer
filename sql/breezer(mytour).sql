select *
  from (select p.TOUR_IDX IDX, p.ID, '' TITLE,  p.CONTENT,            p.PHOTO, null START_DATE, 
  			   null END_DATE, p.SCORE, p.RECOMMEND,    p.POST_DATE, p.TRIP_DATE,  p.LOCATION
		  from TB_POST p
		UNION ALL 
		select          t.IDX, t.ID,  t.TITLE, '' CONTENT, t.MAIN_PHOTO PHOTO,    t.START_DATE,    
			      t.END_DATE, t.SCORE, t.RECOMMEND, null POST_DATE, p.trip_date, '' LOCATION 
		  from TB_TOUR t, (select p.TOUR_IDX, min(p.trip_date) trip_date
							 from TB_POST p
						 group by p.TOUR_IDX) p
		 where t.IDX = p.TOUR_IDX) f
	  order by f.trip_date, f.title;


select * from TB_POST;
select * from TB_TOUR;

DELETE FROM TB_POST;
DELETE FROM TB_TOUR;

DROP TABLE TB_POST;
DROP TABLE TB_TOUR;

INSERT INTO TB_POST VALUES (1, 'federer', sysdate, sysdate, 'C:', 'jj4', 'seoul', '38', '180', 2, 'b', 20000, 5, 1); 
INSERT INTO TB_TOUR VALUES (3, 'federer', 3, '서울여행기3', sysdate, sysdate, 5, 'F:', 10);

CREATE TABLE TB_POST (
	IDX INTEGER NOT NULL, /* IDX */
	ID VARCHAR2(50), /* USER_ID */
	POST_DATE DATE NOT NULL, /* POST_DATE */
	TRIP_DATE DATE NOT NULL, /* TRIP_DATE */
	PHOTO VARCHAR(1000) NOT NULL, /* PHOTO */
	CONTENT VARCHAR(500) NOT NULL, /* CONTENT */
	LOCATION VARCHAR(100), /* LOCATION */
	LAT VARCHAR(15), /* LAT */
	LON VARCHAR(15), /* LON */
	TOUR_IDX INTEGER, /* TOUR_IDX */
	CATEGORY CHAR(2), /* CATEGORY */
	PRICE FLOAT, /* PRICE */
	SCORE FLOAT, /* SCORE */
	recommend INTEGER DEFAULT 0 NOT NULL /* recommend */
);
CREATE TABLE TB_TOUR (
	IDX INTEGER NOT NULL, /* IDX */
	ID VARCHAR2(50) NOT NULL, /* USER_ID */
	SEQ INTEGER NOT NULL, /* SEQ */
	TITLE VARCHAR(100) NOT NULL, /* TITLE */
	START_DATE DATE NOT NULL, /* START_DATE */
	END_DATE DATE, /* END_DATE */
	SCORE FLOAT, /* SCORE */
	MAIN_PHOTO VARCHAR(500) NOT NULL, /* MAIN_PHOTO */
	recommend INTEGER DEFAULT 0 /* recommend */
);