-- 1) Log invalid records
INSERT INTO error_log (personnel_no, error_code, error_message, raw_record)
SELECT
    personnel_no,
    'VALIDATION_ERROR',
    'birth_date is missing',
    CONCAT_WS(',', personnel_no, full_name, COALESCE(birth_date::text,''), org_unit, entry_date::text, pay_grade)
FROM staging_employee
WHERE birth_date IS NULL;

-- 2) Transfer valid records
INSERT INTO sap_employee (
    personnel_no,
    full_name,
    birth_date,
    org_unit,
    entry_date,
    pay_grade,
    updated_at
)
SELECT
    personnel_no,
    full_name,
    birth_date,
    org_unit,
    entry_date,
    pay_grade,
    NOW()
FROM staging_employee
WHERE birth_date IS NOT NULL
ON CONFLICT (personnel_no)
DO UPDATE SET
    full_name  = EXCLUDED.full_name,
    birth_date = EXCLUDED.birth_date,
    org_unit   = EXCLUDED.org_unit,
    entry_date = EXCLUDED.entry_date,
    pay_grade  = EXCLUDED.pay_grade,
    updated_at = NOW();

SELECT
    (SELECT COUNT(*) FROM staging_employee) AS staging_total,
    (SELECT COUNT(*) FROM sap_employee)     AS sap_total,
    (SELECT COUNT(*) FROM error_log)        AS error_total;
