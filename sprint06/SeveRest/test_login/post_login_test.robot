*** Settings ***

Resource    ../config/config.robot

*** Variables ***
 

*** Keywords ***

Fazer LogIn Estático
    [Arguments]    ${testcase}
    ${json}       Importar JSON estático    login.json
    
    Create Session    severest    ${BASEURL}
    ${payload}    Set Variable    ${json["${testcase}"]}
    ${body}=    Set Variable    ${payload}
    Log To Console    ${body}
    
    ${response}=    POST On Session    severest    /login    json=${body}
    #If valido == 200, else == 401
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

Importar JSON estático
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File    ${EXECDIR}/resources/${nome_arquivo}
    ${data}        Evaluate    json.loads('''${arquivo}''')    json
    RETURN         ${data}

*** Test Cases ***

Teste de LogIn Válido Estático - Caso Base
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_valido
   Fazer LogIn Estático    login_valido

Teste de LogIn Válido Estático - Não Cadastrado
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_not_signed"

Teste de LogIn Válido Estático - Email Errado
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_email_wrong

Teste de LogIn Válido Estático - Email Faltando
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_email_blank

Teste de LogIn Válido Estático - Senha Errada
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_password_wrong

Teste de LogIn Válido Estático - Senha Faltando
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_password_blank

Teste de LogIn Inválido Estático
   #Fazer LogIn Estático
   #Send body: estatico_invalido