CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCompaniesWithMinFlights`(IN should_rollback BOOLEAN)
BEGIN
    -- Объявляем обработчик исключений, который срабатывает при SQL-ошибках
    -- EXIT означает, что после выполнения обработчика процедура завершится
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; -- При возникновении ошибки откатываем текущую транзакцию
	RESIGNAL; -- Повторно генерируем ошибку для передачи клиенту
    END;
    
    -- Начинаем новую транзакцию (все изменения можно будет откатить)
    START TRANSACTION;
    -- Удаляем временную таблицу, если она существует
    -- IF EXISTS предотвращает ошибку, если таблица не существует
    DROP TEMPORARY TABLE IF EXISTS temp_results;

    -- Создаем новую временную таблицу для хранения результатов
    -- Таблица будет автоматически удалена при завершении сессии
    CREATE TEMPORARY TABLE temp_results (
        company_id INT,          -- Колонка для ID компании (целое число)
        company_name VARCHAR(45) -- Колонка для названия компании (строка до 45 символов)
    );
    
    -- Вставляем данные во временную таблицу
    INSERT INTO temp_results
    -- Основной запрос для выбора компаний с минимальным количеством рейсов
    SELECT c.id AS company_id, c.name AS company_name
    FROM company c LEFT JOIN trip t ON c.id = t.company -- LEFT JOIN включает компании без рейсов
    GROUP BY c.id, c.name           -- Группируем по ID и названию компании
    HAVING                          -- Фильтруем группы после агрегации
        COUNT(t.id) = (             -- Оставляем только компании с минимальным числом рейсов
            -- Подзапрос для нахождения минимального количества рейсов среди всех компаний
            SELECT MIN(flight_count)
            FROM (
                -- Подзапрос, считающий количество рейсов для каждой компании
                SELECT COUNT(t2.id) AS flight_count
                FROM company c2
                LEFT JOIN trip t2 ON c2.id = t2.company
                GROUP BY c2.id
            ) AS counts
        );
    
    -- Возвращаем клиенту все записи из временной таблицы
    SELECT * FROM temp_results;
    
    -- Проверяем параметр should_rollback
    IF should_rollback THEN ROLLBACK; -- Если TRUE - откатываем транзакцию (все изменения отменяются)
    ELSE COMMIT; -- Если FALSE - подтверждаем транзакцию (изменения сохраняются)
    END IF;
    
    -- Удаляем временную таблицу (освобождаем ресурсы)
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END