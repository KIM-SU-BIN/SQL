--0519 오전 테이블 생성 및 삭제
create table author(
    author_id number(10),
    author_name varchar2(100) not null, -- 제약조건 : NULL값 입력불가
    author_desc varchar2(500),
    PRIMARY KEY (author_id)
);

--묵시적 방법
insert into author
values(1 , '박경리' , '토지 작가' ); --ctrl+space 누를 때 마다 생성되는데 삭제할 수 있는 방법은?

--명시적 방법
INSERT INTO author(author_id, author_name) 
VALUES (2, '이문열' );

--명시적 방법
INSERT INTO author( author_name, author_id) --values 값 변경시 위에 순서도 변경해주어야함
VALUES ('기안84' , 3 );

INSERT INTO author(author_id) 
VALUES (4);

SELECT *
FROM author;

--리셋할 때 (삭제)
drop table book;
drop table  author;


create table book(
    book_id number(10),
    title VARCHAR2(100) not null,
    pubs VARCHAR2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
    );
    
SELECT *
FROM book;

--1, 토지, 마로이네북스, 2012-08-15, 1
INSERT INTO book
VALUES(1, '토지' , '마로니에북스', '2012-08-15' , 1 );

--2, 삼국지, 민음사, 2022-03-01, 2
INSERT INTO book
VALUES(2, '삼국지' , '민음사', '2022-03-01' , 1 );

--순서대로 작업하지 않을 경우 오류 생성 / 테이블(기본키 넣기) 만들고 안에 내용 기입하고 다음 단계로 넘어갈 것

UPDATE author
set author_desc = '삼국지 작가'
where author_id = 2;               --조건만 맞으면 우리가 배운 where 다 사용할 수 있음

--1행의 여러개는 바꿀 수 있음
UPDATE author
set author_name = '김경리',
    author_desc = '토지 작가'
where author_id = 1;

--기안83 항목 삭제 
--삭제시 foreign key로 다른 테이블에서 사용하고 있을 경우 오류!
--현재 book테이블에서 작가 번호 쓰고 있기 떄문에 1,2는 삭제 불가
DELETE FROM author
WHERE author_id = 3;


-- 완죠니 삭제...
DELETE FROM book;
DELETE FROM author;

SELECT *
FROM book;

SELECT *
FROM author;
