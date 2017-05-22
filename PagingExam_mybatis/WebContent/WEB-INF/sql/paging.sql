drop table item_tb;
create table item_tb(
	no number primary key,
	item varchar2(100) not null
);

drop sequence item_tb_no_seq;
create sequence item_tb_no_seq nocache;

select item_tb_no_seq.nextval from dual;

select * from item_tb order by no desc



select rownum, id, name, email from member
select  no, item from item_tb
select  rownum, no, item from item_tb

-- ------------------------------------------ 강사님이랑 한 페이지 테이블 불러오기 --------------------------------------
-- 1페이지에 10개의 항목을 조회
-- 보려는 페이지 : 2페이지
-- 시작 항목: 10*2-10+1 = 11
-- 끝 항목: 10*2 =20

select no, item
from(
select rownum rnum, no, item from ITEM_TB
where rownum <= #{끝항목} -- 1 ~ 20
)
where rnum >= #{시작항목}  -- 11~20


select no, item
from(
	select rownum rnum, no, item	
		from(
			select no, item from item_tb order by item desc-- 정렬 desc -내림차순 순
				)
		where rownum <= 20 ${ 끝번호-endItemNum}
)
where rnum >= 11 ${시작번호-beginItemNum}

-------------------ceil 함수를 안쓰기 위해 ------------------------------

select no, item from(
	select rownum rnum, no, item from(
		select no, item from item_tb order by no desc --정렬
	)where rownum <= #{endItemNum} --rownum으로 조건 조회 (이건 rownum 1부터므로 조회된다.)
) where rnum >= #{startItemNum} --별칭으로 조건 조회  (이건 안쪽에서 처리가 안된다.)


--
-- 1page에 10개씩 보여줄때 2페이지 - 11 ~ 20 번 item
select no, item from(
	select rownum rnum, no, item from(
		select no, item from item_tb order by no desc
	)where rownum <= 20 --rownum으로 조건 조회 (<= 이므로 안쪽 select에서 rownum 조회 안해도 된다.) - 1 ~ 20 조회
) where rnum >= 11 --별칭으로 조건 조회 - 1 ~ 20 에서 11 ~ 20 조회

------------------------------------------------------

SELECT 컬럼 별칭
FROM 테이블명
WHERE 제약조건
GROUP BY 그룹으로묶을 컬럼
HAVING 그룹함수조건
ORDER BY 정렬기준컬럼

select no, item
from item_tb
where no > 20

SELECT 문 실행 순서
1. from 절
2. where 절
(3. group by, 4. having)
5. select 절
6. order by 절 

select page, no, item
from 
(
	select ceil(rownum/7) page, no, item 
	from item_tb 
	order by no desc
)
where page = 2

--main sql문 - 최종조회(원하는 페이지의 item들을 조회)
select no, item
from(
	-- page번호 조회(rownum)
	select ceil(rownum/10) page, no, item
	from(
		--정렬
		select no, item 
		from item_tb 
		order by no desc
	)
) where page = 2	






select rownum, no, item 
from item_tb 
order by no desc

rownum no
1		    100
2		    99
3		    98

100		1



select no, item from(select ceil(rownum/10) page, no, item from(select no, item	from item_tb order by no desc)) where page = 2




