create or replace view DEMO_DB.STAGING_JIHUNOH.STG_LEADS_VW as 
select
  lead_id,

  CASE 
        WHEN YEAR(form_submission_date) < 100 THEN DATEADD(year, 2000, form_submission_date)
        ELSE form_submission_date 
    END AS form_submission_date,
  coalesce(sales_call_count, 0) as sales_call_count,
  coalesce(sales_text_count, 0) as sales_text_count,
  coalesce(sales_email_count, 0) as sales_email_count,


  first_sales_call_date as first_sales_call,
  first_text_sent_date as first_text_sent,
  first_meeting_booked_date as first_meeting_booked,
  last_sales_call_date as last_sales_call,
  last_sales_activity_date as last_sales_activity,
  last_sales_email_date as last_sales_email,

  /* cleanup formatting issue comma instead of period */
  try_to_decimal(replace(predicted_sales_with_owner, ',', '.'), 18, 2) as predicted_sales_with_owner,

  marketplaces_used,
  online_ordering_used,
  cuisine_types,
  location_count,
  connected_with_decision_maker,
  status,
  converted_opportunity_id
from demo_db.gtm_case.leads;

