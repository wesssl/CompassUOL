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
    ${data}=     Load JSON From File    ${EXECDIR}/resources/${nome_arquivo}
    RETURN    ${data}
