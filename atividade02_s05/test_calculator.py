import pytest
from calculator import soma, dimin, divisao, multiplicacao, executar_operacao, validar_escolha, validar_numero


#teste de escolha de operação na interface
def test_operacao_soma():
    assert executar_operacao('1', 2, 3) == 5

def test_operacao_divisao_por_zero():
    with pytest.raises(ValueError):
        executar_operacao('3', 5, 0)

def test_escolha_invalida():
    with pytest.raises(ValueError):
        validar_escolha('7')

def test_numero_invalido():
    with pytest.raises(TypeError):
        validar_numero("S")

#testes de tipo de entradas dos numeros
def test_tipo_entrada():
    assert isinstance(validar_numero(5), (int, float))

def test_entrada_notNegative():
    with pytest.raises(ValueError):
        validar_numero(-5)


#teste de soma
def test_soma():
    assert soma(2, 2) == 4
    #teste de entradas negativas ----- obsoletas agora que criei os de validacao de valores

#teste de diminuição
def test_dimin():
    assert dimin(2, 2) == 0
    #teste de entradas negativas ----- obsoletas agora que criei os de validacao de valores

#teste de divisão
    #teste base
    #teste de entradas negativas
    #teste de divisão por zero

#teste de multiplicação
    #teste base
    #teste de entradas negativas


