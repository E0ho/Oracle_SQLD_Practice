-- 조인을 통한 합집합 구현
-- UNION : 두 개 이상의 테이블을 하나로 만드는 연산이다. 중복을 제거하기 때문에 정렬이 발생한다.
-- 주의 사항은 두 개 이상의 테이블의 컬럼 수, 컬럼의 데이터 타입이 무조건 일치해야 한다.

-- 아래 코드는 중복된 내용이 없기 때문에 20개 출력
SELECT U.USERID, U.HEIGHT
 FROM USERTBL U
UNION
SELECT B.USERID, B.PRICE
 FROM BUYTBL B;
-- 아래 코드는 중복된 내용이 있지만 제거를 하고 난 뒤 10개만 출력되었다. 
SELECT U.USERID
 FROM USERTBL U
UNION
SELECT B.USERID
 FROM BUYTBL B;
 
-- UNION ALL은 중복된 레코드까지 다 합집으로 만든다. 정렬과정이 발생하지 않는다.
SELECT U.USERID
 FROM USERTBL U
UNION ALL
SELECT B.USERID
 FROM BUYTBL B;
 
 
-- 차집합은 MINUS 연산을 한다. 먼저 쓴 SELECT문에는 있고, 뒤에 쓰는 SELECT 문에는 없는 집합을 의미한다.
-- MS-SQL에서 똑같은 기능을 하는 것은 EXCEPT가 있다. MYSQL에서는 지원하지 않는다.
-- 아래 쿼리는 구매한 USERID가 5개 밖에 없으므로 결과는 5개의 레코드가 나온다.
SELECT U.USERID
 FROM USERTBL U
MINUS
SELECT B.USERID
 FROM BUYTBL B;
 
-- 계층형 조회(CONNECT BY) : 오라클에서만 지원을 해준다. 자체조인(셀프조인) 방법을 사용한다.
DROP TABLE EMP;
CREATE TABLE EMP(
    EMPNO NUMBER(10) PRIMARY KEY,
    ENAME VARCHAR2(20),
    DEPTNO NUMBER(10),
    MGR NUMBER(10),
    JOB VARCHAR2(20),
    SAL NUMBER(10,5)
);

INSERT INTO EMP VALUES(1000, 'TEST1', 20, NULL, 'CLERK', 800);
INSERT INTO EMP VALUES(1001, 'TEST2', 30, 1000, 'SALESMAN', 1600);
INSERT INTO EMP VALUES(1002, 'TEST3', 30, 1000, 'SALESMAN', 1250);
INSERT INTO EMP VALUES(1003, 'TEST4', 20, 1000, 'MANAGER', 2975);
INSERT INTO EMP VALUES(1004, 'TEST5', 30, 1000, 'SALESMAN', 1250);
INSERT INTO EMP VALUES(1005, 'TEST6', 30, 1001, 'MANAGER', 2850);
INSERT INTO EMP VALUES(1006, 'TEST7', 10, 1001,'MANAGER', 2450);
INSERT INTO EMP VALUES(1007, 'TEST8', 20, 1006, 'ANALYST', 3000);
INSERT INTO EMP VALUES(1008, 'TEST9', 30, 1006, 'PRESIDENT', 5000);
INSERT INTO EMP VALUES(1009, 'TEST10', 30, 1002, 'SALESMAN', 1500);
INSERT INTO EMP VALUES(1010, 'TEST11', 20, 1002, 'CLERK', 1100);
INSERT INTO EMP VALUES(1011, 'TEST12', 30, 1001, 'CLERK', 950);
INSERT INTO EMP VALUES(1012, 'TEST13', 20, 1000, 'ANALYST', 3000);
INSERT INTO EMP VALUES(1013, 'TEST14', 10, 1000, 'CLERK', 1300);
COMMIT;

SELECT *
 FROM EMP;

-- CONNECT BY는 트리(TREE)형태의 구조로 질의를 수행하는 것이다.
-- START WITH구문으로 시작조건을 의미하고, CONNECT BY PRIOR는 조인 조건인다. ROOT노드로 부터 하위노드로 질의를 실행한다.
-- LEVEL 계층형 쿼리에서 단계를 의미하는데 MAX함수 안에 LEVEL이 들어가므로써 4계층의 트리 구조로 되어 있다. LEAF NODE의 계층값을
-- 구하고 있는 코드
SELECT MAX(LEVEL)
 FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

SELECT LEVEL, EMPNO, MGR, ENAME
 FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR
ORDER BY MGR, EMPNO;



-- 계층형 조회 결과를 명확히 보기 위해서 LPAD함수를 사용
SELECT LEVEL, LPAD(' ', 4 * (LEVEL - 1) ) || EMPNO, MGR, CONNECT_BY_ISLEAF
 FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;


-- CONNECT BY 키워드는 내용이 무엇인지는 다시한번 복기