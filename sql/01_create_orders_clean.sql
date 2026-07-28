create view orders_clean as  select *
								, julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date) as mi_date
							from orders
							where order_status = 'delivered' 
								and order_delivered_customer_date is not null
								and date(order_delivered_customer_date) != '2017-09-19'
