계층쿼리
1. CONNECT BY LEVEL < <= 점수
    : 시작 행, 연결될 다음 행과의 조건이 없음
    ==> CROSS JOIN과 유사
2. START WITH, CONNECT BY : 일반적인 계층 쿼리
                            시작 행 지칭, 연결된 다음 행과의 조건을 기술
                    
CREATE TABLE IMSI(
    T VARCHAR2(2)
);


LEVEL : 1
SELECT T,LEVEL,LTRIM(SYS_CONNECT_BY_PATH(T,'-'),'-')"A-B"
FROM IMSI
CONNECT BY LEVEL <= 3;

LAG(COL) : 파티션별 이전 행의 특정 컬럼 값을 가져오는 함수
LEAD(COL) : 파티션별 이후 행의 특정 컬럼 값을 가져오는 함수

자신보다 전체 사원의 급여 순위가 1단계 낮은 사람의 급여 값을 5번째 컬럼으로 생성
단 급여가 같을 경우 입사 일자가 빠른 사람이 우선순위가 높다
SELECT EMPNO,ENAME,HIREDATE,SAL
FROM EMP
ORDER BY SAL DESC, HIREDATE;

SELECT EMPNO,ENAME,HIREDATE, SAL,
       LEAD(SAL) OVER(ORDER BY SAL DESC, HIREDATE) LEAD_SAL,
       LAG(SAL)  OVER(ORDER BY SAL DESC, HIREDATE) LAG_SAL
FROM EMP;


SELECT EMPNO,ENAME,HIREDATE,JOB,SAL 
FROM EMP
ORDER BY JOB ,SAL DESC;


SELECT EMPNO,ENAME,HIREDATE,JOB,SAL,
       LAG(SAL) OVER(PARTITION BY JOB ORDER BY SAL DESC)
FROM EMP;



SELECT ROWNUM RN, a.*
FROM(SELECT EMPNO, ENAME, HIREDATE,SAL
     FROM EMP 
     ORDER BY SAL DESC, HIREDATE) a)a,
     (SELECT ROWNUM RN, a.*
      FROM
      (SELECT EMPNO, ENAME,HIREDATE,SAL
      FROM EMP
      ORDER BY SAL DESC,HIREDATE)a)b
WHERE a.rn - 1 =b.rn;


windowing : 파티션 내의 행들을 세부적으로 선별하는 범위를 기술

SELECT EMPNO, ENAME, SAL,
       SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN 
                    UNBOUNDED PRECEDING AND CURRENT ROW) C_SUM
FROM EMP;


SELECT EMPNO, ENAME, DEPTNO, SAL,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL,EMPNO RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) C_SUM2
FROM EMP;

SELECT EMPNO,ENAME,DEPTNO,SAL,
SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN 2  PRECEDING AND 1 FOLLOWING)
FROM EMP;


WINDOWING 기본 설정값이 존재 : RANGE UNBOUNDED PRECDEIG
SELECT EMPNO, ENAME, DEPTNO, SAL,
     SUM(SAL) OVER(ORDER BY SAL ROWS UNBOUNDED PRECEDING) ROWS_SUM,
      SUM(SAL) OVER(ORDER BY SAL RANGE UNBOUNDED PRECEDING) RANGE_SUM,
      SUM(SAL) OVER(ORDER BY SAL)C_SUM
FROM EMP;

모델링 과정 요구사항 파악 이후
개념모델 ==> 논리모델 - 물리모델
논리 모델의 요약판

논리모델 : 시스템에서 필요로 하는 엔터티(테이블) 엔터티의 속성 엔터티간의 관계를 기술
         데이터가 어떻게 저장될지는 관심사하잉 아니다 ==> 물리 모델에서 고려할 사항
         논리 모델에서는 데이터의 전반적인 큰 틀을 설계
물리모델 : 논리 모델을 갖고 해당시스템이 사용할 데이터베이스를 고려하여 최적화된 
         테이블 컬럼 제약 조건을 생성하는 설계하는 단계
         
논리 모델       :   물리 모델
엔터티TYPE          테이블 
속성(ATTRIBUTE)    컬럼
식별자             키 ==> 행들을 구분할 수 있는 유일한 값

요구사항 요구사항 기술서, 장표, 인터뷰 에서 명사 ==> 엔터티 or 속성일 확률이 높음


명명규칙
엔터티 : 단수 명사
        서술식 표현은 잘못된 방법
        
        