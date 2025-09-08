*** Settings ***

Resource    ../config/config.robot

*** Variables ***

${TOKEN}    

*** Keywords ***

Gerar Novo Token
    Create Session    severest    ${BASEURL}






*** Test Cases ***