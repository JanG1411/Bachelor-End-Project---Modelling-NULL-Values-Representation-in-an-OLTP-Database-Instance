SELECT CONCAT(
    'SELECT ''', TABLE_NAME, ''' AS table_name, ''', COLUMN_NAME, ''' AS column_name, ',
    'COUNT(*) AS total_rows, ',
    'SUM(CASE WHEN [', COLUMN_NAME, '] IS NULL THEN 1 ELSE 0 END) AS null_count, ',
    'ROUND(100.0 * SUM(CASE WHEN [', COLUMN_NAME, '] IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS null_pct ',
    'FROM [', TABLE_SCHEMA, '].[', TABLE_NAME, '] ',
    'UNION ALL'
) AS sql_text
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_CATALOG = DB_NAME()
  AND TABLE_NAME IN (
      'Person','Customer','Product','SalesOrderHeader','SalesOrderDetail',
      'Address','BusinessEntity','BusinessEntityAddress','Employee',
      'EmailAddress','PhoneNumberType','PersonPhone',
      'StateProvince','CountryRegion'
  )
  AND IS_NULLABLE = 'YES';