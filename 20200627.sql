문자형
CHAR : 고정적인 데이터 (속도가 빠름)
VARCHAR2 : 변할수 있는 데이터 (속도가 느림)

NCHAR : 여러언어를 한번에 사용가능 바이트를 많이 사용
NVARCHAR2

Size => 1byte

SELECT LENGTHB('남자여자') FROM DUAL; // 12 byte

Character 형식
LONG

CLOB 

NCLOB

숫자형: NUMBER로 정수와 실수를 모두 사용

NUMBER


INSERT INTO MEMBER1(ID,NAME,PWD) VALUES('YONGJIN','김용진','1234');
INSERT INTO MEMBER1(ID,NAME,PWD) VALUES('Dongsu','1234');
INSERT INTO MEMBER1(ID,NAME,PWD) VALUES('DUCKYOUNG','김덕영','1234');
INSERT INTO NOTICE (ID,TITLE,WRITER_ID,CONTENT,REGDATE) VALUES('4',' 날씨는 어때?','as','SdO','20/10/10');
SELECT id "user id", name ,pwd 
FROM member1;

UPDATE MEMBER1 SET PWD = '333', name = '이동수' WHERE ID = 'Dongsu';
DELETE NOTICE WHERE ID = '4';

트랙잭션 : 업무 실행단위 /논리 명령 단위 / 개념상의

업무적인 단위           물리적인 명령어 단위
계좌이체          ==>  UPDATE (현재 세션을 위한 임시저장소에서 테스트)
이벤트 게시글 등록  ==>  INSERT UPDATE

SELECT * FROM NOTICE WHERE HIT >= 0 AND HIT <= 2;
SELECT * FROM NOTICE WHERE HIT BETWEEN 0 AND 2;
SELECT * FROM NOTICE WHERE HIT IN(0,2,7);
SELECT * FROM NOTICE WHERE HIT NOT IN(0,2,7);

 LIKE, %, _
 회원중 '이'씨 성을 조회 하시오.
 SELECT * 
 FROM MEMBER1 
 WHERE NAME LIKE '이__';

SELECT *
FROM MEMBER1
WHERE NAME LIKE '%도%';

SELECT * FROM NOTICE WHERE TITLE LIKE '%DB%';

정규식을 이용한 패턴 연산

ROWNUM
SELECT * FROM (SELECT ROWNUM NUM, NOTICE.* FROM NOTICE)
WHERE NUM BETWEEN 6 AND 10;

SELECT NOTICE.* FROM NOTICE;




