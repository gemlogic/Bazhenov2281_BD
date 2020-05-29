--1
Select st.name, st.surname, hb.name
From students st
right join hobbies hb
on st.id = hb.id
--2
Select st.*, min(st_h.date_start) as data
From students st
Inner join students_hobbies st_h
On st.id = st_h.id
Where st_h.date_finish is null
Group by st.id
Order by data 
Limit 1
--3
Select st.name, st.surname, st.score, (select avg(score) from students) as average, sum(hb.risk)
From students st
Inner join students_hobbies sh
on sh.student_id = st.id
Inner join hobbies hb
on hb.id = sh.hobby_id
group by st.name, st.surname, st.score
having sum(hb.risk)>0.9 and st.score > (select avg(score) from students)
--4
Select st.name, h.name, st_h.date_finish, st_h.date_start, 
( extract(year from age(st_h.date_finish,st_h.date_start)*12) + extract (month from age(st_h.date_finish,st_h.date_start))) as months
From students st
Inner join students_hobbies st_h
On st.id = st_h.student_id
Inner join hobbies h
On h.id = st_h.hobby_id
Where not st_h.date_finish is null
Group by st.name, h.name, st_h.date_finish, st_h.date_start, months
--5
WITH hb1 as (
select st_h.student_id
From students_hobbies st_h
Where st_h.date_finish is null
Group by st_h.student_id
Having count(*) > 1
)

Select st.name, st.surname, st.birth_date
From students st
Inner join hb1 h1
On st.id = h1.student_id
Where extract(year from age(now(),st.birth_date)) >= 20
--6
Select st.n_group, avg(st.score)
From students st
Inner join students_hobbies st_h
On st.id = st_h.student_id
Where date_finish is null
Group by st.n_group
--7
Select st.surname, st.n_group, h.risk, h.name, st_h.date_start
From students st
Inner join students_hobbies st_h
On st.id = st_h.student_id
Inner join hobbies h
On h.id = st_h.hobby_id
Where st_h.date_finish is null
Order by st_h.date_start
Limit 1
--8
Select distinct h.name
From students st
Inner join students_hobbies st_h
On st.id = st_h.student_id and st_h.date_finish is null
Inner join hobbies h
On h.id = st_h.hobby_id
Where st.score = (Select max(score) from students)
--9
Select st.surname, h.name
From students st
Inner join students_hobbies st_h
On st.id = st_h.student_id
Inner join hobbies h
On h.id = st_h.hobby_id
Where st.score >=4 and st.score <4.5 and st.n_group >=2000 and st.n_group<3000 and st_h.date_finish is null
--10
With kolvo as (Select substr(st.n_group::varchar,1,1) as n_course
From students st 
Inner join students_hobbies st_h on st.id = st_h.student_id
Inner join hobbies h on st_h.hobby_id = h.id
Where st_h.date_finish is null
Group by st.surname, st.name, st.n_group
Having count(st_h.hobby_id) > 1)

Select distinct n_course
from kolvo, students st
group by n_course
having count(kolvo.*) > count(st.*)/2
--11
Select tright.n_group
From 
	(
	Select n_group, count(score) as all_count 
	From students 
	Group by n_group
	) tleft
Inner join 
	(
	Select n_group, count(score) as t_count
	From students
	Where score >= 4 
	Group by n_group
	) tright 
On tleft.n_group = tright.n_group
Where all_count/t_count >= 0.6
--12
Select count(distinct st_h.hobby_id), substr(st.n_group::varchar, 1, 1) as Course
From students st
Inner join students_hobbies st_h
On st.id = st_h.student_id
Where date_finish is null
Group by Course
--13
Select st.name, st.surname, st.birth_date, substr(st.n_group::varchar, 1, 1) as course
From students st
Left join students_hobbies sth
On st.id = sth.student_id
Where st.score >= 4.5 and sth.date_start is null
Order by course asc, st.birth_date desc
--14
Create view morethanfive as
Select st.* from students st 
Inner join students_hobbies sh on st.id = sh.student_id
Inner join hobbies h on sh.hobby_id = h.id
Where sh.date_finish is null and extract (year from age(now()::date, sh.date_start))>=5
--15
Select h.name, count(sh.student_id) as st_count
From students_hobbies sh 
Inner join hobbies h on sh.hobby_id = h.id
Group by hobby_id, h.name
Order by st_count
--16
Select h.id
From hobbies h
Inner join students_hobbies sh on sh.hobby_id = h.id
Group by h.id
Order by count(sh.student_id) desc limit 1
--17
Select st.*
From students st
Inner join students_hobbies sh on st.id = sh.student_id
Where sh.hobby_id = 
(
	Select h.id
	From hobbies h
	Inner join students_hobbies sh on h.id = sh.hobby_id
	Group by h.id
	Order by count(sh.student_id) desc limit 1
)
--18
Select h.risk as riskest
From hobbies h
Order by riskest desc limit 3
--19

--20
