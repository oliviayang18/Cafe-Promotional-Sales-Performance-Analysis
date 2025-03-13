CREATE TABLE transactions AS

WITH transactions AS (
    SELECT 
        customer_id,
        time,
        amount
    FROM events_normalized
    WHERE event = 'transaction'
),

completed_offers AS (
    SELECT 
        e.customer_id,
        e.time,
        o.offer_type
    FROM events_normalized e
    JOIN offers o ON e.offer_id = o.offer_id
    WHERE e.event = 'offer completed'
),

active_offers AS (
    SELECT 
        t.customer_id,
        t.time AS transaction_time,
        t.amount,
        o.offer_type
    FROM transactions t
    JOIN events_normalized en ON t.customer_id = en.customer_id
    JOIN offers o ON en.offer_id = o.offer_id
    LEFT JOIN events_normalized viewed 
    ON en.customer_id = viewed.customer_id 
      AND en.offer_id = viewed.offer_id 
      AND viewed.event = 'offer viewed'
    WHERE en.event = 'offer received'
      AND t.time BETWEEN en.time AND (en.time + o.duration * 24)
      AND (o.offer_type != 'informational' OR (viewed.time <= t.time))
),

transaction_offer_types AS (
    SELECT 
        t.customer_id,
        t.time,
        t.amount,
        MAX(CASE WHEN c.time = t.time AND c.offer_type = 'bogo' THEN 1 ELSE 0 END) AS bogo_completed,
        MAX(CASE WHEN c.time = t.time AND c.offer_type = 'discount' THEN 1 ELSE 0 END) AS discount_completed,
        MAX(CASE WHEN a.offer_type = 'informational' THEN 1 ELSE 0 END) AS info_active,
        MAX(CASE WHEN a.offer_type = 'bogo' THEN 1 ELSE 0 END) AS bogo_active,
        MAX(CASE WHEN a.offer_type = 'discount' THEN 1 ELSE 0 END) AS discount_active
    FROM transactions t
    LEFT JOIN completed_offers c ON t.customer_id = c.customer_id AND t.time = c.time
    LEFT JOIN active_offers a ON t.customer_id = a.customer_id AND t.time = a.transaction_time
    GROUP BY t.customer_id, t.time, t.amount
)

SELECT 
    time,
    customer_id,
    amount,
    CASE 
        WHEN info_active = 1 AND bogo_completed = 1 AND discount_completed = 1 THEN 'info+promo'
        WHEN info_active = 1 AND bogo_completed = 1 THEN 'info+bogo'
        WHEN info_active = 1 AND discount_completed = 1 THEN 'info+discount'
        WHEN bogo_completed = 1 AND discount_completed = 1 THEN 'multi-promo'
        WHEN bogo_completed = 1 THEN 'bogo'
        WHEN discount_completed = 1 THEN 'discount'
        WHEN info_active = 1 THEN 'informational'
    ELSE 'none'
END AS offer_type

FROM transaction_offer_types
ORDER BY time, customer_id;