SELECT * FROM project_crm1.opportunity3;
use project_crm1;
describe opportunity3;
describe lead_3;
select * from opportunity3;
update opportunity3 set Date_Opportunity_was_Closed="Others" where Date_Opportunity_was_Closed='';
update opportunity3 set Opportunity_Type="Others" where Opportunity_Type='';
update opportunity3 set Industries="Other" where Industries='';
select * from lead_3;
update lead_3 set Industry="Others" where Industry='';
create table crm3 as select * from opportunity3  inner join lead_3 on opportunity3.opportunity_id=lead3.Converted_opportunity_id;
select * from crm3;

-- OPPORTUNITY TABLE --
-- EXPECTED AMOUNT --
select Round(sum(Expected_Amount),2) as Total_Expected_Amount from opportunity3;

-- ACTIVE OPPORTUNITY --
 select count(Date_Opportunity_was_Closed) as Total_Active_Opportunity from opportunity3 where Date_Opportunity_was_Closed ='';
 
 -- CONVERSION RATE --
 select sum(Created_by_Lead_Conversion)/count(Opportunity_id)*100 as Conversion_Rate_Opportunity from opportunity3;
 
 -- WIN RATE --
 select sum(Won)/count(Opportunity_id)*100 as Win_Rate from opportunity3;
 
 -- LOSS RATE --
 select (count(Opportunity_id)-sum(Won))/count(Opportunity_id) * 100 as Loss_Rate from opportunity3;
 
 --  RUNNING TOTAL EXPECTED VS COMMIT FORECAST AMOUNT OVER TIME --
 select  distinct Fiscal_Year,sum(Expected_Amount)  over (order by Fiscal_Year)  as Running_Total_Expected from opportunity3 where Forecast_Category1="commit";
 
 -- RUNNING TOTAL ACTIVE VS TOTAL OPPORTUNITY OVER TIME --
 select  Distinct Fiscal_Year,COUNT(Opportunity_id)   over (order by Fiscal_Year) as Running_Total_Active from opportunity3 where Date_Opportunity_was_Closed="Others";
 
 -- CLOSED WON VS TOTAL OPPORTUNITY OVER TIME --
 select Fiscal_Year,COUNT(Opportunity_id) as Total_Opportunity ,sum(Won) as Total_Closed_Won from opportunity3 group by Fiscal_Year order by Fiscal_Year ASC;
 
 -- CLOSED WON VS TOTAL CLOSED OVER TIME  --
 select Fiscal_Year,sum(Won) as Total_Closed_Won,sum(Closed) as Total_Closed from opportunity3 group by Fiscal_Year order by Fiscal_Year ASC;
 
 -- EXPECTED AMOUNT BY OPPORTUNITY TYPE--
 select Opportunity_Type,Sum(Expected_Amount) from opportunity3 group by Opportunity_Type;
 
 -- OPPORTUNITY_ID BY INDUSTRIES --
 select Industries,count(Opportunity_id) from opportunity3 group by industries order by count(Opportunity_id) DESC limit 5 ;
 
 -- LEAD TABLE --
 -- TOTAL LEAD --
 SELECT SUM(Total_Leads)  as Total_Lead from lead_3;
 
 -- CONVERSION RATE --
 select sum(Conversion_Rate)/sum(Total_Leads)*100 as Conversion_Rate from lead_3;
 
 -- CONVERTED ACCOUNT --
 select sum(Converted_Accounts) as Converted_Account from lead_3;
 
 -- CONVERTED OPPORTUNITY --
 select sum(Converted_Opportunities) as Converted_Opportunities from lead_3;
 
 -- LEAD BY SOURCE --
 select Lead_Source,count(Lead_id) as Lead_ID from lead_3 group by Lead_Source order by Lead_id desc limit 5;
 
 -- LEAD BY INDUSTRY --
 select Industry,count(Lead_id) as Lead_ID from lead_3 group by Industry order by Lead_id desc limit 5;