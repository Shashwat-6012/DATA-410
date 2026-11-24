WITH CountryChange AS (
    SELECT  c.Country,
            g.GroupLabel,
            AVG(CASE WHEN p.PeriodName = 'Recent'   THEN c.AverageTemperature END)
          - AVG(CASE WHEN p.PeriodName = 'Baseline' THEN c.AverageTemperature END) AS TempChange
    FROM    dbo.CleanCountryTemp c
    JOIN    dbo.CountryGroup     g ON g.Country = c.Country
    JOIN    dbo.Period           p ON c.dt BETWEEN p.StartDate AND p.EndDate
    GROUP BY c.Country, g.GroupLabel
)
SELECT  GroupLabel,
        COUNT(*)                  AS Countries,
        ROUND(AVG(TempChange), 2) AS AvgChange_C,
        ROUND(MIN(TempChange), 2) AS SmallestChange_C,
        ROUND(MAX(TempChange), 2) AS LargestChange_C
FROM    CountryChange
GROUP BY GroupLabel
ORDER BY AvgChange_C DESC;
GO