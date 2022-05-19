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

drop table book;
drop table author;

---------------------------------

-- <다시시작> 
--삭제
DELETE FROM author;
drop table author;

--시퀀스 삭제
DROP SEQUENCE seq_author_id;

--작가 테이블 만들기
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
nocache;            --정확한 의미는?


--데이터
insert into author
values (seq_author_id.nextval,'박경리', '토지 작가');

insert into author
values (seq_author_id.nextval,'이문열', '삼국지');

insert into author
values (seq_author_id.nextval,'기안84', '웹툰작가');

insert into author
values (seq_author_id.nextval,'김수빈', 'WOW');

insert into author
values (seq_author_id.nextval,'유재석', '개그맨');

--출력하기
SELECT *
FROM author;

--시퀀스 조회
SELECT * 
FROM user_sequences;

--현재 시퀀스 
SELECT seq_author_id.currval 
FROM dual;

--다음 시퀀스
SELECT seq_author_id.nextval 
FROM dual;

--저장하기
/*여태 한 것은 반영된 것이 아님. 컴텀 끄면 사라짐
커밋을 해야 저장이 완료
<커밋이 반영하는 데이터의 범위 완전 중요!!!! > */
commit;

--뒤로가기 (커밋했던 시점으로 돌아감.)
rollback;

-----------------------------------------------------------

--작가 테이블 삭제 / dml이 아니기 때문에 삭제후 롤백해도 살릴 수 없음
drop table author;
--작가 시퀀스 삭제
drop sequence seq_author_id;

--작가 테이블 만들기
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
INSERT INTO author
values(seq_author_id.nextval, '박경리', '토지작가');

insert into author
values (seq_author_id.nextval,'이문열', '삼국지');

insert into author
values (seq_author_id.nextval,'기안84', '웹툰작가');

update author
set author_name = '자취84',
    author_desc = '나혼자산다 출연'
where author_id = 3;

--출력하기
SELECT *
FROM author;

--시퀀스 조회
SELECT * 
FROM user_sequences;

--현재 시퀀스 
SELECT seq_author_id.currval 
FROM dual;

--다음 시퀀스
SELECT seq_author_id.nextval 
FROM dual;

