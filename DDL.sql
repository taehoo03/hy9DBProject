-- 주석기호
-- 데이터 정의어 DDL
-- CREATE문 : 구조 생성
-- CREATE TABLE|SCHEMA|DOMAIN|INDEX|VIEW
-- 속성(열)과 제약을 정의
CREATE TABLE tablename(
columnname NUMBER(8) NOT NULL,  -- 수치형, 제약조건
columnname2 VARCHAR2(10),  -- 문자열
PRIMARY KEY(columnname)  -- 제약 조건
)

-- 기본키 제약 조건 설정 방법1
CREATE TABLE product (
    prdNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    prdName VARCHAR2(30) NOT NULL,
    prdPrice NUMBER(8),
    prdCompany VARCHAR2(30)
);

-- 기본키 제약 조건 설정 방법2
CREATE TABLE product2 (
    prdNo VARCHAR2(10) NOT NULL,
    prdName VARCHAR2(30) NOT NULL,
    prdPrice NUMBER(8),
    prdCompany VARCHAR2(30),
    PRIMARY KEY(prdNo)
);

-- 기본키 제약 조건 설정 방법3
-- 제약 조건 이름1
CREATE TABLE product3 (
    prdNo VARCHAR2(10) NOT NULL CONSTRAINT PK_product_prdNo1 PRIMARY KEY,
    prdName VARCHAR2(30) NOT NULL,
    prdPrice NUMBER(8),
    prdCompany VARCHAR2(30)
);

-- 기본키 제약 조건 설정 방법4
-- 제약 조건 이름2
CREATE TABLE product4 (
    prdNo VARCHAR2(10) NOT NULL,
    prdName VARCHAR2(30) NOT NULL,
    prdPrice NUMBER(8),
    prdCompany VARCHAR2(30),
    CONSTRAINT PK_product_prdNo2 PRIMARY KEY(prdNo)
);

/*
    출판사 테이블 생성
    publisher(pudNo,pudName)
    제약 조건
    기본키 : pudNo
    not null : 모든 속성

*/

CREATE TABLE publisher(
    pudNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    pudName VARCHAR2(30) NOT NULL
);

/*
    도서 테이블 생성
    BOOK(bookNo, bookName, bookPrice, bookDate, pubNo)
    기본키 : bookNo, 외래키 : pubNo
    기본 값 : bookPrice 기본값(default) 10000, (CHECK) 1000보다 크게 지정
*/

-- CONSTRAINT 제약조건명 FOREIGN KEY(현재 테이블 컬럼) REFERENCES 관계 테이블(속성명) --> 해당 속성은 기본키여야 한다.
CREATE TABLE book(
    bookNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    bookName VARCHAR2(30) NOT NULL,
    bookPrice  NUMBER(8) DEFAULT 10000 CHECK(bookPrice > 1000),
    bookDate DATE,  -- 날씨 타입
    pubNo VARCHAR2(10) NOT NULL,
    CONSTRAINT FK_book_publisher FOREIGN KEY(pubNo) REFERENCES publisher(pudNo)
);

-- 외래키 관계 테이블이 구성될 때는 외래키 포함 테이블보다 관계 테이블이 우선되어야 한다.

-- data 입력 시에도 관계 테이블의 데이터가 먼저 입력되어야 외래키 포함 테이블이 외래키 컬럼 데이터 검증 가능
-- ALTER문 : 구조 변경
--컬럼추가 : ALTER TABLE ..ADD 컬럼명 데이터 타입
--PUBLISHER 테이블에 PUBPHONE 컬럼 추가, 이미 저장된 데이터가 있는 테이블에 컬럼을 추가시 NOT NULL 사용 불가
ALTER TABLE publisher1 ADD punPhone VARCHAR2(13);
ALTER TABLE publisher1 ADD (pubAddress VARCHAR2(50), pubAddress2 VARCHAR(50));
-- 테이블 상세정보 확인
DESCRIBE publisher1;


ALTER TABLE product MODIFY prdPrice NUMBER(2);

ALTER TABLE product MODIFY prdPrice VARCHAR(2);

ALTER TABLE book MODIFY bookNo NUMBER(2);


ALTER TABLE publisher1 MODIFY pubName VARCHAR2(30)NULL;

ALTER TABLE publisher1 RENAME COLUMN pubPhone TO pubTel;

ALTER TABLE publisher1 DROP COLUMN pubAddress2;

ALTER TABLE publisher1 DROP COLUMN (pubAddress,pubTel);

DESCRIBE publisher1;

ALTER TABLE publisher1
DROP PRIMARY KEY CASCADE;

ALTER TABLE publisher1
ADD CONSTRAINT PK_publisher1_pubNo
PRIMARY KEY(pubNo);

--외래키 추가
ALTER TABLE book
ADD CONSTRINT FK_book_publisher
FOREIGN KEY(pubNo) REFERENCES publisher(pubNo);
--외래키 제약조건 삭제 : DROP CONSTRAINT 제약 조건 이름
ALTER TABLE book
DROP CONSTRAINT FK_book_publisher;

-- 기본키 삭제시 다른 테이블의 참조가 없으면 바로 삭제됨
ALTER TABLE publisher1
DROP PRIMARY KEY;

--제약 조건 정보 확인
--일반 유저 설정 제약조건은 USER_CONSTRAINTS 테이블에 정보가 저장되어 있음
--일반 유저는 조회 권한이 있음
SELECT *FROM USER_CONSTRAINTS; --모든 테이블의 제약 조건 정보 반환
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME ='PRODUCT'; -- product 테이블의 제약조건 정보 반환

--CONSTRAINT_TYPE
--C : SHECK ON TABLE , CHECK ,NOT NULL
--P : PRIMARY KEY
--R : FOREIGN KEY


-- DROP문 : 구조 삭제

--테이블 삭제 : 테이블의 모든 구조와 모든 데이터 삭제
 --테이블은 남기고 데이터만 삭제하려면 DML의 DELETE 구문 이용
 -- DROP TABLE 테이블명 [PURGE|CASCADE CONSTRAINTS]
 --PURGE : 테이블 삭제시 복구 임시 테이블 생성하지 않고 영구히 삭제
 --CASCADE CONSTRAINTS : 제약조건 무시하고 기준테이블 강제 삭제
 
 --테이블 삭제
 --기본키 추가
ALTER TABLE book
ADD CONSTRINT FK_book_publisher
PRIMARY KEY(pubNo);
--외래키 추가
ALTER TABLE book
ADD CONSTRINT FK_book_publisher
FOREIGN KEY(pubNo) REFERENCES publisher(pubNo);

--관계있는 테이블이 있는 테이블 삭제
DROP TABLE publisher1; --외래키에 의 해 참조되는 고유/기본 키가 테이블에 있습니다

-- 무조건 삭제
DROP TABLE publisher1 CASCADE CONSTRAINTS;

--무조건 삭제하게 되면 참조하는 테이브의 제약조건(외래키도 ) 삭제됨
DROP TABLE publisher1 CASCADE CONSTRAINTS;
--관계있는 테이블이 없는 테이블 삭제
DROP  TAVLE product;
    
