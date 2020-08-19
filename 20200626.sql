DECODE(MOD(TO_CHAR(REG_DT,'YYYY'),1),
               MOD(TO_CHAR(SYSDATE,'YYYY'),1),'건강검진대상자')hospital

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT * 
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;


expression: 컬럼값을 가공을 하거나, 존재하지 않는 새로운 상수값(정해진 값)을 표현
            연산을 통해 새로운 컬럼을 조회할 수 있다.
            연산을 하더라도 해당 sql 조회 결과에만 나올 뿐이고 실제 테이블의 데이터에는
            영향을 주지 않는다
            SELECT 구분은 테이블의 데이터에 영향을 주지 않음;
        


SELECT sal, sal + 500 , sal - 500 , sal/5 , sal*5 , 500
FROM emp;

날짜에 사칙연산 : 수학적으로 정의가 되어 있지 않음
SQL에서는 날짜데이터 +-정수  =>> 정수를 일수 취급
'2020년 6월 25일' + 5 : 2020년 6월 25일부터 5일 이후 날짜
'2020년 6월 25일' - 5 : 2020년 6월 25일부터 5일 이전 날짜

데이터 베이스에서 주로 사용하는 데이터 타입 숫자, 문자, 날짜

empno : 숫자
ename : 문자
job : 문자
mgt : 숫자
hiredate : 날짜
sal : 숫자
comm : 숫자
deptno : 숫자

테이블의 컬럼구성 정보 확인 :
DESC 테이블명 (DESCRIBE 테이블명)

DESC emp;

SELECT *
FROM dept;

파일시스템과 다른점 파일시스템에서는 비어있는 정보가 있어도 저장되지만 sql에서는 정보가 비어있으면 저장되지 않음

SELECT hiredate, hiredate + 5, hiredate - 5
FROM emp;

*users 테이블의 컬럼 타입을 확인하고 
reg_dt 컬럼 값의 5일 뒤 날짜를 새로운 컬럼으로 표현
조회 컬럼 : userid, reg_dt, reg_dt의 5일 뒤 날짜

DESC users;

SELECT userid, reg_dt, reg_dt + 5
FROM users;

NULL : 아직 모르는 값, 할당되지 않은 값
NULL과 숫자타입의 0은 다르다
NULL과 문자타입의 공백은 다르다

NULL의 중요한 특징
NULL을 피연산자로 하는 연산의 결과는 항상 NULL
ex : NULL + 500 = NULL

emp테이블에서 sal 컬럼과 com칼럼의 합을 새로운 칼럼으로 표현
조회 칼럽은 :emnpo, ename, sal, com ,sal 칼럼과 com칼럼의 합
ALIAS : 컬럼이나 expreastion에 새로운 이름을 부여
별칭을 소문자로 적용 하고 싶은 경우 : 별칭명을 더블 쿼테이션으로 묶는다
적용방법 : 컬럼, EXPENSTION[AS] 별칭명
SELECT empno,sal s, comm AS,sal + comm 
FROM emp;

SELECT prod_id AS id, prod_name AS name
FROM PROD;

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS 바이어아이디, buyer_name AS 이름
FROM buyer;

literal : 값 자체
literal  표기법 : 값을 표현하는 방법
         java : "test"
         sql : 'test'

번외 
int small = 10;
java 대입 연산자 :  =
pl/sql 대입연산자 : :=
언어마다 연산자 표기 literal 표기법이 다르기 때문에 해당 언어에서 지정하는 방시을 잘 따라야 한다


문자열 연산 : 결합
일상생활에서 문자열 결합 연산자가 존재??
java 문자열 연산
Systme.out.println("안녕하세요" + name + "입니다");

sql에서 문자열 결합 연산자 : ||
uesrs 테이블의 userid 칼럼과 username을 결합

sql에서 문자열 결합 함수 : CONCAT : (문자열1, 문자열2) ==> 문자열1 || 문자열2
                        두개으 문자열을 인자로 받아서 결합 결과를 리턴
SELECT userid, usernm, userid || usernm, CONCAT(userid,usernm) concat_id_name
FROM users;

임의 문자열 결합 : (sal + 500, '아이디 : ' || userid)

SELECT '아이디: ' || userid, 500, 'test'
FROM users;

SELECT *
FROM user_tables;

SELECT 'SELECT * table_name ' || table_name || ';',
        concat('SELECT * FROM ', table_name || ';')
FROM user_Tables;

SELECT concat(concat('SELECT * FROM ', table_name), ';')
        
FROM user_tables;
where : 테이블에서 조회할 행의 조건을 기술
        where 절에 기술한 조건이 참일 때 해당 행을 조회한다.
        sql에서 가장 어려운 부분, 많은 응용이 발생하는 부분


SELECT *
FROM users;

SELECT *
FROM users;
where userid = 'brown';

SELECT *
FROM emp;
where 1 = 1;

date 타입에 대한 where절 조건 기술
emp 테이블에서 hiredate 같이 1982년 1월 1일 사원들만 조희
'12/1/01' ==> 라는 조건 값을 구했을 때 한국과 미국의 해석이 다르기 때문에 위 표기는 사용하지 않음
DATE 리터럴 보다는 문자열을 DATA 타입으로 변경해주는 함수를 사용

SELECT *
FROM emp
where hiredate >= '82/01/01';

SELECT *
FROM emp
where HIREDATE >= TO_DATE('1980/01/01','YYYY/MM/DD');


BETWEEN AND : 두 값 사이에 위치한 값을 참으로 인식
사용방법 : 비교값 BETWEEN  시작값 and 종료값;
비교값이 시작값과 종료값을 포함하여 사이에 있으면 참으로 인식

emp테이블에서 sal 값 1000보다 크거나 

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal > 1000 AND sal < 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '1982/01/01' AND '1983/01/01';
WHERE ename BETWEEN '1982/01/01' AND '1983/01/01';

SELECT ename, hiredate
FROM emp
WHERE hiredate > '1982/01/01' AND hiredate <  '1983/01/01';
WHERE ename > '1982/01/01' AND ename <  '1983/01/01';

SELECT *
FROM emp
WHERE deptno = 10
  AND deptno = 20;
    
SELECT *
FROM emp
WHERE deptno = 10
    OR deptno = 20;

IN 연산자 : 비교값이 나열된 값에 포함될 때 참으로 인식
사용방법 : 비교값 IN (비교대상값1,비교대상값2,비교대상값3)

SELECT *
FROM emp
where deptno IN(10,20);

SELECT *
FROM users 
WHERE userid IN('brown','cony','sally');

NULL : 아직 모르는 값, 아직 정해지지 않은 값
    1.NULL과 숫자 타입 0은 다르다
    2.NULL과 문자 타입 ''은 다르다 
    3.NULL값을 포함한 연산의 결과는 NULL : 필요한 경우 NULL 값을 다른값으로 치환
    
ALLAS  : 별칭, 칼럼 혹은 expreesion에 다른 이름을 부여
         칼럼 : expresasion [AS] 별칭명
         별칭을 작성 할 때 주의점
         1. 공백이 들어가면 안됌
         
리터럴 : 값 그 자체
리터럴 표기법 : 리터럴을 표기하는 방법 ==> 언어마다 다르기 때문
test 라는 문자형(리터럴) 표기 방법
java = "test"
sql = 'test'

where : 테이블에서 조회할 형의 조건을 기술
        절에서 사용가능한 연산자 : -, !=, <> , >= , <= , > , <
        BETWEEN AND 값이 특정 범위에 포함되는지 ==> >= <= 을 사용하여 표현 가능
        IN : 특징 값이 나열된 리스트에 포함되는지 검사 ==> or 연산자로 대체
        
사용용도 : 문자의 일부분으로 검색을 하고 싶을 떄 사용
ex : ename 카럼의 값이 a로 시작하는 사원들을 조회
사용방법 : 칼럼 Like '패턴문자열'
마스컴 문자열 : 1. #문자가 없거나 어떤 문자든 여러개의 문자열
              2. _ : 어떤 문자든 딱 하나의 문자를 의미
                 'S#' : S로 시작하고  두번째 문자열이 어떤 문자든 하나의 문자고 오는 2자리 문자열 #와 다르게 어떤 문자든 하나는 와야함.
                 's____':로 시작하고 전체 문자열으 길이가 5글자인 문자열
                 
emp테이블에서 ename 칼럼의 값이 s로 시작하는 사원들만 조회

SELECT *
FROM emp
Where ename LIKE 'S#';

SELECT mem_id, mem_name
FROM member
WHERE  mem_name LIKE '신__';

SELECT mem_id, mem_name
FROM member
Where mem_name LIKE '이__';

UPDATE member set mem_name =  '쁜이'
WHERE mem_id = 'b001';

SELECT mem_id, mem_name
FROM member
Where mem_name LIKE '%이%';

UPDATE member set mem_name =  '신이환'
WHERE mem_id = 'p001';

SELECT mem_id, mem_name
FROM member
Where mem_name LIKE '%이%';

SELECT mem_id, mem_name
FROM member
Where mem_name LIKE '김__';

NULL 비교 : = 연산자로 비교 불가 ==> IS
NULL을 = 비교하여 조회

comm 칼럼의 값이 null인 사람들만 조회
SELECT empno,ename, comm 
FROM emp
WHERE comm = null;

NULL 값 비교

SELECT empno,ename, comm 
FROM emp
WHERE comm IS NULL;

emp테이블에서 comm 값이 널이 아닌 데이터를 조회
SELECT empno,ename, comm 
FROM emp
WHERE comm IS NOT NULL;


논리연산 : AND OR NOT

AND : 모든 식이 참일때
OR : 식중 하나라도 참 일때
NOT : 부정

SELECT *
FROM emp
WHERE mgr = 7698 AND sal > 1000;

SELECT *
FROM emp
WHERE mgr = 7698 or sal > 1000;

SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839,null);

mgr IN(7698.7839,NULL)에 포함된다
mgr NOT IN(7698,7839,NULL); ==> mgr = 7698 AND mgr = 7839 AND mgr != NULL
mgr 칼럼에 null 값이 있을 경우 비교 연산으로 null 비교가 불가하기 때문에
null을 갖는 행은 무시가 된다

실습 7
SELECT *
FROM emp
WHERE job IN ('SALESMAN') AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

실습 8
SELECT *
FROM emp
WHERE  deptno != 10 AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

실습 9
SELECT *
FROM emp
WHERE  deptno NOT IN 10 AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

실습 10
SELECT *
FROM emp
WHERE  deptno IN (20,30) AND HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

실습 11
SELECT *
FROM emp
WHERE job IN ('SALESMAN') OR HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

실습 12
SELECT *
FROM emp
WHERE job IN ('SALESMAN') OR EMPNO Like '78%';

실습 13
SELECT *
FROM emp
WHERE job IN ('SALESMAN') OR EMPNO >= 7800 AND EMPNO < 7900;

실습 14
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR EMPNO > 7800 AND EMPNO <7900 AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

SELECT *
FROM emp
WHERE job IN ('SALESMAN') OR EMPNO LIKE '78%' AND  HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD'); 


1 SELECT 
2 FROM
3 WHERE

오라클에서 실행 순서 : FROM > WHERE > SELECT

정렬
RDBMS 집합적인 사상을 따른다.
집합에는 순서가 없다 (1, 3, 5) == (3, 5 , 1)
집합에는 중복이 없다 (1, 3, 5, 1) == (3, 5 , 1)

데이터정렬(ORDER BY)

ORDER BY
    ASC : 오름차순(기본)
    DESC : 내림차순
    
SELECT *
FROM emp
ORDER BY ename , mgr;

ORDER BY 컬럼뒤에 ASC : DESC 을 기술하여 오름차순 내림차순을 지정할 수 있다
1.ORDER BY 칼럼
2.ORDER BY 별칭
3.ORDER BY SELECT 절에 나열된 컬럼으 인덱스번호

SELECT EMPNO, ENAME, SAL * 12 SALARY
FROM EMP
ORDER BY SALARY;

실습 1
SELECT *
FROM dept
ORDER BY dname;
SELECT *
FROM dept
ORDER BY dname DESC;

실습2
SELECT *
FROM emp
WHERE comm > 0 
ORDER BY comm desc, empno desc;

실습3
SELECT *
FROM emp
WHERE  mgr IS NOT NULL
ORDER BY job , EMPNO DESC ;

실습4
SELECT *
FROM emp
WHERE  deptno != 20 AND sal > 1500
ORDER BY ename desc;

ROWNUM : SELECT 순서대로 형 변호를 부여해주는 가상 컬럼.
특징 : WHERE 절에서 사용 가능.
    *** 사용할수 있는 형태가 정해져 있음 :
            WHERE ROWNUM = 1
            WHERE ROWNUM <= n
            WHERE ROWNUM < n
            BETWEEN 1 AND 10
        사용되지 않는 형태 : 
            WHERE ROWNUM = 2
            WHERE ROWNUM > 10
ROWNUM 사용 용도 : 페이징 처리
페이징 처리 : 네이버 카페에서 게시글 리스트를 한화면에 제한적인 갯수로 조회(100)
            카페에 전체 게시글 수는 굉장히 많음
            ==> 한 화면에 못보여줌, 웹브라우저 속도저하 사용자의 사용성이 굉장히 불편
            ==> 한 페이지당 건수를 정해놓고 해당 건수만큼만 조회해서 화면에 보여준다

ROWNUM 과 ORDER BY : 
SELECT SQL의 실행순서 : FROM => WHERE => SELECT => ORDER BY

ROWNUM : 결과를 정렬 이후에 반영 하고 싶은 경우 ==> IN-LINE-VIEW
VIEW : SQL - DBMS 저장되어 있는 SQL
IN-LINE : 직접 기술 했다 어딘가 저장을 한게 아니라 그 자리에 직접 기술

SELECT ROWNUM, empno, ename
FROM emp;

SELECT절에 *만 단독으로 사용하지 않고 콤마를 통해
다른 임의 칼럼ㅇ나 expression을 표기한 경우 * 앞에 어떤 테이블 에서 온것인지
한정자 (테이블 이름, view 이름)을 붙여줘야 한다

table, view 별첨 : table이나 view에도 SELECT 절의 컬럼처럼 별칭을 부여 할 수 없다
                  단 SELECT 절처럼 AS 키워드는 사용하지 않는다
                   EX : SELECT ROWNUM, a.*
                        FROM(SELECT empno,ename 
                            FROM emp 
                            ORDER BY ename) a;
                            
요구사항 : 1 페이지당 10건의 사원 리스트가 보여야된다
1.page : 1 - 10

2.page : 11 - 20

3.page : 21 - 30
- ((n-1)*10)+ 1 ~ n * 10

ROWNUM의 특성으로 1번부터 읽지 않는 형태이기 때문에 정상적으로 동작하지 않는다

ROWNUM의 값을 별칭을 통해 새로운 컬럼으로 만들고 항 SELECT sql을 in-line view로
      만들어 오부에서 ROWNUM에 부여한 별칭을 통해 페이징 처리를 한다

sql 바인딩 변수 : java 변수
페이지 번호 : page
페이지 사이즈 : pagesize
sql 바인딩 변수 표기 : 변수명 --> : page * pagsize

바인딩 변수 적용 (:page - 1) * :pagsize + 1 - :page *: pageSize

SELECT *
FROM(SELECT ROWNUM rn, a. * 
FROM(SELECT empno,ename 
        FROM emp)a)
     WHERE rn BETWEEN (:page - 1) * :pagsize + 1 AND :page *:pageSize;
     
실습 1
SELECT *
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

실습 2
SELECT * 
FROM(SELECT ROWNUM NUM, a. * 
FROM(SELECT empno,ename 
        FROM emp)a)
WHERE NUM BETWEEN 11 AND 20;

실습 3 
SELECT * 
FROM(SELECT ROWNUM NUM, a. * 
FROM(SELECT empno,ename 
        FROM emp
        ORDER BY ename)a)
WHERE NUM BETWEEN 11 AND 20;


======================함수============================

Function : 입력을 받아들여 특정 로직을 수행 후 결과 값을 반환하는 객체
           오라클에서 함수 구분 : 입력되는 행의 수에 따라
           1.Single row Function:
             하나의 행이 입력도서 결과로 하나의 행이 나온다.
           2.Multi row Function
            여러개의 해이 입력되서  결과로 하나으 행이 나온다.
Dual: 오라클의 sys 계정에 존재하는 하나의 행,
      하나의 칼럼을 갖는 테이블
      누구나 사용할 수 있도록 권한이 개방됌

문자열 함수 : 
LOWER(문자열을 소문자로) UPPER(문자열을 대문자로) INITCAP('Test')
CONCAT(문자열 결합)  SUBSTR(문자열에서 일부분 추출) LENGTH(문자열 길이)
INSTR(문자여에 특정 문자열이 들어있는지 확인후 해당 문자열 인덱스 반환)
LAPD/RPAD(문자열의 왼쪽 오른쪽에 특정 문자열 삽입)
TRIM(문자열 앞뒤로 공백, 혹은 특정 문자 제거)
REPLACE(문자열 치환)

Dual: 테이블 용도
1.함수 실행(테스트)
2.서퀸스 실행
3.merge 구분
4.데이터 복제

SELECT CONCAT('HELLO',CONCAT(',', 'WORLD')) "CONCAT",
       SUBSTR('HELLO, WORLD', 1, 5) "SUBSTR",
       LENGTH('HELLO, WROLD') "LENGTH",
       INSTR('HELLO, WROLD', 'O') "INSTR",
       LPAD('HELLO, WORLD', 15, '*') "LPAD",
       LPAD(' ', 15) "LPAD2",
       RPAD('HELLO, WORLD', 15, '*') "RPAD",
       REPLACE('HELLO, WORLD', 'O','P') "REPLACE",
       TRIM('   HELLO, WORLD    ') "AFTER_TRIM",
       LOWER('ABC'),
       UPPER('abc'),
       INITCAP('aBC')
FROM DUAL;

함수는 WHERE 절에서 사용 가능
SELECT *
FROM emp
WHERE ename = UPPER('smith');
SELECT *
FROM emp
WHERE lower(ename) = 'smith';

위 두개에 쿼리중에서 하지 말아야 할 형태
좌변을 가공하는 형태

오라클 숫자 관련 함수
ROUND(숫자, 반올림 기준자리) : 반올림 함수
TRUNC(숫자, 내림 기준자리) : 내림 함수
MOD(피제수, 제수) : 나머지 값을 구하는 함수

SELECT ROUND(105.54, 1),
       ROUND(105.54, 2),
       ROUND(105.54, 0),
       ROUND(105.54, -1)
FROM DUAL;

SELECT TRUNC(105.54, 1),
       TRUNC(105.54, 2),
       TRUNC(105.54, 0),
       TRUNC(105.54, -1)
FROM DUAL;

SELECT ename, sal ,TRUNC(sal / 1000, 0), MOD (sal,1000) reminder
FROM emp;

SYSDATE : 오라클에서 제공해는 특수 함수
1.인자가 없다
2.오라클이 설치된 서버의 현재 년,월,일,시,분,초 정보를 반환 해주는 함수

날짜타입 +- 정수 : 정수를 일자 추급, 정수만큼 미래, 혹은 과거 날짜의 데이트 값을 반환

SELECT SYSDATE + (1/24/60 * 30)
FROM dual;
데이터 표현하는 바법
1. 데이터 리터럴 : NSL_SESSION_PARATER 성장에 따르기 때문에 DBMS 환경 마다 다르게 인식될 수 있음
실습 1
SELECT TO_DATE('2019/12/31') LASTDAY,
       TO_DATE('2019/12/31')-5 LASTDAY_BEFORE,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE
FROM DUAL;

실습 2
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') DT_DASH,
       TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MM:SS') DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE, 'DD/MM/YYYY') DT_DD_MM_YYYY
FROM DUAL;

SELECT * 
FROM emp
WHERE ROWNUM BETWEEN 1 AND 5;

날짜관련 오라클 내장함수
내장함수 : 탑재가 되어있다
         오라클에서 제공해주는 함수 (많이 사용하기 때문에 개발자가 별도로 개발하지 않도록)
         
(활용도:★)MONTHS_BETWEEN(DATE1,DATE2) : 두 날짜 사이의 개월 수를 변환
(활용도:★★★★★)ADD_MONTHS(DATE,NUMBER) : NUMBER개월 이후의 날짜
(활용도:★★★)NEXT_DAY(DATE) : 주간요일(1~7) : DATE 이후에 등장하는 첫 번째 
                                             주간요일의 날짜변환 : 2020/06/30,6 ==> 2020/07/03
(활용도:★★★)LAST_DAY(DATE) : DATE가 속한 월의 마지막 날짜 2020/06/05 ==> 2020/06/30
                          모든 달의 첫 번째 날은 1일로 정해져 있지만 달의 마지막 날짜는
                          다른 경우가 있다 윤년의 경우 2월달이 29일이다.

SELECT ename, TO_CHAR(hiredate, 'yyyy/mm/dd') hiredate,
       MONTHS_BETWEEN(SYSDATE,hiredate)
FROM emp;   

SELECT ADD_MONTHS(SYSDATE,5) AFT5,ADD_MONTHS (SYSDATE,-5)
FROM  DUAL;

NEXT_DAY : 해당 날짜 이후에 등장하는 첫번째 주간요일의 날씨
SYSDATE : 2020/06/30일 이후에 등장 하는 첫번째 토요일은 몇일인가?

SELECT NEXT_DAY(SYSDATE,7)
FROM DUAL;

LAST_DAY : 해당 일자가 속한 월의 마지막 일자를 변환
SELECT LAST_DAY(TO_DATE('2020/06/05', 'YYYY/MM/DD')) 
FROM DUAL;




LAST_DAY는 있는데 FIRST_DAY는 없다 ==> 모든 월의 첫번째 날짜는 1일이기 때문에
FIRST_DAY 구현 방법
SYSDATE : 2020/06/30 ==>2020/06/01

1.SYSDATE를 문자로 변경한후 포맷은 YYYY/MM으로 설정 해준다
2.1번에 결과에다가 문자열 결합을 통해 '01' 문자를 뒤에 붙여준다 YYYY/MM/DD
3.2번의 결과를 날짜 타입으로 변경

SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM') || '/01','YYYY/MM/DD') First_Day
FROM DUAL;

실습 3
SELECT '201912' PARAM,
        TO_CHAR(LAST_DAY('2019/12/01'),'dd') DT,
       '201911' PARAM,
        TO_CHAR(LAST_DAY('2019/11/01'),'dd') DT,
       '201602' PARAM,
        TO_CHAR(LAST_DAY('2016/02/01'),'dd') DT
FROM DUAL;

실행계획 : DBMS가 요청받은 SQL을 처리하기 위해 세운 절차
       : SQL 자체에는 로직이 없다. 
       
실행계획 보는 방법 :
1.실행계획을 생성
EXPLAIN PLAN FOR
실행계획을 보고자 하는 SQL

2.실행계획을 보는 단계
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

EMPNO 칼럼은 NUMBER  타입이지만 형변환이 어떻게 일어 났는지 확인하기 위해서
의도적으로 문자열 상수 비교를 진행
EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE EMPNO = '7369';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
 실행계획을 읽는 방법 : 
 1.위에서 아래로
 2.단 자식 노드가 있으면 자식 노드 부터 읽는다
   자식노드 : 들여쓰기가 된 노드

   
EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE TO_CHAR(empno) = '7369';
SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE TO_CHAR(empno) = 7300 +'69';
SELECT *
FROM TABLE(dbms_xplan.display);

6,000,000 <===> 6000000

국제화 : i18n
날짜 국가별로 형식이 다르다
한국: yyyy/mm/dd
미국: mm/dd/yyyy

숫자 
한국 : 9,000,000.00
독일 : 9.000.000,00

SAL (NUMBER) 칼럼의 값을 문자열 포맷팅 적용
SELECT ENAME, SAL, TO_NUMBER(TO_CHAR(SAL, 'L9,999.00'),'L9,999.00')
FROM EMP;

NULL과 관련된 함수 : NULL값을 다른 값으로 치환 하거나, 혹은 강제로  NULL을 만드는 것

1.NVL(EXPR1,EXPR2)
  : if(expr1 == null)
        expr2 반환
    else
        expr1 반환
 
  
SELECT empno, sal,comm, NVL(comm, 0),
       sal + comm, sal + nvl(comm,0)
FROM EMP;
=> 커미션값이 0이면 null 아니면 원래 값을 반환

2.NVL2(EXPR1,EXPR2,EXPR3)

if(expr1 != null)
    expr2 반환
else
    expr3 반환
    


SELECT empno, sal,comm, NVL2(comm,comm,0),
       sal + comm, sal + nvl2(comm,comm + sal,sal)
FROM EMP;    
3.NULLIF(EXPR1,EXPR2)

if(expt1 = expt2)
    null을 반환
else
    epxt1을 반환

SELECT ename, sal, comm, nullif(sal,3000)
FROM emp;

4.COALESCE(EXPR1,EXPR2.....)
: 인자중에 가장 처음으로 null 값이 아닌 값을 갖는 인자를 변환

SELECT COALESCE(NULL,NULL,30,NULL,50) 
FROM DUAL;
if(expt1 != expt2)
    expt1을 반환
else
    coalesce(expr2,.....)

INSERT INTO EMP (EMPNO,ENAME,HIREDATE) VALUES(9999,'brown',NULL);

SELECT ENAME, MGR,MGR , HIREDATE,
FROM EMP;

SELECT ENAME,MGR, NVL(MGR,111),
       HIREDATE, NVL(HIREDATE,SYSDATE)
FROM EMP;    

SELECT ENAME,MGR, NVL2(MGR,MGR,111), 
       HIREDATE, NVL2(HIREDATE,HIREDATE,SYSDATE)
FROM EMP;



실습 4
SELECT empno,ename,mgr, NVL(mgr,9999) MGR_N,NVL2(MGR,mgr,9999) MGR_N_1, COALESCE(mgr,9999)MGR_N_2
FROM EMP;

실습 5
SELECT USERID,USERNM,TO_CHAR(REG_DT,'YY/MM/DD'), NVL(REG_DT,SYSDATE)
FROM USERS
WHERE USERID != 'brown';

SQL, 조건문
CASE
    WHEN 조건문(참 거짓을 판단할 수 있는 문장) THEN  변환할 값
    WHEN 조건문(참 거짓을 판단할 수 있는 문장) THEN  변환할 값1
    WHEN 조건문(참 거짓을 판단할 수 있는 문장) THEN  변환할 값2
    ELSE 모든 WHEN절을 만족시키지 못할때 변환할 기본 값
EMP ==> 하나의 칼럼으로 취급 

EMP테이블에 저장된 JOB 컬럼의 값을 기준으로 급여를 인상
SAL칼럼과 함께 인상딘 SAL 컬럼의 값을 비교하고 싶은 상황
JOB = SALESMAN SAL * 1.05
JOB = MANAGER SAL * 1.10
JOB = PRESIDENT SAL * 1.20
나머지 기타 직군은 SAL로 유지

SELECT EMPNO, ENAME, DEPTNO,
        CASE
            WHEN DEPTNO = 10 THEN 'ACCOUNTING'
            WHEN DEPTNO = 20 THEN 'RESEARCH'
            WHEN DEPTNO = 30 THEN 'SALES'
            WHEN DEPTNO = 40 THEN 'PERATIONCS'
            ELSE 'DDIT'
            END DNAME
FROM EMP;      

DECODE : 조건에 따라 반환 값이 달라지는 함수
        ==> 비교, JAVA if, sql - case와 ㅂ슷
            단 비교연산이 ( = )만 가능
            case의 when절에 기술할 수 있는 코드는 참 거짓 판단 할 수 있는 코드만 가능
            ex : sal > 1000
            이것과 다르게 decode 함수에서는 sal = 1000, sal = 2000
            
DECODE는 가변인자 (인자의 갯수가 정해지지 않음, 상황에 따라 늘어날 수도 있다)를 갖는 함수
문법 : DECODE(기준값(col | expression)),
            비교값1, 반환값1
            비교값1, 반환값1
            비교값1, 반환값1
            옵션(기준값이 비교값중에 일치하는 값이 없을 때 기본적으로 반환할 값)

SELECT EMPNO, ENAME, DEPTNO,
       DECODE(DEPTNO, 10,'ACCOUNTING',
                      20,'RESEARCH',
                      30,'SALES',
                      40,'PERATIONCS',
                      NULL,'DDIT')DNAME
FROM EMP; 

SELECT ENAME, JOB, SAL,
      DECODE(JOB, 'SALESMAN', SAL * 1.05,
                  'MANAGER',  SAL * 1.10,
                  'PRESIDENT', SAL * 1.20, 
                   SAL * 1)BOUNS
FROM EMP;

SELECT ENAME,JOB, SAL,DEPTNO,
        CASE
            WHEN JOB =  'SALESMAN'  THEN SAL * 1.05
            WHEN JOB = 'PRESIDENT' THEN SAL * 1.20
            WHEN JOB = 'MANAGER' THEN 
                                        CASE
                                             WHEN deptno  = 30 then sal * 1.5
                                             else sal * 1.1
                                             end
           else sal                                 
        END BONUS
FROM EMP;

SELECT ENAME, JOB, SAL,
      DECODE(JOB, 'SALESMAN', SAL * 1.05,
                  'MANAGER',DECODE(DEPTNO, 30, SAL *1.5, SAL * 1.1),   
                  'PRESIDENT', SAL * 1.20, 
                   SAL * 1)BOUNS
FROM EMP; 


SELECT ENAME, JOB, SAL,
      DECODE(JOB, 'SALESMAN', SAL * 1.05,
                  'MANAGER' , DECODE(DEPTNO, 30, SAL * 1.5 ,SAL * 1.1),  
                  'PRESIDENT', SAL * 1.20, 
                   SAL * 1)BOUNS
FROM EMP; 
 

실습 1

SELECT EMPNO,ENAME,HIREDATE,
        CASE
        WHEN HIREDATE >= TO_DATE('80/01/01') AND HIREDATE <=  TO_DATE('80/12/30') THEN '건강검진 대상자'
        WHEN HIREDATE >= TO_DATE('81/01/01') AND HIREDATE <=  TO_DATE('81/12/30') THEN '건강검진 비대상자'
        WHEN HIREDATE >= TO_DATE('82/01/01') AND HIREDATE <=  TO_DATE('82/12/30') THEN '건강검진 대상자'
        WHEN HIREDATE >= TO_DATE('83/01/01') AND HIREDATE <=  TO_DATE('83/12/30') THEN '건강검진 비대상자'
        END
FROM EMP;    

SELECT EMPNO,ENAME,HIREDATE,
       DECODE(MOD(TO_CHAR(HIREDATE,'YYYY'),2),
                        MOD(TO_CHAR(SYSDATE,'YYYY'),2),'건강검진대상자',
                        '건강검진 비대상자')
FROM EMP;


실습 2

SELECT USERID,USERNM, 
        CASE
        WHEN ALIAS = '곰' THEN ' '
        WHEN ALIAS = '토끼' THEN ' '
        WHEN ALIAS = '병아리' THEN ' '
        WHEN ALIAS = '사람' THEN ' '
        WHEN ALIAS = '달' THEN ' '
        END ALIAS,
        REG_DT,
        CASE
        WHEN MOD(TO_CHAR(REG_DT,'YYYY'),2) = MOD(TO_CHAR(SYSDATE,'YYYY'),2) THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
        END "병원"
FROM USERS;
DECODE(MOD(TO_CHAR(REG_DT,'YYYY'),2),
               MOD(TO_CHAR(SYSDATE,'YYYY'),2),'건강검진대상자'
               ,'건강검진 비대상자')"hospital"

그룹함수 : 여러개의 행을 입력으로 받아서 하나의 행으로 결과를 리턴하는 함수
SUM : 합계
COUNT : 행의 수
AVG : 평균
MAX : 그룹에서 가장 큰 값
MIN : 그룹에서 가장 작은 값

SELECT 행들을 묶을 기준1,행들을 묶을 기준2, 그룹함수
FROM 테이블
[WHERE]
GROUP BY; 행들을 묶을 기준1,행들을 묶을 기준2

1.부서번호별 SAL 칼럼의 합
==>부서번호가 같은 행들을 하나의 행으로 만든다.

2.부서번호별 가장 큰 급여를 받는 사람 급여액수

3.부서번호별 가장 작은 급여를 받는 사람 급여액수

4.부서번호별 급여 평균액수

5.부서번호별 급여가 존재하는 사람의 수(SAL 컬럼 NULL이 아닌 행의 수)
  * : 그룹의 행 수
SELECT DEPTNO,SUM(SAL), MAX(SAL),MIN(SAL),ROUND(AVG(SAL),2),COUNT(SAL),COUNT(*),COUNT(COMM)
FROM EMP
GROUP BY DEPTNO;

그룹함수의 특징 : 
1.NULL값을 무시
30번 부서의 사원 6명중 2명은 COMM 값이 NULL
SELECT DEPTNO,SUM(COMM)
FROM EMP
GROUP BY DEPTNO;

그룹함수의 특징 
2. 1.GROUP BY 를 적용 여러행을 하나의 행으로 두게 되면은
    SELECT; 절에 기술할 수 있는 칼럼이 제한됌
    ==> select절에 기술되는 일반 컬럼들은 (그룹 함수를 저용하지 않은)
    반드시 group by 절에 기술 되어야 한다
    * 단 그룹핑에 영향을 주지 않는 고정된 상수, 함수는 기술 가능
SELECT DEPTNO,SUM(SAL)
FROM EMP
GROUP BY DEPTNO;

그룹함수 이해하기 힘들다 ==> 엑셀에 데이터를 그려보기

3.그룹함수의 특징  : 일반 함수를 where절에서 사용하는게 가능
                  (where upper('smith') = 'SMITH';)
                  그룹함수의 경우 where절에서 사용하는게 불가능
                  하지만 HAVING 절에 기술하여 동일한 결과를 나타낼 수 있다
                  
sum 값이 9000보다 큰 행들만 조회하고 싶은 경우
SELECT DEPTNO, SUM (SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) > 9000;


SELECT *
FROM(SELECT DEPTNO, SUM(SAL) SUM_SAL
    FROM EMP
    GROUP BY DEPTNO)
WHERE  SUM_SAL > 9000;                    

SELECT 쿼리 문법 총정리
SELECT 
FROM
WHERE
GROUP BY
HAVING
ORDER BY

GROUP BY 절에 행을 그룹방향 기준을 작성
EX : 부서번호였던 그룹을 만들경우 
     GROUP BY DEPTNO
    
전체행을 기준으로 그루핑을 하려면 GROUP BY 절에 어떤 컬럼을 기술해야 할까?
EMP 테이블에 등록된 14명의 사원 전체의 급여 합계를 구하려면 ?? ==> 결과는 1개의 행
EMP GROUP BY; 절을 기술하지 않는다
SELECT SUM(SAL)
FROM EMP;

GROUP BY절에 기술한 컬럼을 SELECT 절에 기술하지 않은 경우??
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;

그룹함수의 제한사항
부서번호별 가장 높은 급여를 받는 사람의 급여액
그래서 그 사람이 누구인가?(서브쿼리,분석함수)
SELECT DEPTNO,MAX(SAL)
FROM EMP
GROUP BY DEPTNO;