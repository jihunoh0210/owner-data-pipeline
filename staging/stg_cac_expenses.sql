CREATE OR REPLACE VIEW DEMO_DB.STAGING_JIHUNOH.STG_CAC_EXPENSES_VW AS 
with salary as (
  select
    to_date(month, 'Mon-YY') as month_date,
    'salary_commission' as spend_type,
    'outbound' as spend_channel,
    try_to_decimal(
      replace(regexp_replace(outbound_sales_team, '[^0-9,\.]', ''), ',', '.'),
      18, 2
    ) as amount_usd
  from DEMO_DB.GTM_CASE.EXPENSES_SALARY_AND_COMMISSIONS

  union all

  select
    to_date(month, 'Mon-YY') as month_date,
    'salary_commission' as spend_type,
    'inbound' as spend_channel,
    try_to_decimal(
      replace(regexp_replace(inbound_sales_team, '[^0-9,\.]', ''), ',', '.'),
      18, 2
    ) as amount_usd
  from DEMO_DB.GTM_CASE.EXPENSES_SALARY_AND_COMMISSIONS
),
ads as (
  select
    to_date(month, 'Mon-YY') as month_date,
    'ads' as spend_type,
    'inbound' as spend_channel,
    try_to_decimal(
      replace(regexp_replace(advertising, '[^0-9,\.]', ''), ',', '.'),
      18, 2
    ) as amount_usd
  from DEMO_DB.GTM_CASE.EXPENSES_ADVERTISING
)
select * from salary
union all
select * from ads;
