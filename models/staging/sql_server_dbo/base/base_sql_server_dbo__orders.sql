with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        shipping_service as shipping_service,
        shipping_cost AS shipping_cost_dollars,
        address_id,
        {{convert_timezone('created_at')}} as created_at_utc,
        promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        {{convert_timezone('_fivetran_synced')}} as date_load_utc

    from source
)

select * from renamed
