with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id, 
        md5(shipping_service) as shipping_service_id,
        shipping_cost AS shipping_cost_dollars,
        address_id,
        created_at as created_at_utc,
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
        _fivetran_synced AS date_load_utc

    from source

)

select * from renamed
