-- 서브쿼리
-- 쿼리문이기는 한데 통상 서브쿼리라고 말하는 것은 WHERE 구문에 (SELECT 문) 이 하나의 쿼리문이 더 존재하는 것을 의미한다.

-- 키가 177초과인 사람의 이름의 키를 출력하는 쿼리이다.
-- 이럴 때 서브쿼리를 이용해주면 된다.
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > 177;

-- 서브쿼리를 사용한 상태이며 위와 동일한 결과를 출력한다.
-- 실행순서가 서브쿼리가 실행 -> 메인쿼리가 실행된다.
SELECT USERNAME, HEIGHT     -- 메인 쿼리
 FROM USERTBL
WHERE HEIGHT > (SELECT HEIGHT       -- 서브쿼리
                          FROM USERTBL
                         WHERE USERNAME = '김용만');

-- FROM구에 들어가는 서브쿼리를 인라인 뷰(INLINE VIEW, 가상의 테이블 만드는 쿼리)
SELECT *
 FROM (SELECT ROWNUM ID, PRODNAME
            FROM BUYTBL)   -- FROM구에는 쿼리문으로 가상의 테이블을 만들어주는 인라인 뷰
WHERE ID < 5;

-- 단일 행 서브쿼리 : SINGLE ROW SUBQUERY --> 반드시 한 행만 조회를 하여 리턴해줘한다.(비교연산자( >, <, >=, <=, = , <>)를 사용한다.)
-- 다중 행 서브쿼리 : MULTI ROW SUBQUERY -- 여러 개의 행을 리턴해도 된다.(ANY, SOME, IN, ALL, EXISTS)

-- 아래쿼리는 비교연산자를 사용하는 단일 행 서브쿼리문인데 리턴하는 레코드가 2개여서 170, 173이므로
-- 비교대상이 애매하다.하여 에러가 발생을 하는 것이다. 모호성이 발생된 것이다.
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > ( SELECT HEIGHT
                          FROM USERTBL
                         WHERE ADDR = '경남' );

-- ANY : OR의 개념과 비슷하다.
-- 170, 173을 둘 다 만족하는 값은 170이므로 170초과되는 결과만 출력해준다.
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > ANY ( SELECT HEIGHT
                                  FROM USERTBL
                                WHERE ADDR = '경남' );
                                
-- SOME을 사용해도 된다. ANY와 동일한 성질을 가지고 있다.                                
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > SOME ( SELECT HEIGHT
                                  FROM USERTBL
                                WHERE ADDR = '경남' );
                                
                                
-- 부등호를 바꾸면 다중 행의 값의 결과와 동일한 것만 출력을 해준다.                                
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT = SOME ( SELECT HEIGHT
                                  FROM USERTBL
                                WHERE ADDR = '경남' );
                                
-- ALL : 서브쿼리의 결과 값을 둘 다 만족하는 데이터만 출력. AND개념과 유사
-- 170, 173이 서브쿼리의 결과라면 둘 다 만족하는 것은 173이 된다.
SELECT USERNAME, HEIGHT, ADDR
 FROM USERTBL
WHERE HEIGHT > ALL ( SELECT HEIGHT
                                  FROM USERTBL
                                WHERE ADDR = '경남' );

-- IN() 메인쿼리의 비교조건이 서브쿼리의 결과 중 하나만 동일하면 참인 된다(OR 개념)                                
-- 서브쿼리의 결과는 서울인 사람의 키를 리턴해준다.
SELECT USERNAME, HEIGHT, ADDR
 FROM USERTBL
WHERE HEIGHT IN ( SELECT HEIGHT
                            FROM USERTBL
                          WHERE ADDR = '서울' );
                          
-- NOT IN()은 서브쿼리의 결과값을 제외하고 출력하는 것이다.                          
SELECT USERNAME, HEIGHT, ADDR
 FROM USERTBL
WHERE HEIGHT NOT IN ( SELECT HEIGHT
                                   FROM USERTBL
                                 WHERE ADDR = '서울' );
                                 
                                 
-- EXISTS는 서브쿼리로 어떤 데이터가 있는지 존재 여부자체를 참이나 거짓인 BOOLEAN값으로 리턴해준다.
-- 실행순서가 메인쿼리 -> 서브쿼리 그 행의 결과를 비교해서 존재하면 출력, 미존재면 출력하지 않는다.
SELECT *
 FROM USERTBL U
WHERE EXISTS ( SELECT *
                       FROM BUYTBL B
                     WHERE U.USERID = B.USERID );

-- 스칼라 서브쿼리 : 반드시 한 행과 한 컬럼만 반환하는 서브쿼리이다.
SELECT ENAME AS "이름", SAL AS "급여",
          ( SELECT ROUND(AVG(SAL), 3) FROM EMP ) AS "평균급여"      -- 스칼라 서브쿼리
 FROM EMP
WHERE EMPNO = 1000;














