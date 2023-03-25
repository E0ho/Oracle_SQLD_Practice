-- 그룹함수

-- 1. ROLLUP : 사전적으로 말을 하자면 '~말아올리다'이고, 오라클에서는 GROUP BY의 컬럼에 대해서 소계, 합계를 구해주는 함수
SELECT DECODE(DEPTNO, NULL, '전체합계', ' ') TOT,  -- DEPTNO가 NULL이면 '전체합계'를 출력한다.
          DECODE(DEPTNO, NULL, ' ', 10, '인사팀', 20, '관리팀', 30, '전산팀') "부서",  -- 부서번호가 NULL이면 공백 출력, 10번 인사팀 등으로 출력
          SUM(SAL)
 FROM EMP
 -- ROLLUP함수를 사용하면 부서별 합계 및 전체합계를 구할 수 있다.
GROUP BY ROLLUP(DEPTNO);

-- 부서별, 직업별 ROLLUP을 실행하면 부서별 합계, 직업별 합계, 전체 합계가 모두 조회된다.
SELECT DEPTNO, JOB, SUM(SAL)
 FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT *
 FROM EMP
ORDER BY DEPTNO;

-- 2. GROUPING 함수 : ROLLUP, CUBE, GROUPING SETS에서 생성되는 합계 값을 구분하기 위해서 만들어진 함수이다.
-- 소계, 합계가 구해지면 GROUPING함수는 1을 리턴해주고, 그렇치 아니하면 0을 반환해준다.
SELECT DEPTNO, GROUPING(DEPTNO),
          JOB, GROUPING(JOB), SUM(SAL)
 FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

-- GROUPING함수의 기능을 사용하면 고객이 원하는 데이터 형태로 작성해서 제공해줄 수가 있다.
SELECT DEPTNO, 
          DECODE(GROUPING(DEPTNO), 0, ' ' , '전체합계') TOT,
          DECODE(GROUPING(JOB), 0, ' ' , '부서합계') TOT_DEPT,
          SUM(SAL)
 FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

-- 3. GROUPING SETS() 함수 : GROUP BY 에 나오는 컬럼의 순서와 관계없이 다양한 소계를 만들수가 있다.독립적인 형태이다.
SELECT DEPTNO, JOB, SUM(SAL)
 FROM EMP
-- 결과론적으로 GROUPING SETS()함수는 컬럼별로 독립적으로 계산한다. 순서에 관계 없다.
GROUP BY GROUPING SETS(DEPTNO, JOB);


-- 4. CUBE()함수 : 제시한 컬럼에 대해서 결합 가능한 모든 집계를 계산, 다차원 집계, 다양하게 데이터 분석
SELECT DEPTNO, JOB, SUM(SAL)
 FROM EMP
 -- 전체합계, 직업별 합계, 부서별 합계, 부서별 직업별 합계도 같이 조회되었다.
GROUP BY CUBE(DEPTNO, JOB);

