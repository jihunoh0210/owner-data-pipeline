--------------Current ARR-----------------

select sum(est_ltv_1yr_won) from DEMO_DB.REPORTING_JIHUNOH.FUNNEL_PERFORMANCE; --5,019,262.59

;
-------------------Opportunity 1: Make the first call earlier------------------

/* Call Count and Wins / Win Rate */
SELECT 
    SALES_CALL_COUNT, 
    COUNT( LEAD_ID) AS LEADS,
    SUM( CASE WHEN IS_WON THEN 1 ELSE 0 END) AS WINS,
    -- Marginal Win Rate
    (SUM( CASE WHEN IS_WON THEN 1 ELSE 0 END) / COUNT( LEAD_ID)) * 100 AS WIN_RATE_PCT
FROM DEMO_DB.REPORTING_JIHUNOH.FUNNEL_PERFORMANCE
WHERE SALES_CALL_COUNT <= 20
GROUP BY 1 ORDER BY 1;
-- within 5 calls, 434/623 ~70% of leads are won
-- 7 out of 10 calls close within first 5 attempts
-- around call 6 and 7, the win rate is ~1%, requiring more calls before closing


/* Calculate Wasted call volume > 15 and lost ARR */
SELECT 
    SUM(SALES_CALL_COUNT - 15) AS WASTED_CALLS,
    SUM(REVENUE_WON_1YR) AS LOST_ARR
FROM DEMO_DB.REPORTING_JIHUNOH.FUNNEL_PERFORMANCE
WHERE SALES_CALL_COUNT > 15;
-- wasted calls 28,431



/* Breakdowns of Win Rates and Volume by Time from Form Submission to Call and Customer Value Tier */
SELECT 
    SPEED_SEGMENT,
    VALUE_TIER,
    COUNT(LEAD_ID) AS LEADS,
    SUM(CASE WHEN IS_WON THEN 1 ELSE 0 END) LEADS_WON,
    (SUM(CASE WHEN IS_WON THEN 1 ELSE 0 END) / COUNT(LEAD_ID)) * 100 AS WIN_RATE_PCT,
    ROUND(AVG(POTENTIAL_LTV_1YR),2) AVG_1YR_LTV
FROM DEMO_DB.REPORTING_JIHUNOH.FUNNEL_PERFORMANCE
WHERE SPEED_SEGMENT LIKE '%Target%' OR SPEED_SEGMENT LIKE '%Missed%'
GROUP BY 1  ,2 ORDER BY 1 DESC,2;



-------------------Opportunity 2: Send Customer Texts--------------------

SELECT
    CASE WHEN SALES_TEXT_COUNT > 0 THEN TRUE 
        ELSE FALSE 
    END AS TEXT_SENT,
    VALUE_TIER,
    COUNT(LEAD_ID) AS LEADS,
    SUM(CASE WHEN IS_WON THEN 1 ELSE 0 END) AS WINS,
    AVG(SALES_TEXT_COUNT),
    (SUM(CASE WHEN IS_WON THEN 1 ELSE 0 END) / COUNT(LEAD_ID)) * 100 AS WIN_RATE_PCT,
    AVG(POTENTIAL_LTV_1YR) AS AVG_LTV
FROM DEMO_DB.REPORTING_JIHUNOH.FUNNEL_PERFORMANCE
GROUP BY 1,2
ORDER BY 1 DESC,2
;
