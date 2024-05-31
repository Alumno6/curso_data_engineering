with 

source as (

    select status from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        md5(status) as promo_status_id,
        status as order_status

    from source
    group by status

    union

    select
        md5('') as promo_status_id,
        null

)

select * from renamed