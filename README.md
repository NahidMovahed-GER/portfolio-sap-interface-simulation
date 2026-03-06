# portfolio-sap-interface-simulation

This project simulates a simple SAP interface.

Employee data from a source system is imported from a CSV file,
validated, and then transferred to a SAP target structure.

The goal of this project is to demonstrate how typical enterprise
interfaces work in real IT systems.

---

# Scenario

A source system exports employee master data as a CSV file.

The interface processes the data in several steps:

1. Import the CSV data into a **staging table**
2. Validate the data
3. Log invalid records
4. Transfer valid records to the **SAP employee table**

Invalid records are not transferred to SAP.
They are stored in an **error log table**.

---

# Architecture

The project uses a simple interface architecture:

Source System (CSV)
        │
        ▼
Staging Table (PostgreSQL)
        │
        ▼
Validation Logic (SQL)
        │
        ├── Valid records → SAP Employee Table
        │
        └── Invalid records → Error Log

---

# Technologies

This project uses the following technologies:

- Docker
- PostgreSQL
- Adminer
- SQL
- CSV file interface

---

# Database Tables

### staging_employee

Stores raw incoming data from the source system.

The staging table allows incomplete or invalid data.
This is common in real interface systems.

---

### sap_employee

Represents the SAP employee master data table.

Only valid data is transferred to this table.

---

### error_log

Stores invalid records and validation errors.

This helps with troubleshooting and data correction.

---

# Data Flow

CSV file  
→ staging_employee  
→ validation logic  
→ sap_employee (valid records)  
→ error_log (invalid records)

---

# Example Validation

Example record in CSV:
```
10006,Invalid User,,HR-003,2026-03-01,E12
```

The field **birth_date is missing**.

Result:

- The record is written to `error_log`
- The record is **not transferred** to `sap_employee`

---

# How to Run

Start the database environment:
```
docker compose up -d
```

Open Adminer in the browser:

```
http://localhost:8080
```
Login:
```
System: PostgreSQL
Server: postgres
User: demo
Password: demo
Database: sap_sim
```
---

# Project Goal

This portfolio project demonstrates:

- SAP interface concepts
- staging table architecture
- validation logic
- error handling
- data integration workflow

The design reflects common patterns used in real enterprise
integration systems and public sector IT environments.
