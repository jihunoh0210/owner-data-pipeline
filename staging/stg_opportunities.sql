create or replace view DEMO_DB.STAGING_JIHUNOH.STG_OPPORTUNITIES_VW as 
select
  opportunity_id,
  account_id,
  stage_name,
  lost_reason_c as lost_reason,
  closed_lost_notes_c as closed_lost_notes,
  business_issue_c as business_issue,
  how_did_you_hear_about_us_c as how_did_you_hear_about_us,

  /* date cleanup dates */
  CASE 
        WHEN YEAR(created_date) < 100 THEN DATEADD(year, 2000, created_date)
        ELSE created_date 
    END AS created_date,
  demo_held,
  CASE 
        WHEN YEAR(demo_set_date) < 100 THEN DATEADD(year, 2000, demo_set_date)
        ELSE demo_set_date 
    END AS demo_set_date,

  CASE 
        WHEN YEAR(demo_time) < 100 THEN DATEADD(year, 2000, demo_time)
        ELSE demo_time 
    END AS demo_time,

  CASE 
        WHEN YEAR(close_date) < 100 THEN DATEADD(year, 2000, close_date)
        ELSE close_date 
    END AS close_date,

  CASE 
        WHEN YEAR(last_sales_call_date_time) < 100 THEN DATEADD(year, 2000, last_sales_call_date_time)
        ELSE last_sales_call_date_time 
    END AS last_sales_call_date_time
from demo_db.gtm_case.opportunities;
