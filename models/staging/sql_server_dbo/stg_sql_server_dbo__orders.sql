with 

source as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        order_id,
        md5(shipping_service) as shipping_service_id,
        shipping_cost_dollars,
        address_id,
        created_at_utc,
        case
            when promo_id != '' then md5(promo_id)
            else md5('sin_promo')
        end as promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        md5(status) as order_status_id,
        _fivetran_deleted,
        date_load_utc

    from source

    union 

    select
        md5('sin order') as order_id,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
)

select * from renamed
