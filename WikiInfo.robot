*** Settings ***
Library    RPA.Browser.Playwright
Library     Collections
Library     OperatingSystem
Library     String


*** Tasks ***
Searching Covid in all languages on the Wikipedia Application
    New Browser    chromium     headless=false
    New Page       https://www.wikipedia.org/
    #Fetch all the languages from the dropdown
    @{selectData}=  Get Select Options  xpath=//select[@name='language']
    #search the term in every language
    FOR    ${optionval}    IN    @{selectData}
        ${opt}=     Get From Dictionary    ${optionval}    value
        #Log To Console    ${opt}
        Fill Text   xpath=//*[@id='searchInput']   Covid
        Select Options By    xpath=//select[@name='language']    value  ${opt}
        Click   xpath=//i[@class='sprite svg-search-icon']
        Sleep   1
        #get the html contents and then create a file from it.
        ${htmlPage}=    Get Page Source
        Create File     ${CURDIR}/htmlfiles/${opt}.html     ${htmlPage}
        Go Back
    END
