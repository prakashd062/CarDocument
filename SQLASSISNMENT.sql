select * from CMC_MEME_MEMBER /* Member first and Last Name Primary Key - MEME_CK */
select * from CMC_SBSB_SUBSC  /* subscriber first and Last Name SBSB_CK is a primary Key */
select * from CMC_CLCL_CLAIM  /*Claim Number - 061640001500 primary key - CLCL_ID */
select * from CMC_PDPD_PRODUCT	/* Product ID Primary key - PDPD_ID */
select * from CMC_GRGR_GROUP	/* Group Primary Key - GRGR_CK */
select * from CMC_SGSG_SUB_GROUP /* sub - group SGSG_CK*/



/* 1st Query - for a given claim find Member first and Last Name, 
also Subscriber first and last name */
select member.MEME_FIRST_NAME,
		member.MEME_LAST_NAME,
		 subscriber.SBSB_FIRST_NAME,
		  subscriber.SBSB_LAST_NAME,
		    claim.CLCL_ID
from CMC_MEME_MEMBER member,
		CMC_SBSB_SUBSC subscriber, 
				CMC_CLCL_CLAIM  claim
	where member.SBSB_CK=subscriber.SBSB_CK and 
			subscriber.SBSB_CK=claim.SBSB_CK and 
				claim.CLCL_ID='061640001500'
	
				
/*2nd Query - for a given Product how many claims are there in Table  */
	
select product.PDPD_ID,count(claim.CLCL_ID) claim_count
 from CMC_PDPD_PRODUCT product,
		  CMC_CLCL_CLAIM claim
  where product.PDPD_ID=claim.PDPD_ID and product.PDPD_ID='PDD10016'		
group by 	product.PDPD_ID	  		


/*3rd Query - for a given Product how many claims are there in Table and how many members */
select  product.PDPD_ID,
				 count( claim.CLCL_ID) CLAIM_COUNT,
				  count(distinct member.MEME_CK) MEMBER_COUNT
 from CMC_PDPD_PRODUCT product,
		  CMC_CLCL_CLAIM claim,
		   CMC_MEME_MEMBER member
  where product.PDPD_ID=claim.PDPD_ID and 
		 claim.MEME_CK=member.MEME_CK and 
		  product.PDPD_ID='PMP10504'		
group by 	product.PDPD_ID		

/*3rd Query - for a given Product how many claims are there in Table and how many members */
select MEPE.PDPD_ID Product,
		count(distinct MEPE.MEME_CK) MEMBER_COUNT,
			count( clcl.CLCL_ID) CLAIM_COUNT
 from CMC_MEPE_PRCS_ELIG MEPE left join CMC_CLCL_CLAIM clcl on MEPE.MEME_CK =clcl.MEME_CK
where MEPE.MEPE_ELIG_IND='Y' and MEPE.PDPD_ID='PMP10504' and 
	GETDATE() between MEPE.MEPE_EFF_DT and MEPE.MEPE_TERM_DT
group by MEPE.PDPD_ID

/*4th Query - For a given list of products 
how many claims are there if zero claims show zero for that product  'PDD10016','PMP10504',*/ 

select  product.PDPD_ID,count(claim.CLCL_ID) claim_count
 from CMC_PDPD_PRODUCT product,
		  CMC_CLCL_CLAIM claim
  where product.PDPD_ID=claim.PDPD_ID and product.PDPD_ID in('PDD10016','PRA19481')
group by 	product.PDPD_ID	  	
having COUNT(product.PDPD_ID)>=0 or COUNT(product.PDPD_ID) is null	

/* Alternate for 4th Query */
select product.PDPD_ID,count(claim.CLCL_ID) claim_count
 from CMC_PDPD_PRODUCT product left join
		  CMC_CLCL_CLAIM claim
  on product.PDPD_ID=claim.PDPD_ID 
  where product.PDPD_ID in('PDD10016','PMP10504','PRA19481')	
group by 	product.PDPD_ID

/*5th Query - for a given claim what is subscriber ID and member suffix */

select distinct subscriber.SBSB_ID,member.MEME_SFX
 from CMC_CLCL_CLAIM claim,
		CMC_SBSB_SUBSC subscriber,
		 CMC_MEME_MEMBER member
  where claim.SBSB_CK=subscriber.SBSB_CK and
		 subscriber.SBSB_CK=member.SBSB_CK and
		  claim.CLCL_ID='061640001500'
		  
  










select pdpd.PDPD_ID,count(distinct clcl.CLCL_ID) CLAIM_COUNT
from CMC_PDPD_PRODUCT pdpd,CMC_SGSG_SUB_GROUP sgsg,CMC_CLCL_CLAIM clcl
where pdpd.PDPD_ID in ('PDD10016','PMP10504','PRA19035')and
		pdpd.LOBD_ID=sgsg.SGSG_ID  
		 group by pdpd.PDPD_ID	 
	
	/*sgsg.SGSG_CK=clcl.SGSG_CK and
			pdpd.PDPD_ID=clcl.PDPD_ID */
			
select product.PDPD_ID,count(claim.CLCL_ID) claim_count
 from CMC_PDPD_PRODUCT product left join
		  CMC_CLCL_CLAIM claim
  on product.PDPD_ID=claim.PDPD_ID and product.PDPD_ID in('PDD10016','PMP10504','PRA19481')	
group by 	product.PDPD_ID
having COUNT(product.PDPD_ID)>=0 or COUNT(product.PDPD_ID) is null

select  product.PDPD_ID,count(claim.CLCL_ID) claim_count
 from CMC_PDPD_PRODUCT product, CMC_SGSG_SUB_GROUP sub,
		  CMC_CLCL_CLAIM claim
 where sub.SGSG_ID=product.LOBD_ID and
  sub.SGSG_CK=claim.SGSG_CK and product.PDPD_ID in('PDD10016','PRA19481')
group by 	product.PDPD_ID	  	
having COUNT(product.PDPD_ID)>=0 or COUNT(product.PDPD_ID) is null	




/*==================================================================================================*/

/*Sequel 2nd Assignment - Use Exit and NotExist */
		/* Member first and Last Name Primary Key - MEME_CK */
select * from CMC_SBSB_SUBSC  /* subscriber first and Last Name SBSB_CK is a primary Key */
select * from CMC_CLCL_CLAIM	 /*Claim Number - 061640001500 primary key - CLCL_ID */
select * from CMC_PDPD_PRODUCT	/* Product ID Primary key - PDPD_ID */
select * from CMC_GRGR_GROUP	/* Group Primary Key - GRGR_CK */
select * from CMC_SGSG_SUB_GROUP /* sub - group SGSG_CK*/
select * from CMC_MEPE_PRCS_ELIG MEPE
select * from CMC_MEME_MEMBER		
/*====================================================================================*/	
/* 1.for a given group, list all the products where subscriber's have a claim */
select distinct MEPE.PDPD_ID
	from CMC_MEPE_PRCS_ELIG MEPE join CMC_GRGR_GROUP GRGR
		on MEPE.GRGR_CK=GRGR.GRGR_CK 
			where exists(select * 
							from CMC_SBSB_SUBSC  sbsb join  CMC_CLCL_CLAIM clcl
									on sbsb.SBSB_CK=clcl.MEME_CK) and MEPE.PDPD_ID is not null
/* 1 Question - 2nd Attempt */
select distinct MEPE.PDPD_ID, GRGR.GRGR_ID
	from CMC_GRGR_GROUP GRGR join
		  	CMC_MEPE_PRCS_ELIG MEPE on
		  		 GRGR.GRGR_CK=MEPE.GRGR_CK   join
		  		     CMC_MEME_MEMBER MEME on 
		  		      MEPE.MEME_CK=MEME.MEME_CK
     where exists(select 1
							from CMC_CLCL_CLAIM clcl
									where MEME.MEME_CK=clcl.MEME_CK) and 	
									 MEME.MEME_REL='M'  and GRGR.GRGR_ID='G0010001'	  
									 
									     
/*=====================================================================================*/

/* 2nd Query - for a given group how many spouse's have claims[spouse is a wife or husband]*/

select GRGR.GRGR_ID group_id ,
		COUNT( MEME.MEME_CK) spouse_count
		  
	from CMC_GRGR_GROUP GRGR join
			CMC_MEPE_PRCS_ELIG MEPE on
			 GRGR.GRGR_CK=MEPE.GRGR_CK join
		  		       CMC_MEME_MEMBER MEME on 
		  		        MEPE.MEME_CK=MEME.MEME_CK
   
     where exists(select 1
							from CMC_CLCL_CLAIM clcl
									where MEME.MEME_CK=clcl.MEME_CK and MEME.MEME_REL in ('W','H')) and  	
									 MEME.MEME_REL in ('W','H')  and  
									  GRGR.GRGR_ID='G0010004'		
		
	  Group By GRGR.GRGR_ID							 	 
  
/* ========================================================================*/

/*3rd Query - for a given group how many prducts are there how many members are 
	there and count of childrens who dont have claim */
	
select COUNT(distinct MEPE.PDPD_ID) Product_Count,
       COUNT( MEPE.MEME_CK) Member_Count,
		COUNT(distinct MEME.MEME_CK) Children_Count

from CMC_GRGR_GROUP GRGR  join
			CMC_MEPE_PRCS_ELIG MEPE on
			 GRGR.GRGR_CK=MEPE.GRGR_CK join
		  		       CMC_MEME_MEMBER MEME on 
		  		        MEPE.MEME_CK=MEME.MEME_CK join
		  		         CMC_CLCL_CLAIM	clcl on
		  		          clcl.MEME_REL=MEME.MEME_REL
		  		         		 
		 
where  not exists(select 1
					from CMC_MEME_MEMBER MEME
					  where MEME.MEME_REL in ('S','D','O')) and
			
					    GRGR.GRGR_ID='G0010022' 
					    
					    
/*============================================================================= */

/* child having claim and child not having claim usit exist and notexist */
select *
from 
where exists(select meme.MEME_CK
from CMC_MEME_MEMBER meme 
where meme.MEME_REL in	('S','D','O')) 	    

SELECT GRGR.GRGR_ID group_id, COUNT(distinct MEPE.PDPD_ID) ProdID ,COUNT(distinct MEME.MEME_CK) MEMBERS , COUNT(Distinct Meme1.MEME_CK) Child_No_Claims,COUNT(Distinct Meme2.MEME_CK) Child_have_Claims  
FROM CMC_GRGR_GROUP GRGR join
CMC_MEPE_PRCS_ELIG MEPE on
GRGR.GRGR_CK=MEPE.GRGR_CK join
CMC_CLCL_CLAIM clcl on
clcl.PDPD_ID=MEPE.PDPD_ID join
CMC_MEME_MEMBER MEME on 
clcl.MEME_CK=MEME.MEME_CK Join
CMC_MEME_MEMBER Meme1 ON
GRGR.GRGR_CK=Meme1.GRGR_CK 
JOIN CMC_MEME_MEMBER Meme2 ON
GRGR.GRGR_CK=Meme2.GRGR_CK 

WHERE GRGR.GRGR_ID='G0010022' AND exists(select 1 FROM CMC_CLCL_CLAIM clcl
WHERE clcl.MEME_CK=MEME.MEME_CK) And NOT Exists(select 1 FROM CMC_CLCL_CLAIM clcl
WHERE  clcl.MEME_CK=Meme1.MEME_CK) AND Exists(select 1 FROM CMC_CLCL_CLAIM clcl
WHERE  clcl.MEME_CK=Meme2.MEME_CK)
AND Meme1.MEME_REL IN('D', 'S', 'O')
AND Meme2.MEME_REL IN('D', 'S', 'O')
GROUP BY GRGR.GRGR_ID

/*======================================================================================*/
/* 29/01/2019 -- use inline and subquery */

select * from CMC_SBSB_SUBSC  /* subscriber first and Last Name SBSB_CK is a primary Key */
select * from CMC_CLCL_CLAIM	 /*Claim Number - 061640001500 primary key - CLCL_ID */
select * from CMC_PDPD_PRODUCT	/* Product ID Primary key - PDPD_ID */
select * from CMC_GRGR_GROUP	/* Group Primary Key - GRGR_CK */
select * from CMC_SGSG_SUB_GROUP /* sub - group SGSG_CK*/
select * from CMC_MEPE_PRCS_ELIG MEPE
select * from CMC_MEME_MEMBER	

/* 1. for a given group list all the products ,subscriber and 
		count of members who have claims */
		
		


select count(mepe.pdpd_id),COUNT(
from CMC_GRGR_GROUP GRGR grgr right join
		CMC_MEPE_PRCS_ELIG mepe on
		 GRGR.GRGR_CK=MEPE.GRGR_CK right join	
		   CMC_SBSB_SUBSC sbsb
		   mepe.meme_ck=meme.meme_ck 
		  
where (select clcl.MEME_CK
from CMC_CLCL_CLAIM clcl
where clcl.MEME_CK=meme.MEME_CK)			


/*====================================================*/
select  mepe.PDPD_ID,sbsb.SBSB_ID, 
		sbsb.SBSB_FIRST_NAME,
		 sbsb.SBSB_LAST_NAME,
		  COUNT(distinct meme.MEME_CK) member_count
from CMC_GRGR_GROUP grgr  join
		CMC_MEPE_PRCS_ELIG mepe on
		 grgr.GRGR_CK=mepe.GRGR_CK  join	
		  CMC_SBSB_SUBSC sbsb on 
		   mepe.GRGR_CK=sbsb.GRGR_CK   join 
		    CMC_MEME_MEMBER meme on
		     sbsb.SBSB_CK=meme.SBSB_CK 
where meme.MEME_CK in(select clcl.MEME_CK
from CMC_CLCL_CLAIM clcl
where clcl.MEME_CK=meme.MEME_CK and meme.MEME_REL not in('M')) and grgr.GRGR_ID='G0010022'
group by mepe.PDPD_ID,sbsb.SBSB_ID, sbsb.SBSB_FIRST_NAME,sbsb.SBSB_LAST_NAME

/*==========*/

select  mepe.PDPD_ID,sbsb.SBSB_ID, 
		sbsb.SBSB_FIRST_NAME,
		 sbsb.SBSB_LAST_NAME,
		  (select count (distinct clcl.MEME_CK)
from CMC_CLCL_CLAIM clcl,CMC_MEME_MEMBER meme
where  meme.MEME_REL NOT IN ('M')) memeber_count
from CMC_GRGR_GROUP grgr
INNER JOIN CMC_SBSB_SUBSC sbsb
ON grgr.GRGR_CK=sbsb.GRGR_CK
INNER JOIN CMC_MEME_MEMBER meme
ON meme.SBSB_CK=sbsb.SBSB_CK
INNER JOIN CMC_MEPE_PRCS_ELIG mepe
ON meme.MEME_CK=mepe.MEME_CK   
where   grgr.GRGR_ID='G0010022' AND 
		 mepe.MEPE_ELIG_IND='Y' AND 
		  GETDATE() BETWEEN mepe.MEPE_EFF_DT AND mepe.MEPE_TERM_DT
group by mepe.PDPD_ID,sbsb.SBSB_ID, sbsb.SBSB_FIRST_NAME,sbsb.SBSB_LAST_NAME

/*==============================================================================*/

/* 2. for a given group list all the subscriber and 
		get the claimid for the last paid dependent */
		
select sbsb.SBSB_ID, 
		sbsb.SBSB_FIRST_NAME,
		 sbsb.SBSB_LAST_NAME,
		  clcl.CLCL_ID

from  CMC_GRGR_GROUP grgr join 
		CMC_SBSB_SUBSC sbsb on 
		 grgr.GRGR_CK=sbsb.GRGR_CK join
		  CMC_CLCL_CLAIM clcl on
		   sbsb.SBSB_CK=clcl.SBSB_CK

where   clcl.CLCL_PAID_DT=(select MAX(clcl2.CLCL_PAID_DT)
							from  CMC_CLCL_CLAIM clcl2
							 where 	clcl.MEME_REL NOT IN('M') and clcl2.SBSB_CK=sbsb.SBSB_CK) and
		  grgr.GRGR_ID='G0010001'		 		  					    



	/*	select MAX(clcl.CLCL_PAID_DT),clcl.CLCL_ID
		from CMC_CLCL_CLAIM clcl
		group by clcl.CLCL_ID	*/		
						
/* ===================================================================*/
/* 	3. for a given group list all the subscribers and 
		there latest product and there oldest claim 	*/	
	
	select sbsb.SBSB_ID, 
			sbsb.SBSB_FIRST_NAME,
			 sbsb.SBSB_LAST_NAME,
			  clcl.CLCL_ID,
			   mepe.PDPD_ID

	 from  CMC_GRGR_GROUP grgr join 
		    CMC_SBSB_SUBSC sbsb on 
		     grgr.GRGR_CK=sbsb.GRGR_CK join
		      CMC_CLCL_CLAIM clcl on
			   sbsb.SBSB_CK=clcl.SBSB_CK join
		        CMC_MEPE_PRCS_ELIG mepe on 
		         clcl.MEME_CK=mepe.MEME_CK
		     
 where   clcl.CLCL_PAID_DT=(select MIN(clcl2.CLCL_PAID_DT)
							from  CMC_CLCL_CLAIM clcl2
							 where 	  clcl2.SBSB_CK=sbsb.SBSB_CK) and
		  grgr.GRGR_ID='G0010001'	and 
		   	mepe.MEPE_ELIG_IND='Y' and
		   	 mepe.MEPE_EFF_DT=(select MAX(mepe2.MEPE_EFF_DT)
		   						from  	CMC_MEPE_PRCS_ELIG mepe2
		   						 where mepe2.MEPE_ELIG_IND='Y' and 
		   						        mepe2.MEME_CK=mepe.MEME_CK)	 
		   						        

/* ====================================================================================*/
/* 3rd assignment 31/01/2019
club i.exist, ii.Inline and iii.subquery */

/* 1. for a given group for all subscriber's find the latest claim for a dependent who is son 
and maximum claim amount paid subscriber wise and is there a claim for the subscriber
[If present return 'YES'] */

select distinct grgr.GRGR_ID groupid,
	    sbsb.SBSB_FIRST_NAME subscriber_first_name,
	     sbsb.SBSB_LAST_NAME subscriber_last_name,
	     (select *
						 from CMC_CLCL_CLAIM clcl1
					  where clcl2.MEME_REL='M') son_claim,
	      
	       (select MAX(clcl2.CLCL_TOT_PAYABLE)
						 from CMC_CLCL_CLAIM clcl2
					  where clcl2.MEME_REL='M')	max_subscriber_claim	
 
 from CMC_GRGR_GROUP grgr join
       CMC_SBSB_SUBSC sbsb on 
		grgr.GRGR_CK=sbsb.GRGR_CK join
		 CMC_CLCL_CLAIM clcl on
		  sbsb.SBSB_CK=clcl.SBSB_CK
  
  where grgr.GRGR_ID='G0010001'	
  
 /* and 
		 clcl.MEME_REL='S' and 
		 clcl.CLCL_PAID_DT=(select MAX(clcl1.CLCL_PAID_DT)
							 from CMC_CLCL_CLAIM clcl1
							  where clcl.SBSB_CK=clcl1.SBSB_CK) and */
					  
		  




/*select MAX(clcl.CLCL_PAID_DT),clcl.CLCL_ID from CMC_GRGR_GROUP grgr join CMC_CLCL_CLAIM clcl
on grgr.GRGR_CK=clcl.GRGR_CK
where clcl.MEME_REL='S' and grgr.GRGR_ID='G0010001'
group by clcl.CLCL_ID */


/*=======================================================================================*/

/*2. for a given group return the wife first name, last name and maximum claim paid and 
		last paid */
		
		
	select distinct (select meme2.MEME_FIRST_NAME
	                  from CMC_MEME_MEMBER meme2
	                   where meme2.MEME_REL='W') WIFE_FIRST_NAME, 
					 (select meme2.MEME_LAST_NAME
	                  from CMC_MEME_MEMBER meme2
	                   where meme2.MEME_REL='W') WIFE_LAST_NAME,
					  clcl.CLCL_ID MAX_CLAIM_PAID
						 
	 from  CMC_GRGR_GROUP grgr join 
		    CMC_SBSB_SUBSC sbsb on 
		     grgr.GRGR_CK=sbsb.GRGR_CK join
		      CMC_MEME_MEMBER meme on
		       sbsb.SBSB_CK=meme.SBSB_CK join
		        CMC_MEPE_PRCS_ELIG mepe on
		         meme.MEME_CK=mepe.MEME_CK join
		          CMC_CLCL_CLAIM clcl on
		           mepe.MEME_CK=clcl.MEME_CK
		           
	  where   
			  grgr.GRGR_ID='G0010003' and  
			   clcl.CLCL_ID in(select clcl2.CLCL_ID, MAX(clcl2.CLCL_TOT_PAYABLE)
										from CMC_CLCL_CLAIM clcl2)     
  	 
  	 group by clcl.CLCL_ID
  

/*==================================================================================*/
/*4th assignment 04/02/2019*/

/* 1. for a given group find the range of claims and list them
ranges have to be split in increments of 100
0-100
101-200
201-300 */

select distinct grgr.GRGR_ID,
		case 
			when clcl.CLCL_TOT_PAYABLE between 0 and 100 then '0-100'
			when clcl.CLCL_TOT_PAYABLE between 101 and 200 then '101-200'
			when clcl.CLCL_TOT_PAYABLE between 201 and 300 then '201-300'
			when clcl.CLCL_TOT_PAYABLE between 301 and 400 then '301-400'
			else 'high $ claim'
			end as claim_range, clcl.CLCL_ID
		 
 from CMC_GRGR_GROUP grgr join
	    CMC_CLCL_CLAIM clcl on
	     grgr.GRGR_CK=clcl.GRGR_CK

   where grgr.GRGR_ID='G0010003' 
		
/*2. for a given subscriber if the claim belongs to wife or son or any other dependent
u need to count as dependent claim count and subscriber claim count [two seperate ]*/    


select  grgr.GRGR_ID,sbsb.SBSB_ID,sum (case
			 when clcl.MEME_REL!='M' then 1
			  else 0
			  end) dependent_claim_count,
		 SUM(case
			 when clcl.MEME_REL='M' then 1
			  else 0
			  end)	subscriber_claim_count,claim_range

  from CMC_GRGR_GROUP grgr join 
		    CMC_SBSB_SUBSC sbsb on 
		     grgr.GRGR_CK=sbsb.GRGR_CK join
		      CMC_CLCL_CLAIM clcl on
		       sbsb.SBSB_CK=clcl.SBSB_CK join
		        (select  distinct clcl2.SBSB_CK,
		case 
			when clcl2.CLCL_TOT_PAYABLE between 0 and 100 then '0-100'
			when clcl2.CLCL_TOT_PAYABLE between 101 and 200 then '101-200'
			when clcl2.CLCL_TOT_PAYABLE between 201 and 300 then '201-300'
			when clcl2.CLCL_TOT_PAYABLE between 301 and 400 then '301-400'
			else 'high $ claim'
			end as claim_range 
			from CMC_CLCL_CLAIM clcl2	) y on
			y.SBSB_CK=clcl.SBSB_CK
					       
	where grgr.GRGR_ID='G0010001' 	
	 
	 group by sbsb.SBSB_ID,grgr.GRGR_ID	,claim_range     
	 
	  order by 1,2,3 
	  
	  
select clcl.CLCL_TOT_PAYABLE,sbsb.SBSB_ID
from CMC_SBSB_SUBSC sbsb join
		CMC_MEME_MEMBER meme on
		 sbsb.SBSB_CK=meme.SBSB_CK join
		CMC_CLCL_CLAIM clcl
		on meme.MEME_CK=clcl.MEME_CK	

where sbsb.SBSB_ID=200000003
select * from cmc_bl

/*===================================================================================*/
/* 5th assignment 12/02/2019 */

/*1. For a given grp find the oldest bill , newest bill , 
max billed amount , min billed amount */ 	  
select * from CMC_BLBL_BILL_SUMM

select grgr.GRGR_ID,min(blbl.BLBL_DUE_DT) oldest_bill,
		max(blbl.BLBL_DUE_DT) newest_bill,
		 max(blbl.BLBL_BILLED_AMT) max_billed_amount,
		  MIN(blbl.BLBL_BILLED_AMT) min_billed_amount
		 
 from CMC_GRGR_GROUP grgr join 
         CMC_BLBL_BILL_SUMM blbl on 
          grgr.GRGR_CK=blbl.BLEI_CK
  
  where    blbl.BLBL_BILLED_AMT>0    
   
   group by  grgr.GRGR_ID
           
/* 2. For a given prod , find all grps tht are billed and wht is the max bill 
			and min number of sub */
select * from 	CMC_BLSB_SB_DETAIL	
select * from  CMC_MEPE_PRCS_ELIG	

select   blct.PDPD_ID,grgr.GRGR_ID,
		MAX(blbl.BLBL_BILLED_AMT) max_bill,( select  count(distinct sbsb1.SBSB_CK)
													from CMC_SBSB_SUBSC sbsb1 join
															CMC_GRGR_GROUP grgr1 on
															 sbsb1.GRGR_CK=grgr1.GRGR_CK join
															  CMC_MEPE_PRCS_ELIG mepe1 on
															   grgr1.GRGR_CK=mepe1.GRGR_CK
															    where mepe1.PDPD_ID='ZVX10003'	
															    
															  ) subscriber_count
		
 from CMC_BLCT_COMP_TOTL blct join
	     CMC_BLSB_SB_DETAIL blsb on
	      blct.BLEI_CK=blsb.BLEI_CK join
	       CMC_BLBL_BILL_SUMM blbl on
	        blsb.BLEI_CK=blbl.BLEI_CK join
	         CMC_GRGR_GROUP grgr on
	          blbl.BLEI_CK=grgr.GRGR_CK 
	           
	      
	
  where blct.PDPD_ID='ZVX10003'
   
   group by blct.PDPD_ID,grgr.GRGR_ID
   
   
   
   select distinct mepe.PDPD_ID,grgr.GRGR_ID
    from CMC_MEPE_PRCS_ELIG mepe join
          CMC_GRGR_GROUP grgr on
             mepe.GRGR_CK=grgr.GRGR_CK 
             
     where PDPD_ID='PDD10016'     
      group by  mepe.PDPD_ID,grgr.GRGR_ID  



SELECT DISTINCT T1.PDPD_ID,GRGR_ID,maxamount,countsbsb fROM
( select Max(BLBL_BILLED_AMT) maxamount , min(SBSB_CNT) countsbsb ,BLCT.PDPD_ID from CMC_BLCT_COMP_TOTL BLCT 
Inner Join (select BLEI_CK ,BLBL_DUE_DT , count(Distinct SBSB_CK) SBSB_CNT from 
CMC_BLSB_SB_DETAIL group by BLEI_CK ,BLBL_DUE_DT ) BLSB 
 on  BLCT.BLEI_CK=BLSB.BLEI_CK and BLCT.BLBL_DUE_DT=BLSB.BLBL_DUE_DT 
Inner Join CMC_BLBL_BILL_SUMM BLBL on BLSB.BLEI_CK=BLBL.BLEI_CK and BLSB.BLBL_DUE_DT = BLBL.BLBL_DUE_DT 
Inner Join CMC_BLEI_ENTY_INFO BLEI on BLEI.BLEI_CK=BLBL.BLEI_CK

where BLCT.PDPD_ID = 'ZMP10605' 
group by BLCT.PDPD_ID ) T1
INNER JOIN  CMC_BLCT_COMP_TOTL BLCT1 ON T1.PDPD_ID = BLCT1.PDPD_ID
INNER JOIN  CMC_BLEI_ENTY_INFO BLEI1 ON BLEI1.BLEI_CK = BLCT1.BLEI_CK
Inner Join CMC_GRGR_GROUP GR on GR.GRGR_CK = BLEI1.BLEI_CK 
	      
  