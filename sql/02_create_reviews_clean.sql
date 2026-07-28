create view reviews_clean as
select *
from (
    select *, row_number() over(partition by order_id order by review_answer_timestamp desc) as rn
    from order_reviews
)
where rn = 1