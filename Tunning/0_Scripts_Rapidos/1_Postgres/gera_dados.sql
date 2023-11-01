insert into fidc_adm.user
SELECT
floor(random()) + b as idt_user,
(
SELECT string_agg(x, '')
FROM (
SELECT chr(ascii('A') + (random() * 25)::integer)
FROM generate_series(1, 40 + b * 0)
) AS y(x)
) as nam_name
, case when mod((5483 * random()::integer), b) = 0 then 1 else 2 end as ind_type
,(SELECT string_agg(x, '')
FROM (
SELECT chr(ascii('A') + (random() * 25)::integer)
FROM generate_series(1, 18 + b * 0)
) AS y(x)
) as nam_document
,(SELECT string_agg(x, '')
FROM (
SELECT chr(ascii('A') + (random() * 25)::integer)
FROM generate_series(1, 150 + b * 0)
) AS y(x)
) as nam_address_street
,(SELECT string_agg(x, '')
FROM (
SELECT chr(ascii('A') + (random() * 25)::integer)
FROM generate_series(1, 8 + b * 0)
) AS y(x)
) as nam_postal_code
,CURRENT_TIMESTAMP as dat_creation
,CURRENT_TIMESTAMP as dat_update
FROM generate_series(1,5483) as a(b);