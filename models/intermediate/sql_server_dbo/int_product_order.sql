with 

stage_orders as (

    select * from {{ ref('stg_sql_server_dbo__orders') }}
),

stage_order_items as (

    select * from {{ ref('stg_sql_server_dbo__order_items') }}
),

stage_promos as (

    select * from {{ ref('stg_sql_server_dbo__promos') }}
),

stage_products as (

    select * from {{ ref('stg_sql_server_dbo__products') }}
),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['O.order_id','OI.product_id'])}} AS transaction_id,
        O.ORDER_ID as order_id,
        P.product_id as product_id,
        o.user_id as user_id,
        O.created_at_utc,
        O.delivered_at as delivered_at_utc,
        O.order_status_id as order_status_id,
        round(O.shipping_cost_dollars * ((P.PRICE * OI.QUANTITY) / O.ORDER_COST),2)::decimal(30,2) AS transaction_shipping_cost,
        (P.PRICE * OI.QUANTITY)::decimal(30,2) AS transaction_cost,
        round(PR.DISCOUNT * ((P.PRICE * OI.QUANTITY) / O.ORDER_COST),2)::decimal(30,2) AS transaction_discount,
        round(ORDER_TOTAL * ((P.PRICE * OI.QUANTITY) / O.ORDER_COST),2)::decimal(30,2) AS transaction_TOTAL_COST,
        round((P.PRICE * OI.QUANTITY) / O.ORDER_COST * 100,2)::decimal(30,2) AS percent_over_order

    from stage_orders O
    join stage_order_items OI 
    on O.order_id = OI.order_id
    join stage_promos PR
    on O.promo_id = PR.promo_id
    join stage_products P
    on OI.product_id = P.product_id
)

select * from renamed