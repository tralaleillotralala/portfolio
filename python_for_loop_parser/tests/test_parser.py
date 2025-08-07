import pytest
from src.parser import is_valid_for_loop


class TestForLoopParser:
    # Valid cases
    def test_simple_for_loop(self):
        assert is_valid_for_loop("for i in range(5): pass") == True

    def test_for_with_list(self):
        assert is_valid_for_loop("for x in [1,2,3]: print(x)") == True

    def test_for_with_tuple(self):
        assert is_valid_for_loop("for item in (1,2,3): x = item") == True

    def test_for_with_string(self):
        assert is_valid_for_loop('for ch in "hello": pass') == True

    def test_for_with_variable(self):
        assert is_valid_for_loop("for elem in my_list: elem.process()") == True

    def test_for_with_else(self):
        code = """
for i in range(3):
    print(i)
else:
    print("Done")
"""
        assert is_valid_for_loop(code) == True

    def test_nested_range(self):
        assert is_valid_for_loop("for i in (range(10)): pass") == True

    def test_range_with_3_args(self):
        assert is_valid_for_loop("for i in range(1,10,2): continue") == True

    # Invalid cases
    def test_empty_string(self):
        assert is_valid_for_loop("") == False

    def test_missing_in(self):
        assert is_valid_for_loop("for i range(5): pass") == False

    def test_missing_colon(self):
        assert is_valid_for_loop("for i in range(5) pass") == False

    def test_invalid_iterable_number(self):
        assert is_valid_for_loop("for i in 123: pass") == False

    def test_invalid_range_args(self):
        assert is_valid_for_loop("for i in range(1,2,3,4): pass") == False

    def test_unclosed_bracket(self):
        assert is_valid_for_loop("for i in [1,2: pass") == False

    def test_missing_identifier(self):
        assert is_valid_for_loop("for in range(5): pass") == False

    def test_invalid_else_position(self):
        code = """
for i in range(3):
    print(i)
print("Extra")
else:
    print("Done")
"""
        assert is_valid_for_loop(code) == False