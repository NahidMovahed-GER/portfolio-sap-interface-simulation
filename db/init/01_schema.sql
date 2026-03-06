CREATE TABLE IF NOT EXISTS staging_employee (
  id               SERIAL PRIMARY KEY,
  personnel_no     VARCHAR(20) NOT NULL,
  full_name        VARCHAR(200) NOT NULL,
  birth_date       DATE NOT NULL,
  org_unit         VARCHAR(50) NOT NULL,
  entry_date       DATE NOT NULL,
  pay_grade        VARCHAR(20) NOT NULL,
  source_system    VARCHAR(50) NOT NULL DEFAULT 'FACH_SYSTEM',
  imported_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS sap_employee (
  personnel_no     VARCHAR(20) PRIMARY KEY,
  full_name        VARCHAR(200) NOT NULL,
  birth_date       DATE NOT NULL,
  org_unit         VARCHAR(50) NOT NULL,
  entry_date       DATE NOT NULL,
  pay_grade        VARCHAR(20) NOT NULL,
  updated_at       TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS error_log (
  id               SERIAL PRIMARY KEY,
  personnel_no     VARCHAR(20),
  error_code       VARCHAR(50) NOT NULL,
  error_message    TEXT NOT NULL,
  raw_record       TEXT,
  created_at       TIMESTAMP NOT NULL DEFAULT NOW()
);