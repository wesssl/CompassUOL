*** Settings ***

Library    RequestsLibrary
Library    Collections
Library    FakerLibrary
Library    OperatingSystem
Library    JSONLibrary
Library    String

*** Variables ***

${BASEURL}    http://localhost:3000/

*** Keywords ***

Importar JSON estático
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File    ${EXECDIR}/resources/${nome_arquivo}
    ${data}        Evaluate    json.loads('''${arquivo}''')    json
    RETURN         ${data}
