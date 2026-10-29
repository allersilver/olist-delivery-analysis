select
    case weekday
        when '1' then '1_월'
        when '2' then '2_화'
        when '3' then '3_수'
        when '4' then '4_목'
        when '5' then '5_금'
        when '6' then '6_토'
        when '0' then '7_일'
    end as day_name,
    count(*) as num_days,
    round(avg(cnt), 1) as avg_orders
from (
    select date(order_purchase_timestamp) as order_date,
           strftime('%w', order_purchase_timestamp) as weekday,
           count(*) as cnt
    from orders
    where date(order_purchase_timestamp) between '2017-01-05' and '2018-08-21'
      and date(order_purchase_timestamp) <> '2017-11-24'
    group by order_date
)
group by weekday
order by day_name;


select
    date(order_purchase_timestamp, 'weekday 0', '-6 days') as week_start,
    count(distinct date(order_purchase_timestamp)) as num_days,
    count(*) as weekly_orders
from orders
where date(order_purchase_timestamp) between '2017-01-05' and '2018-08-21'
group by week_start
order by week_start;


select
    sum(case when date(order_purchase_timestamp) between '2017-03-01' and '2017-08-21'
             then 1 else 0 end) as orders_2017,
    sum(case when date(order_purchase_timestamp) between '2018-03-01' and '2018-08-21'
             then 1 else 0 end) as orders_2018,
    round(
        sum(case when date(order_purchase_timestamp) between '2018-03-01' and '2018-08-21'
                 then 1 else 0 end) * 1.0
        / sum(case when date(order_purchase_timestamp) between '2017-03-01' and '2017-08-21'
                   then 1 else 0 end)
    , 2) as growth
from orders;
