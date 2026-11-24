CREATE OR ALTER VIEW dbo.CleanCountryTemp AS
SELECT DISTINCT
        c.dt,
        c.AverageTemperature,
        c.AverageTemperatureUncertainty,
        TRIM(c.Country) AS Country
FROM    dbo.CountryTemperature c
JOIN    dbo.CountryGroup g ON g.Country = TRIM(c.Country)
WHERE   c.AverageTemperature IS NOT NULL
  AND   c.AverageTemperature BETWEEN -60 AND 60
  AND  (c.dt BETWEEN '1951-01-01' AND '1980-12-01'
     OR c.dt BETWEEN '2000-01-01' AND '2012-12-01');
GO

CREATE OR ALTER VIEW dbo.CleanGlobalTemp AS
SELECT  dt, LandAverageTemperature, LandAverageTemperatureUncertainty
FROM    dbo.GlobalTemperature
WHERE   LandAverageTemperature IS NOT NULL
  AND  (dt BETWEEN '1951-01-01' AND '1980-12-01'
     OR dt BETWEEN '2000-01-01' AND '2012-12-01');
GO