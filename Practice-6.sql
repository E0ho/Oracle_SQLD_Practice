-- DUAL 테이블 오라클에서 제공해주는 더미 테이블이다.
DESC DUAL;

-- 내장형 함수(문자형)-오라클 엔진에서 제공해주는 함수
-- ASCII(문자) -> 아스키코드로 출력
-- SUBSTR() -> 문자열을 자르는 함수
-- LENGTHB(문자열) -> 해당 문자열의 바이트크기(한글 : 3바이트, 영문 : 1바이트)
-- LTRIM() -> 좌측 공백 제거 함수
-- RTRIM() -> 우측 공백 제거 함수
-- TRIM() -> 좌우측 공백 제거 함수
-- CHR() -> 아스키코드 값에 해당하는 문자를 출력
SELECT ASCII('A'), SUBSTR('ABCDEFG',1,4), LENGTH('홍길동'), LENGTHB('ABC'), LENGTH(LTRIM('  홍')), 
          LENGTH(RTRIM('홍  ')), LENGTH(TRIM('  홍   ')), CHR(97)
 FROM DUAL;
-- CONCAT() : 문자열을 연결해주는 함수 
SELECT CONCAT('아름다운 ', '대한민국')
 FROM DUAL;
-- || : 문자열 연결 연산자
SELECT '아름다운 ' || '대한민국'
 FROM DUAL;
-- LOWER() : 영문자를 무조건 소문자로 변경
-- UPPER() : 영문자를 무조건 소문자로 변경
SELECT LOWER('ABCDeee'), UPPER('ABCDeee')
 FROM DUAL;
 

-- 내장형 함수(날짜형 함수)
-- SYSDATE : 지금 날짜를 출력
-- EXTRACT() : 년, 월, 일을 추출해서 출력
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE), EXTRACT(DAY FROM SYSDATE)
 FROM DUAL;
 
-- TO_CHAR() : 형변환 함수인데, 포맷에 맞게끔 날짜 및 시각을 표현한다. 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:DD AM')
 FROM DUAL;
 

-- 내장형 함수(숫자형 함수)
-- ABS() : 절댓값을 구하는 함수
-- SIGN() : 양수, 0, 음수인지를 확인하는 함수(1이면 양수, -1이면 음수)
-- MOD() : 나머지를 구하는 함수
-- CEIL() : 무조건 올림하는 함수, 숫자보다 크거나 같은 최소의 정수를 돌려준다.
-- FLOOR() : 무조건 내림하는 함수, 숫자보다 작거나 같은 최대의 정수를 돌려준다.
-- ROUND(실수, 자릿수) : 자릿수로 만드는데 반올림 처리를 하는 함수
-- TRUNC(실수, 자릿수) : 자릿수로 만드는데 절삭 처리를 하는 함수
SELECT ABS(-1), SIGN(0), MOD(11, 4), CEIL(10.9), FLOOR(10.1), ROUND(15.255, 2), TRUNC(15.255, 1)
 FROM DUAL;
