{{
  config(
    materialized='view'
  )
}}

with 

source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        _fivetran_synced AS date_load_utc

    from source

    union
    
    select
        md5('') as address_id,
        null,
        null,
        null,
        null,
        null,
        null       
)

select * from renamed
