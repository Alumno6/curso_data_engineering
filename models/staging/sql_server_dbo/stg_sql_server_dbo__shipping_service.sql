with 

source as (

    select shipping_service from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        md5(shipping_service) as shipping_service_id,
        case
            when shipping_service != '' then shipping_service
            else 'no shiping service'
        end as shipping_service
    from source
    group by shipping_service

    union 

    select
        md5('') as shipping_service_id,
        null

)

select * from renamed