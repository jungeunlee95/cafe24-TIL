show tables;
 alter table orders change today today DATETIME DEFAULT NOW();
-- 카테고리 데이터 넣기
select * from category;
insert into category values(null, '인문');
insert into category values(null, '정치/사회');
insert into category values(null, '컴퓨터/IT');
insert into category values(null, '가정/육아');
-- 카테고리 가져오기
select no, name from category;

-- 책 데이터 넣기
select * from book;
desc book;
insert into book values(null, '마음으로부터 일곱 발자국', 14400, 10, 1);
insert into book values(null, '나를 지키는 노동법 ', 10350, 50, 2);
insert into book values(null, '자바 최적화(Optimizing Java)', 35100, 100, 3);
insert into book values(null, '아이를 위한 하루 한 줄 인문학', 13050, 70, 4);
-- 책 getList
select b.no, b.title, b.price, b.stock, c.name
from book b, category c
where b.category_no = c.no;



-- 고객 데이터 넣기
select * from member;
insert into member values(null, '이정은', '010-1234-5678', 'aaa', 'aaa');
insert into member values(null, '이정은2', '010-1111-2222', 'bbb', 'bbb');
-- 고객 getList
select name, phone, email, password
from member;


-- cart 장바구니에 담기
select * from cart;
select * from member;
select * from book;
insert into cart values(null, 1, 1, 1);
insert into cart values(null, 2, 1, 2);

-- 이사람이 장바구니에 담은적 있는 책이면
select count(*)
from cart
where member_no = 2
and book_no = 3;

update cart
set amount = amount+1
where member_no = 1
and book_no = 2;


-- 해당 고객의 장바구니 정보 가져오기
select c.no, b.title, m.no as member_no, m.name, c.amount
from cart c, book b, member m
where c.book_no = b.no 
and c.member_no = m.no
and member_no = 1;

-- 장바구니 상품 주문하기
select no from orders where member_no = 1 order by no desc limit 1;
select * from book_order;
select * from cart;
delete from book_order where order_no = 20;
select last_insert_id();
-- 주문번호
-- select concat(DATE_FORMAT(now(),'%Y%m%d'), '-', lpad( ((select count(*) from orders)+1), '5', '0' ));

-- 주문정보 등록
insert into orders(no, order_no, address, total_price, member_no) 
values(null, concat(DATE_FORMAT(now(),'%Y%m%d'), '-', 
        lpad( ((select count(*) from orders ALIAS_FOR_SUBQUERY )+1), '5', '0' )),
       '주소',
       (select sum(b.price)
			from cart c, book b
			where c.book_no = b.no 
			and member_no = 1), 
		1 );

select book_no, amount 
from cart where member_no = 1;
select * from book_order;

insert into book_order
values(null,1,20,1);
select no from orders
where member_no = 1
order by no desc
limit 1;
        
-- 장바구니 책 전부 합친 가격
select sum(b.price)
from cart c, book b
where c.book_no = b.no 
and member_no = 1;

select concat(DATE_FORMAT(now(),'%Y%m%d'), '-', 
        lpad( ((select count(*) from orders)+1), '5', '0' ));

-- 방금 프라이머리 키 가져오기
select last_insert_id();

select b.no, b.title, count(*)
from book_order bo, book b
where bo.book_no = b.no
group by bo.book_no;

select no, order_no, address, total_price, DATE_FORMAT(today,'%Y-%m-%d'), member_no
from orders;
