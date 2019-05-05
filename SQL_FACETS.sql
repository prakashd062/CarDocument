
/* 1st Query - for a given group find latest reciept */
select grgr.GRGR_ID,max(rcpt.RCPT_CREATE_DTM) latest_reciept,rcpt.RCPT_ID
from CMC_GRGR_GROUP grgr join
      CMC_RCPT_RECEIPTS rcpt on
       grgr.GRGR_ID=rcpt.RCPT_INPUT_GRGR_ID
 where grgr.GRGR_ID='G0010012'
 group by grgr.GRGR_ID,rcpt.RCPT_ID
 
 /* 2nd Query - for a group get history of bill */
 
 select * from CMC_BLSH_SUM_HIST
 select * from CMC_GRGR_GROUP
 select * from 
 select * from CMC_BLEI_ENTY_INFO
