with 

stage_orders as (

    select * from {{ ref('stg_sql_server_dbo__orders') }}
),

stage_order_items as (

    select * from {{ ref('stg_sql_server_dbo__order_items') }}
),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['O.order_id','OI.product_id'])}} AS transaction_id,
        O.order_id as order_id,
        OI.product_id as product_id,
        OI.quantity as quantity,
        O.shipping_service_id as shipping_service_id,
        O.shipping_cost_dollars AS order_shipping_cost,
        address_id,
        created_at_utc as created_at_utc,
        O.promo_id as promo_id,
        O.estimated_delivery_at,
        O.order_cost,
        O.user_id,
        O.order_total,
        O.delivered_at,
        O.tracking_id,
        order_status_id,
        iff(RANK() OVER(PARTITION BY O.order_id ORDER BY OI.product_id) = 1, true, false) as agregar, 
        O._fivetran_deleted,
        O.date_load_utc

    from stage_orders O
    join stage_order_items OI 
    on O.order_id = OI.order_id
)

select * from renamed