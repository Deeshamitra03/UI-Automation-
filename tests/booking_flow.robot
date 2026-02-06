*** Settings ***
Resource    ../resources/keywords/booking_keywords.robot

*** Test Cases ***
Verify Doctor Appointment Booking Flow
    Open Doctors Listing Page
    Apply Filter "Available Tomorrow"
    Select First Doctor
    Select Next Available Slot
    Fill Booking Details    name=TestUser    phone=9999999999