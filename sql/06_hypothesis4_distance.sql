create table geo_clean as
select geolocation_zip_code_prefix as zip_prefix
     , avg(geolocation_lat) as lat
     , avg(geolocation_lng) as lng
from geolocation
group by geolocation_zip_code_prefix;
 

select o.order_id
     , oi.seller_id
     , o.mi_date
     , gc.lat as customer_lat
     , gc.lng as customer_lng
     , gs.lat as seller_lat
     , gs.lng as seller_lng
from orders_clean o join customers c on o.customer_id = c.customer_id
										join geo_clean gc on c.customer_zip_code_prefix = gc.zip_prefix
										join order_items oi on o.order_id = oi.order_id
										join sellers s on oi.seller_id = s.seller_id
										join geo_clean gs on s.seller_zip_code_prefix = gs.zip_prefix;