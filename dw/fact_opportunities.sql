create or replace table DEMO_DB.DW_JIHUNOH.FACT_OPPORTUNITIES as
select
  opportunity_id,
  account_id,
  stage_name,
  lost_reason,
  business_issue,
  how_did_you_hear_about_us,

  created_date,
  demo_set_date,
  demo_time,
  demo_held,
  close_date,
  last_sales_call_date_time,

  iff(stage_name ilike '%won%', true, false) as is_won,
  iff(stage_name ilike '%lost%', true, false) as is_lost,

  /* Attribution rule (DW, not staging) */
  case
    when how_did_you_hear_about_us ilike '%cold%' then 'outbound'
    else 'inbound'
  end as channel_inferred
from DEMO_DB.STAGING_JIHUNOH.STG_OPPORTUNITIES_VW;
