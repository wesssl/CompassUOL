*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    FakerLibrary

*** Variables ***
${BASE_URL}       https://restful-booker.herokuapp.com
${USERNAME}       admin
${PASSWORD}       password123
${TOKEN}          NONE
${BOOKINGID}      NONE

*** Keywords ***
Gerar Token
    Create Session    restful    ${BASE_URL}
    ${body}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST On Session    restful    /auth    json=${body}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()}[token]
    Set Suite Variable    ${TOKEN}    ${token}

Criar Booking
    ${firstname}=    First Name
    ${lastname}=     Last Name
    ${bookingdates}=    Create Dictionary    checkin=2025-09-01    checkout=2025-09-10
    ${payload}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=200
    ...    depositpaid=${True}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=Café da manhã
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${response}=    POST On Session    restful    /booking    json=${payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${BOOKINGID}=    Set Variable    ${response.json()}[bookingid]
    Set Suite Variable    ${BOOKINGID}

Consultar Booking por ID
    ${headers}=    Create Dictionary    Accept=application/json
    ${response}=    GET On Session    restful    /booking/${BOOKINGID}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    Dados do booking: ${response.json()}

Deletar Booking
    ${headers}=    Create Dictionary    Content-Type=application/json    Cookie=token=${TOKEN}
    ${response}=    DELETE On Session    restful    /booking/${BOOKINGID}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    201
    Log    Booking ${BOOKINGID} deletado com sucesso

*** Test Cases ***
Checkar se a API está funcionando
    Create Session    restful    ${BASE_URL}
    ${response}=    GET On Session    restful    /ping
    Should Be Equal As Integers    ${response.status_code}    201

Criar token de acesso
    Gerar Token
    Log    Token gerado: ${TOKEN}

Criar booking
    Criar Booking

Pesquisar booking por ID específica
    Consultar Booking por ID

Deletar booking
    Gerar Token
    Deletar Booking