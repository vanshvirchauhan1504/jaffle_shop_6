{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    o.updated_at,
    sum(oi.quantity * p.price) as order_amount
from {{ ref('stg_orders') }} o
join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
{% if is_incremental() %}
    where o.updated_at > (select max(updated_at) from {{ this }})
{% endif %}
group by
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    o.updated_at