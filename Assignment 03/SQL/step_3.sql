SELECT COUNT(*) AS CleanCountryRows FROM dbo.CleanCountryTemp;   -- expect 5,676
SELECT COUNT(*) AS CleanGlobalRows  FROM dbo.CleanGlobalTemp;    -- expect 516

-- Months per country per period: expect 360 baseline and 156 recent for all 11
SELECT c.Country, p.PeriodName, COUNT(*) AS Months
FROM dbo.CleanCountryTemp c
JOIN dbo.Period p ON c.dt BETWEEN p.StartDate AND p.EndDate
GROUP BY c.Country, p.PeriodName
ORDER BY c.Country, p.PeriodName;

-- Duplicates: expect no rows
SELECT TRIM(Country) AS Country, dt, COUNT(*) AS N
FROM dbo.CountryTemperature
WHERE TRIM(Country) IN (SELECT Country FROM dbo.CountryGroup)
GROUP BY TRIM(Country), dt
HAVING COUNT(*) > 1;

-- Largest uncertainty in the kept data
SELECT TOP 1 Country, dt, AverageTemperatureUncertainty
FROM dbo.CleanCountryTemp
ORDER BY AverageTemperatureUncertainty DESC;
GO