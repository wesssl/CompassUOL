*** Settings ***

Library    Browser
Library    FakerLibrary

Resource    ../resources/base.robot


*** Keywords ***

Criar Massa de dados Estática
    ${NAME}    Set Variable    Wes Lima
    ${EMAIL}    Set Variable    email@email.com
    ${PASSWORD}    Set Variable    teste123
    RETURN    ${NAME}    ${EMAIL}    ${PASSWORD} 

Criar Massa de dados Dinâmica
    ${NAME}    FakerLibrary.Name
    ${EMAIL}    FakerLibrary.Email
    ${PASSWORD}    FakerLibrary.Password
    RETURN    ${NAME}    ${EMAIL}    ${PASSWORD}

Preencher formulário
    [Arguments]     ${NAME}=    ${EMAIL}=    ${PASSWORD}=
    Fill Text    xpath=//*[@id="name"]    ${NAME}
    Fill Text    xpath=//*[@id="email"]     ${EMAIL}
    Fill Text    xpath=//*[@id="password"]     ${PASSWORD}

Checkar se os elementos de cadastro estão visíveis
    Wait For Elements State    xpath=//h1    visible    3
    Get Text    xpath=//h1    equals    Faça seu cadastro

*** Test Cases ***

Deve poder cadastrar um novo usuário estático
    [Tags]    cadastrodinamico    
    Acessar URL    signup
    Checkar se os elementos de cadastro estão visíveis
    ${NAME}    ${EMAIL}    ${PASSWORD}    Criar Massa de dados Estática
    Remove User From Database    ${EMAIL}
    Preencher formulário    ${NAME}    ${EMAIL}    ${PASSWORD}
    Click    id=buttonSignup

    Wait For Elements State    xpath=//*[@class="notice success"]    visible    5
    Get Text                   xpath=//*[@class="notice success"]    equals     Boas vindas ao Mark85, o seu gerenciador de tarefas.

    Sleep    5
    Close Browser

Não deve criar um usuário com o mesmo email
    [Tags]    emailduplicate
    Acessar URL    signup
    Checkar se os elementos de cadastro estão visíveis
    ${NAME}    ${EMAIL}    ${PASSWORD}    Criar Massa de dados Estática
    Remove User From Database        ${EMAIL}
    Insert User From Database        ${NAME}    ${EMAIL}    ${PASSWORD}
    Preencher formulário    ${NAME}    ${EMAIL}    ${PASSWORD}
    Click    id=buttonSignup

    Wait For Elements State    xpath=//*[@class="notice error"]    visible    5
    Get Text                   xpath=//*[@class="notice error"]    equals     Oops! Já existe uma conta com o e-mail informado.
    Remove User From Database        ${EMAIL}
    Sleep    5
    Close Browser
