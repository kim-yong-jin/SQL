--정규화 단계
--[1 - 2 - 3] - BCNT - 4 - 5
--정규화 순서 : 순서대로 하는게 맞음
--
--정규화 : 데이터 상태 이상을 방지
--
--정규화 끝나고 나서 물리적인 고려
--
--nomalization    de-nomalization
--
--pl/sql record type
--java에서 클래스를 인스턴스로 생성을 하려면
--1.class생성 : 붕어빵 틀
--2.1번에서 생성한 class를 활용하여 new연산자를 통해 instance를 생성 (붕어빵)
--
--dept테이블의 10번 부서의 부서번호랑 부서이름을 pl/sql record type으로 생성된
--변수에 값을 담아서 출력(dept 모든 컬럼을 조회하는 것이 아니라 일부 컬럼만 조회)
--
--SET SERVEROUTPUT ON;
--
--
--TYPE 선언 방법:
--TYPE 타입이름(CLASS이름 짓기) IS RECORD
--    컬럼명1 타입명1,
--    컬럼명2 타입명2
--DECLARE
--    TYPE dept_rec_type is record(
--        deptno dept.deptno%TYPE,
--        dname  dept.dname%TYPE
--    );
--    
--    dept_rec dept_rec_type;
--BEGIN
--    SELECT deptno, dname into dept_rec
--    FROM dept
--    WHERE deptno = 10;
--    
--    DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno || ',dname : ' || dept_rec.dname);
--END;
--/
--
--TABLE TYPE : 여러건의 행을 저장할 수 있는 타입
--dept 테이블의 모든 행을 담아보는 실습
--
--TABLE TYPE 선언
--TYPE 테이블 타입 이름 IS TABLE OF 행의 타입 INDEX BY BINARY_INTEGER
--DECLARE
--    TYPE dept_tab_type IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
--    dept_tab dept_tab_type;
--BEGIN
--    SELECT * INTO BULK COLLECT INTO dept_tab
--    FROM dept;
--END;
--/
--
--DECLARE
--    
--    TYPE dept_tab_type IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
--    
--    dept_tab dept_tab_type;
--   
--    
--BEGIN
--
--    SELECT * BULK COLLECT INTO dept_tab 
--    FROM dept;
--    
--    FOR i IN 1..dept_tab.count LOOP
--         DBMS_OUTPUT.PUT_LINE(dept_tab(i).dname);
--    END LOOP;
--    
--END;
--/
--
--
--조건제어 - 분기 (if)
--구문 
--IF condition THEN
--    실행할 문장
--ELSIF condition THEN
--    실행할 문장
--ELSE
--    실행할 문장
--END IF;
--
--
--
--DECLARE
--    p NUMBER := 2;
--BEGIN
--    IF p = 1 THEN
--        DBMS_OUTPUT.PUT_LINE('p=1');
--    ELSIF P = 2 THEN
--        DBMS_OUTPUT.PUT_LINE('p=2');
--    ELSE
--        DBMS_OUTPUT.PUT_LINE('ELSE');
--    END IF;
--END;
--/
--
--FOR LOOP
--문법
--FOR 인덱스 변수 IN [REVERSE] 시작 값.. 종료 값 LOOP
--    반복실행할 문장;
--END LOOP
--
--DECLARE
--BEGIN
--    FOR i  IN 2..9 LOOP
--      FOR j in 1..9 LOOP
--         DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' || i * j);
--      END LOOP;
--    END LOOP;
--END;
--/
-- 
--while 
--문법
--    while 조건 loop 
--        반복할 문장
--    END LOOP
--1 * 5
--DECLARE
--    i NUMBER := 0;
--    sum NUMBER := 0;
--BEGIN 
--    WHILE i <= 5 LOOP
--        DBMS_OUTPUT.PUT_LINE(sum);
--        sum := sum + i;
--END LOOP;
--END;
--/
--
--
--LOOP 
--    문법
--    LOOP
--        반복 실행할 문장;
--        EXIT 탈출조건
--        반복 실행할 문장;
--    END LOOP;
--
--DECLARE
--    i NUMBER := 0;
--BEGIN
--    LOOP
--        EXIT WHEN i > 5;
--        DBMS_OUTPUT.PUT_LINE(i);
--        i := i + 1;
--    END LOOP;    
--END;
--
--SELECT * BULK
--
--
--CURSOR : SELECT 문이 실행되는 메모리 상의 공간
--    다량의 데이터를 변수에 담게되면 메모리 낭비가 심해져 프로그램이 
--    정상적으로 동작 못할 수도 있음.
--    
--    한번에 모든 데이터를 인출하지 않고, 개발자가 직접 인출 단계를 제어 함으로써
--    변수에 모든 데이터를 담지 않고도 개발하는 것이 가능
--
--CURSOR의 종류
--묵시적 커서 : 커서이름을 별도로 지정하지 않을 경우 ==> ORACLE이 알아서 처리해줌
--명시적 커서 : 커서를 명시적 이름과 함께 선언하고, 개발자가 해당 커서를 직접 제어 가능;

--명시적 CURSOR 사용방법
--1.커서선언 DECLARE
--    CURSOR 커서 이름 IS
--        SELECT 쿼리;
--2.커서 열기 ;
--    OPEN 커서이름;
--3.FETCH (인출)
--    FETCH 커서이름 INTO 변수
--4.커서 닫기
--    CLOSE 커서이름;
--    
--dept 테이블의 모든 행에 대해 부서번호, 부서이름을 cursor를 통해 데이터를 다루는 실습;

DECLARE
    CURSOR dept_cur  IS 
        SELECT deptno,dname
        from dept;
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    OPEN dept_cur;
    
    LOOP
        FETCH dept_cur INTO v_deptno, v_dname;
        EXIT WHEN dept_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_deptno || ', ' || v_dname);
    END LOOP;    
END;

--CURSOR의 경우 반복문과 사용되는 일이 많기 때문에
--PL/SQL에서는 FOR LOOP 문과 함께 사용하는 문법을 지원한다
--문법
--    FOR 레코드명 IN 커서명 LOOP
--        반복실행할 문장;
--    END LOOP
--open, fetch, close : 2~4단계 - for LOOP에서 해결
    
DECLARE
    CURSOR dept_cur IS 
        SELECT deptno,dname
        from dept;
BEGIN
    FOR dept_row IN dept_cur LOOP
        DBMS_OUTPUT.PUT_LINE(dept_row.deptno || ', ' || dept_row.dname);
    END LOOP;    
END;


emp 테이블에서 특정 부서에 속하는 사원의 사번과, 이름을 출력하는 로직을
파라미터가 있는 커서를 활용 하여 작성하는 실습;
DECLARE
    CURSOR emp_cur (p_deptno dept.deptno%TYPE) IS
        SELECT empno,ename
        from emp
        where deptno = p_deptno;
BEGIN
    FOR emp_row IN emp_cur(30) LOOP
        DBMS_OUTPUT.PUT_LINE(emp_row.empno || ', ' || emp_row.ename);
    END LOOP;
END;
/

인라인 뷰
인라인 커서
FOR LOOP 기술서 커서를 직접 기술

여러행의 데이터를 가져오는 방법 2가지
1.테이블 타입 변수에 우리가 필요로 하는 전체 테이블의 데이터를 전부 담아서 처리
2.cursor : 선언 - open - fetch 1건씩 - close
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE avgdt IS
    TYPE t_dt IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt t_dt;
    dffsum NUMBER:= 0;
BEGIN 
    SELECT * BULK COLLECT INTO V_DT
    FROM DT;
    
    FOR i IN  1..v_dt.COUNT - 1 LOOP
        dffsum := dffsum + v_dt(i).dt - v_dt(i + 1).dt;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('V_DIFFSUM : ' || v_diffsum);
END;
/

CREATE TABLE DT AS
SELECT SYSDATE DT FROM DUAL UNION ALL
SELECT SYSDATE - 5 FROM DUAL UNION ALL
SELECT SYSDATE - 10 FROM DUAL UNION ALL
SELECT SYSDATE - 15 FROM DUAL UNION ALL
SELECT SYSDATE - 20 FROM DUAL UNION ALL
SELECT SYSDATE - 25 FROM DUAL UNION ALL
SELECT SYSDATE - 30 FROM DUAL UNION ALL
SELECT SYSDATE - 35 FROM DUAL;

SELECT *
FROM DT;



SELECT DT,
       LEAD(DT) OVER(ORDER BY DT DESC) LEAD_DT,
        DT - LEAD(DT) OVER(ORDER BY DT DESC) LEAD_DT
FROM DT;
SELECT AVG(DIFF)
FROM
(SELECT DT - LEAD(DT) OVER(ORDER BY DT DESC) DIFF
FROM DT);


SELECT MAX(DT), MIN(DT),MAX(DT)-MIN(DT) /(COUNT(*) -1)
FROM DT;

PL /SQL FUNCTION : JAVA METHOD
정해진 작업을 한 후 결과를 돌려주는 PL/SQL BLOCK;

CREATE OR REPLACE  FUNCTION 함수명 {[파라미터]} RETURN TYPE IS
BEGIN
END;
/

RETURN TYPE : 명시할 때 SIZE 정보는 명시하지 않음
VARCHAR2(2000) x ==> VARCHAR2

사번을 입력 받아서 (파라미터) 해당 사원의 이름을 반환하는 함수 getEmpName 생성

CREATE OR REPLACE FUNCTION getEmpName (p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
        v_ename emp.ename%TYPE;
    BEGIN
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno = P_empno;
        
        RETURN v_ename;
    END;
END;
/
function : getdeptname 작성
파라미터 : 부서번호
리턴값 :파라미터로 들어온 부서번호의 부서이름

CREATE OR REPLACE FUNCTION getdeptname (p_deptno dept.deptno%TYPE) RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = P_deptno;
    
    RETURN v_dname;
END;


select getdeptname(deptno)
from dept;

package 패키지 : 연관된 PL/SQL 블럭을 관리하는 객체
대표적인 오라클 내장 패키지 : DBMS_OUTPUT.
1.선언부       : interface
CREATE OF REPLACE PACKAGE 패키지명 AS
    FUNCTION 함수이름(인자) RETURN 반환타입;
END 패키지명;
/
getempname, getdeptname
names라는 이름의 패키지를 생성하여 등록

1.패키지 선언부 생성
CREATE OR REPLACE PACKAGE NAMES AS
    FUNCTION getempname (p_empno emp.empno%TYPE) RETURN VARCHAR2;
    FUNCTION getdeptname (p_deptno dept.deptno%TYPE) RETURN VARCHAR2;
END names;
/
2.패키지 바디 새성
CREATE OR REPLACE PACKAGE BODY names AS
        FUNCTION getEmpName (p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
        v_ename emp.ename%TYPE;
    BEGIN
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno = P_empno;
        
        RETURN v_ename;
    END;
    FUNCTION getdeptname (p_deptno dept.deptno%TYPE) RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = P_deptno;
    
    RETURN v_dname;
END;
END;
/

TRIGGER : 방아쇠

이벤트 핸들러 : 이벤트를 다루는 녀석

web = 클릭, 스크롤, 키 입력
dbms : 특정 테이블에 데이터 신규입력, 기존 데이터 변경, 기존 데이터 삭제
    ==> 후속작업

트리거 : 설정한 이벤트에 따라 자동으로 실행되는 PL/SQL 블럭
        이벤트 종류 : 데이터 신규입력, 기존 데이터 삭제, 기존 데이터 변경
        
시나리오 : users 테이블의 pass 컬럼(비밀번호)이 존재
         특정 쿼리에 의해 users테이블의 pass 커럼이 변경이되면
         users_history 테이블에 변경전 pass 값을 트리거를 통해 저장

1.users_hisory 테이블 생성
create table users_history as
    select userid, pass, sysdate reg_dt
    from users
    where 1 = 2;
    
DESC users_history;

users 테이블의 변경을 감지하여 실행할 트리거를 생성
감지 항목 : users 테이블의 pass 컬럼이 변경이 되었을때
감지시 실행 로직 : 변경 전 pass 값을 users_history에 저장

CREATE OR REPLACE TRIGGER make_history
    BEFORE UPDATE ON users
    FOR EACH ROW
    
    BEGIN
    /*-- users 테이블의 특정 행이 update가 되었을 경우 시행
        :OLD.컬럼명 ==> 기존 값
        :NEW.컬럼명 ==> 갱신 값*/
        IF :OLD.pass != :NEW.pass THEN
            INSERT INTO users_history VALUES(:OLD.userid, :OLD.pass,SYSDATE);
        END IF;    
    END;
    /
    
SELECT *
FROM USERS;

트리거와 무관한 컬럼을 변경할 시 테스트
UPDATE users SET usernm = 'brown'
WHERE userid = 'brown'

SELECT *
FROM USERS_HISTORY;

UPDATE USERS SET pass = '1234'
WHERE userid = 'brown';

실무 
신규개발 : 좋아함 
          빨리 개발 하는 것이 가능
유지보수 : 안좋아함
         유지보수적인 면에서는 문서화가 잘 안되어 있을 경우 코드 동작에 대한 이해가
         힘들어짐
         
         
EXCEPTION
 JAVA : EXCEPTION, ERROR
        - CHECKED EXCEPTION : 반드시 예외처리를 해야하는 예외
        - UNCHECKED EXCEPTION : 예외처리를 안해도 되는 예외
        
PL/SQL : PL/SQL 블럭이 실행되는 동안 발생하는 에러
예외의 종류

1.사전 정의 예외 (PREDEFINED ORACLE EXCEPTION).
0
  . JAVA ARITHMATIC EXCEPTION
  . 오라클이 사전에 정의한 상황에서 발생하는 예외
  
2.사용자 정의 예외
 .변수 커서처럼 PL/SQL 블록의 선언부에게 개발자가 직접 선언한 예외
  RAISE 키워드를 통해 개발자가 직접 예외를 던진다
  (JAVA : THROW NEW RuntimeEXCEPTION();)
  PL/SQL 블록에서 예외가 발생하면...
  예외가 발생된 지점에서 코드 중단(에러)
  
  단 PL/SQL 블록에서 예외처리 부분이 존재하면 (EXCEPTION 절)
  EXCEPTION 절에 기술한 코드가 실행
          