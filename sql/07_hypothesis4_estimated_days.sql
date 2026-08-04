select order_id
			, julianday(order_estimated_delivery_date) - julianday(order_purchase_timestamp) as estimated_days
from orders_clean

