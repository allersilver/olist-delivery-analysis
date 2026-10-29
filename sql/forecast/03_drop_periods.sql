with weekly as (
    select
        date(order_purchase_timestamp, 'weekday 0', '-6 days') as week_start,
        count(distinct date(order_purchase_timestamp)) as num_days,
        count(*) as weekly_orders
    from orders
    where date(order_purchase_timestamp) between '2017-01-05' and '2018-08-21'
    group by week_start
),
with_prev as (
    select
        week_start,
        num_days,
        weekly_orders,
        avg(weekly_orders) over (
            order by week_start
            rows between 4 preceding and 1 preceding
        ) as prev4_avg
    from weekly
)
select
    week_start,
    num_days,
    weekly_orders,
    round(prev4_avg, 1) as prev4_avg,
    round(100.0 * (weekly_orders - prev4_avg) / prev4_avg, 1) as change_pct
from with_prev
where week_start between '2017-12-01' and '2018-01-31'
   or week_start between '2018-05-01' and '2018-07-31'
order by week_start;


with weekly as (
    select
        date(order_purchase_timestamp, 'weekday 0', '-6 days') as week_start,
        count(*) as weekly_orders
    from orders
    where date(order_purchase_timestamp) between '2017-01-05' and '2018-08-21'
    group by week_start
)
select round(avg(weekly_orders), 1) as before_bf_avg
from weekly
where week_start between '2017-10-23' and '2017-11-13';


select
    date(order_purchase_timestamp) as order_date,
    case strftime('%w', order_purchase_timestamp)
        when '1' then '월'
        when '2' then '화'
        when '3' then '수'
        when '4' then '목'
        when '5' then '금'
        when '6' then '토'
        when '0' then '일'
    end as day_name,
    count(*) as cnt
from orders
where date(order_purchase_timestamp) between '2017-12-18' and '2018-01-07'
   or date(order_purchase_timestamp) between '2018-05-14' and '2018-06-03'
   or date(order_purchase_timestamp) between '2018-06-25' and '2018-07-15'
group by order_date
order by order_date;
