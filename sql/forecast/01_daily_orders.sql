select order_status, count(*) as cnt
from orders
group by order_status;


select date(order_purchase_timestamp) as order_date,
       count(*) as cnt
from orders
group by order_date;


select sum(cnt) as total_orders
from (
    select date(order_purchase_timestamp) as order_date,
           count(*) as cnt
    from orders
    group by order_date
);


select
    count(*) as total,
    sum(case when date(order_purchase_timestamp) between '2017-01-01' and '2018-08-21'
             then 1 else 0 end) as in_period,
    round(100.0 * sum(case when date(order_purchase_timestamp) between '2017-01-01' and '2018-08-21'
                           then 0 else 1 end) / count(*), 2) as excluded_pct
from orders;


select
    julianday('2018-08-21') - julianday('2017-01-01') + 1 as total_days,
    count(distinct date(order_purchase_timestamp)) as actual_days
from orders
where date(order_purchase_timestamp) between '2017-01-01' and '2018-08-21';


select
    count(*) as total_orders,
    count(distinct date(order_purchase_timestamp)) as total_days,
    round(count(*) * 1.0 / count(distinct date(order_purchase_timestamp)), 1) as avg_daily_orders
from orders
where date(order_purchase_timestamp) between '2017-01-05' and '2018-08-21';
