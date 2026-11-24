WITH AnnualAvg AS (
    SELECT  c.Country,
            p.PeriodName,
            YEAR(c.dt)               AS Yr,
            AVG(c.AverageTemperature) AS AnnTemp
    FROM    dbo.CleanCountryTemp c
    JOIN    dbo.Period p ON c.dt BETWEEN p.StartDate AND p.EndDate
    GROUP BY c.Country, p.PeriodName, YEAR(c.dt)
),
Stats AS (
    SELECT  Country,
            AVG(CASE WHEN PeriodName = 'Baseline' THEN AnnTemp END)   AS BaseAvg,
            AVG(CASE WHEN PeriodName = 'Recent'   THEN AnnTemp END)   AS RecentAvg,
            STDEV(CASE WHEN PeriodName = 'Baseline' THEN AnnTemp END) AS BaseSD
    FROM    AnnualAvg
    GROUP BY Country
)
SELECT  s.Country,
        g.GroupLabel,
        ROUND(s.BaseAvg, 2)                         AS Avg_1951_1980_C,
        ROUND(s.RecentAvg - s.BaseAvg, 2)           AS TempChange_C,
        ROUND(s.BaseSD, 2)                          AS BaselineYearlySD_C,
        ROUND((s.RecentAvg - s.BaseAvg) / s.BaseSD, 2) AS Change_In_SDs
FROM    Stats s
JOIN    dbo.CountryGroup g ON g.Country = s.Country
ORDER BY Change_In_SDs DESC;
GO