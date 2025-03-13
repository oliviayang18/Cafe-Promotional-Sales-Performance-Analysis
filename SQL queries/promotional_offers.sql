CREATE TABLE promotional_offers AS

WITH transactions AS (
    SELECT 
        customer_id,
        time,
        amount
    FROM events_normalized
    WHERE event = 'transaction'
),

offer_events AS (
    SELECT 
        customer_id,
        time,
        e.offer_id,
        event,
        e.reward AS rewards,
        o.offer_type,
        o.difficulty,
        o.reward,
        o.duration,
        o.channels
    FROM events_normalized e
    LEFT JOIN offers o ON e.offer_id = o.offer_id
    WHERE event IN ('offer received', 'offer viewed', 'offer completed')
)

SELECT
    oe.offer_type,
    oe.difficulty,
    oe.reward,
    oe.duration,
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
GROUP BY oe.offer_type, oe.offer_id
ORDER BY oe.offer_type, reception DESC;