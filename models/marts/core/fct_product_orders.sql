with 

int_orders as (

    select * from {{ ref('int_product_order') }}
),

renamed as (

    select
        transaction_id,
        order_id,
        product_id,
        user_id,
        created_at_utc,
        delivered_at_utc,
        order_status_id,
        transaction_shipping_cost,
        transaction_cost,
        transaction_discount,
        transaction_TOTAL_COST,
        percent_over_order

    from int_orders 
    
    
)

select * from renamed