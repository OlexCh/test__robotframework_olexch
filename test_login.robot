*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description # automated tests for scout website

*** Variables ***
${LOGIN URL}            https://scouts.futbolkolektyw.pl/en/
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
${EXCLUBINPUT}          xpath=//*[@name='exClub']
${SUBMITBUTTON}         xpath=//*[text()='Submit']
${REMINDPASSWORD}       xpath=//h5[(text()= 'Remind password')]
${SENDPASSWORD}         xpath=//*[(@name='email')]
${MESSAGESHOWN}         xpath=//div[contains(text(),'Message sent successfully.')]
${EMPTYINPUTMESSAGE}    xpath=//span[text()= 'Please provide your username or your e-mail.']
${INVALIDPASSWORD}      xpath=//span[text()= 'Identifier or password invalid.']
${PLAYERSBUTTON}        xpath=//span[text()='Players']
${MAINPAGEBUTTON}       xpath=//span[text()='Main page']
${POLSKIBUTTON}		    xpath=//span[text()='Polski']
${CHANGEPOLSKI}		    xpath=//span[text()='Strona główna']
${TITLETEXT}	        xpath=//h6[contains(text(),'PANEL SKAUTINGOWY')]
${ENGLISHBUTTON}        xpath=//span[contains(text(),'English')]
${LOGOUTBUTTON}         xpath=//span[contains(text(),'Logout')]
${LEFTLEG}			    xpath=//*[@id='menu-leg']/div[3]/ul/li[2]
${RIGHTLEG}			    xpath=//*[@id='menu-leg']/div[3]/ul/li[1]
${SELECTLEGFIELD} 	    xpath=//*[@id='menu-leg']//ul[1]
${SELECTLEG}		    xpath=//*[@id='mui-component-select-leg']

*** Test Cases ***
Login to the system
	Open login page
	Type in email
	Type in password
	Click on the Signin button
	Assert dashboard
	[Teardown]  Close Browser

Password recovery
	Open login page
	Type in email
	Type invalid password
	Click on the Signin button
	Assert invalidpassword
	Click on the Remind password button
	Assert Remind password
	Type in sendpassword
	Click on the Send button
	Assert messageshown
	[Teardown]  Close Browser

Empty login fields
	Open login page
	Click on the Signin button
	Assert emptyinput
	[Teardown]  Close Browser

Navigation bar
    Open login page
	Type in email
	Type in password
	Click on the Signin button
	Assert dashboard
	Click on the Players button
	Assert titletext
	Click on the Main page button
	Assert dashboard
	Click on the Polski button
    Assert Polski
    Click on the English button
    Click on the Logout button
    [Teardown]  Close Browser

Add_new_player
	Open login page
	Type in email
	Type in password
	Click on the Signin button
	Assert dashboard
	Click on the Add player button
    Click Select the Leg
    Set the Right leg
	Assert addplayer
	Type in name
	Type in surname
	Type in age
	Type in mainposition
	Type in exclub
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
	title should be     PANEL SKAUTINGOWY
	Capture Page Screenshot     alert.png
Assert addplayer
	wait until element is visible   ${ADDPLAYERTITLE}
	title should be    Add player
Type in name
	Input Text  ${NAMEINPUT}   Ronaldinho
Type in surname
	Input Text  ${SURNAMEINPUT}   Guacho
Type in age
	Input Text  ${AGEINPUT}   21031980
Type in mainposition
	Input Text  ${MAINPOSITION}   forward
Type in exclub
	Input Text  ${EXCLUBINPUT}   Barcelona
Click on the Submit button
	Click Element   xpath=//*[text()='Submit']
Click on the Remind password button
    Click Element   xpath=//a[(text()= 'Remind password')]
Assert Remind password
	wait until element is visible   ${REMINDPASSWORD}
	title should be    Remind password
Type in sendpassword
    Input Text  ${SENDPASSWORD}   test
Click on the Send button
    Click Element   xpath=//span[text()= 'Send']
Assert messageshown
	wait until element is visible   ${MESSAGESHOWN}
	element text should be		${MESSAGESHOWN}    Message sent successfully.
Assert emptyinput
    wait until element is visible   ${EMPTYINPUTMESSAGE}
	element text should be		${EMPTYINPUTMESSAGE}    Please provide your username or your e-mail.
Type invalid password
	Input Text  ${PASSWORDINPUT}    gfhtrs
Assert invalidpassword
    wait until element is visible   ${INVALIDPASSWORD}
	element text should be		${INVALIDPASSWORD}    Identifier or password invalid.
Click on the Players button
    Click Element   ${PLAYERSBUTTON}
Click on the Main page button
    Click Element   ${MAINPAGEBUTTON}
Click on the Polski button
    Click Element   ${POLSKIBUTTON}
Assert Polski
    wait until element is visible   ${CHANGEPOLSKI}
	element text should be		${CHANGEPOLSKI}    Strona główna
Assert titletext
    wait until element is visible   ${TITLETEXT}
	element text should be		${TITLETEXT}    PANEL SKAUTINGOWY
Click on the English button
    Click Element   ${ENGLISHBUTTON}
Click on the Logout button
    Click Element   ${LOGOUTBUTTON}
Click Select the Leg
	Click Element   ${SELECTLEG}
	wait until element is visible   ${SELECTLEGFIELD}
Set the Right leg
    Click Element   ${RIGHTLEG}
