-- 전체 복구를 하기 위해서 기 존재하는 테이블 삭제
DROP TABLE BUYTBL;
DROP TABLE USERTBL;

-- USERTBL 테이블 만들기
-- 회원 테이블
CREATE TABLE USERTBL ( 
    USERID CHAR(8) PRIMARY KEY,                    -- 사용자 아이디(PK)
    USERNAME VARCHAR2(10) NOT NULL,                -- 이름
    BIRTHYEAR NUMBER(10) NOT NULL,                 -- 출생년도
    ADDR VARCHAR2(20) NOT NULL,                    -- 지역(경기,서울,경남 식으로 2글자만입력)
    MOBILE1 VARCHAR2(5),                           -- 휴대폰의 앞자리
    MOBILE2 VARCHAR2(10),                          -- 휴대폰의 나머지 전화번호(하이픈제외)
    HEIGHT NUMBER(5),                              -- 키
    MDATE DATE                                     -- 회원 가입일
);
-- BUYTBL 테이블 만들기
-- 회원 구매 테이블
CREATE TABLE BUYTBL (  
   ID NUMBER(10) PRIMARY KEY,
   USERID CHAR(8) NOT NULL,                            -- 아이디(FK)
   PRODNAME VARCHAR2(20) NOT NULL,                     --  물품명
   GROUPNAME VARCHAR2(20),                             -- 분류
   PRICE NUMBER(10) NOT NULL,                          -- 단가
   AMOUNT NUMBER(5) NOT NULL,                          -- 수량
   FOREIGN KEY (USERID) REFERENCES USERTBL(USERID)     -- 외래키 설정
);

-- 데이터 삽입(USERTBL)
INSERT INTO USERTBL VALUES('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8');
INSERT INTO USERTBL VALUES('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7');
INSERT INTO USERTBL VALUES('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9');
INSERT INTO USERTBL VALUES('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5');
INSERT INTO USERTBL VALUES('KJD', '김제동', 1974, '경남', NULL , NULL      , 173, '2013-3-3');
INSERT INTO USERTBL VALUES('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4');
INSERT INTO USERTBL VALUES('SDY', '신동엽', 1971, '경기', NULL , NULL      , 176, '2008-10-10');
INSERT INTO USERTBL VALUES('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4');
INSERT INTO USERTBL VALUES('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12');
INSERT INTO USERTBL VALUES('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

-- 데이터 삽입(BUYTBL)
INSERT INTO BUYTBL VALUES(1 , 'KHD', '운동화', NULL , 30, 2);
INSERT INTO BUYTBL VALUES(2, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO BUYTBL VALUES(3, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO BUYTBL VALUES(4, 'PSH', '모니터', '전자', 200, 5);
INSERT INTO BUYTBL VALUES(5, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO BUYTBL VALUES(6, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO BUYTBL VALUES(7, 'KJD', '책' , '서적', 15, 5);
INSERT INTO BUYTBL VALUES(8, 'LHJ', '책' , '서적', 15, 2);
INSERT INTO BUYTBL VALUES(9, 'LHJ', '청바지', '의류', 50, 1);
INSERT INTO BUYTBL VALUES(10, 'PSH', '운동화', NULL, 30, 2);
INSERT INTO BUYTBL VALUES(11, 'LHJ', '책' , '서적', 15, 1);
INSERT INTO BUYTBL VALUES(12, 'PSH', '운동화', NULL, 30, 2);

-- 데이터 출력
SELECT *
  FROM USERTBL;
  
SELECT *
  FROM BUYTBL;

-- 트랜잭션 처리
COMMIT;
