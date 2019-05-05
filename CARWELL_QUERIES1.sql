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
    (application.APPL_DATE <'2019-01-01' or application.APPL_DATE is null)
     group by customer.CUST_NAME,application.APPL_DATE)a left join
    
    
     (select  customer.CUST_NAME,count(vehicle.VEH_MASTER_ID) spray_count,application.APPL_DATE
   from CAR_CUSTOMER_MASTER customer join
         CAR_CUST_LOCATION_MASTER location on
          customer.CUST_CODE=location.CUST_CODE  join 
           CAR_VEH_RECORD_MASTER vehicle on
             location.LOC_CODE=vehicle.LOC_CODE left join
              CAR_VEH_APP_TRANS application on
               vehicle.VEH_MASTER_ID=application.VEH_MASTER_ID
    where customer.TYP_CODE=3 and vehicle.PROGRAM_YEARS>0 and application.APPL_DATE like '%2019%'
    group by customer.CUST_NAME,application.APPL_DATE )b on
    a.CUST_NAME=b.CUST_NAME
     
     group by a.CUST_NAME,b.CUST_NAME
     order by a.CUST_NAME