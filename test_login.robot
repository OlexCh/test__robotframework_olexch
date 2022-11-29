*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description # automated tests for scout website

*** Variables ***
${LOGIN URL}            https://scouts-test.futbolkolektyw.pl/en
${BROWSER}              Chrome
${SIGNINBUTTON}         xpath=//*[(text()= 'Sign in')]
${EMAILINPUT}           xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}             xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${ADDPLAYERBUTTON}      xpath=//*[(text()='Add player')]
${ADDPLAYERTITLE}       xpath=//span[contains(text(),'Add player')]
${NAMEINPUT}            xpath=//*[(@name='name')]
${SURNAMEINPUT}         xpath=//*[@name='surname']
${AGEINPUT}             xpath=//*[@name='age']
${MAINPOSITION}         xpath=//*[@name='mainPosition']
${SUBMITBUTTON}         xpath=//*[text()='Submit']

*** Test Cases ***
Login to the system
	Open login page
	Type in email
	Type in password
	Click on the Submit button
	Assert dashboard
	[Teardown]  Close Browser

Add_new_player
	Open login page
	Type in email
	Type in password
	Click on the Signin button
	Assert dashboard
	Click on the Add player button
	Assert addplayer
	Type in name
	Type in surname
	Type in age
	Type in mainposition
	Click on the Submit button
	[Teardown]  Close Browser

*** Keywords ***
Open login page
	Open Browser    ${LOGIN URL}   ${BROWSER}
	Title Should Be 	Scouts panel - sign in
Type in email
	Input Text  ${EMAILINPUT}   user07@getnada.com
Type in password
	Input Text  ${PASSWORDINPUT}    Test-1234
Click on the Signin button
	Click Element   xpath = //*[(text()= 'Sign in')]
Click on the Add player button
    Click Element   xpath = //*[(text()='Add player')]
Assert dashboard
	wait until element is visible   ${PAGELOGO}
	title should be     Scouts panel
	Capture Page Screenshot     alert.png
Assert addplayer
	wait until element is visible   ${ADDPLAYERTITLE}
	title should be    Add player
Type in name
	Input Text  ${NAMEINPUT}   Kilian
Type in surname
	Input Text  ${SURNAMEINPUT}   Mbappe
Type in age
	Input Text  ${AGEINPUT}   20121998
Type in mainposition
	Input Text  ${MAINPOSITION}   forward
Click on the Submit button
	Click Element   xpath=//*[text()='Submit']
