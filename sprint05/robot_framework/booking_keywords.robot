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
