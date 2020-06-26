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
WHERE mgr NOT in(7698,7839);

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
