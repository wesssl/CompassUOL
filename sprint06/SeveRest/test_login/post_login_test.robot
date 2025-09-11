*** Settings ***

Resource    ../config/config.robot

*** Variables ***
 

*** Keywords ***

Fazer LogIn Estático
    [Arguments]    ${testcase}    #define qual o caso de teste, isso vai definir como o keyword irá se comportar
    ${json}=       Importar JSON estático    login.json
    
    Create Session    severest    ${BASEURL}
    ${payload}    Set Variable    ${json["${testcase}"]}
    ${body}=    Set Variable    ${payload}
    
    Log To Console    \n Payload: ${body}

    ${response}=    POST On Session    severest    /login    json=${body}    expected_status=any

    Run Keyword If    '${testcase}' == 'login_valido'    #Validação da resposta
    ...    Validar Sucesso no LogIn    ${response}
    ...  ELSE IF    '${testcase}' != 'login_valido'
    ...    Validar Falha no LogIn   ${response}

    Log    \n Mensagem de Status: ${response.json()}    console=True
    Log To Console    Status code: ${response.status_code}
Validar Sucesso no LogIn
    [Arguments]    ${response}
    Run Keyword And Continue On Failure     Should Be Equal As Integers    ${response.status_code}    200

Validar Falha no LogIn
    [Arguments]    ${response}
    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${response.status_code}    401

*** Test Cases ***

Teste de LogIn Válido Estático - Caso Base
   Fazer LogIn Estático    login_valido

Teste de LogIn Inválido Estático - Não Cadastrado
   Fazer LogIn Estático    login_not_signed

Teste de LogIn Inválido Estático - Email Errado
   Fazer LogIn Estático    login_email_wrong

Teste de LogIn Inválido Estático - Email Faltando
   Fazer LogIn Estático    login_email_blank

Teste de LogIn Inválido Estático - Senha Errada
   Fazer LogIn Estático    login_password_wrong

Teste de LogIn Inválido Estático - Senha Faltando
   Fazer LogIn Estático    login_password_blank