with 

source as (

    select * from {{ source('google_sheets', 'budget') }}

),

renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        _fivetran_synced AS date_load_utc

    from source

)

select * from renamed
