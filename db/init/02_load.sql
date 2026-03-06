TRUNCATE staging_employee;

COPY staging_employee(personnel_no, full_name, birth_date, org_unit, entry_date, pay_grade)
FROM '/data/inbound/employees.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

SELECT COUNT(*) AS staging_count FROM staging_employee;
