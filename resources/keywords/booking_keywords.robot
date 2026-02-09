*** Settings ***
Library     Browser
Resource    ../../config/config.robot
Resource    ../locators/doctors_list_page.robot
Resource    ../locators/doctor_profile_page.robot
Resource    ../locators/booking_page.robot

*** Keywords ***
Open Doctors Listing Page
    [Documentation]    Launches the browser.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${BASE_URL}
    Wait For Load State    domcontentloaded

Apply Filter "Available Tomorrow"
    [Documentation]    Selects the filter
    Wait For Elements State    ${FILTER_AVAILABILITY}    visible    timeout=3s
    Click   ${FILTER_AVAILABILITY}
    Wait For Elements State    ${FILTER_OPTION_TOMORROW}    visible    timeout=30s
    Click    ${FILTER_OPTION_TOMORROW}
    #Sleep   10s
    Wait For Elements State    ${RESET_FILTERS}    visible    timeout=10s

Select First Doctor
    [Documentation]    Clicks doctor profile and handles the new tab safely.
    Wait For Elements State    ${FIRST_DOCTOR_PROFILE}    visible
    Click    ${FIRST_DOCTOR_PROFILE}
    Switch Page    NEW
    Wait For Load State    domcontentloaded

Select Next Available Slot
    [Documentation]    Uses JavaScript to FORCE the click on the slot.
    Wait For Elements State    ${SLOT_SECTION}    visible    timeout=${TIMEOUT}
    Scroll To Element          ${SLOT_SECTION}
    ${is_next_btn_visible}=    Run Keyword And Return Status    Wait For Elements State    ${BTN_NEXT_AVAILABILITY}    visible    timeout=2s
    Run Keyword If    ${is_next_btn_visible}    Click    ${BTN_NEXT_AVAILABILITY}
    Wait For Elements State    ${TIME_SLOT}    visible    timeout=${TIMEOUT}
    #Evaluate Javascript    ${TIME_SLOT}    element => element.click()
    Click   ${TIME_SLOT}

Fill Booking Details
    [Arguments]    ${name}    ${phone}
    [Documentation]    Verifies we reached the Login Gate.
    Wait For Elements State    ${HEADER_LOGIN}    visible    timeout=${TIMEOUT}
    Type Text    ${INPUT_MOBILE_LOGIN}    ${phone}
    Click    ${BTN_CONTINUE}
    Log    "Success: Reached Login Page."