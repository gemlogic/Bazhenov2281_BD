--1
select name, surname, score
from students st
where st.score >= 4 and st.score <= 4.5

select name, surname, score
from students st
group by st.score, st.name, st.surname
having st.score >= 4 and st.score <= 4.5
--2
select *
from students st
Where st.n_group::varchar Like '3%'
--3
select *
from students st
order by st.n_group, st.name
--4
select name, surname, score
from students st
where st.score >= 4
order by st.score DESC
--5
select name, risk
from hobbies hb
where name = 'Хоккей' or name = 'Футбол'
--6
select id, hobby_id
from  students_hobbies sh
where date_start > '2015-02-09' and date_start < '2017-11-09' and date_finish is NULL
--7
select name, surname, score
from students st
where st.score >= 4
order by st.score DESC
--8
select name, surname, score
from students st
where st.score >= 4
order by st.score DESC
Limit 5

select name, surname, score
FROM students st
ORDER BY st.score DESC FETCH FIRST 5 ROWS ONLY
--9
SELECT name,
case
	when hb.risk>=8 then 'очень высокий' 
	when hb.risk >=6 and hb.risk<8 then 'высокий'
	when hb.risk >=4 and hb.risk<6 then 'средний'
	when hb.risk >=2 and hb.risk<4 then 'низкий'
	when hb.risk <2 then 'очень низкий'
END as risk
from hobbies hb
--10
select *
from hobbies hb
order by hb.risk DESC
Limit 3