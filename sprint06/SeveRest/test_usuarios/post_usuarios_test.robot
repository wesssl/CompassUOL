*** Settings ***

Resource    ../config/config.robot
Library    FakerLibrary

*** Variables ***


*** Keywords ***

Cadastro Novo Usuário Dinâmico
    ${FIRSTNAME}    First Name
    ${EMAIL}        Email
    ${PASSWORD}     Password
    ${ADM}    Set Variable    "true"
    Create Session    severest    ${BASEURL}
    ${body}=    Create Dictionary    email=${FIRSTNAME}    email=${EMAIL}    password=${PASSWORD}    administrador=${ADM}

Cadastro Novo Usuário Estático Válido

Cadastro Novo Usuário Estático Inválido

*** Test Cases ***