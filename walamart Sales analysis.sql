create schema project;
use project;
select * from walmart ;

----- feature Enigneering ---
select Time from walmart;
ALTER TABLE walmart
MODIFY COLUMN Time TIME;
select time ,
(case
	when Time between "00:00:00" and "12:00:00" then "morning"
    when Time between "12:01:00" and "16:00:00" then "afternoon"
    else "evening"
    end) as Time_of_day

from walmart;
alter table walmart 
add column Time_of_day varchar(20);

select * from walmart;
update walmart 
set Time_of_day=(
case
	when Time between "00:00:00" and "12:00:00" then "morning"
    when Time between "12:01:00" and "16:00:00" then "afternoon"
    else "evening"
    end) ;
    select Time,Time_of_day from walmart ;
    
    
    ----------- day name -------------
    select date from walmart;
   -------- modifying the dataype in order to extract day name ----
    ALTER TABLE walmart
MODIFY COLUMN date DATE;
select date,dayname(date) from walmart;

alter table walmart add column day_name varchar(30);
update walmart set day_name=dayname(date);
select * from walmart;


----------- adding month name ------------
select date,monthname(date) from walmart;
alter table walmart add column Monthname varchar(30);
update walmart set Monthname=monthname(date);

select * from walmart;

----------- oo ---------------------------------------
----- exploratory dtata analysis(EdA) -----

----- generic ----

-- unique cities the data have ?---
select distinct(City) from walmart;

----- in which city is each branch -----
select distinct(City),branch from walmart;

----- product ------

----- how many unique product lines does the data have -----
select count(distinct(Product_line)) from walmart;
  
-- what is the most common payment method --
select payment,count(*) as count_payment from walmart
group by payment
order by count_payment
desc;

----- what is the most selling product line -----
select Product_line ,count(*) from walmart
group by Product_line
order by Count(*)
desc;

----- total revenue by month ----
select Monthname,sum(Total) as Total_Revenue from walmart
group by Monthname
order by sum(Total)
desc;


-----  what month has the largest cogs ----
select Monthname,sum(cogs)as largest_cogs_by_month from walmart
group by Monthname
order by sum(cogs)
desc limit 1;

----- what product line has the largest revenue ---

select Product_line ,sum(total) as Revenue from walmart
group by Product_line order by sum(total) desc limit 1;


----- revenue generated city wise -----

select City,branch, sum(Total) as Revenue from walmart group by City,branch order by Revenue;

----- which product line has the largest vat ---
select Product_line, avg(Tax) from walmart
group by Product_line
order by avg(Tax) desc limit 1;

----- which branch sold more products than average product sold ---
select Branch,sum(Quantity) as Qty from walmart group by Branch
 having sum(Quantity) > (select avg(Quantity) from walmart);
 
 -----  revenue via gender ----
 select Gender,avg(Total) as AVG_revenue  from walmart
 group by Gender order by avg(Total) ;
 
 ----- revenue generated via month ---
 select Monthname,avg(Total) as Avg_revenue  from walmart
 group by Monthname;
 
 
 ----- sales -------
 
 ----- number of sales made in each time of day ---=
 select Time_of_day, count(*) as number_of_sales from walmart

 group by Time_of_day;
 
 
 ----- which customer type brings the most revnue ----
 select Customer_type,sum(Total) from walmart
 group by Customer_type order by sum(Total) desc limit 1;
 
 -- which city has the largest vat ( value added tax) ---
 select City, avg(Total) from walmart
 group by City order by avg(Total)
 desc limit 1;
  
  
  ----- customer -----
  -- how many unique customer types ---
  select distinct(Customer_Type) from walmart;
  
  -- ho wmany payment methods are there -- 
  select distinct(payment) from walmart;
  
  -- what is the gender of most of the customers --
  select Gender ,count(*)as count_of_gender from walmart group by gender ;
  
  ----- gender distribution per branch -----
  select Gender ,count(*) as gender_count from walmart where Branch ="B"
  group by Gender
  order by gender_count desc ;
  
  -- which time of day customers give most rating --
  select Time_of_day,count(Rating) as Rating_count ,avg(rating) from walmart
  group by Time_of_day order by count(Rating) desc;

-- which time of day customers give rating per branch --
select Time_of_day,Branch, count(Rating)  from walmart
group by Time_of_day,Branch;

-- which day of week has the best average ratings --
select day_name,avg(Rating) from walmart
group by day_name order by avg(Rating);