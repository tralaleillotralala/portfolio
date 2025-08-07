import pytest
from src.parser import Parser, tokenize

@pytest.fixture
def parser():
    def _parser(code):
        tokens = tokenize(code)
        return Parser(tokens)
    return _parser