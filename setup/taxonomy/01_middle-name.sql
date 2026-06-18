SELECT
    PersonType,
    COUNT(*) AS total,
    SUM(CASE WHEN MiddleName IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN MiddleName IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Person.Person
GROUP BY PersonType
ORDER BY PersonType;

SELECT
    CASE WHEN MiddleName IS NULL THEN 'NULL' ELSE 'NOT NULL' END AS middle_name_status,
    CASE WHEN Suffix IS NULL THEN 'No suffix' ELSE 'Has suffix' END AS suffix_status,
    CASE WHEN Title IS NULL THEN 'No title' ELSE 'Has title' END AS title_status,
    COUNT(*) AS total
FROM Person.Person
GROUP BY
    CASE WHEN MiddleName IS NULL THEN 'NULL' ELSE 'NOT NULL' END,
    CASE WHEN Suffix IS NULL THEN 'No suffix' ELSE 'Has suffix' END,
    CASE WHEN Title IS NULL THEN 'No title' ELSE 'Has title' END
ORDER BY middle_name_status;