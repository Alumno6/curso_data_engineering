with 

source as (

    select * from {{ ref('stg_sql_server_dbo__users') }}

),

renamed as (

    select
        user_id,
        updated_at,
        address_id,
        last_name,
        created_at,
        phone_number,
        total_orders,
        first_name,
        email as correo,
        _fivetran_deleted,
        date_load

    from source

)

select * from renamed