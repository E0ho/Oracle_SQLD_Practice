-- DCL(DATA CONTROL LANGUAGE)
-- GRANT : 데이터베이스 사용자에게 권한을 부여
-- 데이터 사용하기 위해서는 권한이 필요하며 연결, 입력, 수정, 삭제, 조회를 할 수 있다.

-- 계정 생성하기
SHOW USER;

CONNECT SYSTEM/1234;    -- SQLPLUS에서만 적용된다.
-- 해당 DB의 우클릭 후 접속해제 하고 SYSTEM계정으로 접속한다.
SHOW USER;

CREATE USER C##TEST IDENTIFIED BY 1234;
COMMIT;

SELECT *
 FROM EMP;
-- C##TEST계정에게 접속, 자원에 대한 권한을 부여함 
GRANT CONNECT, RESOURCE TO C##TEST;
COMMIT;

-- C##TEST계정으로 EMP테이블을 조회하니깐 테이블이 존재하지 않는다라는 메시지가 출력되었다.
-- 이유는 EMP테이블에 대한 권한이 없기 때문이다.
SELECT *
 FROM EMP;

-- C##TEST 에게 SELECT, INSERT, UPDATE 권한 부여하는 코드
GRANT SELECT, INSERT, UPDATE
     ON EMP
     TO C##TEST;
COMMIT; 

SHOW USER;
-- C##PERPEAR계정에서 만들어진 테이블 EMP를 조회하고자 한다면 아래와 같이 조회를 한다.
SELECT *
 FROM C##PERPEAR.EMP;
-- DELETE에 대한 권한은 주지 않았으므로 삭제가 안된다. 
DELETE FROM C##PERPEAR.EMP;

-- UPDATE에 대한 권한은 주었기에 수정이 된다. 
UPDATE C##PERPEAR.EMP
      SET ENAME = '홍길동'
WHERE EMPNO = 1000;
COMMIT;

-- REVOKE : 주어진 권한을 회수하는 명령어
REVOKE INSERT, UPDATE 
      ON EMP
  FROM C##TEST;
COMMIT;

-- 다시 권한을 회수한 후 C##TEST로 접속하여 아래 쿼리문을 실행해보자
UPDATE C##PERPEAR.EMP
      SET ENAME = '김말자'
WHERE EMPNO = 1000;

SHOW USER;