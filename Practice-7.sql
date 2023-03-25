 -- DECODE()함수 : IF문으로 구현할 수 있다.
 -- DECODE()함수는 컬럼값이 비교값과 비교해서 그 결과가 참이면 3번째 인자값을 리턴, 거짓이면 4번째 인자값 리턴
SELECT DECODE(EMPNO, 1000, '참', '거짓')  
 FROM EMP; 
 
SELECT *
 FROM EMP;
 
SELECT DECODE(MGR, NULL, 'NULL값이다.', 'NULL값이 아니다.')
 FROM EMP;  
 
-- 성별이 남자이면 M, 여자이면 F를 출력하는 DECODE문을 작성하시오.
-- DECODE(성별, '남자', 'M', 'F');

-- CASE문 : 프로그래밍 언어처럼 조건문을 사용할 수 있다.
SELECT CASE
            WHEN EMPNO = 1000 THEN 'A'
            WHEN EMPNO = 1001 THEN 'B'
            ELSE 'C'
          END
 FROM EMP;
 
 -- DEPTNO가 10번이면 '인사팀', 20번이면 '총무팀', 30번이면 '전산팀', 그 외 나머지는 '부서없음' 표식하시오. 단, CASE문을 이용하시오.
 -- CASE WHEN THEN ELSE END 문법을 알 수 있도록 하자.
 SELECT CASE
            WHEN DEPTNO = 10 THEN '인사팀'
            WHEN DEPTNO = 20 THEN '총무팀'
            WHEN DEPTNO = 30 THEN '전산팀'
            ELSE '부서없음'
          END
 FROM EMP;
 
