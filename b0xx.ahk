#SingleInstance force
#NoEnv
#include <CvJoyInterface>
SetBatchLines, -1

hotkeyLabels := Object()
hotkeyLabels.Insert("Analog Up")
hotkeyLabels.Insert("Analog Left")
hotkeyLabels.Insert("Analog Down")
hotkeyLabels.Insert("Analog Right")
hotkeyLabels.Insert("ModX")
hotkeyLabels.Insert("ModY")
hotkeyLabels.Insert("L")
hotkeyLabels.Insert("Y")
hotkeyLabels.Insert("R")
hotkeyLabels.Insert("B")
hotkeyLabels.Insert("A")
hotkeyLabels.Insert("X")
hotkeyLabels.Insert("Z")
hotkeyLabels.Insert("C-stick Up")
hotkeyLabels.Insert("C-stick Left")
hotkeyLabels.Insert("C-stick Down")
hotkeyLabels.Insert("C-stick Right")
hotkeyLabels.Insert("Start")
hotkeyLabels.Insert("D-pad Up")
hotkeyLabels.Insert("D-pad Left")
hotkeyLabels.Insert("D-pad Down")
hotkeyLabels.Insert("D-pad Right")

Menu, Tray, Click, 1
;Menu, Tray, NoStandard
Menu, Tray, Add, Edit Controls, ShowGui
Menu, Tray, Default, Edit Controls

#ctrls = 22  ;Total number of Key's we will be binding (excluding UP's)?

for index, element in hotkeyLabels{
 Gui, Add, Text, xm vLB%index%, %element% Hotkey:
 IniRead, savedHK%index%, Hotkeys.ini, Hotkeys, %index%, %A_Space%
 If savedHK%index%                                       ;Check for saved hotkeys in INI file.
  Hotkey,% savedHK%index%, Label%index%                 ;Activate saved hotkeys if found.
  Hotkey,% savedHK%index% . " UP", Label%index%_UP                 ;Activate saved hotkeys if found.
  ;TrayTip, B0XX, Label%index%_UP, 3, 0
  ;TrayTip, B0XX, % savedHK%A_Index%, 3, 0
  ;TrayTip, B0XX, % savedHK%index% . " UP", 3, 0
 checked := false
 if(!InStr(savedHK%index%, "~", false)){
  checked := true
 }
 StringReplace, noMods, savedHK%index%, ~                  ;Remove tilde (~) and Win (#) modifiers...
 StringReplace, noMods, noMods, #,,UseErrorLevel              ;They are incompatible with hotkey controls (cannot be shown).
 Gui, Add, Hotkey, x+5 vHK%index% gGuiLabel, %noMods%        ;Add hotkey controls and show saved hotkeys.
 if(!checked)
  Gui, Add, CheckBox, x+5 vCB%index% gGuiLabel, Prevent Default Behavior  ;Add checkboxes to allow the Windows key (#) as a modifier..
 else
  Gui, Add, CheckBox, x+5 vCB%index% Checked gGuiLabel, Prevent Default Behavior  ;Add checkboxes to allow the Windows key (#) as a modifier..
}                                                               ;Check the box if Win modifier is used.


;----------Start Hotkey Handling-----------

; Create an object from vJoy Interface Class.
vJoyInterface := new CvJoyInterface()

; Was vJoy installed and the DLL Loaded?
if (!vJoyInterface.vJoyEnabled()){
  ; Show log of what happened
  Msgbox % vJoyInterface.LoadLibraryLog
  ExitApp
}

myStick := vJoyInterface.Devices[1]

;Alert User that script has started
TrayTip, B0XX, Script Started, 3, 0

; Stick variables
l := false
ldash := false
r := false
rdash := false
u := false
d := false
lshield := false
modx := 0
mody := 0
cl := false
cu := false
cd := false
cr := false
b := false
a := false





; Gives stick input based on stick variables

stickuwu() {
	global
	if ((not l) and (not r) and (not u) and (not d)) {
		myStick.SetAxisByIndex(16384,1)
		myStick.SetAxisByIndex(16384,2)
	} 
;	----------------------------------------------- QUADRANT 1 -----	
	else if (u and r) { 
		if (modx and not mody) {
			if (cd) {
				myStick.SetAxisByIndex(24400,1)
				myStick.SetAxisByIndex(12400,2)
			}
			else if (cl) {			
				myStick.SetAxisByIndex(24550,1)
				myStick.SetAxisByIndex(11500,2)
			}
			else if (cu) {			
				myStick.SetAxisByIndex(23250,1)
				myStick.SetAxisByIndex(11500,2)
			}	
			else if (cr) {			
				myStick.SetAxisByIndex(22968,1)
				myStick.SetAxisByIndex(10850,2)
			}			
			else {
				myStick.SetAxisByIndex(24000,1)
				myStick.SetAxisByIndex(13300,2)
			}
		}
		else if (mody and not modx) {
			if (cd) {
				myStick.SetAxisByIndex(20400,1)
				myStick.SetAxisByIndex(8000,2)
			}
			else if (cl) {			
				myStick.SetAxisByIndex(21200,1)
				myStick.SetAxisByIndex(8150,2)
			}
			else if (cu) {			
				myStick.SetAxisByIndex(22100,1)
				myStick.SetAxisByIndex(8150,2)
			}	
			else if (cr) {			
				myStick.SetAxisByIndex(22500,1)
				myStick.SetAxisByIndex(9000,2)
			}				
			else {
				myStick.SetAxisByIndex(19400,1)
				myStick.SetAxisByIndex(8750,2)
			}
		}	
		else {
			if (lshield and not rshield) {
				myStick.SetAxisByIndex(21900,1)
				myStick.SetAxisByIndex(10700,2)
			}
			else if (rshield) {
				myStick.SetAxisByIndex(21900,1)
				myStick.SetAxisByIndex(10700,2)
			}
			else {
				myStick.SetAxisByIndex(32768,1)
				myStick.SetAxisByIndex(0,2)
			}
		}
	}
;	----------------------------------------------- QUADRANT 2 -----	
	else if (u and l) { 
		if (modx and not mody) {
			if (cd) {
				myStick.SetAxisByIndex(8450,1)
				myStick.SetAxisByIndex(12400,2)
			}
			else if (cl) {
				myStick.SetAxisByIndex(8350,1)
				myStick.SetAxisByIndex(11500,2)
			}
			else if (cu) {			
				myStick.SetAxisByIndex(9600,1)
				myStick.SetAxisByIndex(11500,2)
			}	
			else if (cr) {			
				myStick.SetAxisByIndex(9800,1)
				myStick.SetAxisByIndex(10850,2)
			}
			else {
				myStick.SetAxisByIndex(8850,1)
				myStick.SetAxisByIndex(13300,2)
			}
		}
		else if (mody and not modx) {
			if (cd) {
				myStick.SetAxisByIndex(12368,1)
				myStick.SetAxisByIndex(8000,2)
			}
			else if (cl) {			
				myStick.SetAxisByIndex(11600,1)
				myStick.SetAxisByIndex(8150,2)
			}
			else if (cu) {			
				myStick.SetAxisByIndex(10700,1)
				myStick.SetAxisByIndex(8150,2)
			}	
			else if (cr) {			
				myStick.SetAxisByIndex(10350,1)
				myStick.SetAxisByIndex(9000,2)
			}						
			else {
				myStick.SetAxisByIndex(13400,1)
				myStick.SetAxisByIndex(8750,2)
			}
		}
		else {
			if (lshield and not rshield) {
				myStick.SetAxisByIndex(10868,1)
				myStick.SetAxisByIndex(10700,2)
			}
			else if (rshield) {	
				myStick.SetAxisByIndex(10868,1)
				myStick.SetAxisByIndex(10700,2)
			}
			else {
				myStick.SetAxisByIndex(0,1)
				myStick.SetAxisByIndex(0,2)
			}
		}
	}
;	----------------------------------------------- QUADRANT 3 -----	
	else if (d and l) {
		if (modx and not mody) {
			if (cd and not rshield and not lshield) {
				myStick.SetAxisByIndex(8450,1)
				myStick.SetAxisByIndex(20100,2)
			}
			else if (cl and not rshield and not lshield) {
				myStick.SetAxisByIndex(8350,1)
				myStick.SetAxisByIndex(21000,2)
			}
			else if (cu and not rshield and not lshield) {			
				myStick.SetAxisByIndex(9600,1)
				myStick.SetAxisByIndex(21000,2)
			}	
			else if (cr and not rshield and not lshield) {			
				myStick.SetAxisByIndex(9800,1)
				myStick.SetAxisByIndex(21700,2)
			}
			else {
				if (rshield or lshield) {
					myStick.SetAxisByIndex(9850,1)
					myStick.SetAxisByIndex(20100,2)
				}
				else {
					myStick.SetAxisByIndex(8850,1)
					myStick.SetAxisByIndex(19200,2)
				}
			}	
		}
		else if (mody and not modx) {
			if (cd and not rshield and not lshield) {
				myStick.SetAxisByIndex(12368,1)
				myStick.SetAxisByIndex(24500,2)
			}
			else if (cl and not rshield and not lshield) {			
				myStick.SetAxisByIndex(11600,1)
				myStick.SetAxisByIndex(24350,2)
			}
			else if (cu and not rshield and not lshield) {			
				myStick.SetAxisByIndex(10700,1)
				myStick.SetAxisByIndex(24350,2)
			}	
			else if (cr and not rshield and not lshield) {			
				myStick.SetAxisByIndex(10350,1)
				myStick.SetAxisByIndex(23650,2)
			}			
			else {
				if (rshield or lshield) {
					myStick.SetAxisByIndex(11300,1)
					myStick.SetAxisByIndex(25000,2)
				}
				else {
					myStick.SetAxisByIndex(13400,1)
					myStick.SetAxisByIndex(23900,2)
				}
			}
		}	
		else {
			if (lshield and not rshield) {
				myStick.SetAxisByIndex(7200,1)
				myStick.SetAxisByIndex(25200,2)
				}
			else if (rshield) {
				myStick.SetAxisByIndex(10868,1)
				myStick.SetAxisByIndex(21768,2)
			}
			else {	
				myStick.SetAxisByIndex(0,1)
				myStick.SetAxisByIndex(32768,2)
			}
		}
	}	
;	----------------------------------------------- QUADRANT 4 -----
	else if (d and r) {
		if (modx and not mody) {
			if (cd and not rshield and not lshield) {
				myStick.SetAxisByIndex(24400,1)
				myStick.SetAxisByIndex(20100,2)
			}
			else if (cl and not rshield and not lshield) {
				myStick.SetAxisByIndex(24550,1)
				myStick.SetAxisByIndex(21000,2)
			}
			else if (cu and not rshield and not lshield) {			
				myStick.SetAxisByIndex(23250,1)
				myStick.SetAxisByIndex(21000,2)
			}	
			else if (cr and not rshield and not lshield) {			
				myStick.SetAxisByIndex(22968,1)
				myStick.SetAxisByIndex(21700,2)
			}
			else {
				if (rshield or lshield) {
					myStick.SetAxisByIndex(22918,1)
					myStick.SetAxisByIndex(20100,2)
				}
				else {
					myStick.SetAxisByIndex(24000,1)
					myStick.SetAxisByIndex(19200,2)
				}
			}
		}
		else if (mody and not modx) {
			if (cd and not rshield and not lshield) {
				myStick.SetAxisByIndex(20400,1)
				myStick.SetAxisByIndex(24500,2)
			}
			else if (cl and not rshield and not lshield) {			
				myStick.SetAxisByIndex(21200,1)
				myStick.SetAxisByIndex(24350,2)
			}
			else if (cu and not rshield and not lshield) {			
				myStick.SetAxisByIndex(22100,1)
				myStick.SetAxisByIndex(24350,2)
			}	
			else if (cr and not rshield and not lshield) {			
				myStick.SetAxisByIndex(22500,1)
				myStick.SetAxisByIndex(23650,2)
			}			
			else {
				if (rshield or lshield) {
					myStick.SetAxisByIndex(21500,1)
					myStick.SetAxisByIndex(25000,2)
				}
				else {
					myStick.SetAxisByIndex(19400,1)
					myStick.SetAxisByIndex(23900,2)
				}
			}	
		}
		else {
			if (lshield and not rshield) {
				myStick.SetAxisByIndex(25568,1)
				myStick.SetAxisByIndex(25200,2)
				}
			else if (rshield)  {
				myStick.SetAxisByIndex(21900,1)
				myStick.SetAxisByIndex(21768,2)
				}
			else {
				myStick.SetAxisByIndex(32768,1)
				myStick.SetAxisByIndex(32768,2)
			}
		}
	}
;	----------------------------------------------- LEFT -----	
	else if (l) { 
			if (modx and not mody) {
				if (not rdash) {
					myStick.SetAxisByIndex(9550,1)
				}
				else {
					myStick.SetAxisByIndex(0,1)
				}	
				myStick.SetAxisByIndex(16384,2)
			}
			else if (mody and not modx) {
				if (not rdash) {
					if (not b) {
						myStick.SetAxisByIndex(12900,1)
					}
					else {
						myStick.SetAxisByIndex(0,1)
					}
				}
				else {
					myStick.SetAxisByIndex(0,1)
				}
				myStick.SetAxisByIndex(16384,2)
			}
			else if (rshield) {
				myStick.SetAxisByIndex(9900,1)
				myStick.SetAxisByIndex(16384,2)
			}
			else {
				myStick.SetAxisByIndex(0,1)
				myStick.SetAxisByIndex(16384,2)
			}		
	}
;	----------------------------------------------- RIGHT -----		
	else if (r) { 
			if (modx and not mody) {
				if (not ldash) {
					myStick.SetAxisByIndex(23250,1)
				}
				else {
					myStick.SetAxisByIndex(32768,1)
				}
				myStick.SetAxisByIndex(16384,2)
			}
			else if (mody and not modx) {
				if (not ldash) {
					if (not b) {
						myStick.SetAxisByIndex(19900,1)
					}
					else {
						myStick.SetAxisByIndex(32768,1)
					}
				}
				else {
					myStick.SetAxisByIndex(32768,1)
				}
				myStick.SetAxisByIndex(16384,2)
			}
			else if (rshield) {
				myStick.SetAxisByIndex(22968,1)
				myStick.SetAxisByIndex(16384,2)
			}
			else {
				myStick.SetAxisByIndex(32768,1)
				myStick.SetAxisByIndex(16384,2)
			}
	}
;	----------------------------------------------- UP -----		
	else if (u) { 
		if (modx and not mody) {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(13300,2)
		}
		else if (mody and not modx) {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(8750,2)
		}
		else if (rshield) {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(10700,2)
		}
		else {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(0,2)
		}
	}
;	----------------------------------------------- DOWN -----		
	else if (d) { 
		if (modx and not mody) {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(19200,2)
		}
		else if (mody and not modx) {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(23900,2)
		}
		else if (rshield) {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(21768,2)
		}
		else {
			myStick.SetAxisByIndex(16384,1)
			myStick.SetAxisByIndex(32768,2)
			}
	}	
}
	
	
	

validateHK(GuiControl) {
 global lastHK
 Gui, Submit, NoHide
 lastHK := %GuiControl%                     ;Backup the hotkey, in case it needs to be reshown.
 num := SubStr(GuiControl,3)                ;Get the index number of the hotkey control.
 If (HK%num% != "") {                       ;If the hotkey is not blank...
  StringReplace, HK%num%, HK%num%, SC15D, AppsKey      ;Use friendlier names,
  StringReplace, HK%num%, HK%num%, SC154, PrintScreen  ;  instead of these scan codes.
  ;If CB%num%                                ;  If the 'Win' box is checked, then add its modifier (#).
   ;HK%num% := "#" HK%num%
  If (!CB%num% && !RegExMatch(HK%num%,"[#!\^\+]"))       ;  If the new hotkey has no modifiers, add the (~) modifier.
   HK%num% := "~" HK%num%                   ;    This prevents any key from being blocked.
  checkDuplicateHK(num)
 }
 If (savedHK%num% || HK%num%)               ;Unless both are empty,
  setHK(num, savedHK%num%, HK%num%)         ;  update INI/GUI
}

checkDuplicateHK(num) {
 global #ctrls
 Loop,% #ctrls
  If (HK%num% = savedHK%A_Index%) {
   dup := A_Index
   TrayTip, B0XX, Hotkey Already Taken, 3, 0
   Loop,6 {
    GuiControl,% "Disable" b:=!b, HK%dup%   ;Flash the original hotkey to alert the user.
    Sleep,200
   }
   GuiControl,,HK%num%,% HK%num% :=""       ;Delete the hotkey and clear the control.
   break
  }
}

setHK(num,INI,GUI) {
 If INI{                          ;If previous hotkey exists,
  Hotkey, %INI%, Label%num%, Off  ;  disable it.
  Hotkey, %INI% UP, Label%num%_UP, Off  ;  disable it.
}
 If GUI{                           ;If new hotkey exists,
  Hotkey, %GUI%, Label%num%, On   ;  enable it.
  Hotkey, %GUI% UP, Label%num%_UP, On   ;  enable it.
}
 IniWrite,% GUI ? GUI:null, Hotkeys.ini, Hotkeys, %num%
 savedHK%num%  := HK%num%
 ;TrayTip, Label%num%,% !INI ? GUI " ON":!GUI ? INI " OFF":GUI " ON`n" INI " OFF"
}

#MenuMaskKey vk07                 ;Requires AHK_L 38+
#If ctrl := HotkeyCtrlHasFocus()
 *AppsKey::                       ;Add support for these special keys,
 *BackSpace::                     ;  which the hotkey control does not normally allow.
 *Delete::
 *Enter::
 *Escape::
 *Pause::
 *PrintScreen::
 *Space::
 *Tab::
  modifier := ""
  If GetKeyState("Shift","P")
   modifier .= "+"
  If GetKeyState("Ctrl","P")
   modifier .= "^"
  If GetKeyState("Alt","P")
   modifier .= "!"
  Gui, Submit, NoHide             ;If BackSpace is the first key press, Gui has never been submitted.
  If (A_ThisHotkey == "*BackSpace" && %ctrl% && !modifier)   ;If the control has text but no modifiers held,
   GuiControl,,%ctrl%                                       ;  allow BackSpace to clear that text.
  Else                                                     ;Otherwise,
   GuiControl,,%ctrl%, % modifier SubStr(A_ThisHotkey,2)  ;  show the hotkey.
  validateHK(ctrl)
 return
#If

HotkeyCtrlHasFocus() {
 GuiControlGet, ctrl, Focus       ;ClassNN
 If InStr(ctrl,"hotkey") {
  GuiControlGet, ctrl, FocusV     ;Associated variable
  Return, ctrl
 }
}


;----------------------------Labels

;Show GUI from tray Icon
ShowGui:
    Gui, show,, Dynamic Hotkeys
    GuiControl, Focus, LB1 ; this puts the windows "focus" on the checkbox, that way it isn't immediately waiting for input on the 1st input box
return

GuiLabel:
 If %A_GuiControl% in +,^,!,+^,+!,^!,+^!    ;If the hotkey contains only modifiers, return to wait for a key.
  return
 If InStr(%A_GuiControl%,"vk07")            ;vk07 = MenuMaskKey (see below)
  GuiControl,,%A_GuiControl%, % lastHK      ;Reshow the hotkey, because MenuMaskKey clears it.
 Else
  validateHK(A_GuiControl)
return

;-------macros

Pause::Suspend
^!r:: Reload
SetKeyDelay, 0
#MaxHotkeysPerInterval 200

^!s::
  Suspend
    If A_IsSuspended
        TrayTip, B0XX, Hotkeys Disabled, 3, 0
    Else
        TrayTip, B0XX, Hotkeys Enabled, 3, 0
  Return
  
;           //// STICK ////
;---- UP ----
	Label1:
	u := true
	d := false
	stickuwu()
	return

Label1_UP:
	u := false
	stickuwu()
	return
  
;---- LEFT ----
Label2:
	l := true
	ldash := true
	r := false
	stickuwu()
	return

Label2_UP:
	l := false
	ldash := false
	stickuwu()
	return

;---- DOWN ----
Label3:
	d := true
	u := false
	stickuwu()
	return
	
Label3_UP:
	d := false
	stickuwu()
	return
  
;---- RIGHT ----
Label4:
	r := true
	l := false
	rdash := true
	stickuwu()
	return

Label4_UP:
	r := false
	rdash := false
	stickuwu()
	return  

;           //// MODIFIERS ////
;---- ModX ----
Label5:
	modx := true
	stickuwu()
	return

Label5_UP:
	modx := false
	stickuwu()
	return

;---- ModY ----  
Label6:
	mody := true
	stickuwu()
	return
Label6_UP:
	mody := false
	stickuwu()
	return  

;           //// BUTTONS ////
;---- L ---- 
Label7:
	lshield := true
	myStick.SetBtn(1,1)
	stickuwu()
	Return

Label7_UP:
	lshield := false
	myStick.SetBtn(0,1)
	stickuwu()
	Return

;---- Y ---- 
Label8:
	myStick.SetBtn(1,2)
	Return

Label8_UP:
	myStick.SetBtn(0,2)
	Return

;---- R ---- 
Label9:
	rshield := true
	myStick.SetBtn(1,3)
	stickuwu()
	Return

Label9_UP:
	rshield := false
	myStick.SetBtn(0,3)
	stickuwu()
	Return

;---- B ---- 
Label10:
	b := true
	myStick.SetBtn(1,4)
	stickuwu()
	Return

Label10_UP:
	b := false
	myStick.SetBtn(0,4)
	Return

;---- A ---- 
Label11:
	a := true
	stickuwu()
	myStick.SetBtn(1,5)
	Return

Label11_UP:
	a := false
	myStick.SetBtn(0,5)
	Return

;---- X ---- 
Label12:
	myStick.SetBtn(1,6)
	Return

Label12_UP:
	myStick.SetBtn(0,6)
	Return

;---- Z ---- 
Label13:
	lshield := true
	myStick.SetBtn(1,7)
	stickuwu()
	Return

Label13_UP:
	lshield := false
	myStick.SetBtn(0,7)
	stickuwu()
	Return
  
;           //// C-STICK ////  
;---- CU ---- 
Label14:
	cu := true
	if (modx and mody) {
		myStick.SetBtn(1,9)
	}
	else { 
		myStick.SetAxisByIndex(0,5)
	}
	stickuwu()
	Return

Label14_UP:
	cu := false
	myStick.SetBtn(0,9)
	myStick.SetAxisByIndex(16384,5)
	stickuwu()
	Return
  
;---- CL ---- 
Label15:
	cl := true
	if (modx and mody) {
		myStick.SetBtn(1,10)
	}
	else if (u and modx and not mody) {
		myStick.SetAxisByIndex(8000,4)
		myStick.SetAxisByIndex(13300,5)
	}
	else if (d and modx and not mody) {
		myStick.SetAxisByIndex(8000,4)
		myStick.SetAxisByIndex(19168,5)
	}
	else {
		myStick.SetAxisByIndex(0,4)
	}
	stickuwu()
	Return

Label15_UP:
	cl := false
	myStick.SetBtn(0,10)
	myStick.SetAxisByIndex(16384,4)
	myStick.SetAxisByIndex(16384,5)  
	stickuwu()
	Return

;---- CD ---- 
Label16:
	cd := true
	if (modx and mody) {
	myStick.SetBtn(1,11)
	}
	else {
	myStick.SetAxisByIndex(32768,5)
	}
	stickuwu()
	Return
  
	Label16_UP:
	cd:= false
	myStick.SetBtn(0,11)
	myStick.SetAxisByIndex(16384,5)
	stickuwu()
	Return
  
;---- CR ---- 
Label17:
	cr := true
	if (modx and mody) {
		myStick.SetBtn(1,12)
	}
	else if (u and modx and not mody) {
		myStick.SetAxisByIndex(24768,4)
		myStick.SetAxisByIndex(13300,5)
	}
	else if (d and modx and not mody) {
		myStick.SetAxisByIndex(24768,4)
		myStick.SetAxisByIndex(19168,5)
	}
	else {
		myStick.SetAxisByIndex(32768,4)
	}
	stickuwu()
	Return

Label17_UP:
	cr := false
	myStick.SetBtn(0,12)
	myStick.SetAxisByIndex(16384,4)
	myStick.SetAxisByIndex(16384,5)  
	stickuwu()
	Return

;           //// OTHER BUTTONS ////  
;---- START ---- 
Label18:
	myStick.SetBtn(1,8)
	Return

Label18_UP:
	myStick.SetBtn(0,8)
	Return
  
;---- DPAD UP ---- 
Label19:
	myStick.SetBtn(1,9)
	Return

Label19_UP:
	myStick.SetBtn(0,9)
	Return
  
;---- DPAD LEFT ---- 
Label20:
	myStick.SetBtn(1,10)
	Return

Label20_UP:
	myStick.SetBtn(0,10)
	Return 

;---- DPAD DOWN ---- 
Label21:
	myStick.SetBtn(1,11)
	Return

Label21_UP:
	myStick.SetBtn(0,11)
	Return
  
;---- DPAD RIGHT ---- 
Label22:
	myStick.SetBtn(1,12)
	Return

Label22_UP:
	myStick.SetBtn(0,12)
	Return  
	
;----------------------------end macros

