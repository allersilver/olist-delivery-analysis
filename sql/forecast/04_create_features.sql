with daily as (
    select
        date(order_purchase_timestamp) as order_date,
        count(*) as cnt
    from orders
    where date(order_purchase_timestamp) between '2017-01-05' and '2018-08-21'
    group by order_date
)
select
    order_date,
    cnt,
    cast(strftime('%w', order_date) as integer) as weekday,
    row_number() over (order by order_date) as trend,
    case when order_date = '2017-11-24' then 1 else 0 end as event_peak,
    case when order_date between '2017-11-25' and '2017-11-29' then 1 else 0 end as event_after,
    case when order_date between '2018-05-21' and '2018-05-31' then 1 else 0 end as event_strike
from daily
order by order_date;
