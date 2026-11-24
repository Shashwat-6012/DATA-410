WITH CountryPeriodAvg AS (
    SELECT  c.Country,
            g.GroupLabel,
            p.PeriodName,
            AVG(c.AverageTemperature) AS AvgTemp,
            COUNT(*)                  AS MonthsUsed
    FROM    dbo.CleanCountryTemp c
    JOIN    dbo.CountryGroup     g ON g.Country = c.Country
    JOIN    dbo.Period           p ON c.dt BETWEEN p.StartDate AND p.EndDate
    GROUP BY c.Country, g.GroupLabel, p.PeriodName
),
GlobalPeriodAvg AS (
    SELECT  p.PeriodName,
            AVG(t.LandAverageTemperature) AS AvgTemp,
            COUNT(*)                      AS MonthsUsed
    FROM    dbo.CleanGlobalTemp t
    JOIN    dbo.Period          p ON t.dt BETWEEN p.StartDate AND p.EndDate
    GROUP BY p.PeriodName
),
AllRows AS (
    SELECT Country, GroupLabel, PeriodName, AvgTemp, MonthsUsed
    FROM   CountryPeriodAvg
    UNION ALL
    SELECT 'World (land average)', 'Global benchmark', PeriodName, AvgTemp, MonthsUsed
    FROM   GlobalPeriodAvg
)
SELECT  Country,
        GroupLabel,
        ROUND(MAX(CASE WHEN PeriodName = 'Baseline' THEN AvgTemp END), 2) AS Avg_1951_1980_C,
        ROUND(MAX(CASE WHEN PeriodName = 'Recent'   THEN AvgTemp END), 2) AS Avg_2000_2012_C,
        ROUND(MAX(CASE WHEN PeriodName = 'Recent'   THEN AvgTemp END)
            - MAX(CASE WHEN PeriodName = 'Baseline' THEN AvgTemp END), 2) AS TempChange_C,
        SUM(MonthsUsed) AS MonthsUsed
FROM    AllRows
GROUP BY Country, GroupLabel
ORDER BY TempChange_C DESC;
GO