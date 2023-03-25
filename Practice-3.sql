-- 뷰 만들기
CREATE VIEW V_EMP 
    AS SELECT EMPNO, ENAME 
         FROM EMP;
         
-- 뷰를 가지고 조회
SELECT *
 FROM V_EMP;

-- 뷰에 데이터 삽입은 되지 않는다.
INSERT INTO V_EMP VALUES(102, '신은혁');
-- 뷰를 가지고 삭제를 진행하니 뷰의 데이터도 삭제되고 실제 테이블의 데이터도 삭제됨(권장되어지는 방법은 절대로 아니다.)
DELETE FROM V_EMP
WHERE EMPNO = 100;

COMMIT;

SELECT *
 FROM EMP;

-- 뷰에 ALTER 문은 적용되지 않는다.
-- ALTER VIEW V_EMP
--    ADD (AGE NUMBER(2) DEFAULT 1);

-- 뷰 삭제하는 코드
DROP VIEW V_EMP;




