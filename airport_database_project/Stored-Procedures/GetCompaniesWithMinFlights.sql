CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCompaniesWithMinFlights`(IN should_rollback BOOLEAN)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- Создаем временную таблицу с уникальным именем, которая сохранится после процедуры
    DROP TEMPORARY TABLE IF EXISTS global_min_companies;
    CREATE TEMPORARY TABLE global_min_companies (
        company_id INT,
        company_name VARCHAR(45)
    );
    
    -- Заполняем таблицу данными
    INSERT INTO global_min_companies
    SELECT c.id, c.name
    FROM company c 
    LEFT JOIN trip t ON c.id = t.company
    GROUP BY c.id, c.name
    HAVING COUNT(t.id) = (
        SELECT MIN(flight_count)
        FROM (
            SELECT COUNT(t2.id) AS flight_count
            FROM company c2
            LEFT JOIN trip t2 ON c2.id = t2.company
            GROUP BY c2.id
        ) AS counts
    );
    
    -- Возвращаем результаты
    SELECT * FROM global_min_companies;
    
    -- Управление транзакцией
    IF should_rollback THEN
        ROLLBACK;
        -- Даже при откате оставляем таблицу, но очищаем её
        TRUNCATE TABLE global_min_companies;
    ELSE COMMIT;
    END IF;
    
    -- ЯВНО НЕ УДАЛЯЕМ ТАБЛИЦУ, чтобы она была доступна после процедуры
    -- Она автоматически удалится при завершении сессии
END