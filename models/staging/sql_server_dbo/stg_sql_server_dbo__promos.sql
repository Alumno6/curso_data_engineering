with 

source as (

    select * from {{ ref('base_sql_server_dbo__promos') }}

),

renamed as (

    select
        promo_id,
        promo_name,
        discount,
        {{dbt_utils.generate_surrogate_key(['promo_status'])}} as promo_status_id,
        _fivetran_deleted,
        date_load_utc
    from source
    union all
    select
        {{dbt_utils.generate_surrogate_key(["'sin_promo'"])}},
        null,
        null,
        null,
        null,
        null
)

select * from renamed
