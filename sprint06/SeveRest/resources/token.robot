*** Settings ***

Resource    ../config/config.robot

*** Variables ***

${TOKEN}    

*** Keywords ***

Gerar Novo Token
    Create Session    severest    ${BASEURL}
    ${body}=    Create Dictionary    email=fulano@qa.com    password=teste
    ${response}=    POST On Session    severest    /login    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${authorization}=    Set Variable    ${json['authorization']}
    ${parts}=    Split String    ${authorization}    ${SPACE}
    ${TOKEN}=    Set Variable    ${parts[1]}
    Set Global Variable    ${TOKEN}
    RETURN    ${TOKEN}

Log do Bearer Token
    ${TOKEN}    Gerar Novo Token
    Log To Console    ${TOKEN}

*** Test Cases ***

Teste de Token
    Gerar Novo Token
    Log do Bearer Token
