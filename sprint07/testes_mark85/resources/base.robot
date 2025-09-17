*** Settings ***

Library    libs/database.py
Library    Browser
Library    FakerLibrary

*** Variables ***


*** Keywords ***


Acessar URL
    [Arguments]     ${url}=
    New Browser     browser=chromium    headless=false

    New Page        http://localhost:3000/${url}