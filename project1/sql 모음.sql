--ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
---- 관리자계정 들어오자마자 실행하기!
--
--DROP USER MEMBER_LSY CASCADE;
--
--
--
---- 수업용 프로젝트 계정 생성
--CREATE USER project IDENTIFIED BY project1234;
--
---- 권한 부여
--GRANT CONNECT, RESOURCE, CREATE VIEW TO project;
--
---- 객체 생성 공간 할당
--ALTER USER project DEFAULT TABLESPACE SYSTEM
--QUOTA UNLIMITED ON SYSTEM;

--------------------------------------------------------

CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"MEMBER_EMAIL"	VARCHAR2(50)		NOT NULL,
	"MEMBER_PW"	VARCHAR2(100)		NOT NULL,
	"MEMBER_NICKNAME"	VARCHAR2(30)		NOT NULL,
	"MEMBER_TEL"	CHAR(11)		NOT NULL,
	"MEMBER_ADDRESS"	VARCHAR2(300)		NULL,
	"PROFILE_IMG"	VARCHAR2(300)		NULL,
	"ENROLL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"AUTHORITY"	NUMBER	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원 번호(SEQ_MEMBER_NO)';

COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원 이메일(아이디로 사용)';

COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원 비밀번호(암호화 진행)';

COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS '회원 닉네임(중복 X)';

COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS '휴대폰 번호(- 없음)';

COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS" IS '회원 주소';

COMMENT ON COLUMN "MEMBER"."PROFILE_IMG" IS '프로필 이미지 경로';

COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS '회원가입일';

COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL" IS '탈퇴여부(N : 탈퇴X, Y : 탈퇴O)';

COMMENT ON COLUMN "MEMBER"."AUTHORITY" IS '회원 권한(1 : 일반, 2 : 관리자)';

CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	VARCHAR2(150)		NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"B_CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"B_UPDATE_DATE"	DATE		NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"BOARD_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_CODE"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글 번호(SEQ_BOARD_NO)';

COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글 제목';

COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글 내용';

COMMENT ON COLUMN "BOARD"."B_CREATE_DATE" IS '게시글 작성일';

COMMENT ON COLUMN "BOARD"."B_UPDATE_DATE" IS '마지막 수정일(수정 시 UPDATE)';

COMMENT ON COLUMN "BOARD"."READ_COUNT" IS '조회수';

COMMENT ON COLUMN "BOARD"."BOARD_DEL_FL" IS '삭제 여부(N : 삭제X, Y : 삭제O)';

COMMENT ON COLUMN "BOARD"."MEMBER_NO" IS '작성자 회원 번호';

COMMENT ON COLUMN "BOARD"."BOARD_CODE" IS '게시판 코드 번호';

CREATE TABLE "BOARD_IMG" (
	"IMG_NO"	NUMBER		NOT NULL,
	"IMG_PATH"	VARCHAR2(300)		NOT NULL,
	"IMG_RENAME"	VARCHAR2(30)		NOT NULL,
	"IMG_ORIGINAL"	VARCHAR2(300)		NOT NULL,
	"IMG_ORDER"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_IMG"."IMG_NO" IS '이미지 번호(SEQ_IMG_NO)';

COMMENT ON COLUMN "BOARD_IMG"."IMG_PATH" IS '이미지 저장 폴더 경로';

COMMENT ON COLUMN "BOARD_IMG"."IMG_RENAME" IS '변경된 이미지 파일 이름';

COMMENT ON COLUMN "BOARD_IMG"."IMG_ORIGINAL" IS '원본 이미지 파일 이름';

COMMENT ON COLUMN "BOARD_IMG"."IMG_ORDER" IS '이미지 파일 순서 번호';

COMMENT ON COLUMN "BOARD_IMG"."BOARD_NO" IS '이미지가 첨부된 게시글 번호';

CREATE TABLE "BOARD_LIKE" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_LIKE"."BOARD_NO" IS '게시글 번호';

COMMENT ON COLUMN "BOARD_LIKE"."MEMBER_NO" IS '좋아요 누른 회원 번호';

CREATE TABLE "COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"COMMENT_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"C_CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"COMMENT_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PARENT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "COMMENT"."COMMENT_NO" IS '댓글 번호(SEQ_COMMENT_NO)';

COMMENT ON COLUMN "COMMENT"."COMMENT_CONTENT" IS '댓글 내용';

COMMENT ON COLUMN "COMMENT"."C_CREATE_DATE" IS '댓글 작성일';

COMMENT ON COLUMN "COMMENT"."COMMENT_DEL_FL" IS '댓글 삭제 여부(N : 삭제, Y : 삭제O)';

COMMENT ON COLUMN "COMMENT"."BOARD_NO" IS '댓글이 작성된 게시글 번호';

COMMENT ON COLUMN "COMMENT"."MEMBER_NO" IS '댓글 작성자 회원 번호';

COMMENT ON COLUMN "COMMENT"."PARENT_NO" IS '부모 댓글 번호';

CREATE TABLE "BOARD_TYPE" (
	"BOARD_CODE"	NUMBER		NOT NULL,
	"BOARD_NAME"	VARCHAR2(300)		NOT NULL
);

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_CODE" IS '게시판 종류별 코드 번호(SEQ_BOARD_CODE)';

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_NAME" IS '게시판 이름';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "PK_BOARD_IMG" PRIMARY KEY (
	"IMG_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "PK_BOARD_LIKE" PRIMARY KEY (
	"BOARD_NO",
	"MEMBER_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);

ALTER TABLE "BOARD_TYPE" ADD CONSTRAINT "PK_BOARD_TYPE" PRIMARY KEY (
	"BOARD_CODE"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BOARD_TYPE_TO_BOARD_1" FOREIGN KEY (
	"BOARD_CODE"
)
REFERENCES "BOARD_TYPE" (
	"BOARD_CODE"
);

ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "FK_BOARD_TO_BOARD_IMG_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_LIKE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_LIKE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_BOARD_TO_COMMENT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_COMMENT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_COMMENT_TO_COMMENT_1" FOREIGN KEY (
	"PARENT_NO"
)
REFERENCES "COMMENT" (
	"COMMENT_NO"
);


--------------------------------------------------

-- 시퀀스 생성
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE;  --회원 번호
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;  --게시글 번호
CREATE SEQUENCE SEQ_IMG_NO NOCACHE;  --게시글 이미지 번호
CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE;  --댓글 번호
CREATE SEQUENCE SEQ_BOARD_CODE NOCACHE;  --게시판 종류 코드 번호


-- 게시판 종류 추가
INSERT INTO BOARD_TYPE VALUES(SEQ_BOARD_CODE.NEXTVAL, '공지 사항');
INSERT INTO BOARD_TYPE VALUES(SEQ_BOARD_CODE.NEXTVAL, '자유 게시판');
INSERT INTO BOARD_TYPE VALUES(SEQ_BOARD_CODE.NEXTVAL, '질문 게시판');
INSERT INTO BOARD_TYPE VALUES(SEQ_BOARD_CODE.NEXTVAL, '테스트 게시판');

COMMIT;

-- 게시판 종류 조회
SELECT * FROM BOARD_TYPE ORDER BY 1;


-- 회원 샘플데이터 삽입
INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user01@kh.or.kr', 'pass01!', 
		'유저일', '01012345678', '04540,,서울시 중구 남대문로 120,,2층',
		DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user02@kh.or.kr', 'pass02!', 
		'이번유저', '01022222222', '04540,,서울시 중구 남대문로 120,,3층',
		DEFAULT, DEFAULT, DEFAULT, DEFAULT);

COMMIT;



-- 로그인 SQL
SELECT MEMBER_NO, MEMBER_EMAIL, MEMBER_NICKNAME, 
		MEMBER_TEL, MEMBER_ADDRESS, PROFILE_IMG, AUTHORITY, 
		TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') AS ENROLL_DATE 
FROM "MEMBER"
WHERE MEMBER_DEL_FL = 'N'
AND MEMBER_EMAIL = 'user01@kh.or.kr'
AND MEMBER_PW = 'pass01!';


-- 회원 정보 수정
UPDATE "MEMBER" SET
MEMBER_NICKNAME = '변경된닉네임',
MEMBER_TEL = '01012345611',
MEMBER_ADDRESS = '12345,,서울,,어딘가'
WHERE MEMBER_NO = 4 ;  
					--> 로그인한 회원의 번호

SELECT * FROM "MEMBER";


UPDATE "MEMBER" SET
MEMBER_PW = '$2a$10$WbMM9ZEcO.MMc8dEz3Un1Ob/ryDkRA3rK0funrJQTHKwbhEeJWN2m';

COMMIT;

-- bcrypt 암호화 적용 시 로그인 SQL
SELECT MEMBER_NO, MEMBER_EMAIL, MEMBER_PW, MEMBER_NICKNAME,
   MEMBER_TEL, MEMBER_ADDRESS, PROFILE_IMG, AUTHORITY,
   TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') AS ENROLL_DATE
FROM "MEMBER"
WHERE MEMBER_DEL_FL = 'N'
AND MEMBER_EMAIL = 'user02@email.com';


SELECT * FROM "MEMBER";

COMMIT;

SELECT * FROM "MEMBER";


-- 탈퇴하지 않은 회원 중 이메일이 같은 사람의 수 조회
-- 0: 중복x / 1:중복O
SELECT COUNT(*)
FROM "MEMBER"
WHERE MEMBER_EMAIL = 'user0111@kh.or.kr'
AND MEMBER_DEL_FL = 'N';



-- 메일 중복 검사
SELECT COUNT(*)
FROM "MEMBER"
WHERE MEMBER_EMAIL = 'user0111@kh.or.kr'
AND MEMBER_DEL_FL = 'N'


-- 닉네임 중복 검사
SELECT COUNT(*)
FROM "MEMBER"
WHERE MEMBER_NICKNAME = '유저일111'
AND MEMBER_DEL_FL = 'N'


-- 이메일이 일치하는 회원 정보 조회
SELECT MEMBER_NO, MEMBER_EMAIL, MEMBER_NICKNAME, MEMBER_ADDRESS, MEMBER_DEL_FL,  
		TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일"') ENROLL_DATE 
FROM "MEMBER"
WHERE MEMBER_EMAIL = 'user01@kh.or.kr'
AND ROWNUM = 1;



-- 회원 목록 조회
SELECT MEMBER_NO, MEMBER_EMAIL, MEMBER_DEL_FL
FROM "MEMBER"
ORDER BY MEMBER_NO;


SELECT * FROM MEMBER;

SELECT * FROM BOARD_TYPE;


-- COMMENT 테이블 PARENT_NO 컬럼 NULL 허용
ALTER TABLE "COMMENT" 
MODIFY PARENT_NO NULL;


-- BOARD 테이블 샘플데이터 삽입(PL/SQL)
BEGIN 
	FOR I IN 1..2000 LOOP
		INSERT INTO BOARD 
		VALUES(SEQ_BOARD_NO.NEXTVAL, 
			   SEQ_BOARD_NO.CURRVAL || '번째 게시글',
			   SEQ_BOARD_NO.CURRVAL || '번째 게시글입니다.<br>안녕하세요',
			   DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1, 
			   CEIL(DBMS_RANDOM.VALUE(0,4)));
	END LOOP;
END;
/

COMMIT;
 
SELECT * FROM BOARD_TYPE;

SELECT COUNT(*) FROM "BOARD" WHERE BOARD_CODE=4;


-- COMMENT 테이블 샘플 데이터 삽입(PL/SQL)
BEGIN
   FOR I IN 1..2000 LOOP
      INSERT INTO "COMMENT" 
      VALUES(SEQ_COMMENT_NO.NEXTVAL, 
            SEQ_COMMENT_NO.CURRVAL || '번째 댓글',
            DEFAULT, DEFAULT,
             CEIL(DBMS_RANDOM.VALUE(0,2000)),
             1, NULL);
   END LOOP;
END;
/

COMMIT;


-- BOARD_IMG 테이블 샘플데이터 삽입
SELECT * FROM BOARD_IMG;


SELECT * FROM "BOARD"
WHERE BOARD_CODE = 1
ORDER BY 1 DESC;
-- 2000 1999 1997 1990

INSERT INTO BOARD_IMG 
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/', 
      '20221116105843_00001.gif', '1.gif', 0, 2000);
     
INSERT INTO BOARD_IMG 
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
   '20221116105843_00002.gif', '2.gif', 0, 1999);

INSERT INTO BOARD_IMG 
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
   '20221116105843_00003.gif', '3.gif', 0, 1997);

INSERT INTO BOARD_IMG 
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
   '20221116105843_00004.gif', '4.gif', 0, 1990);
 
SELECT * FROM BOARD_IMG;  
COMMIT;


-- BOARD_LIKE 테이블 샘플 데이터 삽입
SELECT * FROM  BOARD_LIKE;

INSERT INTO BOARD_LIKE VALUES(2000, 1);
INSERT INTO BOARD_LIKE VALUES(1999, 1);
COMMIT;


-- 특정 게시판 목록 조회 _상호연관 서브쿼리(상관쿼리)
-- 게시글 번호, 제목, 작성자닉네임, 조회수, 작성일 +댓글수, 좋아요수, 썸네일
SELECT BOARD_NO, BOARD_TITLE, MEMBER_NICKNAME, READ_COUNT, 
	CASE  
      WHEN SYSDATE - B_CREATE_DATE < 1/24/60
      THEN FLOOR( (SYSDATE - B_CREATE_DATE) * 24 * 60 * 60 ) || '초 전'
      WHEN SYSDATE - B_CREATE_DATE < 1/24
      THEN FLOOR( (SYSDATE - B_CREATE_DATE) * 24 * 60) || '분 전'
      WHEN SYSDATE - B_CREATE_DATE < 1
      THEN FLOOR( (SYSDATE - B_CREATE_DATE) * 24) || '시간 전'
      ELSE TO_CHAR(B_CREATE_DATE, 'YYYY-MM-DD')
   END B_CREATE_DATE,
	(SELECT COUNT(*) FROM "COMMENT" C
	WHERE C.BOARD_NO = B.BOARD_NO) COMMENT_COUNT,
	(SELECT COUNT(*) FROM BOARD_LIKE L
	WHERE L.BOARD_NO = B.BOARD_NO) LIKE_COUNT,
	(SELECT IMG_PATH || IMG_RENAME FROM BOARD_IMG I
	WHERE IMG_ORDER = 0
	AND I.BOARD_NO = B.BOARD_NO) THUMBNAIL
FROM BOARD B
JOIN "MEMBER" USING (MEMBER_NO)
WHERE BOARD_CODE = 1
AND BOARD_DEL_FL = 'N'
ORDER BY BOARD_NO DESC;

-- 댓글 수
SELECT COUNT(*) FROM "COMMENT"
WHERE BOARD_NO = 1997;


-- 좋아요 수
SELECT COUNT(*) FROM BOARD_LIKE L
WHERE L.BOARD_NO = 2000;

-- 썸네일 이미지 조회     
		-- // 하나의 경로로 나옴
SELECT IMG_PATH || IMG_RENAME FROM BOARD_IMG I
WHERE IMG_ORDER = 0
AND I.BOARD_NO = 2000;


-- PAGING 페이징처리(일정 개수로 잘라서 출력하는 것) : RowBounds

-- 게시글 수 조회(삭제 제외)
SELECT COUNT(*) FROM BOARD 
WHERE BOARD_CODE = 1,
AND BOARD_DEL_FL 'N';


-- 특정 게시글 상세 조회
SELECT BOARD_NO, BOARD_TITLE, BOARD_CONTENT, READ_COUNT,
	TO_CHAR(B_CREATE_DATE, 'YYYY"년" MM"월" DD"일 HH24:MI:SS') B_CREATE_DATE,
	TO_CHAR(B_UPDATE_DATE, 'YYYY"년" MM"월" DD"일 HH24:MI:SS') B_UPDATE_DATE,
	MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG
FROM BOARD 
JOIN MEMBER USING(MEMBER_NO)
WHERE BOARD_NO = 2000
AND BOARD_DEL_FL = 'N';


-- 특정 게시글 이미지 모두 조회
SELECT * FROM BOARD_IMG 
WHERE BOARD_NO = 2000
ORDER BY IMG_ORDER; 




INSERT INTO BOARD_IMG
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
'20221116105843_00002.gif', '2.gif', 1 , 2000);
INSERT INTO BOARD_IMG
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
'20221116105843_00003.gif', '3.gif', 2 , 2000);
INSERT INTO BOARD_IMG
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
'20221116105843_00004.gif', '4.gif', 3 , 2000);

COMMIT;


-- 특정 게시글 댓글 모두 조회(어려움)
SELECT COMMENT_NO, COMMENT_CONTENT, 
	TO_CHAR(C_CREATE_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') C_CREATE_DATE,
	BOARD_NO, MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG, 
	PARENT_NO, COMMENT_DEL_FL
FROM "COMMENT"
JOIN MEMBER USING(MEMBER_NO)	
WHERE BOARD_NO = 2000
AND COMMENT_DEL_FL = 'N';


SELECT*FROM "MEMBER"
WHERE MEMBER_DEL_FL = 'N'; 
-- 1번, 13번

 

-- 댓글 삽입
--INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 댓글1', DEFAULT, DEFAULT, 게시글번호, 회원번호, null);
--INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 댓글2', DEFAULT, DEFAULT, 게시글번호, 회원번호, null);
--INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글1', DEFAULT, DEFAULT, 게시글번호, 회원번호, 부모댓글1번호);
--INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글2', DEFAULT, DEFAULT, 게시글번호, 회원번호, 부모댓글1번호);
--INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글3', DEFAULT, DEFAULT, 게시글번호, 회원번호, 부모댓글1번호);
--
--INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글4', DEFAULT, DEFAULT, 게시글번호, 회원번호, 부모댓글2번호);
--INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글5', DEFAULT, DEFAULT, 게시글번호, 회원번호, 부모댓글2번호);
--COMMIT;


INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 댓글1', DEFAULT, DEFAULT, 2000, 1, null);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '부모 댓글2', DEFAULT, DEFAULT, 2000, 2, null);

INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글1', DEFAULT, DEFAULT, 2000, 10, 2009);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글2', DEFAULT, DEFAULT, 2000, 11, 2009);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글3', DEFAULT, DEFAULT, 2000, 13, 2009);

INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글4', DEFAULT, DEFAULT, 2000, 12, 2010);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '대댓글5', DEFAULT, DEFAULT, 2000, 3, 2010);

ROLLBACK;

COMMIT;

/*
 부모댓글1
 - 대댓글1
 - 대댓글2
 - 대댓글3
 부모댓글2
 - 대댓글4
 - 대댓글5 
 */

/* 계층형 쿼리(START WITH, CONNECT BY, ORDER SIBLINGS BY)

- 상위 타입과 하위 타입간의 관계를 계층식으로 표현할 수 있게하는 질의어(SELECT)

- START WITH : 상위 타입(최상위 부모)으로 사용될 행을 지정 (서브쿼리로 지정 가능)

- CONNECT BY 
  -> 상위 타입과 하위 타입 사이의 관계를 규정
  -> PRIOR(이전의) 연산자와 같이 사용하여
     현재 행 이전에 상위 타입 또는 하위 타입이 있을지 규정

   1) 부모 -> 자식 계층 구조
     CONNECT BY PRIOR 자식 컬럼 = 부모 컬럼

   2) 자식 -> 부모 계층 구조
     CONNECT BY PRIOR 부모 컬럼 = 자식 컬럼

- ORDER SIBLINGS BY : 계층 구조 정렬


** 계층형 쿼리가 적용 SELECT 해석 순서 **

5 : SELECT
1 : FROM (+JOIN)
4 : WHERE
2 : START WITH
3 : CONNECT BY
6 : ORDER SIBLINGS BY

- WHERE절이 계층형 쿼리보다 해석 순서가 늦기 때문에
먼저 조건을 반영하고 싶은 경우 FROM절 서브쿼리(인라인뷰)를 이용

*/
-- 특정 게시글 댓글 모두 조회(어려움)
SELECT LEVEL, C.* FROM
	(SELECT COMMENT_NO, COMMENT_CONTENT, 
		TO_CHAR(C_CREATE_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') C_CREATE_DATE,
		BOARD_NO, MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG, 
		PARENT_NO, COMMENT_DEL_FL
	FROM "COMMENT"
	JOIN MEMBER USING(MEMBER_NO)	
	WHERE BOARD_NO = 2000
	AND COMMENT_DEL_FL = 'N') C
START WITH PARENT_NO IS NULL  -- PARENT_NO가 NULL일 경우 최상위 부모
CONNECT BY PRIOR COMMENT_NO = PARENT_NO  -- 부모 -> 자식 계층 구조 
ORDER SIBLINGS BY COMMENT_NO;



SELECT * FROM BOARD
WHERE BOARD_NO = 2000;



-- 조회수 증가
UPDATE "BOARD" 
SET READ_COUNT = READ_COUNT +1
WHERE BOARD_NO = 2000;

ROLLBACK;



-- 게시글 상세조회(좋아요 수 추가) _상관쿼리 사용
SELECT BOARD_NO, BOARD_TITLE, BOARD_CONTENT, READ_COUNT,
	TO_CHAR(B_CREATE_DATE, 'YYYY"년" MM"월" DD"일 HH24:MI:SS') B_CREATE_DATE,
	TO_CHAR(B_UPDATE_DATE, 'YYYY"년" MM"월" DD"일 HH24:MI:SS') B_UPDATE_DATE,
	MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG,
	(SELECT COUNT(*) FROM BOARD_LIKE L 
	  WHERE L.BOARD_NO = B.BOARD_NO)LIKE_COUNT
FROM BOARD B
JOIN MEMBER USING(MEMBER_NO)
WHERE BOARD_NO = 2000
AND BOARD_DEL_FL = 'N'


SELECT * FROM BOARD_LIKE;


SELECT * FROM BOARD
WHERE BOARD_NO = '1977';



-- 게시글 삽입
INSERT INTO BOARD
      VALUES(SEQ_BOARD_NO.NEXTVAL,
             #{boardTitle},
             #{boardContent},
	         DEFAULT, DEFAULT, DEFAULT, DEFAULT, 
	         #{memberNo}, 
           	 #{boardCode})


SELECT * FROM BOARD_TYPE;



-- 게시글 첨부 이미지 삽입(여러행 동시 삽입)
INSERT INTO BOARD_IMG
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
'20221116105843_00004.gif', '4.gif', 0 , 1000);
INSERT INTO BOARD_IMG
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
'20221116105843_00004.gif', '4.gif', 1 , 1000);
INSERT INTO BOARD_IMG
VALUES(SEQ_IMG_NO.NEXTVAL, '/resources/images/board/',
'20221116105843_00004.gif', '4.gif', 2 , 1000);

-- INSERT ALL : 한번에 여러 행 삽입(단, 시퀀스 사용 불가)
-- 서브쿼리를 이용한 INSERT + UNION ALL
INSERT INTO BOARD_IMG
SELECT SEQ_IMG_NO.NEXTVAL IMG_NO, A.* FROM
(SELECT '경로' IMG_PATH,
	   '변경된 파일' IMG_RENAME,
	   '원본파일명' IMG_ORIGINAL,
	   1 IMG_ORDER,
	   1000 BOARD_NO
FROM DUAL
UNION ALL
SELECT '경로2' IMG_PATH,
	   '변경된 파일2' IMG_RENAME,
	   '원본파일명2' IMG_ORIGINAL,
	   2 IMG_ORDER,
	   1000 BOARD_NO
FROM DUAL) A

--// 시퀀스 번호가 각각 있었을 때는 오류가 남
-- 두개를 UNION ALL 로 묶고 조회하면 됨.
	  
SELECT * FROM BOARD_IMG; 

ROLLBACK;


SELECT * FROM BOARD_IMG
WHERE BOARD_NO = 2010;


-- 이미지 삭제
DELETE FROM BOARD_IMG
WHERE BOARD_NO = 2010
AND IMG_ORDER IN (1,2,4);

ROLLBACK;


-- 게시글 수정(제목, 내용)	
UPDATE BOARD SET
BOARD_TITLE = #{boardTitle},
BOARD_CONTENT = #{boardContent)
WHERE BOARD_NO = #{boardNO)



-- 검색 조건이 일치하는 게시글 수 조회
SELECT COUNT(*) 
FROM "BOARD" 
JOIN "MEMBER" USING(MEMBER_NO)
WHERE BOARD_CODE = 1
AND BOARD_DEL_FL = 'N'
-- 제목 검색
--AND BOARD_TITLE LIKE '%10%'
-- 내용 검색
--AND BOARD_CONTENT LIKE '%10%'
-- 제목+내용 검색
--
-- 작성자 닉네임
AND MEMBER_NICKNAME LIKE '%유저%'




