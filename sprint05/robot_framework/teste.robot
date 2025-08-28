*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary

*** Variables ***
${baseUrl}    https://restful-booker.herokuapp.com
${username}   admin
${password}   password123
${id}         1

*** Keywords ***

*** Test Cases ***
#Sondagem dos test cases para desenvolvimento posterior
Checkar se a API está funcionando
    GET request do Ping
    Response == 200 OK
    
Criar token de acesso
    POST request do Auth
    Dados válidos
    Response == 200 OK

Pesquisar booking por ID específica
    GET request do Booking
    ID valida
    Response == 200 OK

Criar booking
    POST request do Booking
    Dados válidos
    Response == 200 OK

Deletar booking
    DELETE request do Booking
    ID válida
    Response == 200 OK

