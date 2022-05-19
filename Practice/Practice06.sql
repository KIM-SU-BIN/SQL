< ppt 예제 풀기 >
--작가 테이블 생성
CREATE TABLE author (
  author_id	NUMBER(10),
  author_name VARCHAR2(100) NOT NULL,
  author_desc VARCHAR2(500),
  PRIMARY KEY (author_id)	
);

-- 작가 시퀀스 만들기 
create sequence seq_author_id
INCREMENT BY 1
start with 1
nocache;  

--작가 데이터 추가
insert into author
values (seq_author_id.nextval, '김문열', '경북 영양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');


--PPT24 예제 강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요
UPDATE author
set author_desc = '서울특별시'
where author_id = 5;               --조건만 맞으면 우리가 배운 where 다 사용할 수 있음


--PPT24 예제 author 테이블에서 기안84 데이터를 삭제해 보세요  삭제 안됨
delete from author 
where author_id = 4;
-- 삭제되지 않는 이유 : book테이블에서 참조하여 사용하고 있기 때문에 삭제 불가

--출력하기
SELECT *
FROM author;

--작가 테이블 삭제 / dml이 아니기 때문에 삭제후 롤백해도 살릴 수 없음
drop table author;
--작가 시퀀스 삭제
drop sequence seq_author_id;

--저장2
commit;

--되돌리기
rollback;
----------------------------------------------------------------------------

--북 테이블 만들기
create table book(
    book_id number(10),
    title VARCHAR2(100) not null,
    pubs VARCHAR2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_id foreign key(author_id)
    references author(author_id)
    );

--북 시퀀스 만들기 
create sequence seq_book_id
INCREMENT BY 1
start with 1
nocache; 

--book 데이터 추가 (DML)
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values (seq_book_id.nextval, '오직 두 사람', '문학동네', '2017-05-04', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-08-04', 5);

--조회하기
select *
from book;

--북 테이블 삭제 / dml이 아니기 때문에 삭제후 롤백해도 살릴 수 없음
drop table book;
--북 시퀀스 삭제
drop sequence seq_book_id;

--저장2
commit;

--두 테이블 합하여 출력하기
SELECT book_id, title, pubs, pub_date, author_name, author_desc
FROM author au, book bo
where au.author_id = bo.author_id;