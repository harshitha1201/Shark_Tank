select *
from shark_tank_india

-- 1. total episodes
select max(episode_number) as total_no_of_episodes
from shark_tank_india

select count(distinct episode_number) as total_no_of_episodes
from shark_tank_india

-- 2. pitches 

select count(distinct brand) as no_of_pitches 
from shark_tank_india

-- 3. pitches converted

select count(*) as pitches_converted_to_offers
from shark_tank_india
where amount_invested_lakhs>0

select count(case when amount_invested_lakhs>0 then 1 end) as pitches_converted_to_offers
from shark_tank_india

-- 4. total male

select sum(male) as no_of_males 
from shark_tank_india

-- 5. total female

select sum(female) as no_of_females
from shark_tank_india

-- 6. gender ratio

select *,(no_of_males/no_of_females) as gender_ratio 
from (
select sum(male) as no_of_males,sum(female) as no_of_females
from shark_tank_india
) as male_female_count

-- 7. total invested amount

select concat(sum(amount_invested_lakhs),' lakhs') as total_invested_amount
from shark_tank_india

-- 8. avg equity taken

select avg(equity_taken_in_percent) as avg_equity_taken_in_percent
from 
(
select equity_taken_in_percent
from shark_tank_india
where equity_taken_in_percent>0
) as avg_equity_table

-- 9. highest deal taken

select concat(max(amount_invested_lakhs), ' lakhs') as highest_deal
from shark_tank_india

-- 10. highest equity taken

select max(equity_taken_in_percent) as highest_equity_taken
from shark_tank_india

-- 11. startups having atleast 1 women
select * from (
select (case when female>0 then brand end) as brand_name
from shark_tank_india
) as atleast_one_female
where brand_name is not null

-- 12. pitches converted having atleast one women

select *
from shark_tank_india
where female>0 and amount_invested_lakhs>0

select *
from shark_tank_india
where female>0 and deal!='No deal'

-- 13. avg team members
select round(avg(team_members),0) as avg_team_members
from shark_tank_india

-- 14. amount invested per deal

select concat(avg(amount_invested_lakhs),' lakhs') as avg_amount_invested
from shark_tank_india
where deal!='No Deal'

-- 15. avg age group of contestants 

select avg_age,count(*) as count_avg_age_group
from shark_tank_india
group by avg_age
order by count_avg_age_group desc

-- 16. top age group among pitchers

select avg_age as most_common_age_group
from (
select top 1 avg_age,count(*) as count_avg_age_group
from shark_tank_india
group by avg_age
order by count_avg_age_group desc
) as avg_age_table

-- 17. most commmon location group of contestants

select top 1 location as most_common_location
from shark_tank_india
group by location
order by count(*) desc

-- 18. most commmon sector group of contestants

select  top 1 sector as most_common_sector
from shark_tank_india
group by sector
order by count(*) desc

-- 19. partner deals

select *
from shark_tank_india
where partners like '%_-_%'

-- 20. all deals

select partners,count(partners) as cnt 
from shark_tank_india  
where partners!='-' 
group by partners 
order by cnt desc

-- 21. which startup bagged highest amount and to which sector does it belong?

select brand, sector
from shark_tank_india
where amount_invested_lakhs= (select max(amount_invested_lakhs) from shark_tank_india)

-- 22. highest amount bagged startup in each sector and which sector does they belong?

select brand,sector,amount_invested_lakhs from (
select *,rank() over(partition by sector order by amount_invested_lakhs desc) as rnk 
from shark_tank_india
) as ranked_table
where rnk =1

-- 23. making the matrix

-- no of episodes Ashneer was there
select count(*) as episodes_by_ashneer
from shark_tank_india
where ashneer_amount_invested is not null

-- no of deals Ashneer has done
select count(*) as deals_by_ashneer
from shark_tank_india
where ashneer_amount_invested>0

-- amount invested by ashneer
select concat(sum(ashneer_amount_invested),' lakhs') as total_by_ashneer
from shark_tank_india

-- avg equity taken by ashneer
select avg(ashneer_equity_taken_in_percent) as avg_equity_ashneer
from shark_tank_india
where ashneer_amount_invested !=0 and ashneer_amount_invested is not null

-- we are now joining the queries making it a row
-- can be done for all sharks

select C.*,D.amount_invested,D.total_by_ashneer from(
select A.*,B.deals_by_ashneer from (
select 'Ashneer' as shark_name,count(*) as episodes_by_ashneer
from shark_tank_india
where ashneer_amount_invested is not null ) as A
inner join 
(select 'Ashneer' as shark_name,count(*) as deals_by_ashneer
from shark_tank_india
where ashneer_amount_invested>0) as B on A.shark_name=B.shark_name
) as C
inner join
(select 'Ashneer' as shark_name,concat(sum(ashneer_amount_invested),' lakhs') as amount_invested,avg(ashneer_equity_taken_in_percent)  as total_by_ashneer
from shark_tank_india
where ashneer_amount_invested !=0 and ashneer_amount_invested is not null) as D on C.shark_name=D.shark_name
