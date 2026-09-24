select
    order_item_id,
    order_id,
    product_id,
    quantity
from {{ source('raw', 'order_items') }}