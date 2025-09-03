*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    FakerLibrary
Library    OperatingSystem

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

Importar JSON estático
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File    ${EXECDIR}/${nome_arquivo}
    ${data}        Evaluate    json.loads('''${arquivo}''')    json
    RETURN         ${data}

Criar DataMass dinâmico válido de Booking
    ${firstname}            First Name
    ${lastname}             Last Name
    ${totalprice}           Random Number
    ${additionalneeds}      Word
    ${bookingdates}         Create Dictionary    checkin=2025-09-01    checkout=2025-09-10
    ${payload}              Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=${totalprice}
                                          ...    depositpaid=${True}    bookingdates=${bookingdates}   additionalneeds=${additionalneeds}
    ${tipoteste}  Set Variable    dinamicovalido
    RETURN        ${payload}    ${tipoteste}

Criar DataMass estático válido de Booking
    ${json}       Importar JSON estático    booking_datamass.json
    ${payload}    Set Variable    ${json["user_valido"]}
    ${tipoteste}  Set Variable    estaticovalido
    RETURN        ${payload}    ${tipoteste}

Criar DataMass estático inválido de Booking
    ${json}       Importar JSON estático    booking_datamass.json
    ${payload}    Set Variable    ${json["user_invalido"]}
    ${tipoteste}  Set Variable    estaticoinvalido
    RETURN        ${payload}    ${tipoteste}

Criar Booking
    [Arguments]        ${payload}    ${tipoteste}
    ${headers}=        Create Dictionary    Content-Type=application/json    Accept=application/json
    ${response}=       POST On Session    restful    /booking    json=${payload}    headers=${headers}    expected_status=any
    
    Run Keyword And Continue On Failure    Run Keyword If    '${tipoteste}' == 'estaticoinvalido'
    ...    Should Be Equal As Integers    ${response.status_code}    400
    ...    ELSE    Should Be Equal As Integers    ${response.status_code}    200
    
    Run Keyword If    '${tipoteste}' != 'estaticoinvalido' and ${response.status_code} == 200
    ...    Set Suite Variable    ${BOOKINGID}    ${response.json()}[bookingid]

*** Test Cases ***
Checkar se a API está funcionando
    [Tags]    GET
    Create Session    restful    ${BASE_URL}
    ${response}=    GET On Session    restful    /ping
    Should Be Equal As Integers    ${response.status_code}    201

Criar token de acesso
    [Tags]    POST
    Gerar Token
    Log    Token gerado: ${TOKEN}

Criar booking dinâmico válido
    [Tags]            POST
    ${payload}    ${tipoteste}=         Criar DataMass dinâmico válido de Booking
    Criar Booking     ${payload}    ${tipoteste}

Criar booking estático válido
    [Tags]            POST
    ${payload}    ${tipoteste}=         Criar DataMass estático válido de Booking
    Criar Booking      ${payload}    ${tipoteste}

Criar booking estático inválido
    [Tags]            POST
    ${payload}    ${tipoteste}=        Criar DataMass estático inválido de Booking
    Criar Booking      ${payload}    ${tipoteste}