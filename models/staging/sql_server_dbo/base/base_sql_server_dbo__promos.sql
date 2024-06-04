with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['promo_id'])}} as promo_id,
        promo_id as promo_name,
        discount as discount,
        status as promo_status,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc
    from source 
    
)

select * from renamed
