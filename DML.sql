--데이터 조작어(DML)
--삽입 삭제 수정 조회



CREATE TABLE publisher (
	pubNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    pubName VARCHAR2(30) NOT NULL
 );
DROP TABLE publisher;
CREATE TABLE publisher (
	pubNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    pubName VARCHAR2(30) NOT NULL
 );
INSERT INTO publisher (pubNo, pubName) VALUES('1', '서울 출판사');
INSERT INTO publisher (pubNo, pubName) VALUES('2', '강남 출판사');
INSERT INTO publisher (pubNo, pubName) VALUES('3', '종로 출판사');

SELECT * FROM publisher;

-- BOOK테이블 외래키 추가
ALTER TABLE book ADD CONSTRAINT FK_book_pub FOREIGN KEY(pubNo) REFERENCES publisher(pubNo);

--INSERT
SELECT * FROM book;
--BOOK 테이블에 INSERT : 모든 컬럼값 입력
INSERT INTO book(bookNo,booKName,bookPrice,bookDate,pubNo)
    VALUES(4,'자바스크립트',23000,'2019-05-17','1');
    SELECT *FROM book;
    
    --모든 컬럼값 입력할 경우 열 이름 생략 가능 : 컬럼값이 1개라도 부족하면 오류
    --테이블 생성할 때 순서를 지켜줌
    
    INSERT INTO book 
    VALUES('5','C++프로그래밍','25000','2024-02-02','2');
    SELECT * FROM book;
    
    --여러개의 레코드를 INSERT
    --DBMS마다 차이가 있음
    /*
    INSERT ALL
    INTO 테이블명([컬럼명나열]) VALUES( 값 나열) -- 쉽표등 기호없이 INTO로 진행
    INTO 테이블명([컬럼명나열]) VALUES( 값 나열)
    INTO 테이블명([컬럼명나열]) VALUES( 값 나열)
    SELECT *
    FROM DUAL; --DUAL : 가짜(가상) 테이블
    */
    INSERT ALL
        INTO book VALUES('6','알고리즘',25000,'2023-01-15','1')
        INTO book VALUES('7','웹프로그래밍',26000,'2026-01-15','3')
    SELECT *
    FROM DUAL;
    SELECT DUAL;
    SELECT * FROM booK;
    
    INSERT ALL
        INTO book (bookNo,bookName,bookDate,pubNo)  VALUES ('8','C프로그래밍','2024-12-05','2')
    SELECT * FROM DUAL;
    SELECT * FROM book;
    
    INSERT INTO(bookNo,bookName,bookDate,pubNo)  VALUES ('9','C프로그래밍2','2024-12-05','2');
    SELECT * FROM book;
    
    --오라클은 테이블 컬럼 속성으로 자옫증가 사용 불가능
    --SEQUENCE  객체 사용하면 자옫 증가 효과 가능
    --시퀸스 사용 : 시퀸스 객체면.NEXTVAL (현재 SEQUENCE 객체의 값 반환하고증가감값으로 설정
    --시퀸스 생성
    CREATE TABLE board(
     bNo NUMBER PRIMARY KEY, -- 기본키(시퀀스 적용할 컬럼)
     bSubject VARCHAR2(30) NOT NULL,
     bName VARCHAR2(20) NOT NULL,
     bContent VARCHAR2(100) NULL
);

--데이터 삽입 
INSERT INTO board VALUES(NO_SEQ.NEXTVAL,'추석','홍길동','...');
INSERT INTO board VALUES(NO_SEQ.NEXTVAL,'추석','홍길동','...');
INSERT INTO board VALUES(NO_SEQ.NEXTVAL,'추석','홍길동','...');
INSERT INTO board VALUES(NO_SEQ.NEXTVAL,'추석','홍길동','...');

SELECT & FROM board;  

--현재 시퀸스의 값 검색 : 시퀸스.CURRVAL
SELECT NO_SEQ.CURRVAL FROM dual;

--시퀸스의 정보 검생(USER_SEQUENCES 테이블 조회)
SELECT SEQUENCE_NAME , MAX_VALUE
FROM USER_SEQUENCES;

--시퀸스 수정
ALTER SEQUENCE NO_SEQ
    MAXVALUE 1000;
    SELECT SEQUENCE_NAME, MAX_VALUE
    FROM USER_SEQUENCES;
    
    --시퀸스 삭제
    DROP SEQUENCE NO_SEQ;
    SELECT SEQUENCE_NAME, MAX_VALUE
    FROM USER_SEQUENCES;
    
    
    
--DELETE
--UPDATE
--IMPORT 된 ProductFin테이블에 대해 기본키 제약조건 추가
ALTER TABLE productfin
    ADD CONSTRAINT PK_productfin_prdno
    PRIMARY KEY(prdNo);
 /*   
--UPDATE 문
특정 열의 값을 수정하는 명령어
조건을 사용하지 ㅇ낳으면 컬럼의 전체값 동일하게 수정됨
조건에 맞는 행을 찾아서 열의 값 수정이 되도록where 절을 보통 사용
UPDATE 테이블명 SET 컬럼명 = 값 [WHERE 조건절];
*/

--상품번호가 5인 튜플의 상품명을 'UHD-TV'로 수정
SELECT * FROM productFin;
UPDATE productFin SET prdName ='UHD-TV';
SELECT * FROM productFIn;

COMMIT; -- 여기까지DB에 반영
--상품으로 'UHD-TV'로 수정
/*
DML등 쿼리 구문은 수정과 관련된 내용은 바로 DB에 반영되지 않음(DML은 예외)
롤백 가능
COMMIT : 최종 반영(이전 COMMIT  다음 문장부터 현재 COMMIT 전 문장까지)
ROLLBACK : 취소(이전 커밋된 내용 바로 다음 명령까지 취소)

*/
/*
    DELETE 문
    테이블에 있는 기존 행을 삭제하라는 명령어
    기본형식
    DELETE FROM 테이블명 [WHERE 조건] ;
    DELETE문에서 WHERE 절 생략하면 테이블의 모든 데이터가 삭제됨
    삭제는 레코드 단위로 삭제됨 : 특정 컬럼의 특정 값만 삭제는 불가능
*/

--상품명이 '그늘막 텐트'인 레코드를 삭제

DELETE FROM productFin WHERE prdName ='그늘막 텐트';
DELETE FROM productFin;
ROLLBACK;
SELECT * FROM productFin;
--PRODUCTFIN 테이블의 모든 레코드를 삭제
DELETE FROM productFin;












