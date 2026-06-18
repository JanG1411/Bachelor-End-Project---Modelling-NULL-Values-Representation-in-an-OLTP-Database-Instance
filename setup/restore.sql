RESTORE DATABASE AdventureWorks
FROM DISK = '/var/opt/mssql/data/AdventureWorks2019.bak'
WITH
    MOVE 'AdventureWorks2019' TO '/var/opt/mssql/data/AdventureWorks.mdf',
    MOVE 'AdventureWorks2019_log' TO '/var/opt/mssql/data/AdventureWorks.ldf',
    REPLACE;

SELECT name, state_desc
FROM sys.databases;