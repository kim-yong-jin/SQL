DROP TABLE dept_test;

제약조건 생성 방법 2번 :
테이블 생성시 컬럼  기술이후 별도로 제약 조건을 기술하는 방법
dept_test 테이블의 deptno컬럼을 대상으로  PRIMARY key 제약 조건생성

CREATE TABLE DEPT_TEST
(DEPTNO    NUMBER(2), 
DNAME     VARCHAR2(14), 
LOC       VARCHAR2(13),

constraint pk_dept_test PRIMARY KEY(deptno)
);

dept_test테이블에 deptno가 동일한 값을 갖는 INSERT 쿼리를 2개 생성하여
2개의 쿼리가 정상적으로 동작하는지 테스트
INSERT INTO dept_test(deptno) VALUES(99);

SELECT *
FRom dept_test;



NOT NULL 제약조건 : 컬럼 레벨에 기술, 테이블 기술 없음, 테이블 수정시 변경 가능


CREATE TABLE DEPT_TEST
(deptno     NUMBER(2) constraint pk_dept_test PRIMARY KEY, 
DNAME     VARCHAR2(14) NOT NULL, 
LOC       VARCHAR2(13)

);

INSERT INTO dept_test VALUES(99,NULL,'대전');


UNIQUE 제약조건 : 해당 컬럼의 값이 다른 행에 나오지 않도록 (중복되지 않도록)
                데이터 무결성을 지켜주는 조건
                (ex : 사번, 학번)
수업시간 UNIQUE 제약조건 명명 규칙 : uk_테이블명_해당컬럼명;


DROP TABLE dept_test;


CREATE TABLE DEPT_TEST
(DEPTNO    NUMBER(2), 
DNAME     VARCHAR2(14), 
LOC       VARCHAR2(13),
-- dname,loc를 결합해서 중복되는 데이터가 없으면 됌
-- 다음 두개는 중복
-- ddit, daejeon
-- ddit, daejeon
-- 아래는 부서명은 동일하지만 loc 정보가 다르기 때문에 dname, loc 
-- 조합은 서로 다른 데이터 
-- ddit, daejeon
-- ddit, 대전
constraint uk_dept_test_dname UNIQUE(dname,loc)
);              

dname, loc 컬럼 조합으로 중복된 데이터가 들어가는지 안들어가는지 테스트
dname, loc 컬럼 조합의 값이 동일한 데이터인 경우 ==> 에러 UNIQUE 제약 조건에 의해
INSERT INTO dept_test VALUES(99,'ddit','대전');
select *
from dept_test;
            
            
rollback;
dname, loc 컬럼 조합의 값이 하나의 컬럼만 동일한 데이터인 경우 
INSERT INTO dept_test VALUES(99,'ddit','대전');
INSERT INTO dept_test VALUES(99,'ddit','daejeon');
            
select *
from dept_test;
                        
FOREIGN KEY : 참조 키
한 테이블의 컬럼의 값이 참조하는 테이블의 컬럼 값중에 존재하는 값만 입력되도록
제어하는 제약 조건

즉 FOREIGN KEY 경우 두개의 테이블간의 제약조건

*참조되는 테이블 컬럼에는(DEPT_TEST.DEPTNO) 인덱스가 생성되어 있어야 한다
자세한 내용은 INDEX 편에서 다시 확인.

DROP TABLE dept_test;



CREATE TABLE DEPT_TEST
(deptno     NUMBER(2), 

 DNAME     VARCHAR2(14), 
 
 LOC       VARCHAR2(13),
 constraint pk_dept_test PRIMARY KEY(deptno)
);

테스트 데이더 준비
dept_test테이블의 deptno 컬럼을 참조하는 emp_test 테이블 생성

DESC emp;
CREATE TABLE emp_TEST
(empno     NUMBER(4), 

 ename     VARCHAR(10), 
 
 deptno       NUMBER(2) REFERENCES dept_test(deptno)
);

1.dept_test 테이블에는 부서번호가 1번인 부서가 존재
2.emp_test 테이블의 deptno 컬럼으로 dept_test.deptno 컬럼을 강조
  ==> emp_test 테이블의 deptno 컬럼에는 dept_test.deptno 컬럼에 존재한 값만
      입력하는 것이 가능
      
dept_test 테이블에 존재하는 부서번호로 emp_test테이블에 입력하는 경우
INSERT INTO emp_test VALUES(9999,'brown',1);


dept_test  테이블에 존재하지 않는 부서번호로 emp_test 테이블에 입력하는 경우 ==> 에러
INSERT INTO emp_test VALUES(9998,'sally',1);
                
FK 제약조건을 테이블 컬럼 기술이후에 별도로 기술하는 경우 
CONSTRAINT : 제약조건명 제약조건 타입 대상컬럼 REFERENCES 참조 테이블 (참조테이블의 컬럼명)
명령규칙 : FK_타겟테이블명_참조테이블명[idx]
DROP TABLE emp_test;

CREATE TABLE emp_test
(empno     NUMBER(4), 

 ename     VARCHAR2(10), 
 
 deptno       NUMBER(2),
 constraint FK_emp_test_dept_test FOREIGN  KEY(deptno) 
                                  REFERENCES dept_test (deptno)
);

dept_test 테이블에 존재하는 부서번호로 emp_test테이블에 입력하는 경우
INSERT INTO emp_test VALUES(9999,'brown',1);

select *
from emp_test;

dept_test  테이블에 존재하지 않는 부서번호로 emp_test 테이블에 입력하는 경우 ==> 에러
INSERT INTO emp_test VALUES(9998,'sally',2);    

참조되고 있는 부모쪽 데이터를 삭제하는 경우

dept_test 테이블에 1번 부서가 존재하고
emp_test 테이블의 brown 사원이 1번 부서에 속한 상태에서
1번 부서를 삭제하는 경우.
FK의 기본 설정에서는 참조하는 데이터가 없어 질 수 없기 때문에 에러 발생
SELECT *
FROM emp_test;

DELETE dept_test
WHERE deptno = 1;



FK 생성시 옵션
0.DEFAULT : 무결성이 위배되는 경우 에러
1.on delete cascade : 부모 데이터를 삭제할 경우 참고있는 자식 데이터를 같이 삭제
 dept_test 테이블의 1번 부서를 삭제하면 1번 부서에 소속된 brown 사원도 삭제
 
2.on delete set null = 부모 데이터를 삭제할 경우 참조하는 
                       자식 데이터의 컬럼을 null로 수정
 

CHECK 제약조건 : 컬럼에 입려되는 값을 검증하는 제약조건
EX : SALLRY 컬럼(급여)이 음수가 입력되는 것을 부자연스러움
     성별 컬럼에 남, 여가 아닌 값이 들어 오는 것은 데이터가 잘못된 것
     직원 구분이 정직원, 임시직 2개가 존재할때 다른 값이 들어오면 논리적으로 어긋남
      
DROP TABLE emp_test;


CREATE TABLE emp_test(
EMPNO    NUMBER(4), 
ENAME     VARCHAR(10), 
--SAL NUMBER(7,2) CHECK (SAL > 0)
SAL NUMBER(7,2) CONSTRAINT SAL_NO_ZERO CHECK(Sal > 0)
);               



INSERT INTO emp_test VALUES(4244,'tom',-5);

select *
from emp_test;

테이블 생성 + [제약조건 포함]
: CTAS
CREATE TABLE 테이블명 AS
SELECT ....


CREATE TABLE MEMBRER_20200713 AS
SELECT *
FROM MEMBER;
MEMBER  테이블에 작업

CTAS 명령을 이용하여 EMP 테이블의 모든 데이터를 바탕으로 EMP_TEST 테이블 생성
DROP TABLE EMP_TEST;

CREATE TABLE EMP_TEST AS
SELECT *
FROM EMP;

SELECT *
FROM EMP_TEST;

테이블 칼럼 구조만 복사하고 싶을때 WHERE절에 항상 FALSE가 되는
조건을 기술하여 생성가능
CREATE TABLE EMP_TEST2 AS
SELECT *
FROM EMP
WHERE 1 != 1;

SELECT *
FROM EMP_TEST2;

생성된 테이블 변경
컬럼 작업
1.존재하지 않았던 새로운 컬럼 추가
 ** 테이블의 컬럼 기술순서를 제어하는건 불가
 ** 신규로 추가하는 컬럼의 경우 컬럼순서가 항상 테이블의 마지막
 ** 설계를 할때 컬럼순서에 충분히 고려, 누락된 컬럼이 없는지도 고려
 
 2.존재하는 컬럼 삭제
  ** 제약조건(FK) 주의
  
3.존재하는 컬럼 변경
 * 컬럼명 변경 ==> FK와 관계 없이 알아서 적용해줌
 * 그 외적인 부분에서는 사실상 불가능 하다고 생각하면 편함
    데이터가 이미 들어가 있는 테이블의 경우 
    1.컬럼 사이즈 변경
    2.컬럼 타입 변경
    ==> 설계시 충분한 고려
    
    제약조건 작업
    1.제약조건 추가
    2.제약조건 삭제
    3.제약조건 비활성화 / 활성화

DROP TABLE EMP_TEST;

CREATE TABLE EMP_TEST (
    EMPNO NUMBER(4),
    ENAME VARCHAR(10),
    DEPTNO NUMBER(2)
);
테이블 수정
ALTER TABLE EMP_TEST ADD ( hp VARCHAR2(11) );

SELECT *
FROM EMP_TEST;

DESC EMP_TEST;

2.컬럼 수정(MODIFY)
 ** 데이터가 존재하지 않을 때는 비교적 자유롭게 수정 가능
ALTER TABLE EMP_TEST MODIFY (HP VARCHAR2(5));
ALTER TABLE EMP_TEST MODIFY (HP NUMBER);


컬럼 기본값 설정
ALTER TABLE EMP_TEST MODIFY (HP DEFAULT 123);

INSERT INTO EMP_TEST (EMPNO, ENAME, DEPTNO)
               VALUES(9999, 'brown', NULL);
               
SELECT *
FROM EMP_TEST;

컬럼명칭 변경(RENAME COLUMN 현재 컬럼명 TO 변경할 컬럼명)
ALTER TABLE EMP_TEST RENAME COLUMN HP TO CELL;

SELECT *
FROM EMP_TEST;

컬럼 삭제(DROP,DROP COLUMN)
ALTER TABLE EMP_TEST DROP (CELL);
ALTER TABLE EMP_TEST DROP COLUMN CELL;

DESC EMP_TEST;

3.제약조건 추가, 삭제 (ADD, DROP)
            +
  테이블 레벨의 제약조건 생성

ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약 조건타입 대상 컬럼;

DROP TABLE EMP_TEST;

CREATE TABLE EMP_TEST (
    EMPNO NUMBER(4),
    ENAME VARCHAR(10),
    DEPTNO NUMBER(2)
);

테이블 수정을 통해서 EMP_TEST 테이블의 EMPNO 컬럼에 PRIMARY KEY 제약조건 추가

ALTER TABLE EMP_TEST ADD CONSTRAINT PK_EMP_TEST PRIMARY KEY (EMPNO);

제약조건 삭제 (DROP)
ALTER TABLE EMP_TEST DROP CONSTRAINT PK_EMP_TEST;

SELECT *
FROM EMP_tEST;

제약조건 활성화 비활성화
제약조건 drop은 제약조건 자체를 삭제하는 행위
제약조건 비활성화는 제약조건 자체는 남겨두지만, 사용하지 않는 형태
때가되면 다시 활성화 하여 데이터 무결성에 대한 부분을 강제할 수 있음


DROP TABLE EMP_TEST;

CREATE TABLE EMP_TEST (
    EMPNO NUMBER(4),
    ENAME VARCHAR(10),
    DEPTNO NUMBER(2)
);

테이블 수정명령을 통해 emp_test테이블의 emp_no 컬럼으로 PRIMARY KEY 제약 생성
ALTER TABLE emp_test add constraint pk_emp_test primary key (empno);

제약 조건을 활성화 / 비활성화 (enable / disable)

ALTER TABLE EMP_TEST DISABLE CONSTRAINT PK_EMP_TEST;
SELECT *
FROM EMP_TEST;

PK_EMP_TEST 비활성화 되어있기 때문에 EMPNO 컬럼에 중복되는 값 입력이 가능

INSERT INTO EMP_TEST VALUES(9999,'brown',null);
INSERT INTO EMP_TEST VALUES(9999,'sally',null);

PK_EMP_TEST 제약조건을 활성화
ALTER TABLE EMP_TEST ENABLE CONSTRAINT PK_EMP_TEST;


SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'P';

SELECT *
FROM USER_CONS_COLUMNS
where TABLE_NAME = 'CYCLE'
AND CONSTRAINT_NAME = 'PK_CYCLE';

SELECT *
FROM USER_TAB_COMMENTS;

SELECT *
FROM USER_COL_COMMENTS;

테이블 컬럼 주석 달기
COMMENT ON TABLE 테이블명 IS '주석';
COMMENT ON COLUMN 테이블명,컬럼명 IS '주석';

EMP_TEST 테이블, 컬럼에 주석;
COMMENT ON TABLE EMP_TEST IS '사원_복제';
COMMENT ON COLUMN EMP_TEST.EMPNO IS '사번';
COMMENT ON COLUMN EMP_TEST.ENAME IS '사원이름';
COMMENT ON COLUMN EMP_TEST.DEPTNO IS '소속부서번호';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'EMP_TEST';

SELECT *
FROM USER_TAB_COMMENTS;

SELECT *
FROM USER_COL_COMMENTS;


SELECT U.TABLE_NAME, U.TABLE_TYPE, U.COMMENTS, C.COLUMN_NAME, C.COMMENTS 
FROM USER_TAB_COMMENTS U JOIN USER_COL_COMMENTS C ON (U.TABLE_NAME = C.TABLE_NAME)
WHERE U.TABLE_NAME IN('CUSTOMER','PRODUCT','CYCLE','DAILY');

ALTER TABLE EMP_TEST ADD CONSTRAINT PK_EMP_TEST PRIMARY KEY (EMPNO);

SELECT *
FROM DEPT;

ALTER TABLE EMP ADD CONSTRAINT PK_EMP PRIMARY KEY (EMPNO);
ALTER TABLE DEPT ADD CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO);
ALTER TABLE EMP ADD CONSTRAINT FK_EMP FOREIGN KEY (DEPTNO) REFERENCES(DEPTNO);

