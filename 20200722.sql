mybatis
SELECT : 결과가 1건이나 복수거나
    1건 sqlSession.selectOne("네임스페이스,sqlid", [인자]) ==> overloading
        리턴타입 : resultType
    복수 1건 sqlSession.selectOne("네임스페이스,sqlid", [인자]) ==> overloading
        리턴타입 List<resulType>
        
        
오라클 계층쿼리 : 하나의 테이블(혹은 인라인 뷰)에서 
               특정 행을 기준으로 다른 행을 찾아가는 문법
조인 : 테이블 - 테이블
계층쿼리 : 행 - 행

1.시작점을 설정
2.시작점과 다른 행을 연결시킬 조건을 기술;


1.시작점 : MGR 정보가 없는 킹
2.연결 조건 : KING을 MGR컬럼으로 하는 사원

SELECT LPAD('기준문자열', 15,'*')
FROM DUAL;


SELECT LPAD(' ', (LEVEL - 1) * 4) || ENAME, LEVEL
FROM EMP
START WITH ename = 'BLAKE'
CONNECT BY  PRIOR EMPNO = MGR;


최하단 노드에서 상위 노드로 연결하는 상향식 연결방법
시작점 : SMITH

PRIOR 키워드는 CONNECT BY 키워드와 떨어져서 사용해도 무관
PRIOR 키워드는 현재 읽고 있는 행을 지칭하는 키워드

SELECT LPAD(' ', (LEVEL-1) *4) || ENAME, EMP.*
FROM EMP
START WITH ENAME = 'SMITH'
CONNECT BY EMPNO = PRIOR MGR AND PRIOR HIREDATE < HIREDATE;

SELECT *
FROM DEPT_H;



1.나의 풀이
SELECT LPAD(' ', (LEVEL-1) * 4) || DEPTNM, LEVEL
FROM DEPT_H
START WITH P_DEPTCD IS NULL
CONNECT BY PRIOR DEPTCD = P_DEPTCD;

2.선생님 풀이
SELECT LPAD(' ', (LEVEL - 1) * 4) || DEPTNM, LEVEL
FROM DEPT_H
START WITH DEPTNM = 'XX회사'
CONNECT BY PRIOR DEPTCD = P_DEPTCD;

1.나의 풀이
SELECT DEPTCD,LPAD(' ', (LEVEL - 1) * 4) || DEPTNM DEPTNM,P_DEPTCD,LEVEL
FROM DEPT_H
START WITH DEPTNM = '디자인팀'
CONNECT BY  DEPTCD = PRIOR P_DEPTCD;