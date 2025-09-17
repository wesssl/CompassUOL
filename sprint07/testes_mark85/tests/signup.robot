*** Settings ***

Library    Browser
Library    FakerLibrary

Resource    ../resources/base.robot

*** Variables ***




*** Test Cases ***

Deve poder cadastrar um novo usuário

    ${NAME}    Set Variable    Wes Lima
    ${EMAIL}    Set Variable    email@email.com
    ${PASSWORD}    Set Variable    teste123

    Remove User From Database    ${EMAIL}

    Acessar URL    signup

    Wait For Elements State    xpath=//h1    visible    3
    Get Text    xpath=//h1    equals    Faça seu cadastro

    Fill Text    xpath=//*[@id="name"]    ${NAME}
    Fill Text    xpath=//*[@id="email"]     ${EMAIL}
    Fill Text    xpath=//*[@id="password"]     ${PASSWORD}
    
    Click    id=buttonSignup

    Wait For Elements State    xpath=//*[@class="notice success"]    visible    3
    Get Text                   xpath=//*[@class="notice success"]    equals     Boas vindas ao Mark85, o seu gerenciador de tarefas.

    Sleep    5
    Close Browser