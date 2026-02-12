create or replace table DEMO_DB.DW_JIHUNOH.FACT_CAC_EXPENSES AS
select
  month_date,
  spend_channel as channel,
  spend_type,
  amount_usd
from DEMO_DB.STAGING_JIHUNOH.STG_CAC_EXPENSES_VW;
