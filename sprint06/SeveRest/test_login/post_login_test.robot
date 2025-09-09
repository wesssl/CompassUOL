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

    ${response}=    POST On Session    severest    /login    json=${body}    expected_status=any
    Run Keyword If    '${testcase}' == 'login_valido'
    ...    Validar Sucesso no LogIn    ${response}
    ...  ELSE IF    '${testcase}' != 'login_valido'
    ...    Validar Falha no LogIn   ${response}

Validar Sucesso no LogIn
    [Arguments]    ${response}
    Run Keyword And Continue On Failure     Should Be Equal As Integers    ${response.status_code}    200

Validar Falha no LogIn
    [Arguments]    ${response}
    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${response.status_code}    401

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

Teste de LogIn Inválido Estático - Não Cadastrado
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_not_signed"
   Fazer LogIn Estático    login_not_signed

Teste de LogIn Inválido Estático - Email Errado
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_email_wrong
   Fazer LogIn Estático    login_email_wrong

Teste de LogIn Inválido Estático - Email Faltando
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_email_blank
   Fazer LogIn Estático    login_email_blank

Teste de LogIn Inválido Estático - Senha Errada
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_password_wrong
   Fazer LogIn Estático    login_password_wrong

Teste de LogIn Inválido Estático - Senha Faltando
   #Fazer LogIn Estático - argument ${testcase}
   #Send body: login_password_blank
   Fazer LogIn Estático    login_password_blank