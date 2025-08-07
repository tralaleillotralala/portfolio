CALL GetCompaniesWithMinFlights(FALSE); -- Вызываем процедуру

-- Основной запрос с использованием временной таблицы
SELECT 
    p.name AS name,
    COUNT(DISTINCT pit.trip) AS count
FROM passenger p
JOIN pass_in_trip pit ON p.id = pit.passenger
JOIN trip tr ON pit.trip = tr.id
JOIN global_min_companies gmin ON tr.company = gmin.company_id
GROUP BY p.id, p.name
HAVING COUNT(DISTINCT pit.trip) >= 1
ORDER BY count DESC, name ASC;

