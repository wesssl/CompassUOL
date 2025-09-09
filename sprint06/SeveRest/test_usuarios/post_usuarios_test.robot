*** Settings ***

Resource    ../config/config.robot
Library    FakerLibrary

*** Variables ***


*** Keywords ***

Criar DataMass de Novo Usuário Dinâmico
    ${FIRSTNAME}    First Name
    ${EMAIL}        Email
    ${PASSWORD}     Password
    ${ADM}    Set Variable    "true"
    Create Session    severest    ${BASEURL}
    ${payload}=    Create Dictionary    nome=${FIRSTNAME}    email=${EMAIL}    password=${PASSWORD}    administrador=${ADM}
    
Criar DataMass de Novo Usuário Estático

Cadastro de Usuário

*** Test Cases ***