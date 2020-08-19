오라클 객체(object)
table
    ddl생성,수정,삭제
    view - sql(쿼리다) 논리적인 데이터 정의, 실체가 없다
           view 구성하는 테이블의 데이터가 변경되면 view 결과도 달라진다
    sequence - 중복되지 않는 정수값을 반환 해주는 객체
               유일한 값이 필요할  떄 사용할 수 있는 객체
               nextval, currval
    index - 테이블의 일부 컬럼을 기준으로 미리 정렬해 놓은 데이터
            ==> 테이블 없이 단독적으로 생성 불가, 특정 테이블에 종속
                table 삭제를 하면 관련 인덱스도 같이 삭제
                
                
DB 구조에서 중요한 전제 조건
1.DB에서 I/O의 기준은 행 단위가 아니라 block 단위
  한건의 데이터를 조회하더라도 해당 행이 존재하는 block 전체를 읽는다

데이터 접근 방식
1.table full access
  multi block io => 읽어야 할 블럭을 여러개를 한번에 읽어 들이는 방식
                    (일반적으로 8~16 block)
  사용자가 원하는 데이터의 결과가 table 모든 데이터를 다 읽어야 처리가 가능한 경우
  ==> 인덱스 보다 여러 블럭을 한번에 많이 조회하는 table full access 방식이 유리 할 수 있다
  ex : 
    전제 조건은 MGR, SAL, COMM 컬럼으로 인덱스가 없을 때
    SELECT COUNT(mgr), SUM(sal), sum(COMM), AVG(SAL)
2.index 접근 index 접근 후 table access 
  sigle block io ==> 읽어야할 행이 있는 데이터 block만 읽어서 처리하는 방식
  소수의 몇건 데이터를 사용자가 조회할 경우, 그리고 조건에 맞는 인덱스가 존재할 경우
  빠르게 응답을 받을 수 있다
  하지만 single block io가 빈번하게 일어나면 multi block io보다 오히려 느리다
  빠르게 응답을 받을 수 있다
2.extent 공간할당 기준



emp테이블의 job 컬럼을 기준으로 2번째 NON-UNIQUE 인덱스 생성;

CREATE INDEX IDX_NU_EMP_02 ON EMP(JOB);

EXPLAIN PLAN FOR
SELECT *
FROM EMP;

SELECT *
FROM EMP
WHERE JOB = 'MANAGER' AND ENAME LIKE('C%');

SELECT JOB, ROWID
FROM EMP
ORDER BY JOB;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

인덱스 추가 생성
EMP 테이블의 JOB, ENAME 컬럼으로 복합 NON-UNIQUE INDEX 생성

IDX_NU_EMP_03
CREATE INDEX IDX_NU_EMP_03 ON EMP(JOB,ENAME);

SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
      AND ENAME LIKE 'C%';



SELECT JOB, ENAME, ROWID
FROM EMP
ORDER BY JOB,ENAME;

위에 쿼리와 변경된 부분은 LIKE 패턴이 변경
LIKE C% => %C;

EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
AND ENAME LIKE '%C';


SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


인덱스 추가
EMP 테이블에 ENAME, JOB 컬럼을 기준으로 NON-UNIQUE 인덱스 생성(IDX_NU_EMP_04)

CREATE INDEX IDX_NU_EMP_04 ON EMP(ENAME,JOB);

현재 상태
인덱스 : IDX_NU_emp_01(empno),
        IDX_NU_emp_02(JOB),
        IDX_NU_emp_03(JOB,empno) ==> 삭제
        IDX_NU_EMP_04(ENAME,JOB) : 복합 컬럼의 인덱스의 컬럼순서가 미치는 영향

DROP INDEX IDX_NU_emp_03;
SELECT ENAME, JOB, ROWID
FROM EMP
ORDER BY ENAME,JOB;

SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
      AND ENAME LIKE 'C%';
      
      
조인에서의 인덱스 활용
EMP : PK_EMP, FK_EMP_DEPT 생성
ALTER TABLE EMP ADD CONSTRAINT PK_EMP PRIMARY KEY(EMPNO);
ALTER TABLE EMP ADD CONSTRAINT FK_EMP_DEPT FOREIGN KEY (DEPTNO)
                                            REFERENCES DEPT (DEPTNO);

EMP : PK_EMP(EMPNO)
DEPT : PK_DEPT(DEPTNO);


접근방식 : EMP 1.TABLE FULL ACCESS 2.인덱스 * 4 : 방법 5가지 존재
         DEPT 1.TABLE FULL_ACCESS, 2.인덱스 * 1 : 방법 2가지
            가능한 경우의 수가 10가지
            방향성 EMP DEPT를 먼저 처리할지 ==> 20;
SELECT *
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
AND EMP.EMPNO =7788;

4 3 5 2 6 1 0

EXPLAIN PLAN FOR
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM DEPT
WHERE 1 = 1;
 IDX_NU_emp_02(JOB)
CREATE UNIQUE INDEX IDX_U_DEPT_TEST01 ON DEPT_TEST2 (DEPTNO);

CREATE INDEX IDX_NU_DEPT_TEST02 ON DEPT_TEST2 (DNAME);

CREATE INDEX IDX_NU_DNAME ON DEPT_TEST2 (DNAME,DEPTNO);


1.EMPNO (=)
2.ENAME (=)
3.DEPTNO (=), EMPNO(LIKE)
4.DEPTON(=),  SAL (BETWEEN)
5.DEPTNO(=)
  EMPNO(=)
6.DEPTNO,HIREDATE 컬럼으로 구성된 인덱스가 있을경우 TABLE 접근이 필요없음.

1)EMPNO
2)ENAME
3)DEPTNO,EMPNO,SAL,HIREDATE

EMP테이블에 데이터가 5천만건
10 20 30 데이터는 각각 50건씩만 존재 ==> 인덱스
40번 데이터 4850만건 ==> TABLE FULL ACCESS


SYNONYM : 오라클 객체 별칭을 생성
SEM.V_EMP => V_EMP

생성방법 CREATE [PUBLIC] SYNONYM 시노님이름 FOR 원본객체이름;

PUBLIC : 모든 사용자가 사용할 수 있는 시노님
         권한이 있어야 생성가능
PRIVATE [DEFAULT]: 해당 사용자만 사용할 수 있는 시노님

삭제방법 
DROP SYNONYM 시노님이름;

INSERT INTO DPET VALUES(10,'TEST','SEOUL');




EXPLAIN PLAN FOR
SELECT *
FROM EMP 
WHERE EMPNO = EMPNO;


CREATE INDEX IDX_NU_EMP ON EMP_TEST (EMPNO);
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


SLECT

CREATE UNIQUE INDEX idx_u_emp_01 ON emp (empno);
CREATE INDEX idx_nu_dept_02 ON dept (deptno);
CREATE INDEX idx_nu_emp_03 ON emp (deptno, empno, sal);
CREATE INDEX idx_nu_emp_dept_04 ON emp_dept (deptno);