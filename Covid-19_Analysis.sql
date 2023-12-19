/*
Covid 19 Data Exploration 

Skills used: Joins, Aggregate Functions, Converting Data Types
*/

-- Selecting data for initial exploration
SELECT *
FROM death_data
WHERE continent IS NOT NULL 
ORDER BY 3, 4;

-- Initial data selection
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM death_data
WHERE continent IS NOT NULL 
ORDER BY 1, 2;

-- Analyzing likelihood of death if contracting COVID
SELECT Location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 AS DeathPercentage
FROM death_data
WHERE location LIKE 'United Kingdom'
  AND continent IS NOT NULL 
ORDER BY 1, 2;

-- Analyzing percentage of population infected with COVID
SELECT Location, date, Population, total_cases, (total_cases / population) * 100 AS PercentPopulationInfected
FROM death_data
ORDER BY 1, 2;

-- Countries with highest infection rate compared to population
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases / population)) * 100 AS PercentPopulationInfected
FROM death_data
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;

-- Countries with highest death count per population
SELECT Location, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM death_data
WHERE continent IS NOT NULL 
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- Breaking down by continent: showing continents with highest death count per population
SELECT continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM death_data
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Global numbers
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS DeathPercentage
FROM death_data
WHERE continent IS NOT NULL;

-- Total population vs vaccinations: shows percentage of population that has received at least one COVID vaccine
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM death_data dea
JOIN vaccine_data vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2, 3;

