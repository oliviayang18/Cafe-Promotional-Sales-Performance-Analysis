CREATE TABLE transaction_record AS

WITH offer_received AS(
    SELECT customer_id, offer_id, time AS reception_time
    FROM events_normalized
    WHERE event = 'offer received'
),

offer_viewed AS(
    SELECT customer_id, offer_id, time AS view_time
    FROM events_normalized
    WHERE event = 'offer viewed'
),

offer_completed AS(
    SELECT customer_id, offer_id, time AS completion_time
    FROM events_normalized
    WHERE event = 'offer completed'
),

active_offer AS(
    SELECT 
        r.customer_id, r.offer_id, o.offer_type, r.reception_time, v.view_time, c.completion_time,
        r.reception_time + (o.duration * 24) AS end_time,
        CASE WHEN v.view_time IS NOT NULL 
                AND v.view_time >= r.reception_time 
                AND v.view_time <= r.reception_time + (o.duration * 24)
                THEN 1 
             ELSE 0 
        END AS was_viewed,
        CASE WHEN c.completion_time IS NOT NULL 
                AND c.completion_time >= r.reception_time 
                AND c.completion_time <= r.reception_time + (o.duration * 24)
                THEN 1 
             ELSE 0 
        END AS was_completed,
        CASE WHEN c.completion_time IS NOT NULL 
                AND c.completion_time < r.reception_time 
                THEN 1 
             ELSE 0 
        END AS error
    FROM offer_received AS r
    JOIN offers AS o ON r.offer_id = o.offer_id
    LEFT JOIN offer_viewed AS v ON r.offer_id = v.offer_id AND r.customer_id = v.customer_id
    LEFT JOIN offer_completed AS c ON r.offer_id = c.offer_id AND r.customer_id = c.customer_id
)





SELECT
    e.customer_id, e.amount, MAX(en.reward) AS reward,
    SUM(CASE WHEN a.offer_type = 'BOGO' THEN 1 ELSE 0 END) AS active_bogo,
    SUM(CASE WHEN a.offer_type = 'discount' THEN 1 ELSE 0 END) AS active_discount,
    SUM(CASE WHEN a.offer_type = 'informational' THEN 1 ELSE 0 END) AS active_informational,
    MAX(CASE WHEN a.offer_type IN ('BOGO', 'discount') AND a.was_viewed = 1 THEN 1 ELSE 0 END) AS promotional_viewed,
    MAX(CASE WHEN a.offer_type = 'informational' AND a.was_viewed = 1 THEN 1 ELSE 0 END) AS informational_viewed,
    CASE 
        WHEN SUM(CASE WHEN a.offer_type = 'informational' THEN 1 ELSE 0 END) > 0
        AND (SUM(CASE WHEN a.offer_type = 'BOGO' THEN 1 ELSE 0 END) > 0
            OR SUM(CASE WHEN a.offer_type = 'discount' THEN 1 ELSE 0 END) > 0) THEN 'Info+Promo'
        WHEN SUM(CASE WHEN a.offer_type = 'informational' THEN 1 ELSE 0 END) > 0 THEN 'Informational'
        WHEN SUM(CASE WHEN a.offer_type = 'BOGO' THEN 1 ELSE 0 END) > 0 THEN 'BOGO'
        WHEN SUM(CASE WHEN a.offer_type = 'discount' THEN 1 ELSE 0 END) > 0 THEN 'Discount'
        ELSE 'None'
    END AS offer_type,
    MIN(a.reception_time) AS reception_time,
    MIN(CASE WHEN a.was_viewed = 1 THEN a.view_time ELSE NULL END) AS view_time,
    e.time AS transaction_time
FROM events_normalized AS e
LEFT JOIN active_offer AS a 
    ON e.customer_id = a.customer_id AND e.time >= a.reception_time AND e.time <= a.end_time AND a.error = 0
LEFT JOIN events_normalized AS en
    ON en.customer_id = e.customer_id 
    AND en.event = 'offer completed'
    AND en.time = e.time
WHERE e.event = 'transaction'
GROUP BY e.customer_id, e.time, e.amount;