SELECT NVL(JOB,'총계'),GROUPING(JOB),GROUPING(DEPTNO), SUM(SAL + NVL(COMM,0))SAL     
FROM EMP
GROUP BY ROLLUP(JOB,DEPTNO);

GROUPING(COLUMN) : 0, 1

0 : 컬럼이 소계 계산에 사용 되지 않았다 GROUP BY 컬럼으로 사용됨
1 : 컬럼이 소계 계산에 사용 되었다.

SELECT DECODE(GROUPING(JOB), 1, '총계',0,JOB),DEPTNO,
SUM(SAL + NVL(COMM,0))SAL
FROM EMP
GROUP BY ROLLUP(JOB,DEPTNO);

NVL 함수를 사용하지 않고 GROUPING 함수를 사용해야 하는 이유

GROUP BY JOB, MGR,
GROUP BY JOB
GROUP BY 전체
SELECT JOB,DEPTNO,GROUPING(JOB),GROUPING(DEPTNO),SUM(SAL)
FROM EMP
GROUP BY ROLLUP(JOB,DEPTNO);






SELECT CASE
        WHEN GROUPING(JOB) = 1 THEN '총'
        WHEN GROUPING(JOB) = 0  THEN JOB
        END JOB,
        CASE 
        WHEN GROUPING(JOB) = 1 AND GROUPING(DEPTNO) = 1 THEN '계'
        WHEN GROUPING(JOB) = 0 AND GROUPING(DEPTNO) = 1 THEN '소계'
        WHEN GROUPING(JOB) = 0 AND GROUPING(DEPTNO) = 0 THEN TO_CHAR(DEPTNO)
        END DEPTNO, SUM(SAL) SAL_SUM
FROM EMP
GROUP BY ROLLUP(JOB,DEPTNO;


SELECT DECODE(GROUPING(JOB), 1, '총',0,JOB),
       DECODE(GROUPING(JOB) + GROUPING(DEPTNO), 0, TO_CHAR(DEPTNO),
                                                1, '소계',
                                                2, '계'),
SUM(SAL + NVL(COMM,0))SAL
FROM EMP
GROUP BY ROLLUP(JOB,DEPTNO);



SELECT GROUPING(DEPTNO),GROUPING(JOB), SUM(SAL)
FROM EMP
GROUP BY ROLLUP(JOB,DEPTNO);


SELECT DEPTNO,JOB, SUM(SAL +NVL(COMM,0))
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);




SELECT DECODE(GROUPING(DNAME), 1, '총',DNAME) dname,
       DECODE(GROUPING(DNAME) + GROUPING(JOB), 0, DNAME,
                                               1, '소계',
                                               2, '계')
JOB, SUM(SAL +NVL(COMM,0))SAL_SUM
FROM EMP JOIN DEPT ON(EMP.DEPTNO = DEPT.DEPTNO)
GROUP BY ROLLUP(DNAME,JOB)
ORDER BY DNAME,JOB DESC;


확장된 group by
1.rollup (0)
    컬럼 기술에 방향성이 존재
    group by rollup(job, deptno) != group by rollup(deptno,job)
    group by job, deptno            group by job, deptno
    group by job                    group by job
    group by ''                     group by ''

단점 : 개발자가 필요가 없는 서브 그룹을 임의로 제거 할 수 없다.

2.grouping sets(0) - 필요한 서브그룹을 임의로 지정하는 형태
  ==> 복수의 group by 를 하나로 합쳐서 결과를 돌려주는 형태
  group by grouping sets(col1,col2)
  group by col1
  union all
  group by col2
  
  group by grouping sets(col2,col1)
  group by set의 경우 rollup과는 다르게 컬럼 나열순서가 데이터자체에 영향을 미치지 않음
  
  복수 컬럼으로 group by
  group by col1, col2
  union all
  group by col1
  ==> grouping sets((col1,col2),col2)
  
  grouping sets 실습
  select job, deptno, sum(sal + nvl(comm,0)) sal_sum
  FROM EMP
  --GROUP BY ROLLUP(JOB,DEPTNO)
  GROUP BY GROUPING SETS(JOB,DEPTNO);
  
  
위 쿼리를 UNION ALL로 풀어 쓰기


SELECT JOB,NULL, SUM(SAL + NVL(COMM,0)) SAL_SUM
FROM EMP
GROUP BY JOB

UNION ALL

SELECT NULL,DEPTNO, SUM(SAL + NVL(COMM,0)) SAL_SUM
FROM EMP
GROUP BY DEPTNO;

SELECT JOB, DEPTNO, MGR, SUM(SAL + NVL(COMM,0)) SAL_SUM
FROM EMP
GROUP BY GROUPING SETS((JOB,DEPTNO),MGR);


CUBE 
GROUP BY를 확장한 구문
CUBE절에 나열한 모든 가능한 조합으로 서브그룹을 생성
GROUP BY CUBE(JOB,DEPTNO);


GROUP BY JOB,DEPTNO
GROUP BY JOB
GROUP BY DEPTNO
GROUP BY 

SELECT JOB,DEPTNO, SUM(SAL+ NVL(COMM,0))
FROM EMP
GROUP BY CUBE(JOB,DEPTNO,MGR);

CUBE의 경우 기술한 컬럼으로 모든 가능한 조합으로 서브그룹을 생성한다.
가능한 서브그룹을 2 * 기술한 컬럼 개수
기술한 컬럼이 3개만 넘어도 생성되는 서브그룹의 개수가 8개가 넘기 때문에
실제 필요하지 않은 서브 그룹이 포함될 가능성이 높다. ==> ROLLUP GROUPING SETS 보다 활요성이 떨어진다.

GROUP BY JOB, ROLLUP(DEPTNO),CUBE(MGR);

==> 내가 필요로하는 서브그룹을 GROUPING SETS을 통해 정의하면 간단하게 작성 가능.
ROLLUP(DEPTNO) : GROUP BY DEPTNO 
                 GROUP BY ''

CUBE(MGR) : GROUP BY MGR
            GROUP BY ''
            
GROUP BY JOB, DEPTNO, MGR
GROUP BY JOB, DEPTNO,
GROUP BY JOB, MGR
GROUP BY JOB

SELECT JOB, DEPTNO, MGR, SUM(SAL + NVL(COMM,0)) SAL_SUM
FROM EMP
GROUP BY JOB, ROLLUP(DEPTNO), CUBE(MGR);



SELECT JOB,DEPTNO,MGR,SUM(SAL + NVL(COMM,0))SAL
FROM EMP
GROUP BY JOB, ROLLUP(JOB,DEPTNO), CUBE(MGR);


GROUP BY JOB DEPTNO MGR
GROUP BY JOB DEPTNO
GROUP BY JOB ,MGR
GROUP BY JOB 

1.DROP TABLE EMP_TEST;

2.CREATE TABLE EMP_TEST AS
  SELECT *
  FROM EMP;

3.ALTER TABLE EMP_TEST ADD (DNAME VARCHAR2(14));

SELECT *
FROM EMP_TEST;

DESC EMP_TEST;


SELECT EMPNO,ENAME,DEPTNO, (SELECT DNAME FROM DEPT WHERE DEPT.DEPTNO = EMP_TEST.DEPTNO)
FROM EMP_TEST;

WHERE 절이 존재하지 않음 == > 모든 행에 대해서 업데이를 실행
UPDATE EMP_TEST SET DNAME =  (SELECT DNAME 
                              FROM DEPT 
                              WHERE DEPT.DEPTNO = EMP_TEST.DEPTNO);
                              
SELECT *
FROM EMP_TEST;

SELECT *
FROM DEPT_TEST;

DROP TABLE DEPT_TEST;

CREATE TABLE DEPT_TEST AS
SELECT *
FROM DEPT;

ALTER TABLE DEPT_TEST ADD(EMPCNT NUMBER);


UPDATE DEPT_TEST SET EMPCNT =  (SELECT COUNT(DEPTNO) 
                                FROM EMP 
                                WHERE EMP.DEPTNO = DEPT_TEST.DEPTNO);

SELECT *
FROM DEPT_TEST;

COMMIT;

