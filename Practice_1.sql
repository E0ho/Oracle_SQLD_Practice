-- DDL (Data Definition Language) 테이블 생성

-- 테이블 생성 (DDL구문)
CREATE TABLE EMP(
    EMPNO INT NOT NULL PRIMARY KEY, 
    EMP_NAME VARCHAR(30) NOT NULL,
    AGE INT NOT NULL,
    SAL INT NOT NULL,
    DEPT_CODE VARCHAR(5) NOT NULL
);

-- 테이블 수정 (DEPT_CODE속성의 데이터 타입 변경) (DDL구문)
ALTER TABLE EMP MODIFY DEPT_CODE VARCHAR(5);

-- 테이블명 수정 ALTER TABLE ~ RENAME TO구문을 사용한다.
ALTER TABLE EMP
    RENAME TO NEW_EMP;

ALTER TABLE NEW_EMP
    RENAME TO EMP;

-- 테이블에 컬럼 추가 ADD
ALTER TABLE EMP
    ADD (AGE NUMBER(2) DEFAULT 1);

-- 테이블의 컬럼 변경
ALTER TABLE EMP
    MODIFY (ENAME VARCHAR2(50));

-- 데이터 타입을 변경할 때는 변경할 테이블에 데이터가 존재하면 에러가 발생하므로 설계단에서 잘 설계하여 진행하여야 한다.
ALTER TABLE EMP
    MODIFY (SAL VARCHAR2(10) NOT NULL);
    
-- 컬럼 삭제
ALTER TABLE EMP
    DROP COLUMN AGE;

-- 컬럼명 변경
ALTER TABLE EMP
    RENAME COLUMN ENAME TO NEW_ENAME;


-- NOLOGGING 옵션은 로그파일의 기록을 최소화하면서 입력 시 성능을 향상시키는 방법적인 옵션
-- NOLOGGING 옵션은 BUFFER CACHE라는 메모리 영역을 생략하고 바로 기록을 한다.
ALTER TABLE DEPT NOLOGGING;


-- 테이블 구조를 확인 (DDL구문)
DESC EMP;

-- 데이터 초기화
-- 구조를 유지하여 DROP과 차별화 된다.
TRUNCATE TABLE EMP;


-- 테이블 삭제 (DDL구문)
DROP TABLE EMP;




-- DML (Data Manipulation Language)
-- where 조건을 적절하게 사용해야 한다.

-- AS 별칭을 사용하여 가독성을 좋게 만들어 준다. (DML구문)
SELECT EMPNO AS "사원번호", EMP_NAME AS "이름", AGE AS "나이", SAL AS "연봉", DEPT_CODE AS "부서코드"
 FROM EMP;

-- 데이터 추가 (DML구문)
INSERT INTO EMP VALUES (1000, '임베스트', 20, 10000, '001');            -- 좌측과 같이 입력해도 무방함.
INSERT INTO EMP(EMPNO, EMP_NAME, AGE, SAL, DEPT_CODE) VALUES (1001, '문재인', 22, 21000, '002');       -- 정상적인 방법
INSERT INTO EMP VALUES (1002, '안철수', 32, 32000, '003');

-- 원하는 컬럼을 선택하여 데이터를 저장할 수 있다. NOT NULL 제약조건이 있는 컬럼은 반드시 값을 주어야 한다.
INSERT INTO EMP(EMPNO, ENAME, DEPTNO) VALUES (102, '강감찬', '1001');

-- 데이터 변경
SELECT * 
 FROM EMP; 

UPDATE EMP
      SET EMP_NAME = '한국'
WHERE EMPNO = 1000;


-- 데이터 삭제 (DML구문)
DELETE FROM EMP
WHERE EMPNO = 1000;





-- TCL (Transaction Control Language)
-- DML구문(INSERT, DELETE, UPDATE문)을 Disk에 적재할기 위해 사용된다.
-- DML 명령어를 최종 Disk에 저장하기 위해서는 commit이 필요하다.

-- Disk에 반영
COMMIT;

-- DML 명령어 취소
ROLLBACK;

-- 저장 체크 포인트
SAVEPOINT;
