-- Rename only if the table is still called GlobalTemperatures
EXEC sp_rename 'dbo.GlobalTemperatures', 'GlobalTemperature';
GO

SELECT COUNT(*) AS CountryRows FROM dbo.CountryTemperature;   -- about 577,462
SELECT COUNT(*) AS GlobalRows  FROM dbo.GlobalTemperature;    -- about 3,192

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('CountryTemperature','GlobalTemperature')
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- Should return 11 rows
SELECT DISTINCT Country FROM dbo.CountryTemperature
WHERE TRIM(Country) IN ('United States','Canada','United Kingdom','Germany','Japan',
                        'China','India','Philippines','Bangladesh','Nigeria','Brazil');
GO