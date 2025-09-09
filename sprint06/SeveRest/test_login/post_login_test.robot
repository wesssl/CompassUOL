*** Settings ***

Resource    ../config/config.robot

*** Variables ***
 

*** Keywords ***

Fazer LogIn Válido Estático
    Create Session    severest    ${BASEURL}
    ${body}=    Create Dictionary    email=fulano@qa.com    password=teste
    ${response}=    POST On Session    severest    /login    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

*** Test Cases ***

Teste de LogIn
    Fazer LogIn Válido Estático