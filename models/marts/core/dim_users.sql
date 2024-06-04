with 

stage as (

    select * from {{ ref('stg_sql_server_dbo__users') }}

),

renamed as (

    select
        user_id,
        updated_at_utc,
        address_id,
        last_name,
        created_at_utc,
        phone_number,
        total_orders,
        first_name,
        email

    from stage

)
select * from renamed