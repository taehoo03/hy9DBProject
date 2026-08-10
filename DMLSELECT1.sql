--기본 SELECT
--테이블에서 조건에 맞는 행 검색
/*기본 형식
SELECT[ALLDISTINCT] 속성리스트
FROM테이블명
[WHERE 검색조건(들)]
[GROUP BY 열이름]
[HAVING 검색조건(들)]
[ORDER BY 열이름[ASCIDESC]]

*/
--상품테이블에서 모든 레코드 검색 후 반환

--모든(*)
SELECT * 
FROM productFin;

--상품 테이블에서 상품번호 상품명 가격 정보 반환
SELECT prdNo,prdName,prdPrice
FROM productFin;

--SELECT 결과 반환능 테이블로 반환됨 -> 개발프로그램과 연결되면 객체상태로 전달됨(테이블 구조)

--WHERE 조건절 추가 : 특정 조건을 충족하는 레코드를 테이블로 반환
--상품테이블에서 상품가격이100만원을 초과하는 상품의 번호 , 이름 ,가격 ,제조사를 반환

SELECT prdNo,prdName,prdPrice,prdMaker
FROM productFin
WHERE prdPrice >1000000;

--현재 거래하고 있는 상품 제조사를 확인
--제조사 컬럼 데이터 전부 반환 ( 중복값이 있을수 있음)
SELECT prdMaker
FROM productFin;

--제조사 컬럼 데이터 전부 반환 ( 중복값 제거 후)
SELECT DISTINCT prdMaker
FROM productFin;

SHOW CON_NAME;

ALTER SESSION SET CONTAINER =XEPDB1;

ALTER TABLE publisher ADD PRIMARY KEY(pubNo);
ALTER TABLE book ADD PRIMARY KEY(bookNo);
ALTER TABLE client ADD PRIMARY KEY(clientNo);
ALTER TABLE bookSale ADD PRIMARY KEY(bsNo);

ALTER TABLE book
    ADD CONSTRAINT FK_book_publisher
    FOREIGN KEY(pubNo) REFERENCES publisher(pubNo);
ALTER TABLE bookSale
    ADD CONSTRAINT FK_booksale_book
    FOREIGN KEY(bookNo) REFERENCES book(bookNo);  
ALTER TABLE bookSale
    ADD CONSTRAINT FK_booksale_client
    FOREIGN KEY(clientNo) REFERENCES client(clientNo);
    
    --도서 테이블에서 모든 레코드의 모든 속성을 검색
    SELECT * FROM book;
     --도서테이블에서 모든 레코드의 도서명과 가격 컬럼을 검색
     SELECT bookName ,bookPrice FROM book;
     --현재 서점에 진열된도서들의 저자를 확인(중복값 포함)
     SELECT bookAuthor FROM book;
         --현재 서점에 진열된도서들의 저자를 확인(중복값 제거)
     SELECT DISTINCT bookAuthor FROM book;
     
     --고객중 한번이라도 주문한 적이 있는 고객번호 ㅗ학인
     --주문 : bookSale,bookSale 테이블의 clientNo는 주문고객 번호
     SELECT DISTINCT clientNo FROM bookSale;
     
     --두개이상의 컬럼에 대해 DISTINCT를 적용하면 레코드 단위로 적용
    -- SELECT DISTINCT clientNo FROM

    /*
    사용연산
    비교 (=, <, >, <=, >=, !=)
    범위 (BETWEEN)
    리스트에 포함 (IN, NOT IN)
    NULL (IS NULL, IS NOT NULL)
    논리(AND, OR)
    패턴 매칭 (LIKE)
*/

--비교 (=,<,>,<=,>=,!=
--저자가 홍길동인 도서의 도서명, 저자명 검색
SELECT bookName,bookAuthor
FROM book
WHERE bookAuthor ='홍길동';

--가격이 30000원 이상인 도서의 도서명 , 가격, 재고 검색
SELECT bookName,bookPrice,bookStock
FROM book
WHERE bookPrice >= 30000;

--도서의 재고가 3권에서 5권  사이인 도서의 도서명 재고검색
SELECT bookName ,bookStock
FROM book
WHERE bookStock >= 3 AND bookStock <=5;

--범위 연산자 : between 범위의 시작값 and 범위의 끝값
SELECT bookName, bookStock
FROM book 
WHERE bookStock BETWEEN 3 AND 5;

--도서테이블에서 출판사 번호가 1이거나2인 도서의 도서명 , 출판사 번호 검색
SELECT bookName,pubNo
FROM book
WHERE pubNo = 1 OR pubNo =2;
--리스트 포함 여부 : IN,NOT IN
SELECT bookName,pubNo
FROM book
WHERE pubNo IN (1,2); --(갑1 ...값 2 ) 나열된 값 중의 1개의 값과 매칭되면 TRUE


--리스트에 포함되지 않았는지의 여부 : NOT IN
--도서 테이블에서 출판사 번호가 2가 아닌 다른출판사에서 출판한 도서의 도서명 , 출판사 번호 검색
SELECT bookName,pubNo
FROM book
WHERE pubNo != 2 OR pubNo != 1;
--위 식과 결과 다름
SELECT bookName,pubNo
FROM book
WHERE pubNo NOT IN (1,2); -- in 연산을 먼저 진행해서 결과 반환받고 not 진행


--NULL과 관련된 연산
SELECT clientName, clientHobby FROM client;
--clientHobby 컬럼은 NULL 값을 포함하고 있음
--아자르의 취미는 null 아님
--테이블 컬럼의 속성이 널 허용한다면 해당 컬럼의 데이터가 저장되지 않으면 널이 자동으로 저장됨
--널이 안보이고 정보도 없는 컬럼 공백문자가 저장된 상황

--고객 데이터 중 취미정보를 제공한 고객의 이름과 취미 속성을 반환 - is not null
SELECT clientName,clientHobby
FROM client
WHERE clientHobby IS NOT NULL;
--고객 데이터 중 취미정보를 제공하지 않는 고객의 이름과 취미 속성을 반환 is null
SELECT clientName,clientHobby
FROM client
WHERE clientHobby IS  NULL;

SELECT clientName,clientHobby
FROM client
WHERE clientHobby  ='';

--논리 ( AND, OR)
--도서의 저자가 홍길동 이면서 재고가 3권 이상인 도서의 정보 반환 
--도서의 저자가 홍길동 이거나 성춘향인 도서의 정보 반환
SELECT * FROM BOOK
WHERE  bookAuthor = '홍길동' AND bookStock>=3;
SELECT * FROM BOOK
WHERE  bookAuthor = '홍길동' OR bookAuthor ='성춘향';

--패턴 매칭 : like
--와일드 카드 문자 : %(0개 이상으 ㅣ문자), _(한글자)

--출판사 테이블에서 출판사 이름에 출판사가 포함된 모든 레코드 반환
SELECT * FROM BOOK;



SUM() : 합계
    AVG() : 평균
    COUNT() : 선택된 열의 행 수(널 값은 제외)
    COUNT(*) : 전체 행의 수
    MAX() : 최대
    MIN() : 최소

