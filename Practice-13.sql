-- 윈도우 함수
-- 윈도우 함수는 행과 행 간의 관계를 정의하기 위해서 제공되는 함수이다.
-- 윈도우 함수를 사용해서 순위, 합계, 평균, 행 위치 등을 조작할 수가 있다.

-- UNBOUNDED PRECEDING : 행의 집합 중 맨 처음 행
-- UNBOUNDED FOLLOWING : 행의 집합 중 맨 마지막 행
-- TOTSAL에는 처음부터 마지막 행까지의 합계가 들어간다.
SELECT EMPNO, ENAME, SAL,
          SUM(SAL) OVER(ORDER BY SAL
                                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS TOTSAL
 FROM EMP;
 
 -- CURRENT ROW : 현재 행
 -- 처음부터 다음 행을 더하고 또 다음 행을 더하는 행위
 SELECT EMPNO, ENAME, SAL,
          SUM(SAL) OVER(ORDER BY SAL
                                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TOTSAL
 FROM EMP;
 
 -- 순위 함수
 -- 순위 함수의 종류 : RANK, DENSERANK, ROW_NUMBER
 
SELECT ENAME, SAL, JOB,
           -- 급여(SAL) 순위를 계산한다. 동일한 순위는 동일하게 조회하고 행의 갯수의 만큼 마지막 등수가 결정이 된다.  
           RANK() OVER(ORDER BY SAL DESC) AS ALL_RANK,
           -- JOB별로 묶어서 급여로 내림차순을 하고 있다.
           RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS JOB_RANK
 FROM EMP;
 
 
 SELECT ENAME, SAL, JOB,
           -- 급여(SAL) 순위를 계산한다. 동일한 순위는 동일하게 조회하고 행의 갯수의 만큼 마지막 등수가 결정이 된다.  
           RANK() OVER(ORDER BY SAL DESC) AS ALL_RANK,
           -- DENSE_RANK()는 동일한 순위를 하나의 건수로 인식해서 조회하고 행의 갯수와 항상 마지막 등수가 같지 않을수도 있다.
           DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSE_RANK
 FROM EMP;
 
SELECT ENAME, SAL, JOB,
           -- 급여(SAL) 순위를 계산한다. 동일한 순위는 동일하게 조회하고 행의 갯수의 만큼 마지막 등수가 결정이 된다.  
           RANK() OVER(ORDER BY SAL DESC) AS ALL_RANK,
           -- DENSE_RANK()는 동일한 순위를 하나의 건수로 인식해서 조회하고 행의 갯수와 항상 마지막 등수가 같지 않을수도 있다.
           DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSE_RANK,
           -- ROW_NUMBER()는 동일한 순위에 대해서도 고유의 순위를 부여한다.
           ROW_NUMBER() OVER(ORDER BY SAL DESC) AS ROW_NUMBER
 FROM EMP;
 
 -- 집계함수
 -- 집계함수의 종류 : SUM, AVG, COUNT, MAX, MIN 
SELECT ENAME, MGR, SAL,
           AVG(SAL) OVER(PARTITION BY MGR) AS SUMMGR
 FROM EMP;
 
 -- 행 순서 관련 함수
 -- FIRST_VALUE, LAST_VALUE, LAG, LEAD 함수
 
 -- FIRST_VALUE함수는 파티션에서 조회된 행 중에서 첫 번째 FETCH가 되는 행의 값을 출력함을 알 수가 있다.
 -- 아래 쿼리는 의미론적으로 바라볼 때는 부서별 중에서 급여가 가장 높은 사람을 추출하는 쿼리문
SELECT DEPTNO, ENAME, SAL,
           FIRST_VALUE(ENAME) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A
 FROM EMP;
 
 -- LAST_VALUE함수는 파티션에서 마지막 행을 가지고 온다.
 -- BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING : 현재 행에서 마지막 행까지의 범위를 의미
 SELECT DEPTNO, ENAME, SAL,
           LAST_VALUE(ENAME) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND
           UNBOUNDED FOLLOWING) AS DEPT_A
 FROM EMP;

-- LAG함수는 이전 값을 출력해주는 함수이다.
SELECT DEPTNO, ENAME, SAL,
           LAG(SAL) OVER(ORDER BY SAL DESC) AS PRE_SAL
 FROM EMP;
 
-- LEAD함수는 지정한 위치의 행을 가져온다. LEAD함수의 매개변수 중에서 2는 SAL에서 두 번째 행을 가져와 출력을 한다.
-- LEAD함수는 음수값을 받지 아니한다.
-- LEAD함수의 기본값은 1이다.
SELECT DEPTNO, ENAME, SAL,
          LEAD(SAL, 2) OVER(ORDER BY SAL DESC) AS PRE_SAL
 FROM EMP;
 
 -- 비율 관련 함수
 -- 종류 : CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT가 있다.

-- PERCENT_RANK함수는 파티션에서 제일 먼저 나온 것을 0으로 제일 늦게 나온 것을 1로 하여 값이 아닌 행의 순서별 백분율로 조회한다.
SELECT DEPTNO, ENAME, SAL, PERCENT_RANK()
           OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS PERSENT_SAL
 FROM EMP;

-- CUME_DIST함수는 0으로 부터 시작하지 아니하고 첫 번째 사람도 백분율에 적용을 시키고 누적 백분율을 표식을 한다.
-- 누적 백분율의 값은 0~1의 사이의 값을 가진다.
SELECT DEPTNO, ENAME, SAL, CUME_DIST()
           OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS PERSENT_SAL
 FROM EMP;
 
-- NTILE함수는 매개변수로 들어가는 정수값에 의해서 행이 분할이 되어 출력이 되어진다.
-- 단, 나누어서 떨어지면 행의 갯수가 동일하게 분할이 되지만 떨어지지 않는다면 오라클 엔진에서 알아서 적절히 분할을 시켜줌을 
-- 알 수가 있다.
SELECT DEPTNO, ENAME, SAL, NTILE(4) OVER(ORDER BY SAL DESC) AS N_TILE
 FROM EMP;
 
-- 확인 문제 2번 풀이
SELECT *
 FROM DEPT;
 
SELECT *
 FROM EMP;
 
UPDATE DEPT
      SET DEPTNO = 10
 WHERE DEPTNO = 1000; 
 
UPDATE DEPT
      SET DEPTNO = 20
 WHERE DEPTNO = 1001;

UPDATE DEPT
      SET DEPTNO = 30
 WHERE DEPTNO = 1002;
 
COMMIT;

SELECT B.DEPTNAME, A.JOB, SUM(A.SAL) AS SAL,
          COUNT(A.EMPNO)
 FROM EMP A, DEPT B
WHERE A.DEPTNO = B.DEPTNO
GROUP BY ROLLUP(B.DEPTNAME, A.JOB)
 
 
 
 
 
 
 
 
 
 
 