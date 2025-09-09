*** Settings ***

Resource    ../config/config.robot

*** Variables ***


*** Keywords ***

Criar DataMass de Novo Usuário Dinâmico
    ${FIRSTNAME}    First Name
    ${EMAIL}        Email
    ${PASSWORD}     Password
    ${ADM}    Set Variable    "true"
    ${DYNAMICPAYLOAD}=    Create Dictionary    nome=${FIRSTNAME}    email=${EMAIL}    
    ...    password=${PASSWORD}    administrador=${ADM}
    RETURN    ${DYNAMICPAYLOAD}

Criar DataMass de Novo Usuário Estatico
    [Arguments]    ${testcase}
    ${json}=       Importar JSON estático    user.json
    ${STATICPAYLOAD}    Set Variable    ${json["${testcase}"]}
    RETURN    ${STATICPAYLOAD}

Criar Novo Usuário
    #importar payload estatico
    #importar payload dinamico
    #estruturar payload

    ${response}=    POST On Session    severest    /login    json=${body}    expected_status=any
    Run Keyword If    '${testcase}' == 'user_valido'
    ...    Validar Sucesso No Cadastro    ${response}
    ...  ELSE IF    '${testcase}' != 'user_valido'
    ...    Validar Falha No Cadastro   ${response}


Validar Sucesso No Cadastro

Validar Falha No Cadastro


*** Test Cases ***

Criar Novo Usuário - Caso Base

Criar Novo Usuário - Sem nome

Criar Novo Usuário - Sem Email

Criar Novo Usuário - Sem Senha

Criar Novo Usuário - Sem Administrador

Criar Novo Usuário - Email repetido

Criar Novo Usuário - Email Gmail

Criar Novo Usuário - Email Hotmail

Criar Novo Usuário - Email Sem Arroba

Criar Novo Usuário - Email Sem Ponto Com

Criar Novo Usuário - Senha Com Menos De Cinco Caracteres

Criar Novo Usuário - Senha Com Mais De Dez Caracteres

