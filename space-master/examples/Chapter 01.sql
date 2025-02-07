-- SQL Alternatives. Simple query used to compare with Query by Example (QBE) visual programming tool.
SELECT satellite.norad_id, satellite.launch_id, launch.launch_date
FROM satellite JOIN launch ON satellite.launch_id = launch.launch_id
WHERE trunc(launch.launch_date) = DATE '1957-10-04'
ORDER BY satellite.norad_id;

-- Key concepts. Oracle 21c has 2557 reserved words, whereas most programming languages only have a few dozen.
SELECT COUNT(*) FROM v$reserved_words;
SELECT * FROM v$reserved_words;

-- NULL.

--Initial SQL*Plus formatting to perfectly recreate results in book.
--(But I hope that you're using an IDE instead of SQL*Plus.)
set sqlprompt "SQL> ";
alter session set current_schema = space;

--Incorrect null comparisons:
SELECT count(*) FROM launch WHERE apogee = null;
SELECT count(*) FROM launch WHERE apogee <> null;

--Correct null comparisons:
select count(*) from launch where apogee is null;
select count(*) from launch where apogee is not null;

--Incorrect null "not in" usage:
select count(*)
from launch
where launch.launch_id not in
(
	select satellite.launch_id
	from satellite
);

-- JOIN.
-- Inner join with "inner join" keyword.

select *
from launch
inner join satellite
	on launch.launch_id = satellite.launch_id;

--Inner join with "join" keyword.
select *
from launch
join satellite
	on launch.launch_id = satellite.launch_id;

--Inner join with Cartesian product method.
select *
from launch, satellite
where launch.launch_id = satellite.launch_id;



--Left join with "left outer join" keyword:
select *
from launch
left outer join satellite
	on launch.launch_id = satellite.launch_id;

--Left join with "left join" keyword:
select *
from launch
left join satellite
	on launch.launch_id = satellite.launch_id;

--Left join with "(+)" syntax:
select *
from launch, satellite
where launch.launch_id = satellite.launch_id(+);



--Right joins.  Not shown in the book to save space.
select *
from launch
right outer join satellite
	on launch.launch_id = satellite.launch_id;

select *
from launch
right join satellite
	on launch.launch_id = satellite.launch_id;

select *
from launch, satellite
where launch.launch_id(+) = satellite.launch_id;



--Full outer join with optional "outer" keyword.
select *
from launch
full outer join satellite
	on launch.launch_id = satellite.launch_id;

--Without optional "outer" keyword.
select *
from launch
full join satellite
	on launch.launch_id = satellite.launch_id;

--This does not work. It raises the exception:
--ORA-01468: a predicate may reference only one outer-joined table
select *
from launch, satellite
where launch.launch_id(+) = satellite.launch_id(+);



--Cross joins:
--(These will run for a long time and return 3,040,975,455 rows)

--ANSI join syntax:
select *
from launch
cross join satellite;
--Old-fashioned syntax:
select *
from launch, satellite;
