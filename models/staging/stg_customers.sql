select
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'email']) }} as customer_key,
    customer_id,
    upper(first_name) as first_name,
    upper(last_name) as last_name,
    {{ clean_email('email') }} as email,
    country,
    created_at
from {{ source('raw', 'customers') }}