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

-------------------------------------------------------------------------------------------------------------------------------------------------

-- we are now joining the queries making it a row
-- can be done for all sharks

select C.*,D.amount_invested,D.avg_equity from(
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
(select 'Ashneer' as shark_name,concat(sum(ashneer_amount_invested),' lakhs') as amount_invested,avg(ashneer_equity_taken_in_percent)  as avg_equity
from shark_tank_india
where ashneer_amount_invested !=0 and ashneer_amount_invested is not null) as D on C.shark_name=D.shark_name
union
select C.*,D.amount_invested,D.avg_equity from(
select A.*,B.deals_by_namita from (
select 'Namita' as shark_name,count(*) as episodes_by_namita
from shark_tank_india
where namita_amount_invested is not null ) as A
inner join 
(select 'Namita' as shark_name,count(*) as deals_by_namita
from shark_tank_india
where namita_amount_invested>0) as B on A.shark_name=B.shark_name
) as C
inner join
(select 'Namita' as shark_name,concat(sum(namita_amount_invested),' lakhs') as amount_invested,avg(namita_equity_taken_in_percent)  as avg_equity
from shark_tank_india
where namita_amount_invested !=0 and namita_amount_invested is not null) as D on C.shark_name=D.shark_name
union
select C.*,D.amount_invested,D.avg_equity from(
select A.*,B.deals_by_anupam from (
select 'Anupam' as shark_name,count(*) as episodes_by_anupam
from shark_tank_india
where anupam_amount_invested is not null ) as A
inner join 
(select 'Anupam' as shark_name,count(*) as deals_by_anupam
from shark_tank_india
where anupam_amount_invested>0) as B on A.shark_name=B.shark_name
) as C
inner join
(select 'Anupam' as shark_name,concat(sum(anupam_amount_invested),' lakhs') as amount_invested,avg(anupam_equity_taken_in_percent)  as avg_equity
from shark_tank_india
where anupam_amount_invested !=0 and anupam_amount_invested is not null) as D on C.shark_name=D.shark_name
union
select C.*,D.amount_invested,D.avg_equity from(
select A.*,B.deals_by_vineeta from (
select 'Vineeta' as shark_name,count(*) as episodes_by_vineeta
from shark_tank_india
where vineeta_amount_invested is not null ) as A
inner join 
(select 'Vineeta' as shark_name,count(*) as deals_by_vineeta
from shark_tank_india
where vineeta_amount_invested>0) as B on A.shark_name=B.shark_name
) as C
inner join
(select 'Vineeta' as shark_name,concat(sum(vineeta_amount_invested),' lakhs') as amount_invested,avg(vineeta_equity_taken_in_percent)  as avg_equity
from shark_tank_india
where vineeta_amount_invested !=0 and vineeta_amount_invested is not null) as D on C.shark_name=D.shark_name
union
select C.*,D.amount_invested,D.avg_equity from(
select A.*,B.deals_by_aman from (
select 'Aman' as shark_name,count(*) as episodes_by_aman
from shark_tank_india
where aman_amount_invested is not null ) as A
inner join 
(select 'Aman' as shark_name,count(*) as deals_by_aman
from shark_tank_india
where aman_amount_invested>0) as B on A.shark_name=B.shark_name
) as C
inner join
(select 'Aman' as shark_name,concat(sum(aman_amount_invested),' lakhs') as amount_invested,avg(aman_equity_taken_in_percent)  as avg_equity
from shark_tank_india
where aman_amount_invested !=0 and aman_amount_invested is not null) as D on C.shark_name=D.shark_name
