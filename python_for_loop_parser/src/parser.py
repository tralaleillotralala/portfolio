import re # Импорт модуля для работы с регулярными выражениями

# Определение токенов языка Python, которые мы будем распознавать
# Каждый токен имеет имя и регулярное выражение для его распознавания
TOKENS = [
    ('SPACE', r'[\s]+'),                # Пробельные символы (пропускаем)
    ('COMMENT', r'\#.*'),
    ('KEYWORD', r'\b(for|in|else)\b'),  # Убрали range из ключевых слов
    ('RANGE', r'\brange\b'),            # Добавили отдельный тип для range
    ('DELIMITER', r'\(|\)|\[|\]|\,|\:|\n'),
    ('OPERATOR', r'=|\+|-|\*|\/|\*\*|\/\/|%'),
    ('COMPARISON_OPERATOR', r'<=|>=|==|!=|>|<'),
    ('LOGICAL_OPERATOR', r'&|\||\^'),
    ('FLOAT', r'-?\d+\.\d+'),
    ('INT', r'-?\d+\b'),
    ('STRING', r'''('[^']*'|"[^"]*")'''),
    ('IDENTIFIER', r'\b[a-zA-Z_][a-zA-Z0-9_]*\b'),
]


class Parser:
    def __init__(self, tokens): # Инициализация парсера с токенами
        self.tokens = [t for t in tokens if t[0] not in ['SPACE', 'COMMENT']]
        self.pos = 0            # Текущая позиция в списке токенов
        self.current_token = self.tokens[self.pos] if self.tokens else None

    # Переход к следующему токену
    def advance(self):
        self.pos += 1
        if self.pos < len(self.tokens):
            self.current_token = self.tokens[self.pos]
        else:
            self.current_token = None

    # Основной метод парсинга
    def parse(self):
        try:
            self.parse_for_loop() # Парсим цикл for
            if self.current_token is not None: # Проверяем, что разобрали все токены
                raise SyntaxError(f"Unexpected token {self.current_token}")
            return True
        except SyntaxError as e:
            print(f"Syntax error: {e}")
            return False

    # Парсинг конструкции for: for <id> in <iterable>: <action> [else: <action>]
    def parse_for_loop(self):
        self.match('KEYWORD', 'for') # Проверяем ключевое слово for
        self.match('IDENTIFIER') # Проверяем идентификатор переменной
        self.match('KEYWORD', 'in')  # Проверяем ключевое слово in
        self.parse_iterable()  # Парсим итерируемый объект
        self.match('DELIMITER', ':') # Проверяем двоеточие
        self.parse_action() # Парсим тело цикла
        # Проверяем необязательную часть else
        if self.current_token and self.current_token[1] == 'else':
            self.match('KEYWORD', 'else')
            self.match('DELIMITER', ':')
            self.parse_action()

    # Парсинг итерируемого объекта ITERABLE после in
    def parse_iterable(self):
        if not self.current_token:
            raise SyntaxError("Unexpected end of input")

        if self.current_token[0] == 'IDENTIFIER':
            self.advance()     # Простой идентификатор (переменная)
        elif self.current_token[0] == 'RANGE':
            self.parse_range() # Вызов функции range()
        elif self.current_token[1] == '[':
            self.parse_list()  # Список в квадратных скобках
        elif self.current_token[1] == '(':
            self.parse_tuple_or_range() # Кортеж или range в скобках
        elif self.current_token[0] == 'STRING':
            self.advance()     # Строковый литерал
        else:
            raise SyntaxError(f"Expected iterable, got {self.current_token}")

    # Обработка неоднозначности между кортежем и range в скобках
    def parse_tuple_or_range(self):
        start_pos = self.pos # Запоминаем текущую позицию для возможного отката
        try:
            self.match('DELIMITER', '(') # Открывающая скобка
            if self.current_token and self.current_token[0] == 'RANGE':
                self.parse_range() # Если после скобки идет range - это вызов range в скобках
                if self.current_token and self.current_token[1] == ')':
                    self.match('DELIMITER', ')')
            else: # Иначе это кортеж
                if self.current_token and self.current_token[1] != ')':
                    self.parse_elements() # Элементы кортежа
                self.match('DELIMITER', ')') # Закрывающая скобка
        except SyntaxError: # Если возникла ошибка - откатываемся и пробуем разобрать как кортеж
            self.pos = start_pos
            self.current_token = self.tokens[self.pos]
            self.parse_tuple()

    # Парсинг вызова range: range(<args>)
    def parse_range(self):
        if self.current_token[0] == 'RANGE':
            self.advance()  # Пропускаем 'range'
        self.match('DELIMITER', '(') # Открывающая скобка
        self.parse_range_args() # Аргументы range
        self.match('DELIMITER', ')') # Закрывающая скобка

    # Парсинг аргументов range: 1, 2 или 3 целых числа
    def parse_range_args(self):
        self.match('INT') # Первый аргумент (обязательный)
        if self.current_token and self.current_token[1] == ',':
            self.match('DELIMITER', ',') # Запятая
            self.match('INT')     # Второй аргумент
            if self.current_token and self.current_token[1] == ',':
                self.match('DELIMITER', ',') # Запятая
                self.match('INT') # Третий аргумент

    # Парсинг списка: [<elements>]
    def parse_list(self):
        self.match('DELIMITER', '[') # Открывающая квадратная скобка
        if self.current_token and self.current_token[1] != ']':
            self.parse_elements() # Элементы списка (если не пустой)
        self.match('DELIMITER', ']') # Закрывающая квадратная скобка

    # Парсинг кортежа: (<elements>)
    def parse_tuple(self):
        self.match('DELIMITER', '(')
        if self.current_token and self.current_token[1] != ')':
            self.parse_elements()
        self.match('DELIMITER', ')')

    # Парсинг элементов списка/кортежа: элемент или несколько через запятую
    def parse_elements(self):
        self.parse_element() # Первый элемент
        while self.current_token and self.current_token[1] == ',':
            self.match('DELIMITER', ',') # Запятая
            self.parse_element() # Следующий элемент

    # Парсинг одного элемента (идентификатор, число, строка)
    def parse_element(self):
        if not self.current_token:
            raise SyntaxError("Unexpected end of input")

        if self.current_token[0] in ('IDENTIFIER', 'INT', 'FLOAT', 'STRING'):
            self.advance()
        else:
            raise SyntaxError(f"Expected element, got {self.current_token}")

    def parse_action(self):
        self.parse_statements() # Парсинг тела цикла (после двоеточия)

    # Парсинг одного или нескольких операторов
    def parse_statements(self):
        self.parse_statement() # Первый оператор
        while (self.current_token and
               (self.current_token[0] == 'DELIMITER' and self.current_token[1] == '\n' or
                self.is_statement_start())):
            if self.current_token[1] == '\n':
                self.match('DELIMITER', '\n') # Разделитель операторов
            if self.is_statement_start():
                self.parse_statement() # Следующий оператор

    # Упрощенный парсинг оператора Python (пропускаем все до ключевых слов)
    def parse_statement(self):
        if not self.current_token:
            return

        while (self.current_token and
               not (self.current_token[0] == 'KEYWORD' and
                    self.current_token[1] in ('for', 'if', 'else', 'while'))):
            self.advance()

    # проверка, может ли токен начинать оператор
    def is_statement_start(self):
        if not self.current_token:
            return False
        return (self.current_token[0] in ('IDENTIFIER', 'INT', 'FLOAT', 'STRING', 'DELIMITER') or
                (self.current_token[0] == 'KEYWORD' and
                 self.current_token[1] not in ('for', 'if', 'else', 'while')))

    # Проверка соответствия текущего токена ожидаемому
    def match(self, token_type, value=None):
        if not self.current_token:
            raise SyntaxError(f"Expected {token_type}, but got end of input")
        if self.current_token[0] != token_type:
            raise SyntaxError(f"Expected {token_type}, got {self.current_token[0]}")
        if value is not None and self.current_token[1] != value:
            raise SyntaxError(f"Expected {value}, got {self.current_token[1]}")
        self.advance()

# Лексический анализатор - разбивает строку на токены
def tokenize(input_code):
    tokens = []
    while input_code:
        for token_type, pattern in TOKENS:
            regex = re.compile(pattern)
            match = regex.match(input_code)
            if match:
                value = match.group(0)
                if token_type not in ['SPACE', 'COMMENT']:
                    tokens.append((token_type, value))
                input_code = input_code[len(value):]
                break
        else: # Если токен не распознан - пропускаем один символ
            input_code = input_code[1:]
    return tokens

# Основная функция проверки валидности цикла for
def is_valid_for_loop(input_str):
    try:
        token_list = tokenize(input_str) # Лексический анализ
        parser = Parser(token_list)      # Создание парсера
        return parser.parse()            # Запуск парсинга
    except Exception as e:
        print(f"Error: {e}")
        return False


# примеры для проверки работы парсера
test_examples = [
    ("for i in str1: print(5+2)", True),
    ("for i in range(1, 10): print(i)", True),
    ("for i in range(1, 10, 2): print(i)", True),
    ("for i in (range(10)): print(i)", True),
    ("for item in [1, 2, 3]: pass", True),
    ("for char in 'hello': print(char)", True),
    ("for x in (1, 2, 3): x += 1\ny = 2", True),
    ("for i in my_list:\n\t\tprint(i)\n\telse: print('error')", True),
    ("for i in \"123\":", True),
    ("for _number in range(1, 5): pass", True),

    ("", False),
    ("for i", False),
    ("for :", False),
    ("for i in :", False),
    ("for i in 123.12: pass", False),
    ("for i in 123:", False),
    ("for i in \"123\"):", False),
    ("for i: in range(10): print(i)", False),
    ("for i in range(1, 50, 2, 1): pass", False),
    ("for _number in range(15: pass", False),
]

print("Результаты тестирования:")
for example, expected in test_examples:
    result = is_valid_for_loop(example)
    status = '✅' if (result == True and result == expected) else '❌'
    print(f"{status} '{example}'")
