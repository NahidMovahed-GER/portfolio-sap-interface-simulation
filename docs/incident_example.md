Incident: Employee record not transferred to SAP

Description:
Employee 10006 was not transferred.

Analysis:
birth_date was missing in the CSV file.

Root Cause:
Invalid source system data.

Solution:
Record logged in error_log table.

Prevention:
Add validation in source system.
