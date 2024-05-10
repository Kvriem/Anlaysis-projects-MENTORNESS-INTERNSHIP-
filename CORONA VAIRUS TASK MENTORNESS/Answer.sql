use Mentorness_Tasks
go

-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
select
count(case when [Latitude] is null then 1 end) as nulls_in_Latitude,
count(case when [Longitude] is null then 1 end) as nulls_in_Longitude
from corona

--Q2. If NULL values are present, update them with zeros for all columns. 
update Corona
set 
[Latitude]=0 ,
[Longitude]=0 
where 
[Latitude] is null or
[Longitude] is null 

-- Q3. check total number of rows
select count(*) from Corona

-- Q4. Check what is start_date and end_date
select min([date])as start_date,max([date]) as end_date
from Corona

-- Q5. Number of month present in dataset
select year([date]) as year,count(distinct month([date])) as count_of_months
from Corona
group by year([date])

-- Q6. Find monthly average for confirmed, deaths, recovered
select year([date])year,month([date]) month, avg(confirmed) average_confirmed,avg(deaths) average_deaths,avg(recovered) average_recovered
from corona
group by year([date]) ,month([date])
order by year([date]), month([date])


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 


-- Q8. Find minimum values for confirmed, deaths, recovered per year
	select  year([date]) year, min(confirmed)min_confirmed,min(deaths)min_deaths,min(recovered) min_recovered
	from Corona
	group by year([date])
	order by year

-- Q9. Find maximum values of confirmed, deaths, recovered per year
	select  year([date]) year, max(confirmed) max_confirmed, max(deaths) max_deaths, max(recovered) max_recovered
	from Corona
	group by year([date])
	order by year

-- Q10. The total number of case of confirmed, deaths, recovered each month
	select year(date) year,month([date]) month,sum(confirmed) count_confirmed,sum(deaths) count_deaths ,sum(recovered) count_recovered
	from Corona
	group by year(date),month([date])
	order by year(date),month([date])

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
		select year([date])year,month([date]) month,sum(confirmed) sum_confirmed,avg(confirmed) average_confirmed,STDEV(confirmed) stdev_confiremed
		from corona
		group by year([date]),month([date]) 
		order by year([date]),month([date]) 
-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
		select year([date])year,month([date]) month, sum(Deaths) sum_Deaths,avg(Deaths) average_Deaths,STDEV(Deaths) stdev_Deaths
		from corona
		group by year([date]),month([date]) 
		order by year([date]),month([date]) 

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
		select year([date])year,month([date]) month, sum(recovered) sum_recovered,avg(recovered) average_recovered,STDEV(recovered) stdev_recovered
		from corona
		group by year([date]),month([date]) 
		order by year([date]),month([date]) 

-- Q14. Find Country having highest number of the Confirmed case	
	select country_region,confirmed
	from Corona
	where Confirmed=(select max(Confirmed) from corona)

-- Q15. Find Country having lowest number of the death case
	select  distinct Country_Region, Deaths
	from Corona
	where deaths =(select min(Deaths)  from Corona)

-- Q16. Find top 5 countries having highest recovered case
WITH t AS (
    SELECT DISTINCT Country_Region, Recovered
    FROM Corona
)

SELECT TOP 5 Country_Region, Recovered
FROM t
ORDER BY Recovered DESC
