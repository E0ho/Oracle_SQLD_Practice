-- 부모 테이블 생성
CREATE TABLE DEPT(
    DEPTNO VARCHAR2(4) PRIMARY KEY,
    DEPTNAME VARCHAR2(20)    
);

INSERT INTO DEPT VALUES('1000', '인사팀');
INSERT INTO DEPT VALUES('1001', '총무팀');

COMMIT;

-- 자식 테이블 생성
CREATE TABLE EMP(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(20) NOT NULL,
    SAL NUMBER(10, 2) DEFAULT 0,                -- DEFAULT 기본값으로 0이 들어간다.
    DEPTNO VARCHAR2(4) NOT NULL,
    CREATEDATE DATE DEFAULT SYSDATE,            -- 현재 날짜, 시간을 기본값으로 저장된다.
    CONSTRAINT EMPPK PRIMARY KEY(EMPNO),        -- 기본키 설정
    -- 외래키 설정
    CONSTRAINT DEPTFK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)  
    ON DELETE CASCADE    -- 참조되는 Data 삭제시 함께 연쇄 삭제된다. (참조 무결성 유지)
);

INSERT INTO EMP VALUES(100, '임베스트', 1000, '1000', SYSDATE);
INSERT INTO EMP VALUES(101, '을지문덕', 2000, '1001', SYSDATE);

-- 부모테이블의 부서코드 1002번이 없으므로 무결성 제약조건 위반
INSERT INTO EMP VALUES(102, '강감찬', 3000, '1002', SYSDATE);
ROLLBACK;

-- 부모 테이블인 DEPT는 EMP테이블이 참조하고 있으므로 삭제가 불가능하다. 외래 키에 의해 참조되는 기본 키가 테이블에 있다.
DROP TABLE DEPT;

-- 항상 자식 테이블을 먼저 삭제하고, 난 뒤 부모 테이블인 DEPT테이블을 삭제해야 한다.
DROP TABLE EMP;


-- 부모 테이블의 레코드 중에서 1000번이 인사팀을 삭제하는 하는 코드
DELETE FROM DEPT
WHERE DEPTNO = '1001';
COMMIT;


--테이블 제약 조건 삭제
DROP TABLE EMP CASCADE CONSTRAINT;

DROP TABLE EMP;