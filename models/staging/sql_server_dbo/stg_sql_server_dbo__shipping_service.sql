with 

source as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

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

)

select * from renamed