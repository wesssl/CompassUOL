def soma(num1, num2):
    resultado = num1 + num2
    return resultado

def dimin(num1, num2):
    resultado = num1 - num2
    return resultado

def divisao(num1, num2):
    if num2 == 0:
        return "Erro: divisão por zero"
    resultado = num1 / num2
    return resultado

def multiplicacao(num1, num2):
    resultado = num1 * num2
    return resultado

def input_interface():
    num = input("Digite o número da operação desejada: ")
    return num

def calculadora():
    while True:
        print("Escolha uma operação:")
        print("1. Soma")
        print("2. Diminuição")
        print("3. Divisão")
        print("4. Multiplicação")
        print("5. Sair")

        escolha = input_interface(escolha)

        if escolha == '5':
            print("Saindo da calculadora.")
            break

        if escolha not in ('1', '2', '3', '4'):
            print("Escolha inválida. Por favor, escolha uma opção válida.")
            continue

        try:
            num1 = float(input("Digite o primeiro número: "))
            num2 = float(input("Digite o segundo número: "))
        except ValueError:
            print("Entrada inválida. Por favor, insira números válidos.")
            continue

        if escolha == '1':
            resultado = soma(num1, num2)
            print(f"Resultado da soma: {resultado}")
        elif escolha == '2':
            resultado = dimin(num1, num2)
            print(f"Resultado da diminuição: {resultado}")
        elif escolha == '3':
            resultado = divisao(num1, num2)
            print(f"Resultado da divisão: {resultado}")
        elif escolha == '4':
            resultado = multiplicacao(num1, num2)
            print(f"Resultado da multiplicação: {resultado}")

if __name__ == "__main__":
    calculadora()