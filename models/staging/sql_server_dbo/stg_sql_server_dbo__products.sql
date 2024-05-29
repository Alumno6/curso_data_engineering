with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id,
        price,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc

    from source

    union 

    select
        md5('') as  product_id,
        null,
        null,
        null,
        null,
        null
)


select * from renamed
