select o.order_id, o.mi_date, r.review_score
from orders_clean o join reviews_clean r on o.order_id = r.order_id;
