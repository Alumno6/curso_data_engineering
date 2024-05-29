with 

source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id,
        updated_at as updated_at_utc,
        address_id,
        last_name,
        created_at as created_at_utc,
        phone_number,
        total_orders,
        first_name,
        email,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc

    from source

    union

    select
        md5('') as user_id,
        null,
        null,
        null,
        null,
        null,
        null,        
        null,
        null,
        null,
        null
)

select * from renamed
