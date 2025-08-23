#Funções de cálculo
def soma(num1, num2):
    return num1 + num2

def dimin(num1, num2):
    return num1 - num2

def divisao(num1, num2):
    if num2 == 0:
        raise ValueError("Divisão por zero não é permitida")
    return num1 / num2

def multiplicacao(num1, num2):
    return num1 * num2

#Validação de escolha de operação
def validar_escolha(escolha):
    if escolha not in ('1', '2', '3', '4', '5'):
        raise ValueError("Escolha inválida")
    return escolha

#Validação de números
def validar_numero(num):
    if not isinstance(num, (int, float)):
        raise TypeError("Entrada deve ser um número")
    if not (num > 0):
        raise ValueError("Número inválido")
    return num

#Função que executa operação com parâmetros
def executar_operacao(escolha, num1, num2):
    validar_escolha(escolha)
    validar_numero(num1)
    validar_numero(num2)

    if escolha == '1':
        return soma(num1, num2)
    elif escolha == '2':
        return dimin(num1, num2)
    elif escolha == '3':
        return divisao(num1, num2)
    elif escolha == '4':
        return multiplicacao(num1, num2)
    elif escolha == '5':
        return "Sair"

#Função de interface para rodar a calculadora
def calculadora():
    while True:
        print("Escolha uma operação:")
        print("1. Soma")
        print("2. Diminuição")
        print("3. Divisão")
        print("4. Multiplicação")
        print("5. Sair")

        escolha = input("Digite o número da operação desejada: ")

        #Escolha de operacao
        try:
            validar_escolha(escolha)
        except ValueError as e:
            print(f"Erro: {e}")
            continue

        if escolha == '5':
            print("Saindo da calculadora.")
            break

        #Input dos numeros da operacao
        try:
            num1 = float(input("Digite o primeiro número: "))
            num2 = float(input("Digite o segundo número: "))
        except ValueError:
            print("Entrada inválida. Por favor, insira números válidos.")
            continue

        try:
                resultado = executar_operacao(escolha, num1, num2)
                print(f"Resultado: {resultado}")

        except (ValueError, TypeError) as e:
                print(f"Erro: {e}")
                continue
        
if __name__ == "__main__":
    calculadora()
