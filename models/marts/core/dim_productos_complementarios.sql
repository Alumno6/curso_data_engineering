with 

int_product_order as (
    select * from {{ ref('int_product_order') }}
),
dim_products as (
    select * from {{ ref('dim_products') }}
),

renamed as (

    select
        O1.product_id as product_1_id,
        O2.product_id as product_2_id,
        P1.name as product_1_name,
        P2.name as product_2_name,
        count(O1.transaction_id) as numero_de_ocurrencias,
        round(sum(O1.transaction_cost)/count(O1.order_id),2)::decimal(30,2) as mean_dollar_amount

    from int_product_order O1
    join int_product_order O2
    on O1.order_id = O2.order_id
    join dim_products P1
    on O1.product_id = P1.product_id
    join dim_products P2
    on O2.product_id = P2.product_id
    where O1.product_id != O2.product_id
    group by O1.product_id, O2.product_id, P1.name, P2.name
    order by mean_dollar_amount * numero_de_ocurrencias desc

)

select * from renamed