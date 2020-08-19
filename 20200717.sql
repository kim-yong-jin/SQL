SQL 응용 : DML (SELECT, UPDATE, INSERT, MERGE)

1.Multiple Insert
한번의 INSERT 구문을 통해 여러 테이블에 데이터를 입력

RDBMS : 데이터의 중복을 최소화

사용목적 : 1.실제 사용할 테이블과 별개로 보조 테이블에도 동일한 데이터 쌓기
         2.데이터 수평분할 (*)
         주문 테이블
         2020 데이터 ==> TB_ORDER_2020
         2021 데이터 ==> TB_ORDER_2021
         ==> 오라클 PARTITION 을 통해 더 효과적으로 관리 가능(정식버전)
         하나의 테이블안에 데이터 값에 따라 저장하는 물리공간이 나뉘어 져 있음
         :개발자 입장에서는 데이터를 입력하면
         데이터 값에 따라 물리적인 공간을 오라클이 알아서 나눠 저장
         
        
MULTIPLE INSERT 종류
1. UNCONDITIONAL INSERT : 조건과 관계없이 하나의 데이터를 여러 테이블에 입력
2. CONDITIONAL ALL INSERT : 조건을 만족하는 모든 테이블에 입력
ROLLBACK;
조건 분기 문법: CASE WHEN THEN END
조건 분기 함수: DECODE

   
insert all
    WHEN EMPNO >= 9999 THEN
        INTO EMP_TEST VALUES(EMPNO,ENAME)
    WHEN EMPNO >= 9998 THEN
        INTO EMP_TEST2 VALUES(EMPNO,ENAME)
    ELSE
        INTO EMP_TEST2(EMPNO) VALUES(EMPNO)
    
SELECT 9999 EMPNO, 'brown' ename FROM DUAL
UNION ALL
SELECT 9999 EMPNO, 'sally' ename FROM DUAL;


SELECT *
FROM EMP_TEST;

3. CONDITIONAL FIRST INSERT : 조건을 만족하는 첫번째 테이블에 입력

DROP TABLE EMP_TEST,EMP_TEST2;

EMP테이블의 EMPNO컬럼이랑 ENAME 컬럼만 갖고 EMP_TEST

CREATE TABLE EMP_TEST
(
    EMPNO NUMBER(8),
    ENAME VARCHAR2(13) 
);

CREATE TABLE EMP_TEST2
(
    EMPNO NUMBER(8),
    ENAME VARCHAR2(13) 
);

UNCONDITIONAL INSERT
아래 두개의 행을 emp_test, emp_test2에 동시 입력 하나의 insert 구문 사용
SELECT 9999 EMPNO, 'brown' ename
FROM DUAL;
   
insert all
    INTO EMP_TEST VALUES(EMPNO,ENAME)
    INTO EMP_TEST2(EMPNO) VALUES(EMPNO)
 

UNION ALL
SELECT 9999 EMPNO, 'sally' ename
FROM DUAL;


SELECT *
FROM EMP_TEST2;


3.CONDITIONAL FIRST INSET

insert FIRST
    WHEN EMPNO >= 9999 THEN
        INTO EMP_TEST VALUES(EMPNO,ENAME)
    WHEN EMPNO >= 9998 THEN
        INTO EMP_TEST2 VALUES(EMPNO,ENAME)
    ELSE
        INTO EMP_TEST2(EMPNO) VALUES(EMPNO)
    
SELECT 9999 EMPNO, 'brown' ename FROM DUAL
UNION ALL
SELECT 9998 EMPNO, 'sally' ename FROM DUAL;

SELECT *
FROM EMP_TEST;

MERGE 
1.사용자로 부터 받은 값을 갖고
테이블 저장 OR 수정
입력받은 값이 테이블에 존재하면 수정을 하고 싶고
입력받은 값이 테이블에 존재하지 않으면 신규 입력을 하고 싶을 때

2.테이블의 데이터를 이용하여 다른 테이블의 데이터를 업데이트 OR INSERT하고 싶을때
일반 UPDATE구문에서는 비효율이 존재
ALLERN의 JOB과 DEPTNO를 SMITH 사원과 동일한 업데이트 하시오
    UPDATE EMP SET JOB = (SELECT JOB FROM EMP WHERE ENAME = 'SMITH'),
            DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME  = 'SMITH')
            WHERE ENAME = 'ALLERN';
EX : EMPNO 9999, ENMAE 'brown'
emp 테이블에 동일한 empno가 있으면 ename을 업데이트
emp 테이블에 동일한 empno가 없으면 신규 입력

1.해당 데이터가 존재하는지 확인하는 SELECT 구문을 실행
2. 1번 쿼리의 조회 결과 있으면
  2.1 UPDATE
3.1번 쿼리의 조회 결과 없으면
  3.1 INSERT

1.
SELECT *
FROM EMP
WHERE EMPNO = 9999

2.UPDATE EMP SET ENAME = 'brown'
  WHERE  EMPNO = 9999;

3.INSERT INTO EMP(EMPNO,ENAME) VALUES ('brown',9999);

문법
MERGE INTO 테이블명(덮어 쓰거나,신규로 입력할 테이블) ALIAS
USING (테이블 명 | VIEW | INLINE-VIEW) ALIAS
 ON (두 테이블간 데이터 존재 여부를 확인할 조건)
 WHEN MATCHED THEN
      UPDATE SET 컬럼1 = 값1,
                 컬럼2 = 컬럼2
                 
 WHEN NOT MATCHED THEN
    INSERT 테이블명 VALUES 값1 값2;

ROLLBACK;    
1.7369 사원의 데이터를 EMP_TEST로 복사 (EMPNO, ENAME)


INSERT INTO EMP_TEST
SELECT EMPNO,ENAME
FROM EMP
WHERE EMPNO = 7369;

SELECT *
FROM EMP_TEST;

EMP : 14, EMP_TEST : 1
EMP테이블을 이용하여 EMP_TEST에 
동일한 EMPNO 값이 있으면 EMP_TEST.ENAME 업데이트
동일한 EMPNO 값이 없으면 EMP테이블의 데이터를 신규 입력

SELECT 
FROM EMP_TEST A, EMP B
WHERE A.EMPNO = B.EMPNO;
MERGE INTO EMP_TEST A
USING EMP B
    ON(A.EMPNO = B.EMPNO)
WHEN MATCHED THEN
    UPDATE SET ENAME = B.ENAME || '_M'
WHEN NOT MATCHED THEN
    INSERT(EMPNO,ENAME) VALUES(B.EMPNO,B.ENAME);

EMP_TEST테이블에는....
7369사원의 이름이 SMITH_M으로 업데이트
7369를 제외한 13명의 사원이 INSERT

SELECT *
FROM EMP_tEST;

***MERGE에서 많이 사용하는 형태
사용자로부터 받은 데이터를 EMP_TEST 테이블에
동일한 데이터 존재 유뮤에 따른 MERGE
시나리오 : 사용자 입력 EMPNO = 9999, ENAME = BROWN

INSERT INTO EMP_TEST VALUES (9999,'brown');

MERGE into emp_test
USING DUAL
    ON(EMP_test.EMPNO = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename
WHEN NOT MATCHED THEN
    INSERT VALUES(:empno,:ename);
    
실습 : dept_test3 테이블을 dept 테이블과 동일하겟 ㅐㅇ성
단 10 20 부서 데이터만 복제

dpet테이블을 이용하여 dept_test3테이블에 데이터를  merge
머지조건 : 부서번호가 같은 데이터
동일한 부서가 있을때 기존 loc 컬럼의 값 + _m로 업데이트
동일한 부서가 없을때 신규데이터 입력
ROLLBACK;

DROP TABLE DEPT_TEST3;
CREATE TABLE DEPT_TEST3 AS 
SELECT *
FROM DEPT
WHERE DEPTNO = 10  OR DEPTNO = 20;

SELECT *
FROM DEPT_TEST3;

SELECT *
FROM DEPT;
MERGE INTO DEPT_TEST3
USING DEPT
ON(DEPT_TEST3.DEPTNO = DEPT.DEPTNO)
WHEN MATCHED THEN
    UPDATE SET DEPT_TEST3.LOC = DEPT_TEST3.LOC || '_M'
WHEN NOT MATCHED THEN
    INSERT VALUES(DEPT.DEPTNO,DEPT.DNAME,DEPT.LOC);
    
    
실습2 : 사용자가 입력받은 값을 이용한 MERGE
    사용자 입력 :DEPTNO: 9999, DNAME: 'DDIT', LOC : 'DAEJEON'
    DEPT_TEST3 테이블에 사용자가 입력한 DEPTNO 값과
    동일한 데이터가 있을경우 : 사용자가 입력한 DNAME ,LOC 값으로 두개 컬럼 업데이트
    
    동일한 데이터가 없을경우 : 사용자가 입력한 DEPTNO, DNAME,LOC 값으로 INSERT
MERGE INTO DEPT_TEST3
USING DUAL
ON(DNAME = :DNAME)
WHEN MATCHED THEN
    UPDATE SET LOC = :LOC
WHEN NOT MATCHED THEN
    INSERT VALUES(:DEPTNO,:DNAME,:LOC);


SELECT *
FROM DEPT_TEST3;


GROUP FUNCTION 응용 확장

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
UNION ALL
SELECT NULL,SUM(SAL)
FROM EMP
ORDER BY DEPTNO;

SELECT DEPTNO, DECODE(RN,1,DEPTNO)
FROM
(SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO)A,
(SELECT ROWNUM RN
FROM DEPT
WHERE ROWNUM <=2)B
GROUP BY DECODE(RN, 1, DEPTNO, 2, NULL)
ORDER BY DEPTNO;

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO);

ROLLUP : GROUP BY의 확장구문
         정해진 규칙으로 서브 그룹을 생성하고 생성된 서브 그룹을
         하나의 집합으로 반환
         GROUP BY ROLLUP(COLL,COLL2...)
         ROLLUP 절대 기술된 컬럼을 오른쪽에서 부터 하니씩 제거하 가며
         서브 그룹을 생성
         
         GROUP BY ROLLUP(JOB,DEPTNO)
         GROUP BY ROLLUP(DEPTNO,JOB)
         ROLLUP의 경우 방향성이 있기 때문에 컬럼 기술순서가 다르면
         다른 결과가 나온다.
예시 GROUP BY ROLLUP(DEPTNO)
1.GROUP BY DEPTNO ==> 부서번호별 총계
2.GROUP BY '' ==> 전체 총계

예시 : GROUP BY ROLLUP(JOB,DEPTNO)
1.GROUP BY JOB, DEPTNO == >담당업무 부서번호별 총계
2.GROUP BY JOB ==> 담당업무별 총계
3.GROUP BY JOB ==> 전체 총계

ROLLUP 절에 N개의 컬럼을 기술 했을때 SUBGROUP의 개수는 : N+1개의 서브그룹이 생성

SELECT NVL(JOB,'총계'),GROUPING(JOB),GROUPING(DEPTNO), SUM(SAL + NVL(COMM,0))SAL
FROM EMP
GROUP BY ROLLUP(JOB,DEPTNO);