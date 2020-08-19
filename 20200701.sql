실습 6
SELECT *
FROM CYCLE
WHERE CID = 1
AND PID IN(SELECT PID
           FROM CYCLE
           WHERE CID = 2);
        
서브쿼리 사용할 떄는 OR연산자 보단 IN 연산자 사용

실습 7
SELECT *
FROM CUSTOMER;


SELECT *
FROM CYCLE;

SELECT *
FROM PRODUCT;

SELECT A.*,CUSTOMER.CNM,PRODUCT.PNM
FROM (SELECT *
      FROM CYCLE
      WHERE CID = 1
      AND PID IN (SELECT PID
                  FROM CYCLE
                  WHERE CID = 2))A,CUSTOMER,PRODUCT
WHERE A.CID = CUSTOMER.CID
AND A.PID = PRODUCT.PID;


SELECT  CYCLE.CID, CUSTOMER.CNM, CYCLE.PID, PRODUCT.PNM, CYCLE.DAY, CYCLE.CNT
FROM CYCLE ,CUSTOMER , PRODUCT 
WHERE CYCLE.CID = 1
AND CYCLE.PID IN (SELECT PID
                  FROM CYCLE
                  WHERE CID = 2)
AND CYCLE.CID = CUSTOMER.CID
AND CYCLE.PID = PRODUCT .PID;


1.요구사항을 만족시키는 코드를 작성
2.코드를 깨끗하게 ==> 리팩토링(코드 동작은 그대로 유지한채 깔끔하게 정리하는거)


EXISTS 연산자 : 서브쿼리에서 반환하는 행이 존재하는지 체크하는 연산자
               서브쿼리에서 반환하는 행이 하나라도 존재하면 TRUE
                서브쿼리에서 반환하는 행이 존재하지 않으면 FALSE

특이점 : 1. WHERE 절에서 사용
        2. MAIN 테이블의 컬럼이 항으로 사용되지 않음
        3. 비상호연관서브쿼리, 상호연관서브쿼리 둘다 사용 가능하지만
           주로 상호연관 서브쿼리[확인자]와 사용된다.
        4.서브쿼리의 컬럼값은 중요하지 않다.
          ==> 서브쿼리의 행이 존재하는지만 체크
              그래서 관습적으로 SELECT 'X'를 주로 사용
연산자 : 항이 몇개가 필요한 연산자인지
피연산자1 + 피연산자2

? 3항 연산자 == if

in 연산자 :
컬럼 IN (서브쿼리,값 나열)

컬럼 EXISTS (서브쿼리)


1.아래쿼리에서 서브쿼리는 단독으로 실행 가능?? : 가능하다 
  ==> 서브쿼리의 실행결과가 메인쿼리의 행 값과 관계 없이 항상 실행되고
      반환되는 행의 수가 1개의 행이다.
SELECT *
FROM EMP
WHERE EXISTS (SELECT 'X'
              FROM DUAL);
              
일반적으로 EXISTS 연산자는 상호연관서브쿼리에서 실행된다.


1.사원정보를 조회 하는데
2.WHERE M.EMPNO = E.MGR 조건을 만족하는 사원만 조회

==> 매니저 정보가 존재하는 사원조회(13건)
SELECT *
FROM EMP E
WHERE EXISTS (SELECT 'X'  -- EXISTS를 사용할때 관습적으로 X 사용
              FROM EMP M
              WHERE M.EMPNO = E.MGR); INDEX를 배우고 나서 힘을 발휘하는 모습을 볼 수 있다
==> 서브쿼리가 [확인자]로 사용되었다.
    비상호연관의 경우 서브쿼리가 먼저 실행될 수도 있다.
    => 서브쿼리가 [제공자]로 사용되었다.

실습 8
SELECT E.*
FROM EMP E, EMP M
WHERE M.EMPNO = E.MGR;

실습 9
SELECT * -- 서브
FROM CYCLE;

SELECT *  -- 메인
FROM PRODUCT;

SELECT *
FROM PRODUCT
WHERE EXISTS (SELECT 'X'
              FROM CYCLE
              WHERE PRODUCT.PID = CYCLE.PID AND CID = 1);

IN 연산자 사용해서 풀어보기
SELECT *
FROM PRODUCT
WHERE PID IN (SELECT PID
              FROM CYCLE
              WHERE CID = 1);

실습 10
SELECT * -- 서브
FROM CYCLE;

SELECT *  -- 메인
FROM PRODUCT;

SELECT *
FROM PRODUCT
WHERE NOT EXISTS (SELECT 'X'
              FROM CYCLE
              WHERE PRODUCT.PID = CYCLE.PID AND CID = 1);

  
                 
              