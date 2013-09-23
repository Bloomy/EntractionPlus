#NoEnv
#SingleInstance, Force
#MaxHotkeysPerInterval 200
#HotkeyModifierTimeout 100
#HotkeyInterval, 1000

;----------------------------------------------------------------------------------------------------------------------------------------------------
; ENTRACTION PLUS v0.7
; Author: Orlando Aleman (me@orlandoaleman.com)
; WebSite: http://orlandoaleman.com/software/entraction-plus/
;----------------------------------------------------------------------------------------------------------------------------------------------------
; This software is a fork of EntHelper v0.3R7 by 2+2 forums @ OSRichard
; Original source code from http://forumserver.twoplustwo.com/168/free-software/new-donationware-software-entraction-helper-script-583672/index7.html
;----------------------------------------------------------------------------------------------------------------------------------------------------
; If you like this script please consider donating some money, using one of the following options:
;    - Moneybookers transfer to me: orlandologs@gmail.com
;-----------------------------------------------------------------------------------------------------------------------------------------------------

settingsFile := "EntractionPlus.ini"
readIniFile()

mouseClick := Left

;------------- HIDDEN SETTINGS
; percentage of the window width and height for center of buttons
foldX := 0.48
foldY := 0.95

checkX := 0.62
checkY := 0.95

raiseX := 0.77
raiseY := 0.95

potX := 0.71
potY := 0.86

allinX := 0.79
allinY := 0.86

betBoxX := 0.47
betBoxY := 0.82

rebuyX := 0.50
rebuyY := 0.15

sitOutX := 0.88
sitOutY := 0.94

noBlindsX := 0.88
noBlindsY := 0.97

sitInX := 0.6
sitInY := 0.9

checkForFreeX := 0.58
checkForFreeY := 0.74

maxBuyInX := 0.31
maxBuyInY := 0.54

buyInX := 0.35
buyInY := 0.64

confirmBuyInX := 0.7
confirmBuyInY := 0.89

rebuyOkX := 0.49
rebuyOkY := 0.74

confirmAllInX := 0.41
confirmAllInY := 0.73

confirmLeaveX := 0.45
confirmLeaveY := 0.73

confirmWaiting1X := 0.5
confirmWaiting1Y := 0.86

confirmWaiting2X := 0.41
confirmWaiting2Y := 0.86


;------------- LANGUAGE SETTINGS
if(lobbyLang = "es") {
    ; Window titles (spanish)
    scriptSettingsTitle := "Entraction Plus - Settings"
    closeRebuyWindowTitle := "Recompra\sautom\x{E1}tica\sactivada" ; RegExpr
    confirmWaitingListWindowTitle := "Lista\sde\sespera"
    ;confirmLargeAllInWindowTitle := "Confirmar\sapuesta"
    confirmLargeAllInWindowTitle := "aaabbbccc" ; esta confirmacion la realiza en la traduccion espa�ola la confirmacion de apuesta grande, ya que tienen el mismo titulo
    confirmLargeRaiseWindowTitle := "Confirmar\sapuesta"
    confirmLeaveTableWindowTitle := "Confirmar\ssalida"
    rebuyWindowTitle := "^$"
    checkForFreeWindowTitle := "Confirmar\sretirada"
    lobbyTitle := "\w[\s\w]*\s-\sMen\x{FA}\sprincipal\s\[conectado\]" ; Expresion regular
    tableTitle := "\w+[\s\w+]*\s\x{28}.*\x{29}\s\s\x{5B}Conexi\x{F3}n\x{3a}\s[\s\w]+\x{5d}" ; Expresion regular
    floatDot := ","
}
else {
    ; Window titles (english)
    scriptSettingsTitle := "Entraction Plus - Settings"
    closeRebuyWindowTitle := "Auto\sRebuy\sturned\son"
    confirmWaitingListWindowTitle := "Waiting\sList"
    confirmLargeAllInWindowTitle := "Confirm\sLarge\sAll-In\sRaise"
    confirmLargeRaiseWindowTitle := "Confirm\sLarge\sRaise"
    confirmLeaveTableWindowTitle := "Confirm\sleave"
    rebuyWindowTitle := "^$"
    checkForFreeWindowTitle := "Confirm\sfold"
    lobbyTitle := "\w[\s\w]*\s-\sLobby\s\[connected\]" ; RegExpr
    tableTitle := "\w+[\s\w+]*\s\x{28}.*\x{29}\s\s\x{5B}Connection\x{3a}\s[\s\w]+\x{5d}" ; RegExpr
    floatDot := "."
}

; ROUTINE (DONT TOUCH!)

Menu, Tray, NoStandard
Menu, Tray, NoStandard
Menu, Tray, NoStandard
Menu, Tray, Add, Settings, Settings
Menu, Tray, Default, Settings
;Menu, Tray, Add, Edit Script, Edit
Menu, Tray, Add, Pause script, Pause
Menu, Tray, Add, Suspend hotkeys, Suspend
Menu, Tray, Add, Reload, Reload
Menu, Tray, Add, About, About
Menu, Tray, Add, Exit, Close


SendMode Input
SetTitleMatchMode RegEx
SetBatchLines -1


if (AlwaysCheckForFree = 1)
    SetTimer, checkForFree, 500

if (autoBuyInMax = 1)
    SetTimer, buyInForMax, 500
    
if (autoConfirmRebuy = 1)
    SetTimer, confirmCloseRebuy, 500
    
if (autoConfirmAllIn = 1)
    SetTimer, confirmLargeAllIn, 500

if (confirmLargeRaise = 1)
    SetTimer, confirmLargeRaise, 500
    
if (autoConfirmLeave = 1)
    SetTimer, confirmLeaveTable, 500
     
if (autoConfirmWaitingList = 1)
    SetTimer, confirmWaitingList, 500
    
if (autoActivateTableUnderMouse = 1)
    SetTimer, activateTableUnderMouse, 500

defineHotKeys()

return


About:
    Msgbox,, About,
    (
ENTRACTION PLUS v0.7
Author: Orlando Aleman (me@orlandoaleman.com)
WebSite: http://orlandoaleman.com/software/entraction-plus/

If you like this script please consider donating some money, using one of the following options:
- Moneybookers transfer: orlandologs@gmail.com
	)
return


; GUI
Settings: 
    If WinExist(scriptSettingsTitle) 
       return

    Gui, Add, Tab, x-4 y0 w500 h750 , General|Rebuys|More|Options
    
    Gui, Add, Text, x5 y32 w100 h20 , Fold
    Gui, Add, Edit, x100 y30 w80 h20 vFoldHK, %FoldHK%
    Gui, Add, Text, x5 y52 w100 h20 , Check/Call
    Gui, Add, Edit, x100 y50 w80 h20 vCheckCallHK, %CheckCallHK%
    Gui, Add, Text, x5 y72 w100 h20 , Bet Pot
    Gui, Add, Edit, x100 y70 w80 h20 vBetFullPotHK, %BetFullPotHK%
    Gui, Add, CheckBox, x195 y70 w50 h20 Checked%InstantFullPot% vInstantFullPot, Auto 
    Gui, Add, Text, x5 y92 w100 h20 , Raise
    Gui, Add, Edit, x100 y90 w80 h20 vRaiseHK, %RaiseHK%
    Gui, Add, Text, x5 y112 w100 h20 , All In
    Gui, Add, Edit, x100 y110 w80 h20 vBetAllInHK, %BetAllInHK%
    Gui, Add, CheckBox, x195 y110 w50 h20 Checked%InstantAllIn% vInstantAllIn, Auto

    Gui, Add, Text, x5 y152 w20 h20 , Bet
    Gui, Add, Edit, x33 y150 w25 h20 vpercentage1, %percentage1%
    Gui, Add, Text, x62 y152 w40 h20 , `% Pot
    Gui, Add, CheckBox, x195 y150 w50 h20 Checked%InstantPotPercentage1% vInstantPotPercentage1, Auto
    Gui, Add, Edit, x100 y150 w80 h20 vBetPotPercentage1HK, %BetPotPercentage1HK%
    Gui, Add, Text, x5 y172 w20 h20 , Bet
    Gui, Add, Edit, x33 y170 w25 h20 vpercentage2, %percentage2%
    Gui, Add, Text, x62 y172 w40 h20 , `% Pot
    Gui, Add, CheckBox, x195 y170 w50 h20 Checked%InstantPotPercentage2% vInstantPotPercentage2, Auto
    Gui, Add, Edit, x100 y170 w80 h20 vBetPotPercentage2HK, %BetPotPercentage2HK%
    Gui, Add, Text, x5 y192 w20 h20 , Bet
    Gui, Add, Edit, x33 y190 w25 h20 vpercentage3, %percentage3%
    Gui, Add, Text, x62 y192 w40 h20 , `% Pot
    Gui, Add, CheckBox, x195 y190 w50 h20 Checked%InstantPotPercentage3% vInstantPotPercentage3, Auto
    Gui, Add, Edit, x100 y190 w80 h20 vBetPotPercentage3HK, %BetPotPercentage3HK%
    Gui, Add, Text, x5 y212 w20 h20 , Bet
    Gui, Add, Edit, x33 y210 w25 h20 vpercentage4, %percentage4%
    Gui, Add, Text, x62 y212 w40 h20 , `% Pot
    Gui, Add, CheckBox, x195 y210 w50 h20 Checked%InstantPotPercentage4% vInstantPotPercentage4, Auto
    Gui, Add, Edit, x100 y210 w80 h20 vBetPotPercentage4HK, %BetPotPercentage4HK%

    Gui, Add, Text, x5 y252 w20 h20 , Bet
    Gui, Add, Edit, x33 y250 w25 h20 vBBAmount1, %BBAmount1%
    Gui, Add, Text, x62 y252 w40 h20 , BBs
    Gui, Add, CheckBox, x195 y250 w50 h20 Checked%InstantBBAmount1% vInstantBBAmount1, Auto
    Gui, Add, Edit, x100 y250 w80 h20 vBetBBAmount1HK, %BetBBAmount1HK%
    Gui, Add, Text, x5 y272 w20 h20 , Bet
    Gui, Add, Edit, x33 y270 w25 h20 vBBAmount2, %BBAmount2%
    Gui, Add, Text, x62 y272 w40 h20 , BBs
    Gui, Add, CheckBox, x195 y270 w50 h20 Checked%InstantBBAmount2% vInstantBBAmount2, Auto
    Gui, Add, Edit, x100 y270 w80 h20 vBetBBAmount2HK, %BetBBAmount2HK%
    Gui, Add, Text, x5 y292 w20 h20 , Bet
    Gui, Add, Edit, x33 y290 w25 h20 vBBAmount3, %BBAmount3%
    Gui, Add, Text, x62 y292 w40 h20 , BBs
    Gui, Add, CheckBox, x195 y290 w50 h20 Checked%InstantBBAmount3% vInstantBBAmount3, Auto
    Gui, Add, Edit, x100 y290 w80 h20 vBetBBAmount3HK, %BetBBAmount3HK%
    Gui, Add, Text, x5 y312 w20 h20 , Bet
    Gui, Add, Edit, x33 y310 w25 h20 vBBAmount4, %BBAmount4%
    Gui, Add, Text, x62 y312 w40 h20 , BBs
    Gui, Add, CheckBox, x195 y310 w50 h20 Checked%InstantBBAmount4% vInstantBBAmount4, Auto
    Gui, Add, Edit, x100 y310 w80 h20 vBetBBAmount4HK, %BetBBAmount4HK%
    
    Gui, Add, Text, x5 y352 w100 h20 , Add 1 BB
    Gui, Add, Edit, x100 y352 w80 h20 vAdd1BBHK, %Add1BBHK%
    Gui, Add, Text, x5 y372 w100 h20 , Subtract 1 BB
    Gui, Add, Edit, x100 y370 w80 h20 vSubtract1BBHK, %Subtract1BBHK%
    Gui, Add, Text, x5 y402 w100 h20 , Add 1 SB
    Gui, Add, Edit, x100 y400 w80 h20 vAdd1SBHK, %Add1SBHK%
    Gui, Add, Text, x5 y422 w100 h20 , Subtract1 SB
    Gui, Add, Edit, x100 y420 w80 h20 vSubtract1SBHK, %Subtract1SBHK%
    
    Gui, Add, Button, x90 y460 w50 h20 gSave, Save 
    Gui, Add, Button, x150 y460 w50 h20 gCancel, Cancel


    Gui, Tab, Rebuys
    
    Gui, Add, Text, x5 y32 w100 h20 , Open Rebuy Box
    Gui, Add, Edit, x100 y30 w80 h20 vbuyBoxHK, %OpenRebuyBoxHK%    


    Gui, Add, Text, x5 y72 w20 h20 , Buy
    Gui, Add, Edit, x33 y70 w25 h20 vBuyChipsAmount1, %BuyChipsAmount1%
    Gui, Add, Text, x62 y72 w20 h20 , BBs
    Gui, Add, Edit, x100 y70 w80 h20 vBuyChipsHK1, %BuyChipsHK1%
    Gui, Add, Text, x185 y72 w30 h20, (auto)
    
    Gui, Add, Text, x5 y92 w20 h20 , Buy
    Gui, Add, Edit, x33 y90 w25 h20 vBuyChipsAmount2, %BuyChipsAmount2%
    Gui, Add, Text, x62 y92 w100 h20 , BBs
    Gui, Add, Edit, x100 y90 w80 h20 vBuyChipsHK2, %BuyChipsHK2%
    Gui, Add, Text, x185 y92 w30 h20, (auto)

    Gui, Add, Text, x5 y112 w20 h20 , Buy
    Gui, Add, Edit, x33 y110 w25 h20 vBuyChipsAmount3, %BuyChipsAmount3%
    Gui, Add, Text, x62 y112 w100 h20 , BBs
    Gui, Add, Edit, x100 y110 w80 h20 vBuyChipsHK3, %BuyChipsHK3%
    Gui, Add, Text, x185 y112 w30 h20, (auto)
    
    Gui, Add, Text, x5 y132 w20 h20 , Buy
    Gui, Add, Edit, x33 y130 w25 h20 vBuyChipsAmount4, %BuyChipsAmount4%
    Gui, Add, Text, x62 y132 w100 h20 , BBs
    Gui, Add, Edit, x100 y130 w80 h20 vBuyChipsHK4, %BuyChipsHK4%
    Gui, Add, Text, x185 y132 w30 h20, (auto)    
    
    Gui, Add, Text, x5 y152 w20 h20 , Buy
    Gui, Add, Edit, x33 y150 w25 h20 vBuyChipsAmount5, %BuyChipsAmount5%
    Gui, Add, Text, x62 y152 w100 h20 , BBs
    Gui, Add, Edit, x100 y150 w80 h20 vBuyChipsHK5, %BuyChipsHK5% 
    Gui, Add, Text, x185 y152 w30 h20, (auto)    
    
    Gui, Add, Text, x5 y172 w20 h20 , Buy
    Gui, Add, Edit, x33 y170 w25 h20 vBuyChipsAmount6, %BuyChipsAmount6%
    Gui, Add, Text, x62 y172 w100 h20 , BBs
    Gui, Add, Edit, x100 y170 w80 h20 vBuyChipsHK6, %BuyChipsHK6%
    Gui, Add, Text, x185 y172 w30 h20, (auto)    
    
    Gui, Add, Text, x5 y192 w20 h20 , Buy
    Gui, Add, Edit, x33 y190 w25 h20 vBuyChipsAmount7, %BuyChipsAmount7%
    Gui, Add, Text, x62 y192 w100 h20 , BBs
    Gui, Add, Edit, x100 y190 w80 h20 vBuyChipsHK7, %BuyChipsHK7%
    Gui, Add, Text, x185 y192 w30 h20, (auto)

    Gui, Add, Text, x5 y212 w20 h20 , Buy
    Gui, Add, Edit, x33 y210 w25 h20 vBuyChipsAmount8, %BuyChipsAmount8%
    Gui, Add, Text, x62 y212 w100 h20 , BBs
    Gui, Add, Edit, x100 y210 w80 h20 vBuyChipsHK8, %BuyChipsHK8%
    Gui, Add, Text, x185 y212 w30 h20, (auto)    
    
    Gui, Add, Text, x5 y232 w20 h20 , Buy
    Gui, Add, Edit, x33 y230 w25 h20 vBuyChipsAmount9, %BuyChipsAmount9%
    Gui, Add, Text, x62 y232 w100 h20 , BBs
    Gui, Add, Edit, x100 y230 w80 h20 vBuyChipsHK9, %BuyChipsHK9%    
    Gui, Add, Text, x185 y232 w30 h20, (auto)
    
    Gui, Add, Text, x5 y252 w20 h20 , Buy
    Gui, Add, Edit, x33 y250 w25 h20 vBuyChipsAmount10, %BuyChipsAmount10%
    Gui, Add, Text, x62 y252 w100 h20 , BBs
    Gui, Add, Edit, x100 y250 w80 h20 vBuyChipsHK10, %BuyChipsHK10%
    Gui, Add, Text, x185 y252 w30 h20, (auto)
    
    
    Gui, Add, Text, x5 y292 w20 h20, Buy 
    Gui, Add, Edit, x33 y290 w25 h20 vBuyChipsFromCashierAmount1, %BuyChipsFromCashierAmount1% 
    Gui, Add, Text, x62 y292 w100 h20, EUR
    Gui, Add, Edit, x100 y290 w80 h20 vBuyChipsFromCashierHK1, %BuyChipsFromCashierHK1%
    Gui, Add, Text, x185 y292 w100 h20, (in rebuy box)

    Gui, Add, Text, x5 y312 w20 h20, Buy 
    Gui, Add, Edit, x33 y310 w25 h20 vBuyChipsFromCashierAmount2, %BuyChipsFromCashierAmount2% 
    Gui, Add, Text, x62 y312 w100 h20, EUR
    Gui, Add, Edit, x100 y310 w80 h20 vBuyChipsFromCashierHK2, %BuyChipsFromCashierHK2%
    Gui, Add, Text, x185 y312 w100 h20, (in rebuy box)
    
    Gui, Add, Text, x5 y332 w20 h20, Buy 
    Gui, Add, Edit, x33 y330 w25 h20 vBuyChipsFromCashierAmount3, %BuyChipsFromCashierAmount3% 
    Gui, Add, Text, x62 y332 w100 h20, EUR
    Gui, Add, Edit, x100 y330 w80 h20 vBuyChipsFromCashierHK3, %BuyChipsFromCashierHK3%
    Gui, Add, Text, x185 y332 w100 h20, (in rebuy box)    


    Gui, Add, Text, x5 y372 w100 h20 , Rebuy to Max
    Gui, Add, Edit, x100 y370 w80 h20 vRebuyToMaxHK, %RebuyToMaxHK%

    Gui, Add, Button, x90 y460 w50 h20 gSave, Save 
    Gui, Add, Button, x150 y460 w50 h20 gCancel, Cancell
    

    Gui, Tab, More
    
    Gui, Font, w700,
    Gui, Add, Text, x5 y30 w100 h20, Miscellaneous:
    Gui, Font, norm    
    Gui, Add, Text, x5 y52 w100 h20 , Show Lobby
    Gui, Add, Edit, x100 y50 w80 h20 vShowLobbyHK, %ShowLobbyHK%
    Gui, Add, Text, x5 y72 w100 h20 , Sit In
    Gui, Add, Edit, x100 y70 w80 h20 vSitInHK, %SitInHK%
    Gui, Add, Text, x5 y92 w100 h20 , Sit Out
    Gui, Add, Edit, x100 y90 w80 h20 vSitOutHK, %SitOutHK%
    Gui, Add, Text, x5 y112 w100 h20 , No More Blinds
    Gui, Add, Edit, x100 y110 w80 h20 vNoMoreBlindsHK, %NoMoreBlindsHK%

    Gui, Font, w700,
    Gui, Add, Text, x5 y150 w100 h20, Script related:
    Gui, Font, norm
    Gui, Add, Text, x5 y172 w100 h20, Pause Script
    Gui, Add, Edit, x100 y170 w80 h20 vPauseHK, %PauseHK%
    Gui, Add, Text, x5 y192 w100 h20, Suspend HotKeys
    Gui, Add, Edit, x100 y190 w80 h20 vSuspendHK, %SuspendHK%
    Gui, Add, Text, x5 y212 w100 h20, Exit Script
    Gui, Add, Edit, x100 y210 w80 h20 vExitApplicationHK, %ExitApplicationHK%

    
    Gui, Add, Button, x90 y460 w50 h20 gSave, Save 
    Gui, Add, Button, x150 y460 w50 h20 gCancel, Cancel
    
    Gui, Tab, Options
    Gui, Font, w700,
    Gui, Add, Text, x5 y30 w100 h20, Behaviour:
    Gui, Font, norm    
    Gui, Add, CheckBox, x5 y50 w230 h20 Checked%actOnActiveTable% vactOnActiveTable, Act on active table (or table under mouse)
    Gui, Add, CheckBox, x5 y70 w200 h20 Checked%AlwaysCheckForFree% vAlwaysCheckForFree, Always check for free
    Gui, Add, CheckBox, x5 y90 w200 h20 Checked%autoBuyInMax% vautoBuyInMax, Auto buy in for table maximum
    Gui, Add, CheckBox, x5 y110 w200 h20 Checked%autoConfirmRebuy% vautoConfirmRebuy, Auto confirm rebuy pop-up
    Gui, Add, CheckBox, x5 y130 w200 h20 Checked%confirmLargeRaise% vconfirmLargeRaise, Auto confirm large raise
    Gui, Add, CheckBox, x5 y150 w200 h20 Checked%autoConfirmAllIn% vautoConfirmAllIn, Auto confirm large all-in
    Gui, Add, CheckBox, x5 y170 w200 h20 Checked%autoConfirmLeave% vautoConfirmLeave, Auto confirm leave table pop-up
    Gui, Add, CheckBox, x5 y190 w200 h20 Checked%autoConfirmWaitingList% vautoConfirmWaitingList, Auto confirm waiting list pop-ups
    Gui, Add, CheckBox, x5 y210 w250 h20 Checked%autoActivateTableUnderMouse% vautoActivateTableUnderMouse, Bring to top the table which is under the mouse
    
    Gui, Font, w700,
    Gui, Add, Text, x5 y240 w100 h20, Localization:
    Gui, Font, norm
    alt := lobbyLang = "es" ? 2 : 1
    Gui, Add, Text, x5 y260 w100 h20, Lobby language
    Gui, Add, DropDownList, x100 y257 w80 Choose%alt% vlobbyLang, en|es
    
    Gui, Font, w700,
    Gui, Add, Text, x5 y290 w100 h20, Other settings:
    Gui, Font, norm
    Gui, Add, Text, x5 y310 w100 h20, Delay in autorebuy
    Gui, Add, Edit, x100 y308 w80 h20 vBuyChipsDelay, %BuyChipsDelay%
    Gui, Add, Text, x185 y310 w15 h20, ms

    Gui, Add, Button, x90 y460 w50 h20 gSave, Save 
    Gui, Add, Button, x150 y460 w50 h20 gCancel, Cancel
    
    Gui, Show, x100 y50 h490 w290, %scriptSettingsTitle%
return

Save:
    Gui, Submit
    FileDelete, %settingsFile%
    writeIni()
    Reload
return

Cancel:
    Gui, Destroy
return


GuiClose:
    Gui, Destroy
return

Reload:
    Reload
return

Suspend:
    Suspend
return

Pause:
    Pause
return

Edit:
    Edit
return

Close:
    ExitApp
return


;---------------- HOTKEY-ASSIGNED ROUTINRS

SitOut:
    PressButton(getTableID(), sitOutX, sitOutY, SitOutHK)
return

NoMoreBlinds:
    PressButton(getTableID(), noBlindsX, noBlindsY, NoMoreBlindsHK)
return

SitIn:
    PressButton(getTableID(), sitInX, sitInY, SitInHK)
return

Fold:
    pressFoldButton(getTableID(), FoldHK)
return

CheckCall:
    pressCheckButton(getTableID(), CheckCallHK)
return

Raise:
    pressRaiseButton(getTableID(), RaiseHK)
return

BetPotPercentage1:
    bet(getTableID(), percentage1, BetPotPercentage1HK)
    if InstantPotPercentage1
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetPotPercentage2:
    bet(getTableID(), percentage2, BetPotPercentage2HK)
    if InstantPotPercentage2
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetPotPercentage3:
    bet(getTableID(), percentage3, BetPotPercentage3HK)
    if InstantPotPercentage3
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetPotPercentage4:
    bet(getTableID(), percentage4, BetPotPercentage4HK)
    if InstantPotPercentage4
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetBBAmount1:
    betBB(getTableID(), BBAmount1, BetBBAmount1HK)
    if InstantBBAmount1
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetBBAmount2:
    betBB(getTableID(), BBAmount2, BetBBAmount2HK)
    if InstantBBAmount2
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetBBAmount3:
    betBB(getTableID(), BBAmount3, BetBBAmount3HK)
    if InstantBBAmount3
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetBBAmount4:
    betBB(getTableID(), BBAmount4, BetBBAmount4HK)
    if InstantBBAmount4
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetFullPot:
    bet(getTableID(), 100, BetFullPotHK)
    if InstantFullPot
        Send {Enter}
        ;pressRaiseButton(getTableID(), rebuyWindowTitle)
return

BetAllIn:
    pressAllInButton(getTableID(), BetAllInHK)
    if InstantAllIn
        pressRaiseButton(getTableID(), rebuyWindowTitle)
return

Add1BB:
    changeBet(getTableID(), "up", "bb", Add1BBHK)
return

Subtract1BB:
    changeBet(getTableID(), "down", "bb", Subtract1BB)
return

Add1SB:
    changeBet(getTableID(), "up", "sb", Add1SBHK)
return

Subtract1SB:
    changeBet(getTableID(), "down", "sb", Subtract1SBHK)
return

ExitApplication:
    GoSub Close
return

RebuyToMax:
    PressButton(getTableID(), rebuyX, rebuyY, RebuyToMaxHK)

    if (autoBuyInMax = 0) {
       sleep %BuyChipsDelay%
       GoSub buyInForMax
    }
return

buyChips1:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK1)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount1 * bigBlind, 2)
    buyInChips(amount)
return

buyChips2:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK2)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount2 * bigBlind, 2)
    buyInChips(amount)
return

buyChips3:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK3)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount3 * bigBlind, 2)
    buyInChips(amount)
return

buyChips4:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK4)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount4 * bigBlind, 2)
    buyInChips(amount)
return

buyChips5:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK5)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount5 * bigBlind, 2)
    buyInChips(amount)
return

buyChips6:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK6)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount6 * bigBlind, 2)
    buyInChips(amount)
return

buyChips7:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK7)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount7 * bigBlind, 2)
    buyInChips(amount)
return

buyChips8:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK8)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount8 * bigBlind, 2)
    buyInChips(amount)
return

buyChips9:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK9)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount9 * bigBlind, 2)
    buyInChips(amount)
return

buyChips10:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK10)
    sleep %BuyChipsDelay%
    amount := Round(BuyChipsAmount10 * bigBlind, 2)
    buyInChips(amount)
return

OpenRebuyBox:
    ID := getTableID()
    bigBlind := getBlind(ID, "bb")
    PressButton(ID, rebuyX, rebuyY, BuyChipsHK9)
return


buyChipsFromCashier1:
    IfWinExist, ahk_class SunAwtDialog
    {
        WinGetActiveStats, title, width, height, ax, ay
        if (RegExMatch(title,rebuyWindowTitle)) {
            buyInChips(BuyChipsFromCashierAmount1)
        }
    } 
return


buyChipsFromCashier2:
    IfWinExist, ahk_class SunAwtDialog
    {
        WinGetActiveStats, title, width, height, ax, ay
        if (RegExMatch(title, rebuyWindowTitle)) {
            buyInChips(BuyChipsFromCashierAmount2)
        }
    } 
return

buyChipsFromCashier3:
    IfWinExist, ahk_class SunAwtDialog
    {
        WinGetActiveStats, title, width, height, ax, ay
        if (RegExMatch(title,rebuyWindowTitle)) {
            buyInChips(BuyChipsFromCashierAmount3)
        }
    } 
return


buyInForMax:
    IfWinExist, ahk_class SunAwtDialog
    {
        WinGetActiveStats, title, width, height, ax, ay
        if (RegExMatch(title, rebuyWindowTitle)) {
            CoordMode, Mouse, Screen
            MouseGetPos, px, py
            CoordMode, Mouse, Relative
            X := Round(width * maxBuyInX)
            Y := Round(height * maxBuyInY)
            MouseClick,%mouseClickEvent%, X, Y,, 0
            sleep 50
            X := Round(width * confirmBuyInX)
            Y := Round(height * confirmBuyInY)
            MouseClick,%mouseClickEvent%, X, Y,, 0
            CoordMode, Mouse, Screen
            MouseMove, px, py, 0
            CoordMode, Mouse, Relative
        }
    }
return

buyInChips(amount) {
    global
    IfWinExist, ahk_class SunAwtDialog
    {
        WinGetActiveStats, title, width, height, ax, ay
        if (RegExMatch(title, rebuyWindowTitle)) {
            CoordMode, Mouse, Screen
            MouseGetPos, px, py
            CoordMode, Mouse, Relative
            X := Round(width * buyInX)
            Y := Round(height * buyInY)
            MouseClick,%mouseClickEvent%, X, Y,, 0
            sleep 100
            StringReplace, tmp, amount, . , %floatDot%,
            send {HOME}+{END}%tmp%
            sleep 100
            X := Round(width * confirmBuyInX)
            Y := Round(height * confirmBuyInY)
            MouseClick,%mouseClickEvent%, X, Y,, 0
            CoordMode, Mouse, Screen
            MouseMove, px, py, 0
            CoordMode, Mouse, Relative
        }
    }
}


getTableID() {
    global actOnActiveTable
  
    ID := ""
    if (actOnActiveTable = 1) {
        WinGet, ID,, A 
    } else {
        MouseGetPos,,,ID
    }
    
    WinGetTitle, title, ahk_id %id%
    FoundPos := RegExMatch(title, tableTitle)
    IfGreater, FoundPos, 0
    {
      return ID
    }
    
    ID := ""
    return ID
}

bet(ID, percentage, key) {
    if (ID = "") {
        if (key <> "")
            Send {%key%}
        return
    }
        
    Critical, On
    pressPotButton(ID, key)
    betSize := readBetBox(ID)
    newBetSize := Round(betSize * percentage / 100,2)
    writeBetBox(ID, newBetSize)
    Critical, Off
}

betBB(ID, amount, key) {
    if (ID = "") {
        if (key <> "")
            Send {%key%}
        return
    }
        
    Critical, On
    bigBlind := getBlind(ID, "bb")
    newBetSize := Round(bigBlind * amount,2)
    writeBetBox(ID, newBetSize)
}

changeBet(ID, direction, amount, key) {
    global actOnActiveTable
    
    if (ID = "") {
        if (key <> "")
            Send {%key%}
        return
    }
    
    if (actOnActiveTable <> 1)
        WinActivate, ahk_id%ID%
    
    Critical, On
    betSize := readBetBox(ID)
   
    if (amount = "bb") or (amount = "sb")
        raiseSize := getBlind(ID, amount)
        
    if (direction = "up")
        newBetSize := betSize + raiseSize
    else
        newBetSize := betSize - raiseSize
        
    writeBetBox(ID, newBetSize)
    Critical, Off
}

getBlind(ID, amount) {
    global floatDot
    WinGetTitle, title, ahk_id%ID%
    StringSplit, title_array, title, (
    StringSplit, game_type_blinds_connection, title_array%title_array0%, )
    StringSplit, game_type_blinds, game_type_blinds_connection1, %A_Space%

    StringSplit, blinds, game_type_blinds%game_type_blinds0%, /
    
    if (amount = "sb")
        tmp = %blinds1%
    else
        tmp = %blinds2%

    StringReplace, output, tmp, %floatDot%, . ; Nos aseguramos que la cantidad est� en el formato decimal adecuado  
    return output
}

readBetBox(ID) {
    global actOnActiveTable, betBoxX, betBoxY, floatDot

    if (ID = "") {
        return
    }
    
    if (actOnActiveTable <> 1) 
        WinActivate, ahk_id %ID%
    
    WinGetActiveStats, title, width, height, ax, ay
    X := Round(width * betBoxX)
    Y := Round(height * betBoxY)

    CoordMode, Mouse, Screen
    MouseGetPos, px, py
    CoordMode, Mouse, Relative
    MouseClick,%mouseClickEvent%, X, Y,, 0
    sleep 50
    
    oldClipBoard = %clipBoard%
    clipboard =  ; Start off empty to allow ClipWait to detect when the text has arrived.
    Send {HOME}+{END}
    Send ^c
    ClipWait 0.2 ; Wait for the clipboard to contain text.
    If !ErrorLevel 
    text := clipboard
    clipboard = %oldClipBoard%
    CoordMode, Mouse, Screen
    MouseMove, px, py, 0
    CoordMode, Mouse, Relative
    
    StringReplace, text2, text, %floatDot%, . ; Nos aseguramos que la cantidad est� en el formato decimal adecuado
    return text2
}

writeBetBox(ID, betSize) {
    global actOnActiveTable, betBoxX, betBoxY, floatDot
    
    if (ID = "") {
        return
    }
    
    if (actOnActiveTable <> 1) 
        WinActivate, ahk_id %ID%
    
    WinGetActiveStats, title, width, height, ax, ay
    X := Round(width * betBoxX)
    Y := Round(height * betBoxY)

    CoordMode, Mouse, Screen
    MouseGetPos, px, py
    CoordMode, Mouse, Relative
    MouseClick,%mouseClickEvent%, X, Y,, 0
    sleep 50
    
    StringReplace, tmp, betSize, . , %floatDot%
    Send {HOME}+{END}%tmp%
    CoordMode, Mouse, Screen
    MouseMove, px, py, 0
    CoordMode, Mouse, Relative

}


activateTableUnderMouse:
    ; Looking for buy-in dialogs. Deadlock must be prevented
    WinGet, ids, list, ahk_class SunAwtDialog,,
    Loop, %ids%
    {
       WinGetTitle, title, % "ahk_id " ids%A_Index% 
       if(RegExMatch(title, rebuyWindowTitle) OR RegExMatch(title, closeRebuyWindowTitle) OR RegExMatch(title, confirmWaitingListWindowTitle) OR RegExMatch(title, confirmLargeRaiseWindowTitle) OR RegExMatch(title, confirmLeaveTableWindowTitle) OR RegExMatch(title, confirmLargeAllInWindowTitle)) {
          return
       }
    }

    MouseGetPos,,,ID
    WinGetTitle, title, ahk_id %ID%
    
    FoundPos := RegExMatch(title, tableTitle)
    IfGreater, FoundPos, 0
    {
        WinActivate, ahk_id %ID%
    }
return

confirmCloseRebuy:
    IfWinExist, %closeRebuyWindowTitle%
    {
        ; press "Ok" button
        CoordMode, Mouse, Screen
        MouseGetPos, px, py
        CoordMode, Mouse, Relative
        WinGetActiveStats, title, width, height, ax, ay
        X := Round(width * rebuyOkX)
        Y := Round(height * rebuyOkY)
        MouseClick,%mouseClickEvent%, X, Y,, 0
        CoordMode, Mouse, Screen
        MouseMove, px, py, 0
        CoordMode, Mouse, Relative
    }
return

confirmLargeAllIn:
    IfWinExist, %confirmLargeAllInWindowTitle%
    {
        Critical

        ; Looking for buy-in dialogs. Deadlock must be prevented
        WinGet, ids, list, ahk_class SunAwtDialog,,
        Loop, %ids%
        {
           WinGetTitle, title, % "ahk_id " ids%A_Index% 
           if(RegExMatch(title, rebuyWindowTitle) OR RegExMatch(title, closeRebuyWindowTitle) OR RegExMatch(title, confirmWaitingListWindowTitle) OR RegExMatch(title, confirmLargeRaiseWindowTitle) OR RegExMatch(title, confirmLeaveTableWindowTitle)) {
            
              return
           }
        }
        ; press "Ok" button
        CoordMode, Mouse, Screen
        MouseGetPos, px, py
        CoordMode, Mouse, Relative
        WinGetActiveStats, title, width, height, ax, ay
        X := Round(width * confirmAllInX)
        Y := Round(height * confirmAllInY)
        MouseClick,%mouseClickEvent%, X, Y,, 0
        CoordMode, Mouse, Screen
        MouseMove, px, py, 0
        CoordMode, Mouse, Relative
    }
return

confirmLargeRaise:
    IfWinExist, %confirmLargeRaiseWindowTitle%
    {
        Critical

        ; Looking for buy-in dialogs. Deadlock must be prevented
        WinGet, ids, list, ahk_class SunAwtDialog,,
        Loop, %ids%
        {
           WinGetTitle, title, % "ahk_id " ids%A_Index% 
           if(RegExMatch(title, rebuyWindowTitle) OR RegExMatch(title, closeRebuyWindowTitle) OR RegExMatch(title, confirmWaitingListWindowTitle) OR RegExMatch(title, confirmLargeAllInWindowTitle) OR RegExMatch(title, confirmLeaveTableWindowTitle)) {
              return
           }
        }
        ; press "Ok" button
        CoordMode, Mouse, Screen
        MouseGetPos, px, py
        CoordMode, Mouse, Relative
        WinGetActiveStats, title, width, height, ax, ay
        X := Round(width * confirmAllInX)
        Y := Round(height * confirmAllInY)
        MouseClick,%mouseClickEvent%, X, Y,, 0
        CoordMode, Mouse, Screen
        MouseMove, px, py, 0
        CoordMode, Mouse, Relative
    }
return

confirmLeaveTable:
    IfWinExist, %confirmLeaveTableWindowTitle%
    {
        Critical

        ; Looking for buy-in dialogs. Deadlock must be prevented
        WinGet, ids, list, ahk_class SunAwtDialog,,
        Loop, %ids%
        {
           WinGetTitle, title, % "ahk_id " ids%A_Index% 

           if(RegExMatch(title, rebuyWindowTitle) OR RegExMatch(title, closeRebuyWindowTitle) OR RegExMatch(title, confirmWaitingListWindowTitle) OR RegExMatch(title, confirmLargeAllInWindowTitle) OR RegExMatch(title, confirmLargeRaiseWindowTitle)) {
             return
            }
        }

        ; press "Ok" button
        CoordMode, Mouse, Screen
        MouseGetPos, px, py
        CoordMode, Mouse, Relative
        WinGetActiveStats, title, width, height, ax, ay
        X := Round(width * confirmLeaveX)
        Y := Round(height * confirmLeaveY)
        MouseClick,%mouseClickEvent%, X, Y,, 0
        CoordMode, Mouse, Screen
        MouseMove, px, py, 0
        CoordMode, Mouse, Relative
    }
return

confirmWaitingList:
	MsgBox, %con
    IfWinExist, %confirmWaitingListWindowTitle%
    {
        Critical

        ; Looking for buy-in dialogs. Deadlock must be prevented
        WinGet, ids, list, ahk_class SunAwtDialog,,
        Loop, %ids%
        {
           WinGetTitle, title, % "ahk_id " ids%A_Index% 
           if(RegExMatch(title, rebuyWindowTitle) OR RegExMatch(title, closeRebuyWindowTitle) OR RegExMatch(title, confirmLeaveTableWindowTitle) OR RegExMatch(title, confirmLargeAllInWindowTitle) OR RegExMatch(title, confirmLargeRaiseWindowTitle)) {
              return
           }
        }

        WinActivate, %confirmWaitingListWindowTitle%
        
        ; press "Ok" button
        CoordMode, Mouse, Screen
        MouseGetPos, px, py
        CoordMode, Mouse, Relative
        WinGetActiveStats, title, width, height, ax, ay
        
        X := Round(width * confirmWaiting1X)
        Y := Round(height * confirmWaiting1Y)
        ;Tooltip, title: %title%`nX: %X%`nY: %Y%`nconfirmWaitingListWindowTitle: %confirmWaitingListWindowTitle%
        ;SetTimer, RemoveToolTip, 5000
        MouseClick,%mouseClickEvent%, X, Y,, 0
        
        X := Round(width * confirmWaiting2X)
        Y := Round(height * confirmWaiting2Y)
        MouseClick,%mouseClickEvent%, X, Y,, 0
        
        CoordMode, Mouse, Screen
        MouseMove, px, py, 0
        CoordMode, Mouse, Relative

    }
return


checkForFree:
    IfWinExist, %checkForFreeWindowTitle%
    {   
        Critical
        
        CoordMode, Mouse, Screen
        MouseGetPos, px, py
        CoordMode, Mouse, Relative
        WinGetActiveStats, title, width, height, ax, ay
        X := Round(width * checkForFreeX)
        Y := Round(height * checkForFreeY)
        MouseClick,%mouseClickEvent%, X, Y,, 0
        CoordMode, Mouse, Screen
        MouseMove, px, py, 0
        CoordMode, Mouse, Relative
    }
return

pressFoldButton(ID, key) {
    global FoldX, FoldY
    PressButton(ID, FoldX, FoldY, key)
}

pressCheckButton(ID, key) {
    global CheckX, CheckY
    PressButton(ID, CheckX, CheckY, key)
}

pressRaiseButton(ID, key) {
    global RaiseX, RaiseY
    PressButton(ID, RaiseX, RaiseY, key)
}

pressPotButton(ID, key) {
    global PotX, PotY
    PressButton(ID, PotX, PotY, key)
}

pressAllInButton(ID, key) {
    global AllInX, AllInY
    PressButton(ID, AllInX, AllInY, key)
}


PressButton(ID, qx, qy, key) {
    global actOnActiveTable
    
    if (ID = "") {
        if (key <> "")
            Send {%key%}
        return
    }
        
    if (actOnActiveTable <> 1)
       WinActivate, ahk_id %ID%
 
    WinGetActiveStats, title, width, height, ax, ay       
    
    X := Round(width * qx)
    Y := Round(height * qy)

    CoordMode, Mouse, Screen
    MouseGetPos, px, py
    CoordMode, Mouse, Relative
    MouseClick,%mouseClickEvent%, X, Y,, 0
    CoordMode, Mouse, Screen
    MouseMove, px, py, 0
    CoordMode, Mouse, Relative
}


ShowLobby:
    WinGet, ids, list, ahk_class SunAwtDialog
    Loop, %ids% 
    {
        WinGetTitle, title, % "ahk_id " ids%A_Index%
        if(RegExMatch(title,  rebuyWindowTitle) OR RegExMatch(title, closeRebuyWindowTitle) OR RegExMatch(title,  confirmWaitingListWindowTitle) OR RegExMatch(title, confirmLargeRaiseWindowTitle) OR RegExMatch(title,  confirmLeaveTableWindowTitle) OR RegExMatch(title, confirmLargeAllInWindowTitle)) {
          return
        }
    }

    WinActivate, %lobbyTitle%
return



;;;;;;; IN/OUT

readIniFile() {
    global

    ; read general options
    IniRead, actOnActiveTable, %settingsFile%, Options, actOnActiveTable, 0
    IniRead, AlwaysCheckForFree, %settingsFile%, Options, AlwaysCheckForFree, 1
    IniRead, autoBuyInMax, %settingsFile%, Options, autoBuyInMax, 0
    IniRead, autoConfirmRebuy, %settingsFile%, Options, autoConfirmRebuy, 1
    IniRead, confirmLargeRaise, %settingsFile%, Options, confirmLargeRaise, 1
    IniRead, autoConfirmAllIn, %settingsFile%, Options, autoConfirmAllIn, 1
    IniRead, autoConfirmLeave, %settingsFile%, Options, autoConfirmLeave, 1
    IniRead, autoConfirmWaitingList, %settingsFile%, Options, autoConfirmWaitingList, 1
    IniRead, autoActivateTableUnderMouse, %settingsFile%, Options, autoActivateTableUnderMouse, 1
    IniRead, lobbyLang, %settingsFile%, Options, lobbyLang, en

    IniRead, InstantAllIn, %settingsFile%, Options, InstantAllIn, 1
    IniRead, InstantFullPot, %settingsFile%, Options, InstantFullPot, 1
    IniRead, InstantPotPercentage1, %settingsFile%, Options, InstantPotPercentage1, 0
    IniRead, InstantPotPercentage2, %settingsFile%, Options, InstantPotPercentage2, 0
    IniRead, InstantPotPercentage3, %settingsFile%, Options, InstantPotPercentage3, 0
    IniRead, InstantPotPercentage4, %settingsFile%, Options, InstantPotPercentage4, 0
    IniRead, InstantBBAmount1, %settingsFile%, Options, InstantBBAmount1, 1
    IniRead, InstantBBAmount2, %settingsFile%, Options, InstantBBAmount2, 1
    IniRead, InstantBBAmount3, %settingsFile%, Options, InstantBBAmount3, 1
    IniRead, InstantBBAmount4, %settingsFile%, Options, InstantBBAmount4, 1
    
    ; read pot amounts/percentages
    IniRead, percentage1, %settingsFile%, PotPercentages, percentage1, 66
    IniRead, percentage2, %settingsFile%, PotPercentages, percentage2, 75
    IniRead, percentage3, %settingsFile%, PotPercentages, percentage3, 90
    IniRead, percentage4, %settingsFile%, PotPercentages, percentage4,115
    IniRead, BBAmount1, %settingsFile%, PotPercentages, BBAmount1, 2.5
    IniRead, BBAmount2, %settingsFile%, PotPercentages, BBAmount2, 10
    IniRead, BBAmount3, %settingsFile%, PotPercentages, BBAmount3, 4
    IniRead, BBAmount4, %settingsFile%, PotPercentages, BBAmount4, 8

    ; rebuys
    IniRead, BuyChipsAmount1, %settingsFile%, Rebuys, BuyChipsAmount1, 1
    IniRead, BuyChipsAmount2, %settingsFile%, Rebuys, BuyChipsAmount2, 2
    IniRead, BuyChipsAmount3, %settingsFile%, Rebuys, BuyChipsAmount3, 3
    IniRead, BuyChipsAmount4, %settingsFile%, Rebuys, BuyChipsAmount4, 4
    IniRead, BuyChipsAmount5, %settingsFile%, Rebuys, BuyChipsAmount5, 5
    IniRead, BuyChipsAmount6, %settingsFile%, Rebuys, BuyChipsAmount6, 6
    IniRead, BuyChipsAmount7, %settingsFile%, Rebuys, BuyChipsAmount7, 7
    IniRead, BuyChipsAmount8, %settingsFile%, Rebuys, BuyChipsAmount8, 8
    IniRead, BuyChipsAmount9, %settingsFile%, Rebuys, BuyChipsAmount9, 9
    IniRead, BuyChipsAmount10, %settingsFile%, Rebuys, BuyChipsAmount10, 10    
    IniRead, BuyChipsFromCashierAmount1, %settingsFile%, Rebuys, BuyChipsFromCashierAmount1, 0
    IniRead, BuyChipsFromCashierAmount2, %settingsFile%, Rebuys, BuyChipsFromCashierAmount2, 0
    IniRead, BuyChipsFromCashierAmount3, %settingsFile%, Rebuys, BuyChipsFromCashierAmount3, 0 
    
    ; Time
    IniRead, BuyChipsDelay, %settingsFile%, Time, BuyChipsDelay, 1500
    
    ; read hotkeys
    IniRead, FoldHK, %settingsFile%, Hotkeys, Fold, !F
    IniRead, CheckCallHK, %settingsFile%, Hotkeys, CheckCall, !C
    IniRead, RaiseHK, %settingsFile%, Hotkeys, Raise, !R
    
    IniRead, BetPotPercentage1HK, %settingsFile%, Hotkeys, BetPotPercentage1, !6
    IniRead, BetPotPercentage2HK, %settingsFile%, Hotkeys, BetPotPercentage2, !7
    IniRead, BetPotPercentage3HK, %settingsFile%, Hotkeys, BetPotPercentage3, !8
    IniRead, BetPotPercentage4HK, %settingsFile%, Hotkeys, BetPotPercentage4, !9
    IniRead, BetBBAmount1HK, %settingsFile%, Hotkeys, BetBBAmount1, !1
    IniRead, BetBBAmount2HK, %settingsFile%, Hotkeys, BetBBAmount2, !2
    IniRead, BetBBAmount3HK, %settingsFile%, Hotkeys, BetBBAmount3, !3
    IniRead, BetBBAmount4HK, %settingsFile%, Hotkeys, BetBBAmount4, !4
        
    IniRead, BetFullPotHK, %settingsFile%, Hotkeys, BetFullPot, !B
    IniRead, BetAllInHK, %settingsFile%, Hotkeys, BetAllIn, !A
    
    IniRead, Add1BBHK, %settingsFile%, Hotkeys, Add1BB, %A_Space%
    IniRead, Subtract1BBHK, %settingsFile%, Hotkeys, Subtract1BB, %A_Space%
    IniRead, Add1SBHK, %settingsFile%, Hotkeys, Add1SB, !WheelUp
    IniRead, Subtract1SBHK, %settingsFile%, Hotkeys, Subtract1SB, !WheelDown

    IniRead, OpenRebuyBoxHK, %settingsFile%, Hotkeys, OpenRebuyBox, !Space
    IniRead, BuyChipsHK1, %settingsFile%, Hotkeys, BuyChips1, F1
    IniRead, BuyChipsHK2, %settingsFile%, Hotkeys, BuyChips2, F2
    IniRead, BuyChipsHK3, %settingsFile%, Hotkeys, BuyChips3, F3
    IniRead, BuyChipsHK4, %settingsFile%, Hotkeys, BuyChips4, F4
    IniRead, BuyChipsHK5, %settingsFile%, Hotkeys, BuyChips5, F5
    IniRead, BuyChipsHK6, %settingsFile%, Hotkeys, BuyChips6, F6
    IniRead, BuyChipsHK7, %settingsFile%, Hotkeys, BuyChips7, F7
    IniRead, BuyChipsHK8, %settingsFile%, Hotkeys, BuyChips8, F8
    IniRead, BuyChipsHK9, %settingsFile%, Hotkeys, BuyChips9, F9
    IniRead, BuyChipsHK10, %settingsFile%, Hotkeys, BuyChips10, F10
    IniRead, BuyChipsFromCashierHK1, %settingsFile%, Hotkeys, BuyChipsFromCashier1, F11
    IniRead, BuyChipsFromCashierHK2, %settingsFile%, Hotkeys, BuyChipsFromCashier2, F12
    IniRead, BuyChipsFromCashierHK3, %settingsFile%, Hotkeys, BuyChipsFromCashier3, %A_Space%
    IniRead, RebuyToMaxHK, %settingsFile%, Hotkeys, RebuyToMax, %A_Space%
   
    IniRead, ShowLobbyHK, %settingsFile%, Hotkeys, ShowLobby, !L
    IniRead, SitOutHK, %settingsFile%, Hotkeys, SitOut, !O
    IniRead, SitInHK, %settingsFile%, Hotkeys, SitIn, !I
    IniRead, NoMoreBlindsHK, %settingsFile%, Hotkeys, NoMoreBlinds, !N
    IniRead, PauseHK, %settingsFile%, Hotkeys, Pause, #P
    IniRead, SuspendHK, %settingsFile%, Hotkeys, Suspend, #S
    IniRead, ExitApplicationHK, %settingsFile%, Hotkeys, ExitApplication, #Q
    
    
    IfNotExist, %settingsFile%
    {
        writeIni()
    }

}


writeIni() {
    global
    
    ; write general options
    IniWrite, %actOnActiveTable%, %settingsFile%, Options, actOnActiveTable
    IniWrite, %AlwaysCheckForFree%, %settingsFile%, Options, AlwaysCheckForFree
    IniWrite, %autoBuyInMax%, %settingsFile%, Options, autoBuyInMax
    IniWrite, %autoConfirmRebuy%, %settingsFile%, Options, autoConfirmRebuy
    IniWrite, %autoConfirmAllIn%, %settingsFile%, Options, autoConfirmAllIn
    IniWrite, %confirmLargeRaise%, %settingsFile%, Options, confirmLargeRaise
    IniWrite, %autoConfirmLeave%, %settingsFile%, Options, autoConfirmLeave
    IniWrite, %autoConfirmWaitingList%, %settingsFile%, Options, autoConfirmWaitingList
    IniWrite, %autoActivateTableUnderMouse%, %settingsFile%, Options, autoActivateTableUnderMouse    
    IniWrite, %lobbyLang%, %settingsFile%, Options, lobbyLang
    
    IniWrite, %InstantAllIn%, %settingsFile%, Options, InstantAllIn
    IniWrite, %InstantFullPot%, %settingsFile%, Options, InstantFullPot
    IniWrite, %InstantPotPercentage1%, %settingsFile%, Options, InstantPotPercentage1
    IniWrite, %InstantPotPercentage2%, %settingsFile%, Options, InstantPotPercentage2
    IniWrite, %InstantPotPercentage3%, %settingsFile%, Options, InstantPotPercentage3
    IniWrite, %InstantPotPercentage4%, %settingsFile%, Options, InstantPotPercentage4
    IniWrite, %InstantBBAmount1%, %settingsFile%, Options, InstantBBAMount1
    IniWrite, %InstantBBAmount2%, %settingsFile%, Options, InstantBBAMount2
    IniWrite, %InstantBBAmount3%, %settingsFile%, Options, InstantBBAMount3
    IniWrite, %InstantBBAmount4%, %settingsFile%, Options, InstantBBAMount4

    IniWrite, %BuyChipsDelay%, %settingsFile%, Time, BuyChipsDelay
    
    ; write pot percentages
    IniWrite, %percentage1%, %settingsFile%, PotPercentages, percentage1
    IniWrite, %percentage2%, %settingsFile%, PotPercentages, percentage2
    IniWrite, %percentage3%, %settingsFile%, PotPercentages, percentage3
    IniWrite, %percentage4%, %settingsFile%, PotPercentages, percentage4

    IniWrite, %BBAmount1%, %settingsFile%, PotPercentages, BBAmount1
    IniWrite, %BBAmount2%, %settingsFile%, PotPercentages, BBAmount2
    IniWrite, %BBAmount3%, %settingsFile%, PotPercentages, BBAmount3    
    IniWrite, %BBAmount4%, %settingsFile%, PotPercentages, BBAmount4
    
    IniWrite, %BuyChipsAmount1%, %settingsFile%, Rebuys, BuyChipsAmount1 
    IniWrite, %BuyChipsAmount2%, %settingsFile%, Rebuys, BuyChipsAmount2 
    IniWrite, %BuyChipsAmount3%, %settingsFile%, Rebuys, BuyChipsAmount3
    IniWrite, %BuyChipsAmount4%, %settingsFile%, Rebuys, BuyChipsAmount4
    IniWrite, %BuyChipsAmount5%, %settingsFile%, Rebuys, BuyChipsAmount5 
    IniWrite, %BuyChipsAmount6%, %settingsFile%, Rebuys, BuyChipsAmount6 
    IniWrite, %BuyChipsAmount7%, %settingsFile%, Rebuys, BuyChipsAmount7
    IniWrite, %BuyChipsAmount8%, %settingsFile%, Rebuys, BuyChipsAmount8
    IniWrite, %BuyChipsAmount9%, %settingsFile%, Rebuys, BuyChipsAmount9 
    IniWrite, %BuyChipsAmount10%, %settingsFile%, Rebuys, BuyChipsAmount10     
    IniWrite, %BuyChipsFromCashierAmount1%, %settingsFile%, Rebuys, BuyChipsFromCashierAmount1
    IniWrite, %BuyChipsFromCashierAmount2%, %settingsFile%, Rebuys, BuyChipsFromCashierAmount2
    IniWrite, %BuyChipsFromCashierAmount3%, %settingsFile%, Rebuys, BuyChipsFromCashierAmount3

    ; write hotkeys
    IniWrite, %FoldHK%, %settingsFile%, Hotkeys, Fold
    IniWrite, %CheckCallHK%, %settingsFile%, Hotkeys, CheckCall
    IniWrite, %RaiseHK%, %settingsFile%, Hotkeys, Raise

    IniWrite, %BetPotPercentage1HK%, %settingsFile%, Hotkeys, BetPotPercentage1
    IniWrite, %BetPotPercentage2HK%, %settingsFile%, Hotkeys, BetPotPercentage2
    IniWrite, %BetPotPercentage3HK%, %settingsFile%, Hotkeys, BetPotPercentage3
    IniWrite, %BetPotPercentage4HK%, %settingsFile%, Hotkeys, BetPotPercentage4
    IniWrite, %BetBBAmount1HK%, %settingsFile%, Hotkeys, BetBBAmount1
    IniWrite, %BetBBAmount2HK%, %settingsFile%, Hotkeys, BetBBAmount2
    IniWrite, %BetBBAmount3HK%, %settingsFile%, Hotkeys, BetBBAmount3
    IniWrite, %BetBBAmount4HK%, %settingsFile%, Hotkeys, BetBBAmount4
    
    IniWrite, %BetFullPotHK%, %settingsFile%, Hotkeys, BetFullPot
    IniWrite, %BetAllInHK%, %settingsFile%, Hotkeys, BetAllIn
    
    IniWrite, %Add1BBHK%, %settingsFile%, Hotkeys, Add1BB
    IniWrite, %Subtract1BBHK%, %settingsFile%, Hotkeys, Subtract1BB
    IniWrite, %Add1SBHK%, %settingsFile%, Hotkeys, Add1SB
    IniWrite, %Subtract1SBHK%, %settingsFile%, Hotkeys, Subtract1SB

    IniWrite, %OpenRebuyBoxHK%, %settingsFile%, Hotkeys, OpenRebuyBox
    IniWrite, %BuyChipsHK1%, %settingsFile%, Hotkeys, BuyChips1
    IniWrite, %BuyChipsHK2%, %settingsFile%, Hotkeys, BuyChips2
    IniWrite, %BuyChipsHK3%, %settingsFile%, Hotkeys, BuyChips3
    IniWrite, %BuyChipsHK4%, %settingsFile%, Hotkeys, BuyChips4
    IniWrite, %BuyChipsHK5%, %settingsFile%, Hotkeys, BuyChips5
    IniWrite, %BuyChipsHK6%, %settingsFile%, Hotkeys, BuyChips6
    IniWrite, %BuyChipsHK7%, %settingsFile%, Hotkeys, BuyChips7
    IniWrite, %BuyChipsHK8%, %settingsFile%, Hotkeys, BuyChips8
    IniWrite, %BuyChipsHK9%, %settingsFile%, Hotkeys, BuyChips9
    IniWrite, %BuyChipsHK10%, %settingsFile%, Hotkeys, BuyChips10
    IniWrite, %RebuyToMaxHK%, %settingsFile%, Hotkeys, RebuyToMax
    
    IniWrite, %BuyChipsFromCashierHK1%, %settingsFile%, Hotkeys, BuyChipsFromCashier1
    IniWrite, %BuyChipsFromCashierHK2%, %settingsFile%, Hotkeys, BuyChipsFromCashier2
    IniWrite, %BuyChipsFromCashierHK3%, %settingsFile%, Hotkeys, BuyChipsFromCashier3
    
    IniWrite, %ShowLobbyHK%, %settingsFile%, Hotkeys, ShowLobby
    IniWrite, %SitInHK%, %settingsFile%, Hotkeys, SitIn
    IniWrite, %SitOutHK%, %settingsFile%, Hotkeys, SitOut
    IniWrite, %NoMoreBlindsHK%, %settingsFile%, Hotkeys, NoMoreBlinds
    IniWrite, %PauseHK%, %settingsFile%, Hotkeys, Pause
    IniWrite, %SuspendHK%, %settingsFile%, Hotkeys, Suspend
    IniWrite, %ExitApplicationHK%, %settingsFile%, Hotkeys, ExitApplication    
}


defineHotKeys() {
    global
    
    if ShowLobbyHK
        HotKey, %ShowLobbyHK%, ShowLobby
    if ExitApplicationHK
        HotKey, %ExitApplicationHK%, ExitApplication    
    if PauseHK
        HotKey, %PauseHK%, Pause
    if SuspendHK
        HotKey, %SuspendHK%, Suspend    
    
    Hotkey, IfWinActive, %tableTitle% ahk_class SunAwtFrame 
    
    if FoldHK
        HotKey, %FoldHK%, Fold
    if CheckCallHK
        HotKey, %CheckCallHK%, CheckCall
    if RaiseHK
        HotKey, %RaiseHK%, Raise
    if BetFullPotHK
        HotKey, %BetFullPotHK%, BetFullPot
    if BetAllInHK
        HotKey, %BetAllInHK%, BetAllIn       
        
    if BetPotPercentage1HK
        HotKey, %BetPotPercentage1HK%, BetPotPercentage1
    if BetPotPercentage2HK
        HotKey, %BetPotPercentage2HK%, BetPotPercentage2
    if BetPotPercentage3HK
        HotKey, %BetPotPercentage3HK%, BetPotPercentage3
    if BetPotPercentage4HK
        HotKey, %BetPotPercentage4HK%, BetPotPercentage4
        
    if BetBBAmount1HK
        HotKey, %BetBBAmount1HK%, BetBBAmount1
    if BetBBAmount2HK
        HotKey, %BetBBAmount2HK%, BetBBAmount2
    if BetBBAmount3HK
        HotKey, %BetBBAmount3HK%, BetBBAmount3        
    if BetBBAmount4HK
        HotKey, %BetBBAmount4HK%, BetBBAmount4   

    if Add1BBHK
        HotKey, %Add1BBHK%, Add1BB
    if Subtract1BBHK
        HotKey, %Subtract1BBHK%, Subtract1BB
    if Add1SBHK
        HotKey, %Add1SBHK%, Add1SB
    if Subtract1SBHK
        HotKey, %Subtract1SBHK%, Subtract1SB

    if RebuyToMaxHK
        HotKey, %RebuyToMaxHK%, RebuyToMax
        
    if BuyChipsHK1
        Hotkey, %BuyChipsHK1%, buyChips1
    if BuyChipsHK2
        Hotkey, %BuyChipsHK2%, buyChips2
    if BuyChipsHK3
        Hotkey, %BuyChipsHK3%, buyChips3
    if BuyChipsHK4
        Hotkey, %BuyChipsHK4%, buyChips4
    if BuyChipsHK5
        Hotkey, %BuyChipsHK5%, buyChips5
    if BuyChipsHK6
        Hotkey, %BuyChipsHK6%, buyChips6
    if BuyChipsHK7
        Hotkey, %BuyChipsHK7%, buyChips7
    if BuyChipsHK8
        Hotkey, %BuyChipsHK8%, buyChips8
    if BuyChipsHK9
        Hotkey, %BuyChipsHK9%, buyChips9
    if BuyChipsHK10
        Hotkey, %BuyChipsHK10%, buyChips10      
    if OpenRebuyBoxHK
        HotKey, %OpenRebuyBoxHK%, OpenRebuyBox    
    if NoMoreBlindsHK
        HotKey, %NoMoreBlindsHK%, NoMoreBlinds
        
    if SitOutHK
        HotKey, %SitOutHK%, SitOut
    if SitInHK
        HotKey, %SitInHK%, SitIn

    Hotkey, IfWinActive, ahk_class SunAwtDialog
    
    if BuyChipsFromCashierHK1
        Hotkey, %BuyChipsFromCashierHK1%, buyChipsFromCashier1
    if BuyChipsFromCashierHK2
        Hotkey, %BuyChipsFromCashierHK2%, buyChipsFromCashier2
    if BuyChipsFromCashierHK3
        Hotkey, %BuyChipsFromCashierHK3%, buyChipsFromCashier3        
}
