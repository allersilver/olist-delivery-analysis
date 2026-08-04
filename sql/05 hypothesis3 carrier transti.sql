with carrier as (
    select order_delivered_carrier_date
         , order_purchase_timestamp
         , julianday(order_delivered_carrier_date) - julianday(order_purchase_timestamp) as carrier_lag
         , mi_date
    from orders_clean
)
select *
from carrier
where order_delivered_carrier_date is not null;


with transit as (
    select order_delivered_customer_date
         , order_delivered_carrier_date
         , julianday(order_delivered_customer_date) - julianday(order_delivered_carrier_date) as transit_lag
         , mi_date
    from orders_clean
)
select *
from transit
where transit_lag > 0;
