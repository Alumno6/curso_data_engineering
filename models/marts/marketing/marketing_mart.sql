with 

fct_pro_ord as (

    select * from {{ ref('fct_product_orders') }}
),

fct_order as (

    select * from {{ ref('fct_order') }}
),

dim_user as (

    select * from {{ ref('dim_users') }}
),

dim_addresses as (

    select * from {{ ref('dim_addresses') }}
),

rename as (

    select
        U.user_id as user_id,
        U.first_name,
        U.last_name,
        U.email,
        U.phone_number,
        U.created_at_utc,
        U.updated_at_utc,
        A.address,
        A.country,
        U.total_orders,
        sum(transaction_shipping_cost) as total_shipping_cost_usd,
        sum(transaction_TOTAL_COST) as total_order_cost_usd,
        sum(transaction_discount) as total_discount_usd,
        sum(QUANTITY) as tatal_quantity_product,
        count(distinct product_id) as different_products

    from dim_user U 
    join fct_order O 
    on U.user_id = O.user_id
    join fct_pro_ord P 
    on P.user_id = U.user_id
    join dim_addresses A 
    on U.address_id = A.address_id
    group by 1,2,3,4,5,6,7,8,9,10
    order by first_name
)

select * from rename