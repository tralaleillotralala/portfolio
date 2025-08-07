SELECT 
    p.name AS name,
    COUNT(DISTINCT pit.trip) AS count
FROM 
    passenger p
JOIN 
    pass_in_trip pit ON p.id = pit.passenger
JOIN 
    trip tr ON pit.trip = tr.id
JOIN 
    -- Используем результат вызова процедуры как подзапрос
    (SELECT company_id FROM GetCompaniesWithMinFlights(FALSE)) mfc 
    ON tr.company = mfc.company_id
GROUP BY 
    p.id, p.name
HAVING 
    COUNT(DISTINCT pit.trip) >= 1
ORDER BY 
    count DESC,
    name ASC;



/*SELECT 
    p.name AS name,
    COUNT(DISTINCT pit.trip) AS count  -- Учитываем только уникальные рейсы!
FROM passenger p JOIN pass_in_trip pit
ON p.id = pit.passenger
GROUP BY p.id, p.name
HAVING count >= 1  -- Проверяем уникальные рейсы
ORDER BY 
    count DESC,    -- Сортировка по количеству перелетов (по убыванию)
    name ASC;      -- Сортировка имен (алфавитный порядок)*/

