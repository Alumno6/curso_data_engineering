with 

source as (

    select * from {{ ref('base_sql_server_dbo__promos') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['promo_status'])}} as promo_status_id,
        promo_status as promo_status

    from source
    group by promo_status

    union

    select
        {{dbt_utils.generate_surrogate_key(["''"])}} as promo_status_id,
        null

)

select * from renamed