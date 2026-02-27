-- TYPE YOUR SQL QUERY BELOW

-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change
-- Feature released: 2018-06-02

-- 1a. Daily active users (DAU) per day, labelled before / after the feature release.
--     This produces the data points needed to graph the trend over time.
SELECT
    date(login_timestamp, 'unixepoch')  AS day,
    COUNT(DISTINCT user_id)             AS dau,
    CASE
        WHEN date(login_timestamp, 'unixepoch') < '2018-06-02' THEN 'before'
        ELSE 'after'
    END                                 AS period
FROM   login_history
GROUP  BY day
ORDER  BY day ASC;

-- 1b. Average DAU summarised by period (before vs after).
--     Use this single number to annotate the graph or compare the two periods.
SELECT
    period,
    ROUND(AVG(dau), 2) AS avg_daily_users
FROM (
    SELECT
        date(login_timestamp, 'unixepoch')  AS day,
        COUNT(DISTINCT user_id)             AS dau,
        CASE
            WHEN date(login_timestamp, 'unixepoch') < '2018-06-02' THEN 'before'
            ELSE 'after'
        END                                 AS period
    FROM   login_history
    GROUP  BY day
)
GROUP  BY period
ORDER  BY period DESC;   -- 'before' first, then 'after'




-- PART 2: Create a SQL query that indicates the number of status changes by card

SELECT
    c.id,
    c.name,
    c.status                AS current_status,
    COUNT(h.cardID)         AS number_of_status_changes
FROM   card c
LEFT   JOIN card_change_history h ON h.cardID = c.id
GROUP  BY c.id, c.name, c.status
ORDER  BY number_of_status_changes DESC;
