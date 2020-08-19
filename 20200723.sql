계층쿼리
    테이블(데이터셋)의 행과 행사이의 연관관계를 추적 하는 쿼리
    
    ex : emp 테이블 해당 사원의 mgr 컬럼을 통해 상급자 추적 가능
        1.상급자 직원을 다른 테이블로 관리하지 않음
         1-1. 상급자 구조가 계층이 변경이 되도 테이블의 구조는 변경 할 필요가 없다.
        
        2.join : 테이블 간 연결
            from emp, dept
            where emp.deptno = dept.deptno
        계층쿼리 : 행과 행 사이의 연결(자기 참조)    
                PRIOR : 현재 읽고 있는 행을 지칭
                x : 앞으로 읽을 행
                

SELECT *
FROM NO_EMP;


SELECT LPAD(' ',(LEVEL -1) *4) || S_ID S_ID,VALUE
FROM H_SUM
START WITH PS_ID IS NULL
CONNECT BY PRIOR S_ID = PS_ID;

SELECT LPAD(' ', (LEVEL -1) *4) ||ORG_CD ORG_CD,NO_EMP
FROM NO_EMP
START WITH PARENT_ORG_CD IS NULL
CONNECT BY PRIOR ORG_CD = PARENT_ORG_CD;


가지치기(PRUNING BRANCH)
SELECT 쿼리의 실행순서 : FROM => WHERE => SELECT
계층 쿼리의 SELECT 쿼리 실행 순서 : FROM => START WITH, CONNECT BY => WHERE

계층쿼리에서 조회할 행의 조건을 기술할 수 있는 부분이 두곳 존재
1.CONNECT BY : 다음 행으로 연결할지 말지를 결정
2.WHERE : start with connect by에 의해 조회된 행을 대상으로 적용

SELECT LPAD(' ',(LEVEL -1) * 4) || DEPTNM
FROM DEPT_h
START WITH DEPTCD = 'dept0'
CONNECT BY PRIOR DEPTCD = P_DEPTCD AND deptnm != '정보기획부';


SELECT LPAD(' ',(LEVEL -1) * 4) || DEPTNM
FROM DEPT_h
WHERE deptnm != '정보기획부'
START WITH DEPTCD = 'dept0'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;

계층쿼리에서 사용할 수 있는 특수함수
connect_by_root(col) : 최상위 행의 col 컬럼의 값
sys_connect_by_path(col,구분자): 계층의 순회경로를 표현 
connect_by_lsleaf(col,구분자):  해당 행이 Leaf node인지 아닌지 반환


SELECT DEPTCD,P_DEPTCD,LPAD(' ', (LEVEL - 1) *4) || DEPTNM,
       --CONNECT_BT_ROOT(DEPTNM),
       LTRIM(SYS_CONNECT_BY_PATH(DEPTNM,'-'), '-')
FROM DEPT_H
START WITH DEPTCD = 'dept0'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;

SELECT *
FROM BOARD_TEST;

SELECT SEQ,LPAD(' ', (LEVEL - 1) *4) || TITLE TITLE
FROM BOARD_TEST
START WITH PARENT_SEQ IS NULL
CONNECT BY PRIOR SEQ = PARENT_SEQ
ORDER SIBLINGS BY SEQ;

SELECT ENAME,SAL,deptno
FROM EMP
ORDER BY DEPTNO, SAL DESC;

SELECT *
FROM
(SELECT LEVEL LV
FROM DUAL
CONNECT BY LEVEL <= 14)a,

(SELECT deptno, count(*) cnt
from emp
GROUP BY deptno)b
);


위와 동일한 동작을 하는 윈도우 함수

윈도우 함수 미사용 : emp 테이블 3번조회
윈도우 함수 사용 : emp 테이블 1번조회
SELECT ename, sal, deptno,
       RANK() OVER(PARTITION BY deptno ORDER BY sal desc) sal_rnk
FROM EMP;

윈도우 함수를 사용하면 행간 연산이 가능해짐
==>일반적으로 풀리지 않는 쿼리를 간단하게 만들 수 있다.

모든 DBMS가 동일한 윈도우 함수를 제공하지는 않음

문법 : 윈도우 함수 OVER (PARTITION BY 컬럼 ORDER BY 컬럼 WINDOWING)

PARTITION : 행들을 묶을 그룹 (GROUP BY)
ORDER BY : 묶여진 행들간 순서 (RANK-순위의 경우 순서를 설정하는 기준이 된다)
WINDOWING : 파티션 안에서 특정 행들에 대해서만 연산을 하고 싶을때 범위를 지정


순위 관련함수
1.RANK() : 동일 값일 때는 동일 순위 부여, 후순위 중복자만큼 건너 띄고 부여
           1등이 2명이면 후 순위는 3등
2.DENSE_RANK() : 동일 값일 때는 동일 순위 부여, 후 순위는 이어서 부여
                 1등이 2명이어도 후순위는 2등
3.ROW_NUMBER() : 중복되는 값이 없어 순위 부여 rownum과 유사

SELECT ename, sal, deptno,
       RANK() OVER(PARTITION BY deptno ORDER BY sal desc) sal_rnk,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal desc) sal_rnk,
       ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal desc) sal_rnk
FROM EMP;


SELECT EMPNO,ENAME,DEPTNO, (SELECT COUNT(*)
                           FROM EMP B
                           WHERE A.DEPTNO = B.DEPTNO 
                          ) 
FROM EMP A
ORDER BY DEPTNO;


집계 윈도우 함수 : SUM, MAX, MIN, AVG, COUNT


SELECT EMPNO,ENAME,SAL,DEPTNO,
       ROUND(AVG(SAL) OVER(PARTITION BY deptno),2) AVG_SAL
FROM EMP;



SELECT EMPNO,ENAME,SAL,DEPTNO,(SELECT ROUND(AVG(SAL),2)
                                FROM EMP B
                                WHERE A.DEPTNO = B.DEPTNO) AVG_SAL

FROM EMP A
ORDER BY DEPTNO;



SELECT EMPNO,ENAME,SAL,DEPTNO,
      MAX(SAL) OVER(PARTITION BY deptno) MAX_SAL
FROM EMP;

SELECT EMPNO,ENAME,SAL,DEPTNO,
      MIN(SAL) OVER(PARTITION BY deptno) MIN_SAL
FROM EMP;

