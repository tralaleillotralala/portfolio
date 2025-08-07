# Airport Database Analytics Project

## 📌 О проекте
Полноценный цикл работы с реляционной базой данных авиаперевозок, включающий:
- Проектирование структуры БД по ERD-диаграмме
- Импорт и валидацию данных из CSV-файлов
- Решение аналитических задач с помощью сложных SQL-запросов
- Разработку оптимизированных хранимых процедур
- Управление транзакциями с механизмом отката

## 🛠 Технологии
- **СУБД**: MySQL 8.0+
- **Инструменты**: MySQL Workbench, TablePlus
- **Методологии**: ACID, ETL-процессы

## 🔍 Ключевые кейсы
### 1. Анализ рейсов из Парижа
```sql
SELECT dest.city, 
       TIMESTAMPDIFF(HOUR, f.departure, f.arrival) AS duration
FROM flights f
JOIN airports dest ON f.destination = dest.id
WHERE f.origin = 'CDG'
ORDER BY duration DESC;

2. Хранимая процедура с транзакциями
CREATE PROCEDURE GetCompaniesWithMinFlights(IN should_rollback BOOLEAN)
BEGIN
    --
END


https://rutube.ru/video/5e0bd0f844b34a5f71d9141ee4e89705/?r=wd