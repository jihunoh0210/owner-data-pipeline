create or replace table DEMO_DB.DW_JIHUNOH.FACT_LEADS AS

--bringing only one line for opportunities with multiple lead id's
select
  lead_id,
  form_submission_date,
  status,
  marketplaces_used,
  online_ordering_used,
  cuisine_types,
  connected_with_decision_maker,
  location_count,
  predicted_sales_with_owner,
  sales_call_count,
  sales_text_count,
  sales_email_count,
  first_sales_call,
  first_meeting_booked,
  converted_opportunity_id
from DEMO_DB.STAGING_JIHUNOH.STG_LEADS_VW
where converted_opportunity_id is not null
qualify row_number() over (
    partition by CONVERTED_OPPORTUNITY_ID 
    order by 
        -- Priority 1: Rank the status (True is best, Null is second, False is last)
        case 
            when connected_with_decision_maker = TRUE then 2
            when connected_with_decision_maker is null then 1
            else 0 
        end desc,
        
        -- Priority 2: If the status is a tie, take the most recent date
        form_submission_date desc nulls last
) = 1

union

select
  lead_id,
  form_submission_date,
  status,
  marketplaces_used,
  online_ordering_used,
  cuisine_types
  connected_with_decision_maker,
  location_count,
  predicted_sales_with_owner,
  sales_call_count,
  sales_text_count,
  sales_email_count,
  first_sales_call,
  first_meeting_booked,
  converted_opportunity_id
from DEMO_DB.STAGING_JIHUNOH.STG_LEADS_VW
where converted_opportunity_id is null
;
