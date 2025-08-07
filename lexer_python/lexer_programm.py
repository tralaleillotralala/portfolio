import re

# Определение токенов в порядке приоритета
TOKENS = [
    ('SPACE', r'[\s]+'), # Пробельные символы (игнорируются)
    ('COMMENT', r'\#.*'), # Комментарии (игнорируются)
    ('KEYWORD', r'\b(if|else|elif|for|while|def|return|and|or|not|in|is|break|continue|as|try|raise|except|True|False|import|from)\b'),
    ('COMPARISON_OPERATOR', r'<=|>=|==|!=|>|<'),
    ('OPERATOR', r'=|\+|-|\*|\/|\*\*|\/\/|%'),
    ('LOGICAL_OPERATOR', r'&|\||\^'),
    ('DELIMITER', r'\(|\)|\[|\]|\{|\}|\,|\:'),
    ('FLOAT', r'-?\d+\.\d+'),
    ('INT', r'-?\d+\b'),
    ('STRING', r'''('[^']*'|"[^"]*")'''),
    ('IDENTIFIER', r'\b[a-zA-Z_][a-zA-Z0-9_]*\b'),
]

def tokenize(code):
    tokens = [] # Список для хранения найденных токенов
    while code:
        for token_type, pattern in TOKENS:
            regex = re.compile(pattern) # Компилируем regexp для текущего типа токена
            match = regex.match(code)   # Пытаемся найти соответствие регулярному выражению в начале строки
            if match:
                value = match.group(0)
                if token_type not in ['SPACE']:  # Пропускаем пробелы
                    tokens.append((token_type, value))
                code = code[len(value):] # Укорачиваем анализируемую строку, удаляя обработанную часть
                break
        else: # Если ни один токен не совпал
              # Если ни один шаблон не совпал, значит встретился неизвестный символ
              # Выводим ошибку с указанием проблемного символа и его позиции
            raise SyntaxError(f"Неизвестный символ: '{code[0]}' в позиции {len(code)}")
    return tokens

# Пример использования
python_code = '''
name = "Alice"
greeting = 'Hello ' + name
is_adult = True
if is_adult and len(name) > 3:
    print(greeting)
'''

try:
    tokens = tokenize(python_code)
    print("{:<20} {:<15}".format("Тип токена", "Значение")) # Вывод в табличном формате
    print("-" * 35)
    for token in tokens:
        print("{:<20} {:<15}".format(token[0], token[1]))
except SyntaxError as e: print(f"Ошибка: {e}")