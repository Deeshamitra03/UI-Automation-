*** Variables ***

${FILTER_AVAILABILITY}      xpath=//span[contains(text(),'All Filters')]

${FILTER_OPTION_TOMORROW}   xpath=(//span[@data-qa-id='availability_text' and contains(text(), 'Today')])[1]

${FIRST_DOCTOR_PROFILE}     xpath=(.//div[contains(@class,'listing-doctor-card')])[1]//a >> nth=0

${RESET_FILTERS}    xpath=(//button[@data-qa-id='Reset_Filters'])