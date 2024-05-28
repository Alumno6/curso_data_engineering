with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        md5(promo_id) as promo_id,
        promo_id as promo_name,
        discount as discount_percent,
        md5(status) as promo_status_id,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc
    from source
    union all
    select
        md5('sin_promo'),
        'sin_promo',
        0,
        md5('inactive'),
        null,
        null
)

select * from renamed
