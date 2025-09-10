*** Settings ***

Resource    ../config/config.robot

*** Variables ***


*** Keywords ***

Criar DataMass de Novo Usuário Dinâmico
    ${FIRSTNAME}    First Name
    ${EMAIL}        Email
    ${PASSWORD}     Password
    ${list}=    Create List    true    false
    ${ADM}=    Random Element    ${list}
    ${DYNAMICPAYLOAD}=    Create Dictionary    
    ...    nome=${FIRSTNAME}    
    ...    email=${EMAIL}    
    ...    password=${PASSWORD}    
    ...    administrador=${ADM}
    RETURN    ${DYNAMICPAYLOAD}

Criar DataMass de Novo Usuário Estatico
    [Arguments]    ${testcase}
    ${json}=       Importar JSON estático    user.json
    ${STATICPAYLOAD}    Set Variable    ${json["${testcase}"]}
    RETURN    ${STATICPAYLOAD}

Criar Novo Usuário
    [Arguments]    ${testcase}
    ${dynamic}=    Criar DataMass de Novo Usuário Dinâmico
    ${static}=     Criar DataMass de Novo Usuário Estatico    ${testcase}
    ${body}=    Copy Dictionary    ${dynamic}
    Set To Dictionary    ${body}    &{static}

    Log To Console    \n${body}

    Create Session    severest    ${BASEURL}
    ${response}=    POST On Session    severest    /usuarios    json=${body}    expected_status=any
    
    Run Keyword If    '${testcase}' == 'user_valido'
    ...    Validar Sucesso No Cadastro    ${response}
    ...  ELSE IF    '${testcase}' != 'user_valido'
    ...    Validar Falha No Cadastro   ${response}
    
    Log    Mensagem de status: ${response.json()}    console=True
    Log To Console    Status code: ${response.status_code}

Validar Sucesso No Cadastro
    [Arguments]    ${response}
    Run Keyword And Continue On Failure     Should Be Equal As Integers    ${response.status_code}    201

Validar Falha No Cadastro
    [Arguments]    ${response}
    Run Keyword And Continue On Failure     Should Be Equal As Integers    ${response.status_code}    400

*** Test Cases ***

Criar Novo Usuário - Caso Base
    Criar Novo Usuário    user_valido

Criar Novo Usuário - Sem nome
    Criar Novo Usuário    user_blank_name

Criar Novo Usuário - Sem Email
    Criar Novo Usuário    user_blank_email

Criar Novo Usuário - Sem Senha
    Criar Novo Usuário    user_blank_password

Criar Novo Usuário - Sem Administrador
    Criar Novo Usuário    user_blank_admin

Criar Novo Usuário - Email repetido
    Criar Novo Usuário    user_repeat_email

Criar Novo Usuário - Email Gmail

Criar Novo Usuário - Email Hotmail

Criar Novo Usuário - Email Sem Arroba

Criar Novo Usuário - Email Sem Ponto Com

Criar Novo Usuário - Senha Com Menos De Cinco Caracteres
    Criar Novo Usuário    user_password_less_five

Criar Novo Usuário - Senha Com Mais De Dez Caracteres
    Criar Novo Usuário    user_password_more_ten

