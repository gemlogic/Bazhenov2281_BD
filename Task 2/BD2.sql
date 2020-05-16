--1
select st.n_group, Count(n_group)
from students st
group by st.n_group
--2
select st.n_group, max(score)
from students st
group by st.n_group
--3
select  Count(Distinct surname)
from students st
--4

--5
select 
case 
when st.n_group>=3000 then '3'
when st.n_group>=2000 and st.n_group<3000 then '2'
end as course, avg(score) as avg_score
from students st
group by course
--6
select st.n_group, max(score) as maxsc
from students st
group by st.n_group
having st.n_group <3000
order by maxsc desc
--7
select st.n_group, avg(score) as avg_score
from students st
group by st.n_group 
having avg(score) < 4.5
order by avg_score
--8
Select st.n_group, count(st.name), max(st.score),avg(st.score), min(st.score)
From Students st
Group by st.n_group
Order by st.n_group
--9
...
--10
Select n_group, surname, name, score
From students
Where score =
    (
	 Select max(score)
     From students
	)
Group by n_group, surname, name, score