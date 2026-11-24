DROP TABLE IF EXISTS dbo.CountryGroup;
DROP TABLE IF EXISTS dbo.Period;
GO

CREATE TABLE dbo.CountryGroup (
    Country     VARCHAR(60) PRIMARY KEY,
    GroupLabel  VARCHAR(40) NOT NULL
);

INSERT INTO dbo.CountryGroup (Country, GroupLabel) VALUES
('United States',  'Industrialized'),
('Canada',         'Industrialized'),
('United Kingdom', 'Industrialized'),
('Germany',        'Industrialized'),
('Japan',          'Industrialized'),
('China',          'Developing'),
('India',          'Developing'),
('Philippines',    'Developing'),
('Bangladesh',     'Developing'),
('Nigeria',        'Developing'),
('Brazil',         'Developing');

CREATE TABLE dbo.Period (
    PeriodName  VARCHAR(20) PRIMARY KEY,
    StartDate   DATE NOT NULL,
    EndDate     DATE NOT NULL
);

INSERT INTO dbo.Period (PeriodName, StartDate, EndDate) VALUES
('Baseline', '1951-01-01', '1980-12-01'),
('Recent',   '2000-01-01', '2012-12-01');
GO