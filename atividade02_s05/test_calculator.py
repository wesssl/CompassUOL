import pytest
from calculator import soma, dimin, divisao, multiplicacao, input_interface


#teste de escolha de operação na interface
def test_interface_inputOne():
    escolha = input_interface()
    assert escolha == 1

def test_interface_inputExceedsFive():
    escolha = input_interface()
    assert escolha == 7

def test_interface_inputLessThanZero():
    escolha = input_interface()
    assert escolha == -2

def test_interface_inputString():
    escolha = input_interface()
    assert isinstance(escolha, str)

#testes de tipo de entradas
def test_tipo_entrada():
    num1 = 5
    assert not isinstance(num1, str)

def test_entrada_notNegative():
    num1 = -5
    assert num1 >= 0
    #teste com inteiros
    #teste com String

#teste de soma
def test_soma():
    assert soma(2, 2) == 4
    #teste de entradas negativas

#teste de diminuição
def test_dimin():
    assert dimin(2, 2) == 0
    #teste de entradas negativas

#teste de divisão
    #teste base
    #teste de entradas negativas
    #teste de divisão por zero

#teste de multiplicação
    #teste base
    #teste de entradas negativas


