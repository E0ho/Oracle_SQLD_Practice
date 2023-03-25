-- ROWNUM
-- 오라클 데이터베이스의 SELECT문 결과에 대한 논리적인 일련 번호

-- 페이지의 단위 출력을 하기 위해서는 인라인 뷰를 사용해야 한다.
-- 인라인뷰 FROM절에 서브쿼리 자체 의미한다.
SELECT *   -- 메인쿼리(상위쿼리)
 FROM (SELECT * FROM EMP) LIST; -- 서브쿼리
 
-- ROWNUM을 가지고 데이터의 출력하는 수를 제한
SELECT *
 FROM EMP
WHERE ROWNUM <= 1;  

-- 인라인 뷰를 사용하여 EMP테이블의 5개로 제한(SQL SERVER TOP(), MYSQL에서는 LIMIT과 같은 기능을 가지고 있다.)
SELECT *
 FROM (SELECT ROWNUM LIST , ENAME FROM EMP)   -- 인라인 뷰를 사용함
WHERE LIST <= 5;

-- 웹 게시판에서 많이 사용되는 쿼리문이다.
SELECT *
 FROM (SELECT ROWNUM LIST , ENAME FROM EMP)   -- 인라인 뷰를 사용함
WHERE LIST BETWEEN 5 AND 10;

-- ROWID -> 데이터를 저장할 때 오라클 엔진이 알아서 자동으로 생성되게 만들어 주는 유일한 값
-- 데이터가 어떤 데이터 파일, 어느 블록에 저장되어 있는지 알 수 있다.
-- ROWID구조(오브젝트, 상대파일번호, 블록 번호, 데이터 번호)
SELECT ROWID, ENAME
 FROM EMP;
 
-- WITH 구문 
-- 서브쿼리를 사용해서 임시테이블이나 뷰처럼 사용할 수 있는 구문
WITH VIEWDATA AS(
    SELECT * FROM EMP
    UNION ALL          -- 두 테이블을 합친다(중복된 것도 포함), UNION은 두 테이블을 합치는 것은 동일하나 중복된 것을 제거한다.
    SELECT * FROM EMP
)
SELECT * 
 FROM VIEWDATA
WHERE EMPNO = 1000;

SELECT *
 FROM EMP;
 
-- EMP테이블에서 부서번호가 20번인 것에 대한 임시테이블을 만들고 조회하는 WITH구문의 쿼리
WITH W_EMP AS(
    SELECT * 
     FROM EMP
    WHERE DEPTNO = 20
)
SELECT * 
 FROM W_EMP;