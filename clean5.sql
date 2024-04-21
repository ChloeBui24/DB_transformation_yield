INSERT INTO yield (Date, VALUES)
SELECT
    (json_object->>'date')::DATE,
    CASE
        WHEN trim(json_object->>'value') ~ '^[0-9]+(\.[0-9]+)?$'
        THEN (json_object->>'value')::NUMERIC(6,2)
        ELSE NULL
    END
FROM
    RawData_yield,
    jsonb_array_elements(raw_json -> 'data') AS json_object
ON CONFLICT (DATE) DO NOTHING;
