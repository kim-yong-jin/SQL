확장된 GROUP BY
==> 서브그룹을 자동으로 생성
    만약 이런 구문이 없다면 개발자가 직접 SELECT 쿼리를 여러개 작성해서
    UNION ALL을 시행 ==> 동일한 테이블을 여러번 조회 ==> 성능 저하
    
1.ROLLUP
 1-1. ROLLUP절에 기술한 컬럼을 오른쪽에서 부터 지워나가며 서브그룹을 생성
 1-2. 생성되는 서브 그룹 : ROLLUP절에 기술한 컬럼 개수 + 1
 1-3. ROLLUP절에 기술한 컬럼의 순서가 결과에 영향을 미친다.
 
2.GROUPING SETS
    2-1. 사용자가 원하는 서브그룹을 직접 지정하는 형태
    2-2. 컬럼 기술의 순서는 결과 집합에 영향을 미치지 않음(집합)
    
3.CUBE
    3-1. CUBE절에 기술한 컬럼의 가능한 모든 조합으로 서브그룹을 생성
    3-2. 잘 안쓴다.. 서브그룹이 너무 많이 생성
        2^CUBE절에 기술한 컬럼개수
        
        
1.DEPT_TEST 테이블의 EMPCNT 삭제
ALTER TABLE DEPT_TEST DROP COLUMN EMPCNT;

2.신규 데이터 입력
INSERT INTO DEPT_TEST VALUES(99,'DDIT1', 'DAEJEON');
INSERT INTO DEPT_TEST VALUES(98,'DDIT2', 'DAEJEON');

1.비상호
DELETE DEPT_TEST WHERE DEPTNO NOT IN   (SELECT DEPTNO
                                         FROM EMP);


2.상호
DELETE DEPT_TEST WHERE NOT EXISTS  (SELECT 'X'
                                        FROM EMP
                                        WHERE EMP.DEPTNO = DEPT_TEST.DEPTNO);

2-2 상호연관 NOT IN으로 변경

DELETE DEPT_TEST WHERE DEPTNO NOT IN  (SELECT DEPTNO
                                       FROM EMP
                                       WHERE EMP.DEPTNO = DEPT_TEST.DEPTNO);

3.
UPDATE EMP_TEST A SET SAL = SAL + 200 WHERE SAL < (SELECT ROUND(AVG(SAL),2)
                                                    FROM EMP_TEST B
                                                    WHERE A.DEPTNO = B.DEPTNO); 
SELECT *
FROM EMP_TEST
WHERE SAL < (SELECT AVG(SAL)
            FROM EMP
            );
            
            
WITH : 쿼리 블럭을 생성하고
같이 실행되는 SQL에서 해당 쿼리 블럭을 반복적으로 사용할 때 성능 향상 효과를 기대할 수 있다.
WITH절에 기술된 쿼리 블럭은 메모리에 한번만 올리기 때문에
쿼리에서 반복적으로 사용하더라도 실제 데이터를 가져오는 작업은 한번만 발생한다

하지만 하나의 쿼리에서 동일한 서브쿼리가 반복적으로 사용 된다는 것을 쿼리를 잘못 작성할
가능성이 높다는 뜻이므로,WITH절로 해결하기 보다는 쿼리를 다른방식으로 작성 할 수 없는지
먼저 고려 해볼 것을 추천

회사의 DB를 다른 외부인에게 오픈할 수 없기 때문에 외부인에게 도움을 구하고자 할때
테이블을 대신할 목적으로 많이 사용

사용방법: 쿼리 블럭은 , 를 통해 여러개를 동시에 선언하는 것도 가능
WITH 쿼리블럭이름 AS (
    SELECT 쿼리
)
SELECT *
FROM 쿼리블럭 이름.


1.2020년 7월의 일수 구하기
SELECT TO_DATE('202007' , 'YYYYMM') + LEVEL - 1,
       TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'day')day,
       TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d') d
      
FROM DUAL
CONNECT BY LEVEL <=  TO_CHAR(LAST_DAY(TO_DATE('201902','YYYYMM')),'DD');

SELECT TO_DATE('202007' , 'YYYYMM') + LEVEL - 1,
       DECODE( TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d'), 1, TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'YYYY/MM/DD')) 일,
       DECODE( TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d'), 2, TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'YYYY/MM/DD')) 월,
       DECODE( TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d'), 3, TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'YYYY/MM/DD')) 화,
       DECODE( TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d'), 4, TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'YYYY/MM/DD')) 수,
       DECODE( TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d'), 5, TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'YYYY/MM/DD')) 목,
       DECODE( TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d'), 6, TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'YYYY/MM/DD')) 금,
       DECODE( TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'d'), 7, TO_CHAR(TO_DATE('20200701' , 'YYYYMMDD') + (LEVEL - 1 ),'YYYY/MM/DD')) 토
FROM DUAL
CONNECT BY LEVEL <=  TO_CHAR(LAST_DAY(TO_DATE('201902','YYYYMM')),'DD');


SELECT  DECODE(D, 1, IW +1, IW),
       MAX(DECODE(D, 1, DT)) 일, MAX(DECODE(D, 2, DT)) 월, MAX(DECODE(D, 3, DT)) 화, MAX(DECODE(D, 4, DT)) 수, 
       MAX(DECODE(D, 5, DT)) 목, MAX(DECODE(D, 6, DT)) 금, MAX(DECODE(D, 7, DT)) 토
FROM
(SELECT TO_DATE(:YYYYMM , 'YYYYMM') + LEVEL - 1 DT, 
       TO_CHAR(TO_DATE(:YYYYMM , 'YYYYMM') + LEVEL - 1 ,'DAY') DAY,
       TO_CHAR(TO_DATE(:YYYYMM , 'YYYYMM') + LEVEL - 1 ,'D') d,
       TO_CHAR(TO_DATE(:YYYYMM , 'YYYYMM') + LEVEL - 1 ,'IW') IW
FROM DUAL
CONNECT BY LEVEL <=  TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')),'DD') )
GROUP BY DECODE(D, 1, IW +1, IW)
ORDER BY DECODE(D, 1, IW +1, IW);

SELECT *
FROM SALES;

SELECT SUM(DECODE(M, '01',SALES))"1월", SUM(DECODE(M, '02',SALES))"2월",SUM(DECODE(M, '03',SALES))"3월",
       SUM(DECODE(M, '04',SALES))"4월", SUM(DECODE(M, '05',SALES))"5월",SUM(DECODE(M, '06',SALES))"6월"
FROM
(SELECT TO_CHAR(DT, 'MM') M, SUM(SALES) SALES
FROM SALES
GROUP BY TO_CHAR(DT, 'MM'));

SELECT SUM(DECODE(TO_CHAR(DT,'MM'), '01',SALES))"1월",
       SUM(DECODE(TO_CHAR(DT,'MM'), '02',SALES))"2월",
       SUM(DECODE(TO_CHAR(DT,'MM'), '03',SALES))"3월",
       SUM(DECODE(TO_CHAR(DT,'MM'), '04',SALES))"4월",
       SUM(DECODE(TO_CHAR(DT,'MM'), '05',SALES))"5월",
       SUM(DECODE(TO_CHAR(DT,'MM'), '06',SALES))"6월"
FROM SALES;



SELECT MAX(DECODE(MOD(LV,7), 1, DT)) 일,MAX(DECODE(MOD(LV,7), 2, DT)) 월,MAX(DECODE(MOD(LV,7),3, DT)) 화,
       MAX(DECODE(MOD(LV,7), 4, DT)) 수,MAX(DECODE(MOD(LV,7),5, DT)) 목,MAX(DECODE(MOD(LV,7), 6, DT)) 금,
       MAX(DECODE(MOD(LV,7), 0, DT)) 토
FROM(SELECT TO_DATE(:YYYYMM , 'YYYYMM') + LEVEL -  TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') ,'D') DT, 
            TO_CHAR(TO_DATE(:YYYYMM , 'YYYYMM') + LEVEL - 1 ,'D') d, 
            LEVEL LV
FROM DUAL
CONNECT BY LEVEL <=  35) -- 범위 설정
GROUP BY TRUNC((LV -1)/ 7)
ORDER BY TRUNC((LV -1) / 7);





