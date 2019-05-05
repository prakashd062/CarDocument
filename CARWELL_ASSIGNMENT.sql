select * from CAR_CUSTOMER_MASTER
select * from CAR_CONTACT_MASTER
select * from CAR_CUST_LOCATION_MASTER
select * from CAR_TYPE_MASTER
select * from CAR_PROGRAM_MASTER
select * from CAR_CREDIT_BILL_TRANS
select * from CAR_VEH_APP_TRANS
select * from CAR_VEH_RECORD_MASTER
select * from CAR_VEHICLE_MASTER



/* SELECT customer.CUST_NAME CUSTOMER_NAME,
        location.LOC_DESC ADDRESS,
         COUNT(vehicle.VEH_MASTER_ID) total_spray,(SELECT 
         COUNT(vehicle.VEH_MASTER_ID) 
 FROM CAR_TYPE_MASTER type join 
	   CAR_CUSTOMER_MASTER customer on
	    type.TYP_CODE=customer.TYP_CODE join
	     CAR_CUST_LOCATION_MASTER location on
	      customer.CUST_CODE=location.CUST_CODE join
	       CAR_VEH_RECORD_MASTER vehicle on
	        location.LOC_CODE=vehicle.LOC_CODE join 
	         CAR_VEH_APP_TRANS app on
	          app.VEH_MASTER_ID=vehicle.VEH_MASTER_ID
	
  WHERE type.TYP_CODE=3 and 
		 vehicle.PROGRAM_YEARS>0  and app.APPL_DATE not between '2018-01-01' and '2018-12-01'
		 GROUP BY  CUST_NAME,LOC_DESC  )  total_pending_spray
 FROM CAR_TYPE_MASTER type join 
	   CAR_CUSTOMER_MASTER customer on
	    type.TYP_CODE=customer.TYP_CODE join
	     CAR_CUST_LOCATION_MASTER location on
	      customer.CUST_CODE=location.CUST_CODE join
	       CAR_VEH_RECORD_MASTER vehicle on
	        location.LOC_CODE=vehicle.LOC_CODE join 
	         CAR_VEH_APP_TRANS app on
	          app.VEH_MASTER_ID=vehicle.VEH_MASTER_ID
	
  WHERE type.TYP_CODE=3 and 
		 vehicle.PROGRAM_YEARS>0  and app.APPL_DATE between '2018-01-01' and '2018-12-01'
		 
	GROUP BY  CUST_NAME,LOC_DESC  
union
SELECT customer.CUST_NAME CUSTOMER_NAME,
        location.LOC_DESC ADDRESS,
         COUNT(vehicle.VEH_MASTER_ID) total_pending_spray
 FROM CAR_TYPE_MASTER type join 
	   CAR_CUSTOMER_MASTER customer on
	    type.TYP_CODE=customer.TYP_CODE join
	     CAR_CUST_LOCATION_MASTER location on
	      customer.CUST_CODE=location.CUST_CODE join
	       CAR_VEH_RECORD_MASTER vehicle on
	        location.LOC_CODE=vehicle.LOC_CODE join 
	         CAR_VEH_APP_TRANS app on
	          app.VEH_MASTER_ID=vehicle.VEH_MASTER_ID
	
  WHERE type.TYP_CODE=3 and 
		 vehicle.PROGRAM_YEARS>0  and app.APPL_DATE not between '2018-01-01' and '2018-12-01'
		 GROUP BY  CUST_NAME,LOC_DESC  
	
	
	
	 
	 
select customer.CUST_NAME,
		contact.ADDR1,
		 COUNT(vehicle.VEH_MASTER_ID) spray_count
from CAR_CUSTOMER_MASTER customer join
      CAR_CUST_LOCATION_MASTER location on
       customer.CUST_CODE=location.CUST_CODE left join
        CAR_CONTACT_MASTER contact on
         location.LOC_CODE=contact.LOC_CODE join
          CAR_VEH_RECORD_MASTER vehicle on
           location.LOC_CODE=vehicle.LOC_CODE  join 
	         CAR_VEH_APP_TRANS app on
	          app.VEH_MASTER_ID=vehicle.VEH_MASTER_ID
           
        
        
where customer.TYP_CODE=3 and
       vehicle.PROGRAM_YEARS>0  and   app.APPL_DATE  between '2018-01-01' and '2018-12-01'  
  group by customer.CUST_NAME,contact.ADDR1     
  union
  */
  
 /* ========================================================================================*/ 
 /* 1st Query -  */
 
  select distinct t.CUST_NAME customer_name, t.ADDR1  address, t.spray_count total_spray,s.pending_spray
from  ( select customer.CUST_NAME,
		contact.ADDR1,
		 COUNT(vehicle.VEH_MASTER_ID) spray_count
from CAR_CUSTOMER_MASTER customer join
      CAR_CUST_LOCATION_MASTER location on
       customer.CUST_CODE=location.CUST_CODE left join
        CAR_CONTACT_MASTER contact on
         location.LOC_CODE=contact.LOC_CODE join
          CAR_VEH_RECORD_MASTER vehicle on
           location.LOC_CODE=vehicle.LOC_CODE  join 
	         CAR_VEH_APP_TRANS app on
	          app.VEH_MASTER_ID=vehicle.VEH_MASTER_ID
           
        
        
where customer.TYP_CODE=3 and
       vehicle.PROGRAM_YEARS>0  and   app.APPL_DATE  between '2018-01-01' and '2018-12-31'  
  group by customer.CUST_NAME,contact.ADDR1 ) t , (select customer.CUST_NAME,
		contact.ADDR1,
		 COUNT(vehicle.VEH_MASTER_ID) pending_spray
from CAR_CUSTOMER_MASTER customer join
      CAR_CUST_LOCATION_MASTER location on
       customer.CUST_CODE=location.CUST_CODE left join
        CAR_CONTACT_MASTER contact on
         location.LOC_CODE=contact.LOC_CODE join
          CAR_VEH_RECORD_MASTER vehicle on
           location.LOC_CODE=vehicle.LOC_CODE  join 
	         CAR_VEH_APP_TRANS app on
	          app.VEH_MASTER_ID=vehicle.VEH_MASTER_ID
           
        
        
where customer.TYP_CODE=3 and
       vehicle.PROGRAM_YEARS>0  and   app.APPL_DATE not  between '2018-01-01' and '2018-12-31'  
  group by customer.CUST_NAME,contact.ADDR1)s  
  
  
  /*===========================================================================================*/
  select a.CUST_NAME,count(a.Pending_count) pending_spray,count(b.spray_count) total_spray
from  (select  customer.CUST_NAME,count(vehicle.VEH_MASTER_ID) Pending_count,application.APPL_DATE
   from CAR_CUSTOMER_MASTER customer join
         CAR_CUST_LOCATION_MASTER location on
          customer.CUST_CODE=location.CUST_CODE  join 
           CAR_VEH_RECORD_MASTER vehicle on
             location.LOC_CODE=vehicle.LOC_CODE left join
              CAR_VEH_APP_TRANS application on
               vehicle.VEH_MASTER_ID=application.VEH_MASTER_ID
    where customer.TYP_CODE=3 and vehicle.PROGRAM_YEARS>0 and 
    (application.APPL_DATE <'2018-01-01' or application.APPL_DATE is null)
     group by customer.CUST_NAME,application.APPL_DATE)a left join
    
    
     (select  customer.CUST_NAME,count(vehicle.VEH_MASTER_ID) spray_count,application.APPL_DATE
   from CAR_CUSTOMER_MASTER customer join
         CAR_CUST_LOCATION_MASTER location on
          customer.CUST_CODE=location.CUST_CODE  join 
           CAR_VEH_RECORD_MASTER vehicle on
             location.LOC_CODE=vehicle.LOC_CODE left join
              CAR_VEH_APP_TRANS application on
               vehicle.VEH_MASTER_ID=application.VEH_MASTER_ID
    where customer.TYP_CODE=3 and vehicle.PROGRAM_YEARS>0 and application.APPL_DATE like '%2018%'
    group by customer.CUST_NAME,application.APPL_DATE )b on
    a.CUST_NAME=b.CUST_NAME
     
     group by a.CUST_NAME,b.CUST_NAME