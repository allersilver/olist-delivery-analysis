with first_purchase as (select customer_unique_id
															, mi_date
															 , row_number() over(partition by customer_unique_id order by order_purchase_timestamp asc) as rn
															 , count(*) over(partition by customer_unique_id) as cnt
												from orders_clean o left join customers c on o.customer_id = c.customer_id
												), first_purchase_flag as (select customer_unique_id
																										 , case when mi_date > 0 then 1 else 0 end as is_delayed
																										 , case when cnt >= 2 then 1 else  0 end as is_repurchase
																								from first_purchase 	
																								where rn = 1)
	
select is_delayed
		   , sum(case when is_repurchase = 1 then 1 else 0 end) as purchase_cnt
		   , count(*) as total
from  first_purchase_flag
group by is_delayed


	
select sum(case when mi_date > 0 then 1 else 0 end) as is_delayed
from first_purchase 
where rn = 1

--- 첫 주문이 지연이였던 결과 