select * from portfolioproject..coviddeaths$ where continent is not null
select * from portfolioproject..covidvaccin$ where continent is not null

----Data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..coviddeaths$
where continent is not null
order by 1,2

---Looking @ total cases vs total deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from PortfolioProject..coviddeaths$ 
where continent is not null
----where location like '%states%'
order by 1,2

---looking @ total Cases vs population/shows what percentage contracted covid

select location, date, population, total_cases, (total_cases/population)*100 as deathpercentage
from PortfolioProject..coviddeaths$
where continent is not null
----where location like '%states%'
order by 1,2

---looking @ countries with highest infection rate compared to population

select location, population, Max(total_cases) as highestinfectioncount, max(total_cases/population)*100 as infectedpopulation
from PortfolioProject..coviddeaths$
------where location like '%states%'
group by location, population
order by infectedpopulation desc

---Showing countries with highest death

select location, Max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..coviddeaths$
where continent is not null
------where location like '%anad%'
group by location
order by totaldeathcount desc

---lets break things down by continent

select continent, Max(cast(total_deaths as int)) as totaldeathcount
from PortfolioProject..coviddeaths$
where continent is not null
----where location like '%anad%'
group by continent
order by totaldeathcount desc

---global numbers---
select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, 
sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from PortfolioProject..coviddeaths$
where continent is not null
Group by date
order by 1,2


select * from portfolioproject..covidvaccin$

----total population vs vaccination  / lets join these 2 tables

select dea.continent, dea.location, dea.date, dea.population, vac.
from portfolioproject..coviddeaths$ dea
join portfolioproject..covidvaccin$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3


---View

Create view see_covid_deaths as
select * from portfolioproject..coviddeaths$ 

---Stored Procedure

Create procedure see_covid_vaccine as 
select * from portfolioproject..covidvaccin$

exec see_covid_vaccine