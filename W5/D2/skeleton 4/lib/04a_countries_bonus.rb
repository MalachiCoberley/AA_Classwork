# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          gdp
        FROM
          countries
        WHERE
          continent = 'Europe' AND gdp IS NOT NULL
        ORDER BY 
          gdp DESC
        LIMIT 
          1
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      continent, name, area
    FROM
      countries
    WHERE
      area IN 
      (
      SELECT 
        continent, MIN(area) * 3
      FROM 
        countries
      GROUP BY 
        continent
      )

  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      name, continent
    FROM 
      countries
    WHERE
      population >
      (
      SELECT 
        MIN(population) * 3 
      FROM 
        countries
      GROUP BY 
        continent
      )
      

  SQL
end
