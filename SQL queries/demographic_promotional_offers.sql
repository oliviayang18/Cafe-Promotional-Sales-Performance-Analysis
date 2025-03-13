CREATE TABLE demographic_promotional_offers AS

WITH customers_demographics AS (
    SELECT
        customer_id,
        CASE
            WHEN age < 30 THEN '18-29'
            WHEN age < 40 THEN '30-39'
            WHEN age < 50 THEN '40-49'
            WHEN age < 60 THEN '50-59'
            WHEN age < 70 THEN '60-69'
            WHEN age < 80 THEN '70-79'
            WHEN age >= 80 AND age < 118 THEN '80+'
            ELSE 'Unknown'
        END AS age_group,
        CASE
            WHEN income < 40000 THEN 'Under $40K'
            WHEN income < 60000 THEN '$40K-$60K'
            WHEN income < 80000 THEN '$60K-$80K'
            WHEN income < 100000 THEN '$80K-$100K'
            WHEN income < 120000 THEN '$100K-$120K'
            WHEN income >= 120000 THEN '$120K+'
            ELSE 'Unknown'
        END AS income_group
    FROM customers
),

transactions AS (
    SELECT 
        customer_id,
        time,
        amount
    FROM events_normalized
    WHERE event = 'transaction'
),

offer_events AS (
    SELECT 
        e.customer_id,
        e.time,
        e.offer_id,
        e.event,
        e.reward AS rewards,
        o.offer_type,
        o.difficulty,
        o.reward,
        o.duration,
        o.channels,
        cd.age_group,
        cd.income_group
    FROM events_normalized e
    LEFT JOIN offers o ON e.offer_id = o.offer_id
    LEFT JOIN customers_demographics cd ON e.customer_id = cd.customer_id
    WHERE event IN ('offer received', 'offer viewed', 'offer completed')
)

SELECT
    oe.offer_type,
    oe.difficulty,
    oe.reward,
    oe.duration,
    oe.age_group,
    oe.income_group,
    COUNT(CASE WHEN oe.event = 'offer received' THEN 1 END) AS reception,
    COUNT(CASE WHEN oe.event = 'offer viewed' THEN 1 END) AS VIEW,
    COUNT(CASE WHEN oe.event = 'offer completed' THEN 1 END) AS completion,
    COUNT(CASE WHEN oe.event = 'offer viewed' THEN 1 END) * 1.0 / 
    NULLIF(COUNT(CASE WHEN oe.event = 'offer received' THEN 1 END), 0) AS view_rate,
    COUNT(CASE WHEN oe.event = 'offer completed' THEN 1 END) * 1.0 / 
    NULLIF(COUNT(CASE WHEN oe.event = 'offer received' THEN 1 END), 0) AS completion_rate,
    COUNT(CASE WHEN oe.event = 'offer completed' THEN 1 END) * 1.0 / 
    NULLIF(COUNT(CASE WHEN oe.event = 'offer viewed' THEN 1 END), 0) AS completion_to_view_rate,
    SUM(t.amount) AS total_amount,
    SUM(t.amount)/COUNT(CASE WHEN oe.event = 'offer completed' THEN 1 END) AS average_amount,
    SUM(oe.rewards) AS total_reward,
    oe.channels
FROM offer_events oe
LEFT JOIN transactions t 
    ON oe.customer_id = t.customer_id 
    AND oe.time = t.time
WHERE oe.offer_type IN ('bogo', 'discount')
GROUP BY oe.offer_type, oe.difficulty, oe.reward, oe.duration, oe.age_group, oe.income_group, oe.channels
ORDER BY oe.offer_type, oe.age_group, oe.income_group;