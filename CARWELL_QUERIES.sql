
select * from CAR_CUSTOMER_MASTER
select * from CAR_CONTACT_MASTER
select * from CAR_CUST_LOCATION_MASTER
select * from CAR_TYPE_MASTER
select * from CAR_PROGRAM_MASTER
select * from CAR_CREDIT_BILL_TRANS
select * from CAR_VEH_APP_TRANS
select * from CAR_VEH_RECORD_MASTER
select * from CAR_VEHICLE_MASTER
select * from CAR_VEH_CREDIT_TRANS

select  customer.CUST_NAME,vehicle.VEH_MASTER_ID,app.APPL_DATE
from CAR_CUSTOMER_MASTER customer join
      CAR_CUST_LOCATION_MASTER location on
       customer.CUST_CODE=location.CUST_CODE join 
        CAR_VEH_RECORD_MASTER vehicle on
         location.LOC_CODE=vehicle.LOC_CODE left join
           CAR_VEH_APP_TRANS app on
            vehicle.VEH_MASTER_ID=app.VEH_MASTER_ID
where customer.TYP_CODE=5 and customer.CUST_NAME like '%KSRTC%' and vehicle.PROGRAM_YEARS>0 
     



/* first Query - Pass a  type of customer as a parameter and generate the following report

Cust_Name, Address, Total No of sprays for the current year , pending for the year  */

select  distinct vehicle.PROGRAM_YEARS, vehicle.VEH_MASTER_ID,app.APPL_DATE
 from CAR_CUSTOMER_MASTER customer join
       CAR_CUST_LOCATION_MASTER location on
        customer.CUST_CODE=location.CUST_CODE  join
         CAR_VEH_RECORD_MASTER vehicle on
          location.LOC_CODE=vehicle.LOC_CODE left join
           CAR_VEH_APP_TRANS app on
            vehicle.VEH_MASTER_ID=app.VEH_MASTER_ID
         
 where TYP_CODE=3 and CUST_NAME like '%APSR%' and vehicle.TERM_DATE is null  and 
		vehicle.PROGRAM_YEARS>0

 
 /* second query - Pass a  type of customer as a parameter and generate the following report

Cust_Name, Address, total billed  - Non Program , total billed  - Program

drill down on customer */
  
   select  distinct vehicle.PROGRAM_YEARS, vehicle.VEH_MASTER_ID,app.APPL_DATE,
						vehicle.ANNUAL_PRICE_OVERIDE,vehicle.VEH_NUM
 from CAR_CUSTOMER_MASTER customer join
       CAR_CUST_LOCATION_MASTER location on
        customer.CUST_CODE=location.CUST_CODE  join
         CAR_VEH_RECORD_MASTER vehicle on
          location.LOC_CODE=vehicle.LOC_CODE left join
           CAR_VEH_APP_TRANS app on
            vehicle.VEH_MASTER_ID=app.VEH_MASTER_ID
         
 where TYP_CODE=2 and CUST_NAME like '%GANESH%' and vehicle.TERM_DATE is null  
		and app.APPL_DATE>'2018'
		
		
/* Third Query - Accept two parameter , one application year and one Program or Non Program

Generate   a Report with Vehicle information , application date , total bill for that.*/

select  distinct customer.CUST_NAME,vehicle.VEH_NUM,app.APPL_DATE,vehicle.ANNUAL_PRICE_OVERIDE
 from CAR_CUSTOMER_MASTER customer join
       CAR_CUST_LOCATION_MASTER location on
        customer.CUST_CODE=location.CUST_CODE  join
         CAR_VEH_RECORD_MASTER vehicle on
          location.LOC_CODE=vehicle.LOC_CODE left join
           CAR_VEH_APP_TRANS app on
            vehicle.VEH_MASTER_ID=app.VEH_MASTER_ID
         
 where  
		 app.APPL_DATE>'2019' and vehicle.PROGRAM_YEARS=0
		 
		 
		 
		 
/* first Query */

 select a.CUST_NAME,count(b.spray_count) total_spray,count(a.Pending_count) pending_spray
from  (select   customer.CUST_NAME,count(distinct customer.CUST_NAME)pending_count, vehicle.VEH_MASTER_ID
   from CAR_CUSTOMER_MASTER customer join
         CAR_CUST_LOCATION_MASTER location on
          customer.CUST_CODE=location.CUST_CODE  join 
           CAR_VEH_RECORD_MASTER vehicle on
             location.LOC_CODE=vehicle.LOC_CODE left join
              CAR_VEH_APP_TRANS application on
               vehicle.VEH_MASTER_ID=application.VEH_MASTER_ID
    where customer.TYP_CODE=2 and vehicle.PROGRAM_YEARS>0 and 
    (application.APPL_DATE not like'%2019%' or application.APPL_DATE is null)
     group by customer.CUST_NAME, vehicle.VEH_MASTER_ID)a  join
    
    
     (select  customer.CUST_NAME,count(distinct customer.CUST_NAME)spray_count, vehicle.VEH_MASTER_ID 
   from CAR_CUSTOMER_MASTER customer join
         CAR_CUST_LOCATION_MASTER location on
          customer.CUST_CODE=location.CUST_CODE  join 
           CAR_VEH_RECORD_MASTER vehicle on
             location.LOC_CODE=vehicle.LOC_CODE left join
              CAR_VEH_APP_TRANS application on
               vehicle.VEH_MASTER_ID=application.VEH_MASTER_ID
    where customer.TYP_CODE=2 and 
			vehicle.PROGRAM_YEARS>0 and 
			application.APPL_DATE like '%2019%'
    group by customer.CUST_NAME, vehicle.VEH_MASTER_ID )b on
    a.CUST_NAME=b.CUST_NAME
    
    where a.CUST_NAME is not null 
     group by a.CUST_NAME
    	 
/* Issue in Hilton Highway */		 
		

	
 
 
